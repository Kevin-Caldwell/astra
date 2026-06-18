`include "core/register_file.sv"

module register_file_pipeline (
  input logic clk, resetn,
  input decodePipeline_s decode_output,
  output rfPipeline_s rf_output,
);
  bus_t raw_b_out;

  

  RegisterFile inst_register_file(
    .clk(clk),
    .resetn(resetn),
    .write_address(write_address),
    .read_address_a(decode_output.instr.),
    .write_value(write_value),
    .read_value_a(read_value_a),
    .read_value_b(raw_b_out));

  assign read_value_b = use_immediate ? immediate : raw_b_out;
endmodule