module top_module( 
    input [254:0] in,
    output [7:0] out );

reg [7:0] count_ones;
integer  i ;
always @(*) begin
    count_ones = 8'd0;
    for ( i=0 ;i<$bits(in) ; i=i+1) begin
        if (in[i] == 1'b1) begin
            count_ones = count_ones+1;
        end else begin
            count_ones = count_ones;
        end
    end
end
assign out = count_ones;

/* 	always @(*) begin	// Combinational always block
		out = 0;
		for (int i=0;i<255;i++)
			out = out + in[i];
	end 
*/

endmodule
