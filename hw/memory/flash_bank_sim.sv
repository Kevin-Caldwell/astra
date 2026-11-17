
`include "defs.sv"
// parameter int SF_HEIGHT = 1024;
// parameter int SF_WIDTH = 8;
// parameter int ADDR_BITS = $clog2(SF_HEIGHT);
parameter DEFAULT_HEIGHT = 1024;

module SimulationFlash #(
  parameter SF_HEIGHT = DEFAULT_HEIGHT,
    SF_WIDTH = 8,
    ADDR_BITS =$clog2(DEFAULT_HEIGHT)
) (
  input logic clk, resetn,
  input logic en_write,
  input logic [ADDR_BITS-1:0] addr,
  input logic [SF_WIDTH-1:0] write,
  output logic [SF_WIDTH-1:0] read
);
  logic [SF_WIDTH-1:0] memory[SF_HEIGHT-1:0];

  $info("SF_WIDTH: %5d, SF_HEIGHT: %5d", SF_WIDTH, SF_HEIGHT);

  always_ff @( posedge clk, negedge resetn ) begin
    if (resetn) begin
      for (int i = 0; i < SF_HEIGHT; i++) begin
        memory[i] <= '0;
      end
    end

    if (en_write) begin
      memory[addr] <= write;
    end

    read <= memory[addr];

_DEBUG_HEADER_
    $display("READ: [%5x] %8x", addr * 4, memory[addr][31:0]);
_DEBUG_FOOTER_
  end
endmodule
