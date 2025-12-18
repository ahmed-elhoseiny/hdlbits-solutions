module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); 
wire [3:0] q0,q1,q2;
bcdcount counter0 (
    .clk(clk),
	.reset(reset),
	.enable(1'b1),
	.Q(q0)
    );
bcdcount counter1 (
    .clk(clk),
	.reset(reset),
	.enable((q0 == 4'h9)),
	.Q(q1)
    );
bcdcount counter2 (
    .clk(clk),
	.reset(reset),
	.enable(({q1,q0} == 8'h99)),
	.Q(q2)
    );

    assign OneHertz = ({q2,q1,q0} == 12'h999);
    assign c_enable = {({q1,q0} == 8'h99),(q0 == 4'h9),1'b1};
endmodule

