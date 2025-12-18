module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
wire sel ;
wire [15:0] sum_16_0, sum_16_1 ;

add16 add16_1( .a(a[15:0]), .b(b[15:0]), .cin(0), .sum(sum[15:0]), .cout(sel) );
add16 add16_2( .a(a[31:16]), .b(b[31:16]), .cin(0), .sum(sum_16_0), .cout() );
add16 add16_3( .a(a[31:16]), .b(b[31:16]), .cin(1), .sum(sum_16_1), .cout() );
mux2to1 mux2to1_1 (.d0(sum_16_0), .d1(sum_16_1),.sel(sel), .q(sum[31:16]));

endmodule


/* _______________________________module of mux2to1_______________________________ */

module mux2to1 (
    input [15:0] d0, d1,
    input  sel, 
    output reg [15:0] q
);
always @(*) begin
    case (sel)
        1'd0: q=d0; 
        1'd1: q=d1; 
        default: q=d0; 
    endcase
end

endmodule
