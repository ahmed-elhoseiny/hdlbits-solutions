// HDLBits: Q2b: One-hot FSM equations
// Category: Sequential Logic - Finite State Machines
// Author: Ahmed Husseiny


module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
localparam A = 6'b000001,
           B = 6'b000010,
           C = 6'b000100,
           D = 6'b001000,
           E = 6'b010000,
           F = 6'b100000;

//B
assign Y1 = (y[0] && w) ;
//D
assign Y3 = (y[1] && ~w) || (y[2] && ~w) || (y[4] && ~w) || (y[5] && ~w);
endmodule