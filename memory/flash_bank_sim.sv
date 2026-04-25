
parameter int SF_HEIGHT = 1024;
parameter int SF_WIDTH = 8;
parameter int ADDR_BITS = $clog2(SF_HEIGHT);

module SimulationFlash (
  input logic clk, resetn,
  input logic en_write,
  input logic[ADDR_BITS-1:0] addr,
  input logic [7:0] write, 
  output logic [7:0] read
);
  
  logic [SF_HEIGHT-1:0][SF_WIDTH-1:0] memory;

  always_ff @( posedge clk, negedge resetn ) begin
    if (~resetn) begin
      for (int i = 0; i < SF_HEIGHT; i++) begin
        memory[i] <= 8'b00000000;
      end
    end

    if (en_write) begin
      memory[addr] <= write;
    end else begin
      read <= memory[addr];
    end
  end
endmodule
