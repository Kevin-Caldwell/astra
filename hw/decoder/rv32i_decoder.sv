`include "defs.sv"
`include "riscv/riscv_defs.sv"

enum logic[3:0] {
  R, 
  I, 
  S, 
  B, 
  U, 
  J,
} InstructionType_e;

typedef struct packed {
  logic[6:0] opcode;
  logic[2:0] funct3;
  logic[6:0] funct7;
  reg_t rd;
  reg_t rs1;
  reg_t rs2;
  bus_t immediate;
} RV32IDecoderOut_s;

module RV32IDecoder #() (
  input instr_t instruction,
  output RV32IDecoderOut_s decoded
);

  assign decoded.funct7 = instruction[31:25];
  assign decoded.rs2    = instruction[24:20];
  assign decoded.rs1    = instruction[19:15];
  assign decoded.funct3 = instruction[14:12];
  assign decoded.rd     = instruction[11:7];
  assign decoded.opcode = instruction[6:0];
endmodule

module DecodeImmediate(
  input instr_t instruction,
  input InstructionType_e type,
  output bus_t immediate
);

  always_comb begin
    case (type)
      InstructionType_e.R: immediate = 32'd0;
      InstructionType_e.I: immediate = {20{instruction[instruction[31]]}, instruction[30:20]};
      InstructionType_e.S: immediate = {21{instruction[31]}, instruction[30:25], instruction[11:8] instruction[7]};
      InstructionType_e.B: immediate = {20{instruction[31]}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};
      InstructionType_e.U: immediate = {instruction[31:12], 12'b0};
      InstructionType_e.J: immediate = {12{instruction[31]}, instruction[19:12], instruction[20], instruction[30:25], instruction[24:21], 1'b0};
      default: immediate = 32'd0;
    endcase
  end
endmodule
