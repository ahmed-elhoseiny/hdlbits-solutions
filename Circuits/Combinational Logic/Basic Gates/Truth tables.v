module top_module( 
    input x3,
    input x2,
    input x1,  // three inputs
    output f   // one output
);
/* assign f = (~x3&x2&~x1) |
           (~x3&x2&x1) |
           (x3&~x2&x1) |
           (x3&x2&x1); 
*/


boolen_func (
    .f(f),
    .x3(x3),
    .x2(x2),
    .x1(x1)  
    );
endmodule


//________________________truth table in verilog _______________//
primitive boolen_func (
    output f,
    input x3,x2,x1  
    );


	table
		// x3   x2 	x1 		f
			0	0	0   :   0;
            0	0	1   :	0;
            0	1	0   :	1;
            0	1	1   :	1;
            1	0	0   :	0;
            1	0	1   :	1;
            1	1	0   :	0;
            1	1	1   :	1;
	endtable

endprimitive