// HDLBits: Sequence recognition
// Category: Sequential Logic - Finite State Machines
// Author: Ahmed Husseiny

module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);


localparam IDLE_S0 = 3'd0,
           ONES_S  = 3'd1,
           DISC_S  = 3'd2,
           FLAG_S  = 3'd3,
           ERR_S   = 3'd4;

reg [3:0] counter;
reg [2:0] state, next_state;

always @(posedge clk ) begin
    if (reset || in == 1'b0 ) begin
        counter <= 4'd0 ;
    end else begin
        counter <= counter + 1'b1 ;
    end 
end

always @(posedge clk ) begin
    if (reset) begin
        state <= IDLE_S0;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        IDLE_S0 : next_state = (in == 1'b1) ?  ONES_S:IDLE_S0 ;
        ONES_S  : if (in == 1'b1 && counter == 4'd6) begin
                    next_state = ERR_S;
                end else if (in == 1'b0 && counter == 4'd5) begin
                    next_state = DISC_S;
                end else if (in == 1'b0 && counter == 4'd6) begin
                    next_state = FLAG_S;
                end else if (in == 1'b1 && counter < 4'd6) begin
                    next_state = ONES_S;
                end else begin
                    next_state = IDLE_S0;
                end
        
        DISC_S  : next_state = (in == 1'b1) ?  ONES_S:ONES_S ;
        FLAG_S  : next_state = (in == 1'b1) ?  ONES_S:ONES_S ;
        ERR_S   : next_state = (in == 1'b1) ?  ERR_S:ONES_S ;
        default: next_state = IDLE_S0;
    endcase
end

assign disc = (state == DISC_S);
assign flag = (state == FLAG_S);
assign err  = (state == ERR_S);      
endmodule