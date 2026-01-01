// HDLBits: Q3b: FSM
// Category: Sequential Logic - Finite State Machines
// Author: Ahmed Husseiny

module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
localparam A =3'b000,
            B =3'b001,
            C =3'b010,
            D =3'b011,
            E =3'b100;
    reg [2:0] state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

always @(*) begin
    case (state)
        A: next_state = (x == 1'b0) ? A : B;
        B: next_state = (x == 1'b0) ? B : E;
        C: next_state = (x == 1'b0) ? C : B;
        D: next_state = (x == 1'b0) ? B : C;
        E: next_state = (x == 1'b0) ? D : E;
        default: next_state = A;
    endcase
end
    assign z = (state == E) || (state == D);
endmodule