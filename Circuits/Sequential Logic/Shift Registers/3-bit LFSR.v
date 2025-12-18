module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q

wire [2:0] r;
wire clk,L;
reg [2:0] Q;


always @(posedge clk ) begin
    Q <= {
            ((L) ? r[2]:(Q[1]^Q[2])),
            ((L) ? r[1]:Q[0]),
            ((L) ? r[0]:Q[2])
         };
end

assign  r       = SW;
assign  {L,clk} = KEY;
assign LEDR     = Q ;

endmodule

/* 
module muxed_Dff (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);
wire d_temp;
    always @(posedge clk ) begin
        Q <= d_temp
    end
    assign d_temp = (~L) ? q_in:r_in;
endmodule 
*/