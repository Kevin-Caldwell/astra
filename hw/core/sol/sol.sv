`include "defs.sv"
`include "core/arithmetic/alu.sv"
`include "core/register_file.sv"
`include "decoder/rv32i_decoder.sv"
`include "memory/flash_bank_sim.sv"
`include "riscv/riscv_defs.sv"

// Simple Core for running compute instructions on
// registers.
// Only a validation core with instruction memory,
// register file and write-back.
// All stages of this pipeline are stricly single
// cycle only.

module SolCore #(
) (
  input logic clk, resetn
);

  bus_t pc;

  // Pipeline Registers
  FD_reg fd;
  DX_reg dx;
  XM_reg xm;
  MW_reg mw;

  // Input Signals
  FD_reg fd_in;
  DX_reg dx_in;
  XM_reg xm_in;
  MW_reg mw_in;

  SimulationFlash iCache (
    .clk(clk),
    .resetn(resetn),

    .addr(pc),
    .write(BUS_ZERO),
    .read(fd_in.instruction_)
  );

  RV32IDecoderOut_s decoded;

  RegisterFile rf(
    .clk(clk),
    .resetn(resetn),

    .write_address(mw.rd),

    .read_address_a(decoded.rs1),
    .read_address_b(decoded.rs2),

    .write_value(mw.reg_write_val),
    .read_value_a(dx_in.rf_out_1),
    .read_value_b(dx_in.rf_out_2)
  );

  RV32IDecoder dec (
    .instruction(fd.instruction_),
    .decoded(decoded)
  );

  ALUFlags alu_flags;

  ALU alu(
    .a(dx.rf_out_1),
    .b(dx.rf_out_2),

    .op(decoded.funct3),

    .out(xm_in.alu_out),
    .flags(alu_flags)
  );

  logic en_write;
  assign en_write = xm.itype == InstructionType_S;

  SimulationFlash mCache (
    .clk(clk),
    .resetn(resetn),
    .en_write(en_write),
    .write(xm.alu_out),
    .read(mw_in.mem_read)
  );

  assign dx_in.rd = decoded.rd;
  assign xm_in.rd = dx.rd;
  assign mw_in.rd = xm.rd;

  assign dx_in.itype = decoded.itype;
  assign xm_in.itype = dx.itype;
  assign mw_in.itype = xm.itype;

  always_ff @( posedge clk, negedge resetn ) begin
    if (resetn) begin
      fd <= '0;
      dx <= '0;
      xm <= '0;
      mw <= '0;
      pc <= '0
    end

    pc <= pc + 'd4;
    fd <= fd_in;
    dx <= dx_in;
    xm <= xm_in;
    mw <= mw_in;
  end

endmodule
