module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);

    assign min = ((a<=b) && (a<=c) && (a<=d)) ? a : 
                 ((b<=a) && (b<=c) && (b<=d)) ? b :
                 ((c<=a) && (c<=b) && (c<=d)) ? c : d;

    /* 
    wire [7:0] w1, w2, w3;
    assign w1 = (a < b) ? a : b;
    assign w2 = (c < w1) ? c : w1;
    assign w3 = (d < w2) ? d : w2;
    assign min = w3;
    */
endmodule