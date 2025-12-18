module top_module (
    input clk,
    input w, R, E, L,
    output reg Q
);
wire d_temp;
    always @(posedge clk ) begin
        Q <= d_temp;
    end
    assign d_temp = (L) ? R:
                    (E) ? w:Q;
endmodule