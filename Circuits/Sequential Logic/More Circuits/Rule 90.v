module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q 
  ); 
    
    always@(posedge clk) begin
        if (load) 
          q <= data;
        else 
          q <= {1'b0, q[511:1]} ^ {q[510:0], 1'b0};
    end

endmodule




/* module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

genvar k;
generate
    for (k = 1; k <= 510; k = k + 1) begin : bits
        always @(posedge clk) begin
            if (load)
                q[k] <= data[k];
            else
                q[k] <= q[k-1] ^ q[k+1];
        end
    end
endgenerate

// q[0] and q[511]
always @(posedge clk) begin
    if (load) begin
       q[0] <= data[0];
       q[511] <= data[511]; 
    end else begin
       q[0] <= 1'b0 ^ q[1];
       q[511] <= q[510] ^ 1'b0; 
    end
end
endmodule */