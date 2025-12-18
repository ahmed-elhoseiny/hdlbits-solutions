module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);



wire [3:0] q0,q1,q2,q3;
one_digit_decade_counter u0 (
    .clk(clk),
    .reset(reset),        // Synchronous active-high reset
    .en(1'b1),
    .q(q0)
    );

one_digit_decade_counter u1 (
    .clk(clk),
    .reset(reset),        // Synchronous active-high reset
    .en(ena[1]),
    .q(q1)
    );

one_digit_decade_counter u2 (
    .clk(clk),
    .reset(reset),        // Synchronous active-high reset
    .en(ena[2]),
    .q(q2)
    );

one_digit_decade_counter u3 (
    .clk(clk),
    .reset(reset),        // Synchronous active-high reset
    .en(ena[3]),
    .q(q3)
    );


assign ena = {((q0 == 4'd9) && (q1 == 4'd9) && (q2 == 4'd9)),((q0 == 4'd9) && (q1 == 4'd9)),(q0 == 4'd9)};
assign q = {q3,q2,q1,q0};
endmodule

//_________________________________________________________________//

module one_digit_decade_counter (
    input clk,
    input reset,        // Synchronous active-high reset
    input en,
    output reg [3:0] q);
always @(posedge clk) begin
    if (reset) begin
        q <= 4'd0;
    end else if (q == 4'd9 && en == 1'b1)begin
        q <= 4'd0;
    end else if (q != 4'd9 && en == 1'b1) begin
        q <= q +4'd1;
    end else begin
        q <= q;
    end
end
endmodule