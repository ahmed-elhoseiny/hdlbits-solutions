module top_module (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);
wire d_temp;
    always @(posedge clk ) begin
        Q <= d_temp;
    end
    assign d_temp = (~L) ? q_in:r_in;
endmodule