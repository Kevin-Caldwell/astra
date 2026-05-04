`include "defs.sv"
`include "core/ALU/alu.sv"

interface dut_if;
  bus_t a;
  bus_t b;
  bus_t out;
  logic[2:0] op;
  ALUFlags flags;

endinterface //dut_if

class Transaction;
  rand bus_t a;
  rand bus_t b;
endclass //Transaction

class driver;
  virtual dut_if vif;

  task drive(Transaction tr);
    vif.a <= tr.a;
    vif.b <= tr.b;
  endtask
endclass
