module top_module(
    input a,
    input b,
    input c,
    output out  ); 

// sum-of-products forms
assign out = b | c | a;
// product-of-sums
//assign out = (a|b|c);

endmodule



