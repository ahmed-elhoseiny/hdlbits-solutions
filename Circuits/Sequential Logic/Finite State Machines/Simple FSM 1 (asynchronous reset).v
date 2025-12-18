// HDLBits: Simple FSM 1 (asynchronous reset)
// Category: Sequential Logic - Finite State Machines
// Author: Ahmed Husseiny


module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out);//  

    parameter A=1'b0, B=1'b1; 
    reg state, next_state;

    always @(*) begin    // This is a combinational always block
        // State transition logic
        case (state)
            A: next_state = (in == 1'b1) ? A:B ;
            B: next_state = (in == 1'b1) ? B:A ;
            default: next_state = B ;
        endcase
    end

    always @(posedge clk, posedge areset) begin    // This is a sequential always block
        // State flip-flops with asynchronous reset
        if (areset) begin
            state <= B;
        end else begin
            state <= next_state;
        end

    end

    // Output logic
    assign out = (state == B)? 1'b1:
                 (state == A)? 1'b0:1'b0;

endmodule


//_______________________TFF with the T input inverted_________________________________//
/* module top_module (
    input  clk,
    input areset,
    input  in,
    output reg out
);

    always @(posedge clk, posedge areset) begin
        if (areset)
            out <= 1'b1;
        else if (~in)
            out <= ~out;   // toggle when in is 0
        else
            out <= out;    // hold when in is 1
    end

endmodule */