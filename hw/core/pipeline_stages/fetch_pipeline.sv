`include "core/pipeline_stages/pipeline_signals.sv"

`if (defined(SIM)) begin
  `include "memory/flash_bank_sim.sv"
end

module fetch_pipeline (
  input logic clk, resetn,
  input bus_t pc,
  output fetchPipeline_s fetch_output
);

// Initialize memory here

endmodule
