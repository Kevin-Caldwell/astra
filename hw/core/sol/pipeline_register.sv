`include "defs.sv"

typedef struct packed {
  instr_t instruction_;
} FD_reg;

typedef struct packed {
  bus_t rf_out_1;
  bus_t rf_out_2;
  reg_addr_t rd;
  InstructionType_e itype;
} DX_reg;

typedef struct packed {
  reg_t alu_out;
  reg_addr_t rd;
  bus_t write_val;
  InstructionType_e itype;
} XM_reg;

typedef struct packed {
  reg_addr_t rd;
  bus_t reg_write_val;
  bus_t mem_read;
  InstructionType_e itype;
} MW_reg;