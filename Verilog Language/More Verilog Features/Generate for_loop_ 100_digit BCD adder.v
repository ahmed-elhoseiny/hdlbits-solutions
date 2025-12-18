module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );

    wire [99:0] cout_temp;
    bcd_fadd bcd_fadd_array0(
        .a(a[3:0]),
        .b(b[3:0]),
        .cin(cin),
        .sum(sum[3:0]),
        .cout(cout_temp[0])
    );
/*  // Array of FA instances  (((((((((instance array)))))))))
    bcd_fadd bcd_fadd_array[99:1](
        .a(a[399:4]),
        .b(b[399:4]),
        .cin(cout_temp[98:0]),
        .sum(sum[399:4]),
        .cout(cout_temp[99:1])
    ); */
    genvar i;
    generate
        for (i = 4; i < 400-3; i = i + 4) begin : bcd_fadd_inst
        bcd_fadd bcd_fadd_array(
            .a(a[i+3:i]),
            .b(b[i+3:i]),
            .cin(cout_temp[i/4-1]),
            .sum(sum[i+3:i]),
            .cout(cout_temp[i/4])
           );
        end
    endgenerate


    assign cout = cout_temp[99];
    



endmodule

/* 
module bcd_fadd (
    input [3:0] a,
    input [3:0] b,
    input     cin,
    output   cout,
    output [3:0] sum );
 */