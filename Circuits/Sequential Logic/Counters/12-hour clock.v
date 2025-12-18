module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 

// seconds (00-59)
always @(posedge clk) begin
    if (reset || (ss == 8'h59 && ena == 1'b1)) begin
        ss <= 8'h00;
    end else if (ss[3:0] == 4'h9 && ena == 1'b1) begin
        ss <= {(ss[7:4]+4'h1) , 4'h0};
    end else if (ss[3:0] != 4'h9 && ena == 1'b1) begin
        ss[3:0]<= ss[3:0]+4'h1;
    end else begin
        ss <= ss;
    end
end

// minutes (00-59)
always @(posedge clk) begin
    if (reset || ({mm,ss} == 16'h59_59 && ena == 1'b1)) begin
        mm <= 8'h00;
    end else if ({mm[3:0],ss} == 12'h9_59 && ena == 1'b1) begin
        mm <= {(mm[7:4]+4'h1) , 4'h0};
    end else if (mm[3:0] != 4'h9 && ss == 8'h59 && ena == 1'b1) begin
        mm[3:0]<= mm[3:0]+4'h1;
    end else begin
        mm <= mm;
    end
end

// hours (01-12)AM -- (01-12)PM
always @(posedge clk) begin
    if (reset) begin
        hh <= 8'h12;
        pm <= 0;
    end else if ({hh,mm,ss}==24'h11_59_59 && ena == 1'b1) begin
        hh <= 8'h12;
        pm <= ~pm;
    end else if ({hh,mm,ss}==24'h12_59_59 && ena == 1'b1&& ena == 1'b1) begin
        hh <= 8'h01;
    end else if ({hh[3:0],mm,ss}==20'h9_59_59 && ena == 1'b1) begin
        hh <= {hh[7:4]+4'h1,4'h0};
    end else if ({mm,ss}==16'h59_59 && ena == 1'b1) begin
        hh[3:0] <= hh[3:0]+4'h1;
    end else begin
        hh <= hh;
    end
end
    
endmodule