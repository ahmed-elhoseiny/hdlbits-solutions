// HDLBits: Q5b: Serial two's complementer (Mealy FSM)
// Category: Sequential Logic - Finite State Machines
// Author: Ahmed Husseiny

module top_module (
    input clk,
    input areset,
    input x,
    output reg z
); 

localparam  A  = 1'b0,
            B  = 1'b1;
reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A ;   
    end else begin
        state <= next_state ;
    end
end

always @(*) begin
    case (state)
        A  : next_state = (x == 1'b1) ?  B : A ;
        B  : next_state = B;
        default: next_state = A ;
    endcase
end

always @(*) begin
    case (state)
        A  :  z = (x == 1'b1) ? 1'b1 : 1'b0;
        B  :  z = (x == 1'b1) ? 1'b0 : 1'b1;
        default:  z = 1'b0;
    endcase
end
endmodule