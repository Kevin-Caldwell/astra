`include "defs.sv"

typedef struct packed {
  
} CommonStageSignals_s;

typedef struct packed {
  reg_addr_t write_address, 
  reg_addr_t read_address_a, 
  reg_addr_t read_address_b,
  bus_t write_value, 
  logic use_immediate,
  logic negate,
} RegisterFileStageSignals_s;

typedef struct packed {
  bus_t a, 
  bus_t b, 
  logic[2:0] op
} ALUStageSignals_s;

typedef struct packed {
  
} MemoryStageSignals_s;

typedef struct packed {
  
} PCUpdateStage;
