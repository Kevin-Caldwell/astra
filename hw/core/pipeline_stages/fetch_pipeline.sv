`include "core/pipeline_stages/pipeline_signals.sv"

`include "memory/flash_bank_sim.sv"

module fetch_pipeline (
  input logic clk, resetn,
  input bus_t pc,
  output fetchPipeline_s fetch_output
);

// Initialize memory here

endmodule
