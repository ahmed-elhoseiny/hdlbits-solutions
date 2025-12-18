module top_module (
    input clk,
    input in, 
    output reg out);
    wire d_temp;
always @(posedge clk ) begin
    out <= d_temp;
end

assign d_temp = in ^ out;
endmodule