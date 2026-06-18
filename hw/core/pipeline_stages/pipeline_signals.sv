`include "defs.sv"

typedef struct packed {
  // Register
  reg_addr_t write_address,
  reg_addr_t read_address_a,
  reg_addr_t read_address_b,
  reg_addr_t write_value,
  logic use_immedate,

  // ALU
  logic negate,
  reg_addr_t alu_input_a,
  reg_addr_t alu_input_b,
  reg_addr_t alu_output,

  // Update Program Counter
  logic ctrl_instruction,
  logic branch_success,
  bus_t old_pc,
  bus_t offset,
  bus_t new_pc

} PipelineSignals;


typedef struct packed {
  instr_u instr,
  bus_t pc,
} fetchPipeline_s;

typedef struct packed {
  instr_u instr,
  bus_t pc,
  instrType_e instr_type, // EDIT
} decodePipeline_s;

typedef struct packed {
  instr_u instr,
  bus_t pc,
  bus_t rf_a,
  bus_t rf_b,
} rfPipeline_s;

typedef struct packed {
  instr_u instr,
  bus_t pc,
  bus_t alu_out,
  ALUFlags alu_flags,
} aluPipeline_s;

typedef struct packed {

} memoryPipeline_s;

typedef struct packed {
  instr_u instr,
  bus_t pc,
} pcUpdatePipeline_s;

typedef struct packed {
  instr_u instr,
  bus_t pc,
  bus_t new_pc,
  bus_t rf_w,
  bus_t rf_wb,
} writeBackPipeline_s;
