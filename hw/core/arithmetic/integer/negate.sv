
// Two's complement
module Negate #(
  parameter bus_width = 32;
) (
  input logic[bus_width-1:0] a, 
  output logic[bus_width-1:0] negative_a
);
  assign negative_a = ~a + 1'b1;
endmodule
