module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   ); 

    wire  and_out1 ,and_out2 ,or_out;
    assign and_out1 = (a&b);
    assign and_out2 = (c&d);
    assign or_out = (and_out1|and_out2);
    assign out = or_out;
    assign out_n = ~or_out;
endmodule