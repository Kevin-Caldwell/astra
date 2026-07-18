`include "defs.sv"
`include "core/pipeline_stages/fetch_pipeline.sv"

// Simple Core for running compute instructions on
// registers.
// Only a validation core with instruction memory,
// register file and write-back.
// All stages of this pipeline are 1-cycle only.

module SolCore #(
) (
  input logic clk, resetn
);

  bus_t programCounter;
  fetchPipeline_s fetchSignals;
  decodePipeline_s decodeOutput;
  rfPipeline_s rfOutput;


  fetch_pipeline fetchStage (
    .clk(clk),
    .resetn(resetn),
    .pc(programCounter),
    .fetch_output(fetchSignals)
  );

  decode_stage decodeStage (
    .decodeOutput(decodeOutput)
  );

  register_file_pipeline registerFile (
    .clk(clk),
    .resetn(resetn),
    .decode_output(decodeOutput),
    .rf_output(rfOutput)
  );

endmodule
