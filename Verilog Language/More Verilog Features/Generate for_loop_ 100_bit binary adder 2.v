module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
 
    FA FA_array0(
        .a_i(a[0]),
        .b_i(b[0]),
        .cin_i(cin),
        .sum_i(sum[0]),
        .cout_i(cout[0])
    );
 // Array of FA instances  (((((((((instance array)))))))))
    FA FA_array[99:1](
        .a_i(a[99:1]),
        .b_i(b[99:1]),
        .cin_i(cout[98:0]),
        .sum_i(sum[99:1]),
        .cout_i(cout[99:1])
    );
endmodule
// _______________ FullAdder module____________//
module FA (
    input a_i,b_i,cin_i,
    output sum_i,cout_i
);
    assign {cout_i,sum_i} = a_i+b_i+cin_i;
endmodule