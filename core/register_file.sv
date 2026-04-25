`include "defs.sv"

module RegisterFile (
    input logic clk, resetn,

    // Addresses
    input reg_addr_t write_address,
    input reg_addr_t read_address_a, read_address_b,

    // Busses
    input bus_t write_value,
    output bus_t read_value_a, read_value_b
);

    bus_t integer_registers[REG_COUNT-1:0];

    // Read can be done Combinatorially
    always_comb begin
        read_value_a = integer_registers[read_address_a];
        read_value_b = integer_registers[read_address_b];
    end

    // Writing should be done Sequentially
    always_ff @( posedge clk or negedge resetn ) begin
        // Reset Logic, Set all registers to 0
        if(resetn) begin
            for (int i = 0; i < REG_COUNT; i++) begin
                integer_registers[i] <= 32'b0;
            end
        end

        // Cannot Write to x0
        if(write_address != 0) begin
            integer_registers[write_address] <= write_value;
        end
    end


endmodule