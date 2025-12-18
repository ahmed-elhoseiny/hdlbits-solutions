module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );
    wire [4:0] cout_temp;
genvar i;
generate
    for ( i = 0; i <= 15; i=i+4 ) begin : block
      bcd_fadd bcd_fadd_0(
    .a(a[i+3:i]),
    .b(b[i+3:i]),
    .cin(cout_temp[(i/4)]),
    .cout(cout_temp[(i/4)+1]),
    .sum(sum[i+3:i]) 
    );

    end
endgenerate
    assign cout_temp[0] = cin;
    assign cout= cout_temp[4];
endmodule

/* 
module bcd_fadd (
    input [3:0] a,
    input [3:0] b,
    input     cin,
    output   cout,
    output [3:0] sum );
*/