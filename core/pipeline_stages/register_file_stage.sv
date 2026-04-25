`include "core/register_file.sv"

module RegisterFileStage (
  input logic clk, resetn, 
  input reg_addr_t write_address, 
  input reg_addr_t read_address_a, read_address_b, 
  input bus_t write_value, 
  input logic use_immediate, 
  input bus_t immediate, 
  output bus_t read_value_a, read_value_b
);

  RegisterFile inst_register_file(
    .clk(clk), 
    .resetn(resetn), 
    .write_address(write_address), 
    .read_address_a(read_address_a), 
    .write_value(write_value), 
    .read_value_a(read_value_a), 
    .read_value_b(read_value_b));

  
endmodule