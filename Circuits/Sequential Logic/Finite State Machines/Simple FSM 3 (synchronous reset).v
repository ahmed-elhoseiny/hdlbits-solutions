// HDLBits: Simple FSM 3 (synchronous reset)
// Category: Sequential Logic - Finite State Machines
// Author: Ahmed Husseiny

module top_module(
    input clk,
    input in,
    input reset,
    output reg out); //

    parameter A=2'd0, B=2'd1, C=2'd2, D=2'd3;
    reg  [1:0] current_state, next_state;
    // State transition logic
    always @(*) begin
        case (current_state)
            A: next_state =(in == 1'b1)? B:A ;
            B: next_state =(in == 1'b1)? B:C ;
            C: next_state =(in == 1'b1)? D:A ;
            D: next_state =(in == 1'b1)? B:C ;
        endcase
    end
    // State flip-flops with synchronous reset
    always @(posedge clk ) begin
        if (reset) begin
            current_state <= A; 
        end else begin
            current_state <= next_state;
        end
    end
    // Output logic
    always @(*) begin
    case (current_state)
        A: out = 1'b0 ;
        B: out = 1'b0 ;
        C: out = 1'b0 ;
        D: out = 1'b1 ;
    endcase
    end


endmodule
