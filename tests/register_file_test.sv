`include "core/register_file.sv"

`timescale 1ns/1ps

class RegisterFileTest;
  rand bit [4:0] a;
  rand bit [4:0] b;
  rand bit [4:0] c;
  rand bit [31:0] c_data;
  rand bit [31:0] a_data;
  rand bit [31:0] b_data;

endclass //RegisterFileTest

module TOP ();
  logic clk, resetn;
  bus_t a, b, c;
  reg_addr_t a_a, b_a, c_a;

  initial begin
    $display("Starting Register File Test...");

    clk <= 0;
    resetn <= 1;
    #1
    clk <= 1;
    resetn <= 0;
    forever #5 clk = ~clk;

    repeat (20) begin
      $display("Start...");

    end
  end
endmodule
