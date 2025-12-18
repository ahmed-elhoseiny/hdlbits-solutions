module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
  
  wire [3:0] cout;
    FA FA_0( 
    .a(x[0]), 
    .b(y[0]), 
    .cin(1'b0),
    .cout(cout[0]), 
    .sum(sum[0]) 
    );

// an array of instances
    FA FA_1[2:0]( 
    .a(x[3:1]), 
    .b(y[3:1]), 
    .cin(cout[2:0]),
    .cout(cout[3:1]), 
    .sum(sum[3:1]) 
    );

assign sum[4] = cout[3];

endmodule


//_______________________Full Adder module______________________
module FA( 
    input a, b, cin,
    output cout, sum );
assign {cout,sum}= a+b+cin ;

endmodule