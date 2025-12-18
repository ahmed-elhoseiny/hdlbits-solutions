module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg [31:0] delayed_in;
    always @(posedge clk ) begin
    delayed_in <= in;
    if (reset) begin
        out <= 32'd0;
    end else begin
        out <= out | ((~in)&delayed_in);
    end
end
endmodule
