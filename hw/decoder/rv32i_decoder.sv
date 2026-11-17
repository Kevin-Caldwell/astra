`include "defs.sv"
`include "riscv/riscv_defs.sv"

typedef struct packed {
  logic[6:0] opcode;
  logic[2:0] funct3;
  logic[6:0] funct7;
  reg_t rd;
  reg_t rs1;
  reg_t rs2;
  bus_t immediate;
  InstructionType_e itype;
  alu_op_t alu_op;
} RV32IDecoderOut_s;

module RV32IDecoder (
  input instr_t instruction,
  output RV32IDecoderOut_s decoded
);

  InstructionType_e itype;

  assign decoded.funct7 = instruction[31:25];
  assign decoded.rs2    = instruction[24:20];
  assign decoded.rs1    = instruction[19:15];
  assign decoded.funct3 = instruction[14:12];
  assign decoded.rd     = instruction[11: 7];
  assign decoded.opcode = instruction[ 6: 0];

  FindInstructionType instruct_type_i (
    .instruction(decoded.opcode[6:2]),
    .i_type(itype)
  );

  DecodeImmediate decode_imm (
    .instruction(instruction),
    .instr_type(itype),
    .immediate(decoded.immediate)
  );

  assign decoded.itype = itype;

endmodule

module DecodeImmediate(
  input instr_t instruction,
  input InstructionType_e instr_type,
  output bus_t immediate
);

  always_comb begin
    case (instr_type)
      InstructionType_R: immediate = 32'd0;
      InstructionType_I: immediate = {{20{instruction[instruction[31]]}}, instruction[30:20]};
      InstructionType_S: immediate = {{21{instruction[31]}}, instruction[30:25], instruction[11:8], instruction[7]};
      InstructionType_B: immediate = {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};
      InstructionType_U: immediate = {instruction[31:12], 12'b0};
      InstructionType_J: immediate = {{12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:25], instruction[24:21], 1'b0};
      default: immediate = 32'd0;
    endcase
  end
endmodule
