module top;
    logic clk;
    logic [3:0] counter = 4'h0; // Inline initialization is allowed for simulation

    // Simple clock generator
    initial clk = 0;
    always #5 clk = ~clk;

    // Simple logic to watch
    always_ff @(posedge clk) begin
        if (counter == 4'hf)
            counter <= 4'h0;
        else
            counter <= counter + 1;
    end

    // Simulation control
    initial begin
        // Removed 'counter = 0' from here to avoid the conflict
        #200 $stop;
    end
endmodule