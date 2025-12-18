module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 


// sum-of-products forms
assign out = (~d&~a) | (~c&~b) | (a&c&d) | (c&~a&b);
// product-of-sums
// assign out = (a|b|~c|~d) & (~a|~c|d) & (~b|c|~d) & (~a|~b|c);
endmodule