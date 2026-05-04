
`include "defs.sv"

typedef struct packed {
  logic Z; // Equal
  logic N; // Is result negative?
} ALUFlags;

module SetFlags (
  input logic[XLEN-1:0] in,
  output ALUFlags flags
);
  always_comb begin
    if (in == {XLEN{1'b0}}) begin
      flags.Z = 1;
    end else begin
      flags.Z = 0;
    end

    flags.N = in[XLEN-1];
  end
endmodule

module ALU (
  input logic[XLEN-1:0] a, b,
  input logic[2:0] op,
  output logic[XLEN-1:0] out,
  output ALUFlags flags
);
  always_comb begin
    case (op)
      3'b000: out = a + b;
      3'b001: out = a << b;
      3'b010: // set less than
      3'b011: // set less than unsigned
      3'b100: out = a ^ b;
      3'b101: out = a >> b; // srl funct7: 00000
      3'b101: // sra funct7: 01000
      3'b110: out = a | b;
      3'b111: out = a & b;
      default: out = 32'd0;
    endcase
  end

  SetFlags inst_set_flags (
    .in(out),
    .flags(flags)
  );
endmodule