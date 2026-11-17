`include "defs.sv"

typedef struct packed {
  // Register
  reg_addr_t write_address;
  reg_addr_t read_address_a;
  reg_addr_t read_address_b;
  reg_addr_t write_value;
  logic use_immediate;

  // ALU
  logic negate;
  reg_addr_t alu_input_a;
  reg_addr_t alu_input_b;
  reg_addr_t alu_output;

  // Update Program Counter
  logic ctrl_instruction;
  logic branch_success;
  bus_t old_pc;
  bus_t offset;
  bus_t new_pc;

} PipelineSignals;


typedef struct packed {
  instr_u instr;
  bus_t pc;
} fetchPipeline_s;

typedef struct packed {
  instr_u instr;
  bus_t pc;
  instrType_e instr_type;
} decodeStage_s;

typedef struct packed {
  instr_u instr;
  bus_t pc;
  bus_t out_a;
  bus_t out_b;
  reg_addr_t wb_addr;
  logic wb_rf;
} rfPipeline_s;

typedef struct packed {
  instr_u instr;
  bus_t pc;
  bus_t alu_out;
  ALUFlags alu_flags;
  reg_addr_t wb_addr;
  logic wb_rf;
} aluPipeline_s;

typedef struct packed {
  instr_u instr;
  reg_addr_t wb_addr;
  logic wb_rf;
} memoryPipeline_s;

typedef struct packed {
  instr_u instr;
  bus_t pc;
  reg_addr_t wb_addr;
  logic wb_rf;
} pcUpdatePipeline_s;

typedef struct packed {
  instr_u instr;
  bus_t pc;
  bus_t new_pc;
  bus_t wb_addr;
  bus_t wb_rf;
} writeBackPipeline_s;
