// HDLBits: Q8: Design a Mealy FSM
// Category: Sequential Logic - Finite State Machines
// Author: Ahmed Husseiny

module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output reg z ); 

localparam  S0 = 2'd0,
            S1 = 2'd1,
            S2 = 2'd2;
reg [1:0] state, next_state;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= S0 ;   
    end else begin
        state <= next_state ;
    end
end

always @(*) begin
    case (state)
        S0: next_state = (x == 1'b1) ?  S1:S0 ;
        S1: next_state = (x == 1'b0) ?  S2:S1 ;
        S2: next_state = (x == 1'b1) ?  S1:S0 ; 
        default: next_state = S0 ;
    endcase
end

always @(*) begin
    case (state)
        S0:  z = (x == 1'b1) ? 1'b0:1'b0;
        S1:  z = (x == 1'b0) ? 1'b0:1'b0;
        S2:  z = (x == 1'b1) ? 1'b1:1'b0; 
        default:  z = 1'b0;
    endcase
end

endmodule