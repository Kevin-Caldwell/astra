`timescale 1ns/1ns

module mif_testbench;

logic clk;
logic resetn;

logic[3:0] counter; 

logic[31:0] registers[3:0];

always #5 clk = ~clk;

initial begin
  $readmemh("assets/testing/sample.hex", registers);
  for (int i = 0; i < 4 ; i++) begin
    $display("REGISTER %d: %x", i, registers[i]);
  end

  assert (registers[0] == 32'hdeadbeef) 
  assert (registers[1] == 32'h10027499) 
  assert (registers[2] == 32'h01234567)
  assert (registers[3] == 32'h89abcdef)  
  else   begin
    $display("Register 0 false");
  end
end
  
endmodule