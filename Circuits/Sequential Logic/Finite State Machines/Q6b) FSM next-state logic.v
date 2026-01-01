// HDLBits: Q6b: FSM next-state logic
// Category: Sequential Logic - Finite State Machines
// Author: Ahmed Husseiny

module top_module (
    input [3:1] y,
    input w,
    output Y2);

localparam A = 3'b000,
           B = 3'b001,
           C = 3'b010,
           D = 3'b011,
           E = 3'b100,
           F = 3'b101;

reg [3:1] state, next_state;
assign state = y;
always @(*) begin
    case (state)
        A: next_state = (w == 1'b0) ? B : A;
        B: next_state = (w == 1'b0) ? C : D;
        C: next_state = (w == 1'b0) ? E : D;
        D: next_state = (w == 1'b0) ? F : A;
        E: next_state = (w == 1'b0) ? E : D;
        F: next_state = (w == 1'b0) ? C : D;
        default: next_state = A;
    endcase
end

assign Y2 = next_state[2];
endmodule