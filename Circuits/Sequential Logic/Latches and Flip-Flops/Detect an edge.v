module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    reg [7:0] delayed_in;
always @(posedge clk ) begin
    delayed_in <= in;
    pedge <= in&(~delayed_in);
end
// assign pedge = in&(~delayed_in);
endmodule