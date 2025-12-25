// HDLBits: PS_over_2 packet parser
// Category: Sequential Logic - Finite State Machines
// Author: Ahmed Husseiny

module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //

localparam WAIT_BYTE1 = 2'd0 ,
                BYTE2 = 2'd1 ,
                BYTE3 = 2'd2 ,
                DONE  = 2'd3 ;

reg [1:0] state, next_state;

    // State transition logic (combinational)
always @(*) begin
    case (state)
     WAIT_BYTE1 :  next_state = (in[3] == 1) ? BYTE2:WAIT_BYTE1 ;
     BYTE2      :  next_state = BYTE3;
     BYTE3      :  next_state = DONE;
     DONE       :  next_state = (in[3] == 1) ? BYTE2:WAIT_BYTE1; 
        default: next_state = WAIT_BYTE1 ;
    endcase
end
    // State flip-flops (sequential)
always @(posedge clk ) begin
if (reset) begin
    state <= WAIT_BYTE1 ;
end else begin
    state <= next_state ;
end
end
    // Output logic
assign done = (state == DONE);
endmodule