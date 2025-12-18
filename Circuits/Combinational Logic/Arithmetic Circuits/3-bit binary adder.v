module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );
    
    FA FA_0( 
    .a(a[0]), 
    .b(b[0]), 
    .cin(cin),
    .cout(cout[0]), 
    .sum(sum[0]) 
    );

// an array of instances
    FA FA_1[1:0]( 
    .a(a[2:1]), 
    .b(b[2:1]), 
    .cin(cout[1:0]),
    .cout(cout[2:1]), 
    .sum(sum[2:1]) 
    );


endmodule


//_______________________Full Adder module______________________
module FA( 
    input a, b, cin,
    output cout, sum );
assign {cout,sum}= a+b+cin ;

endmodule
