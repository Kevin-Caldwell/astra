
parameter int XLEN = 32;
parameter int REG_COUNT = 32;

typedef logic[4:0] reg_addr_t;
typedef reg_addr_t reg_t;
typedef logic[XLEN-1:0] bus_t;
typedef logic[XLEN-1:0] instr_t;

typedef enum logic[1:0] {
  R_INSTRUCTION,
  I_INSTRUCTION,
  S_INSTRUCTION,
  U_INSTRUCTION
} instrType_e;

typedef struct packed {
  logic[6:0] funct7;
  reg_addr_t rs2;
  reg_addr_t rs1;
  logic[2:0] funct3;
  reg_addr_t rd;
  logic[6:0] opcode;
} rInstruction_s;

typedef struct packed {
  logic[11:0] imm;
  reg_addr_t rs1;
  logic[2:0] funct3;
  reg_addr_t rd;
  logic[6:0] opcode;
} iInstruction_s;

typedef struct packed {
  logic[6:0] imm_1;
  reg_addr_t rs2;
  reg_addr_t rs1;
  logic[2:0] funct3;
  reg_addr_t imm_0;
  logic[6:0] opcode;
} sInstruction_s;

typedef struct packed {
  logic[19:0] imm;
  reg_addr_t rd;
  logic[6:0] opcode;
} uInstruction_s;

typedef union packed {
  instr_t instruction;
  rInstruction_s r_inst;
  iInstruction_s i_inst;
  sInstruction_s s_inst;
  uInstruction_s u_inst;
} instr_u;
