// HDLBits: Q2a: FSM
// Category: Sequential Logic - Finite State Machines
// Author: Ahmed Husseiny

module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 

localparam A  = 2'd0,
           B  = 2'd1,
           C  = 2'd2,
           D  = 2'd3;

reg [1:0] state, next_state;

always @(posedge clk) begin
    if (!resetn) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        A: begin
            if (r == 3'b000) begin
                next_state = A;
            end else if (r[1]) begin
                next_state = B;
            end else if (r[2] && ~r[1]) begin
                next_state = C; 
            end else if (r[3] && ~r[2] && ~r[1]) begin
                next_state = D;
            end else begin
                next_state = A;
            end
        end
        B: next_state = (r[1]) ? B : A;
        C: next_state = (r[2]) ? C : A;
        D: next_state = (r[3]) ? D : A;
        default: next_state = A;
    endcase
end

assign g = (state == A) ? 3'b000 :
           (state == B) ? 3'b001 :
           (state == C) ? 3'b010 :
           (state == D) ? 3'b100 : 3'b000;

endmodule
