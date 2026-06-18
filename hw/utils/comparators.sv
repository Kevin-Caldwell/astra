
typedef struct packed {
  logic Z; // Equal?
  logic N; // Negative?
} ALUFlags;

typedef enum logic[1:0] {
  kComparatorEqual          = 3'b00,
  kComparatorNotEqual       = 3'b01,
  kComparatorLessThan       = 3'b10,
  kComparatorGreaterEqual   = 3'b11
} Comparators;

module CalculateComparator(
  input en,
  input ALUFlags flags,
  input logic[1:0] compare_op,
  output logic out
);
  always_comb begin
    if (en) begin
      case (compare_op)
        kComparatorEqual:        out = flags.Z;
        kComparatorNotEqual:     out = ~flags.Z;
        kComparatorLessThan:     out = flags.N;
        kComparatorGreaterEqual: out = ~flags.N | flags.Z;
        default: out = 1'b0;
      endcase
    end else begin
      out = 1'b0;
    end
  end
endmodule
