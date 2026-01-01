// HDLBits: Q5a: Serial two's complementer (Moore FSM)
// Category: Sequential Logic - Finite State Machines
// Author: Ahmed Husseiny

module top_module (
    input clk,
    input areset,
    input x,
    output reg z
); 

localparam  SEARCH_ONE  = 2'd0,
            FIRST_ONE   = 2'd1,
            INV_ZERO    = 2'd2,
            INV_ONE     = 2'd3;
reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= SEARCH_ONE ;   
    end else begin
        state <= next_state ;
    end
end

always @(*) begin
    case (state)
        SEARCH_ONE  : next_state = (x == 1'b1) ?  FIRST_ONE:SEARCH_ONE ;
        FIRST_ONE   : next_state = (x == 1'b1) ?  INV_ONE : INV_ZERO;
        INV_ZERO    : next_state = (x == 1'b1) ?  INV_ONE : INV_ZERO;
        INV_ONE     : next_state = (x == 1'b1) ?  INV_ONE : INV_ZERO;
        default: next_state = SEARCH_ONE ;
    endcase
end

always @(*) begin
    case (state)
        SEARCH_ONE  :  z = 1'b0;
        FIRST_ONE   :  z = 1'b1;
        INV_ZERO    :  z = 1'b1;
        INV_ONE     :  z = 1'b0;
        default:  z = 1'b0;
    endcase
end
endmodule