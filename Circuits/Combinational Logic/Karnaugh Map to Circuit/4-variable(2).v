module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 
// sum-of-products forms
assign out =  (a) | (c&~b) ;
// product-of-sums
// assign out =  (a|~b) & (c|a);

endmodule