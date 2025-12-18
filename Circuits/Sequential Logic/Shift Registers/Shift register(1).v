module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);

reg [3:0] Q;
always @(posedge clk ) begin
    if (!resetn) begin
        Q <= 4'b0000 ;
    end else begin
        Q <= {
                in,
                Q[3:1]
             };
    end
end
assign out = Q[0] ;
endmodule