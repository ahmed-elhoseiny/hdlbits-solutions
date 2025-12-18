module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
); //
 
    assign s = a+b;
    assign overflow = (a[$bits(a)-1]~^b[$bits(b)-1]) & (s[$bits(s)-1]^b[$bits(b)-1]);

endmodule