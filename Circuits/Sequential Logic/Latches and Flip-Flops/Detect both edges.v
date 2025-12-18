module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    reg [7:0] delayed_in;
always @(posedge clk ) begin
    delayed_in <= in;
    anyedge <= in^delayed_in;
end
// assign anyedge = in^delayed_in;
endmodule