
`define "defs.sv"

module ProgramCounterUpdate (
  input logic ctrl_instr, branch_success,
  input bus_t old_pc, offset,
  output bus_t new_pc
);
  always_comb begin
    if (ctrl_instr & branch_success) begin
      new_pc = old_pc + offset;
    end else begin
      new_pc = old_pc + 32'd4;
    end
  end
endmodule
