// HDLBits: Q3c: FSM
// Category: Sequential Logic - Finite State Machines
// Author: Ahmed Husseiny

module top_module (
    input clk,
    input [2:0] y,
    input x,
    output reg Y0,
    output z
);
localparam A = 3'b000,
            B = 3'b001,
            C = 3'b010,
            D = 3'b011,
            E = 3'b100;

    always @(*) begin
        case (y)
            A: Y0 <= (x == 1'b0) ? 1'b0 : 1'b1;
            B: Y0 <= (x == 1'b0) ? 1'b1 : 1'b0;
            C: Y0 <= (x == 1'b0) ? 1'b0 : 1'b1;
            D: Y0 <= (x == 1'b0) ? 1'b1 : 1'b0;
            E: Y0 <= (x == 1'b0) ? 1'b1 : 1'b0;
            default: Y0 <= 1'b0;
        endcase
    end

    assign z = (y == E) || (y == D);
endmodule