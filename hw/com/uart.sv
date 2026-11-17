

// enum logic[1:0] {
//     uart_tx_idle = 0,
//     uart_tx_start_bit,
//     uart_tx_data,
//     uart_tx_stop
// } UART_Tx_s;

// enum logic[1:0] {
//     uart_rx_idle = 0,
//     uart_rx_start_bit,
//     uart_rx_data,
//     uart_rx_stop
// } UART_Rx_s;


// module uart_tx (
//     input logic clk, resetn,
//     input logic incoming,
//     input logic[7:0] data,
//     output logic TX

// );

//     UART_Tx_s cur_state, next_state;
//     logic counter_en = 1'b0;
//     logic[3:0] counter = 4'b0;
//     logic[7:0] shift;

//     always_comb begin
//         case (cur_state)
//             uart_tx_idle:
//                 if (incoming) begin
//                     next_state = uart_tx_start_bit;
//                 end else begin
//                     next_state = uart_tx_idle;
//                 end

//             uart_tx_start_bit:
//                 next_state = uart_tx_start_bit;

//             uart_tx_data:
//                 if (counter != 4'd8) begin
//                     next_state = uart_tx_data;
//                 end else begin
//                     next_state = uart_tx_stop;
//                 end

//             uart_tx_stop:
//                 next_state = uart_tx_idle;

//             default:
//                 next_state = uart_tx_idle;
//         endcase

//         case (cur_state)
//             uart_tx_idle: begin
//                 TX = 1'b1;
//             end

//             uart_tx_start_bit: begin
//                 TX = 1'b1;
//             end

//             uart_tx_data: begin

//             end

//             default: begin
//                 TX = 1'b1;
//             end
//         endcase
//     end

//     always_ff @( posedge clk, negedge resetn ) begin
//         if (~resetn) begin
//             cur_state <= uart_tx_idle;
//             shift <= 8'b0;
//         end

//         cur_state <= next_state;

//         if(incoming) begin
//             // shift <= input;
//         end

//     end

// endmodule


// module uart_rx (
//     input logic clk, resetn
// );




// endmodule