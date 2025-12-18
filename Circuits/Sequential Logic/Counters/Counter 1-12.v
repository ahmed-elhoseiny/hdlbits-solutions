module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
); //

    count4 the_counter (
    .clk(clk),
	.enable(c_enable),
	.load(c_load),
	.d(c_d),
	.Q()
    );

    always @(posedge clk) begin
        if (reset) begin
            Q<=4'd1;
        end else if (enable && Q==4'd12) begin
            Q<=4'd1;
        end else if (enable && Q!=4'd12) begin
            Q<= Q+4'd1;
        end else begin
            Q<= Q;
        end
    end
assign c_enable = enable;
assign c_load = reset|(enable && Q==4'd12);
assign c_d = (c_load) ? 4'd1:4'd0 ;

endmodule