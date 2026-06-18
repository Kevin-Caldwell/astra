
module Sext #(
  parameter inLen = 8,
  parameter outLen = 32
) (
  input logic[inLen-1:0] in,
  output logic[outLen-1:0] out
);
  parameter extLen = outLen - inLen;
  logic highest = in[inLen-1];
  assign out = {{extLen{highest}}, in};
endmodule

module Zext #(
  parameter inLen = 8,
  parameter outLen = 32
) (
  input logic[inLen-1:0] in,
  output logic[outLen-1:0] out
);
  parameter extLen = outLen - inLen;
  assign out = {{extLen{1'b0}}, in};
endmodule
