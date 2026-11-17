
typedef enum logic[3:0] {
  InstructionType_R,
  InstructionType_I,
  InstructionType_S,
  InstructionType_B,
  InstructionType_U,
  InstructionType_J, 
  InstructionType_EXTRA, 
  InstructionType_NoImpl
} InstructionType_e;

typedef struct packed {
  logic register_file;
  logic alu;
  logic memory;
  logic branch;
  logic write_back;
} StageEnable_s;

// Source:
// https://docs.riscv.org/reference/isa/unpriv/rv-32-64g.html
enum logic[4:0] {
  LOAD      = 5'b00000,
  STORE     = 5'b01000,
  MADD      = 5'b10000,
  BRANCH    = 5'b11000,
  LOAD_FP   = 5'b00001,
  STORE_FP  = 5'b01100,
  MSUB      = 5'b10001,
  JALR      = 5'b11001,
  CUSTOM_0  = 5'b00010,
  CUSTOM_1  = 5'b01010,
  NMSUB     = 5'b10010,
  // RESERVED = 5'b11011,
  MISC_MEM  = 5'b00011,
  AMO       = 5'b01011,
  NMADD     = 5'b10011,
  JAL       = 5'b11011,
  OP_IMM    = 5'b00100,
  OP        = 5'b01001,
  OP_FP     = 5'b10100,
  SYSTEM    = 5'b11100,
  AUIPC     = 5'b00101,
  LUI       = 5'b01101,
  OP_V      = 5'b10101,
  OP_VE     = 5'b11101,
  OP_IMM_32 = 5'b00110,
  OP_32     = 5'b01110
} RV32Instructions_e;

module GetRequiredStages(
  input logic[6:0] opcode,
  output StageEnable_s stages);

  logic[4:0] trimmed_opcode;

  assign trimmed_opcode = opcode[6:2];

  always_comb begin
    case (trimmed_opcode)
      LOAD:     stages = 5'b11101;
      STORE:    stages = 5'b11100;
      BRANCH:   stages = 5'b11011;
      JALR:     stages = 5'b11011;
      MISC_MEM: stages = 5'b11101;
      JAL:      stages = 5'b11011;
      OP_IMM:   stages = 5'b11001;
      OP:       stages = 5'b11001;
      default:  stages = 5'b00000;
    endcase
  end
endmodule

module FindInstructionType (
  input logic[4:0] packed_opcode, 
  output InstructionType_e i_type
);
  always_comb begin
    case (packed_opcode)
      LOAD:       i_type  = InstructionType_I;
      STORE:      i_type = InstructionType_S;
      MADD:       i_type = InstructionType_NoImpl;
      BRANCH:     i_type = InstructionType_B;
      LOAD_FP:    i_type = InstructionType_I;
      STORE_FP:   i_type = InstructionType_S;
      MSUB:       i_type = InstructionType_NoImpl;
      JALR:       i_type = InstructionType_I;
      CUSTOM_0:   i_type = InstructionType_NoImpl;
      CUSTOM_1:   i_type = InstructionType_NoImpl;
      NMSUB:      i_type = InstructionType_R;
      MISC_MEM:   i_type = InstructionType_NoImpl;
      AMO:        i_type = InstructionType_R;
      NMADD:      i_type = InstructionType_R;
      JAL:        i_type = InstructionType_J;
      OP_IMM:     i_type = InstructionType_I;
      OP:         i_type = InstructionType_R;
      OP_FP:      i_type = InstructionType_R;
      SYSTEM:     i_type = InstructionType_I;
      AUIPC:      i_type = InstructionType_U;
      LUI:        i_type = InstructionType_U;
      OP_V:       i_type = InstructionType_R;
      OP_VE:      i_type = InstructionType_R;
      OP_IMM_32:  i_type = InstructionType_I;
      OP_32:      i_type = InstructionType_R;
      default:    i_type = InstructionType_NoImpl;
    endcase
  end
  
endmodule
