module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
); 
always @(posedge clk ) begin
    if (load) begin
        q <= data;
    end else begin
        q <= (q[511:0] ^ {q[510:0], 1'b0})
            | (~{1'b0, q[511:1]} & {q[510:0], 1'b0});
    end
end
endmodule


/* 
// the next state of each cell depends only on itself and its two neighbours
primitive Rule_110 (
   output Center_next_state,
   input  Left,Center,Right
);

table
    //Left  Center   Right   :  Center_next_state
       1       1       1     :     0;
       1       1       0     :     1;
       1       0       1     :     1;
       1       0       0     :     0;
       0       1       1     :     1;
       0       1       0     :     1;
       0       0       1     :     1;
       0       0       0     :     0;
endtable


endprimitive */