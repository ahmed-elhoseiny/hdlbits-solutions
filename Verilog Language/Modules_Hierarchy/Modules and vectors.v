module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);


wire [7:0] q1,q2,q3;

my_dff8 my_dff8_1 ( .clk(clk), .d(d), .q(q1) );
my_dff8 my_dff8_2 ( .clk(clk), .d(q1), .q(q2) );
my_dff8 my_dff8_3 ( .clk(clk), .d(q2), .q(q3) );
mux8to1 mux8to1_1 (.d0(d), .d1(q1), .d2(q2), .d3(q3),.sel(sel), .q(q));
endmodule


/* _______________________________module of mux8to1_______________________________ */

module mux8to1 (
    input [7:0] d0, d1, d2, d3,
    input [1:0] sel, 
    output reg [7:0] q
);
always @(*) begin
    case (sel)
        2'd0: q=d0; 
        2'd1: q=d1; 
        2'd2: q=d2; 
        2'd3: q=d3; 
        default: q=d0; 
    endcase
end

endmodule
