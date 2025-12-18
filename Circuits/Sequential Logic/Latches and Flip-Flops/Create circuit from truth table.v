module top_module (
    input clk,
    input j,
    input k,
    output reg Q); 
    wire Q_temp;
always @(posedge clk ) begin
    case ({j,k})
        2'b00: Q<= Q_temp;
        2'b01: Q<= 0;
        2'b10: Q<= 1;
        2'b11: Q<= ~Q_temp;
    endcase
    //  Q<=(j&(~Q)) | ((~k)&Q);

end
assign Q_temp = Q ;
endmodule