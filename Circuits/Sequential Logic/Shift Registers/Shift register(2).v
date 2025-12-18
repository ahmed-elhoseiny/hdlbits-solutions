module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); 

wire clk;
wire w, E, L;
wire [3:0] R;
reg  [3:0] Q;
always @(posedge clk ) begin
    Q <= {
        (L) ? (R[3]):((E) ? w:Q[3]),
        (L) ? (R[2]):((E) ? Q[3]:Q[2]),
        (L) ? (R[1]):((E) ? Q[2]:Q[1]),
        (L) ? (R[0]):((E) ? Q[1]:Q[0])
        };
end
assign R = SW ;
assign {w,L,E,clk}= KEY;
assign LEDR = Q;
endmodule



//__________________MUXDFF module_______________//
/* module MUXDFF (
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
 */