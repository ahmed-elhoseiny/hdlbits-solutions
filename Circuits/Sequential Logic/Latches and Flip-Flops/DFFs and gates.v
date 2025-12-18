module top_module (
    input clk,
    input x,
    output z
); 
wire xor_out,and_out,or_out;
reg q_0,q_1,q_2;
reg not_q1,not_q2;
assign xor_out = x^q_0;
DFF_Q_notQ u0 (
    .clk(clk),
    .D(xor_out),
    .Q(q_0),
    .not_Q()
    );

assign and_out = x&not_q1;
DFF_Q_notQ u1 (
    .clk(clk),
    .D(and_out),
    .Q(q_1),
    .not_Q(not_q1)
    );

assign or_out = x|not_q2;
DFF_Q_notQ u2 (
    .clk(clk),
    .D(or_out),
    .Q(q_2),
    .not_Q(not_q2)
    );

assign z = ~(q_0|q_1|q_2);

endmodule


module DFF_Q_notQ (
    input  clk,D,
    output reg Q,
    output wire not_Q
);
    always @(posedge clk) begin
        Q <= D;
    end

assign not_Q = ~Q;

endmodule