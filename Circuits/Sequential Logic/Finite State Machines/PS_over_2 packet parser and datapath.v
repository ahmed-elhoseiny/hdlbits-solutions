// HDLBits: PS_over_2 packet parser and datapath
// Category: Sequential Logic - Finite State Machines
// Author: Ahmed Husseiny

module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    // FSM from fsm_ps2

localparam WAIT_BYTE1 = 2'd0 ,
                BYTE2 = 2'd1 ,
                BYTE3 = 2'd2 ,
                DONE  = 2'd3 ;

reg [1:0] state, next_state;

    // State transition logic (combinational)
always @(*) begin
    case (state)
     WAIT_BYTE1 :  next_state = (in[3] == 1) ? BYTE2:WAIT_BYTE1 ;
     BYTE2      :  next_state = BYTE3;
     BYTE3      :  next_state = DONE;
     DONE       :  next_state = (in[3] == 1) ? BYTE2:WAIT_BYTE1; 
        default: next_state = WAIT_BYTE1 ;
    endcase
end
    // State flip-flops (sequential)
always @(posedge clk ) begin
if (reset) begin
    state <= WAIT_BYTE1 ;
end else begin
    state <= next_state ;
end
end
    // Output logic
assign done = (state == DONE);

    // New: Datapath to store incoming bytes.
always @(posedge clk ) begin
    if (reset) begin
        out_bytes <= 24'd0;
    end else begin
        case (state)
        WAIT_BYTE1 :  out_bytes = (in[3] == 1) ? {in,8'd0,8'd0}:24'd0 ;
        BYTE2      :  out_bytes = {out_bytes[23:16],in,8'd0};
        BYTE3      :  out_bytes = {out_bytes[23:16],out_bytes[15:8],in};
        DONE       :  out_bytes = (in[3] == 1) ? {in,8'd0,8'd0}:24'd0 ;
    default: out_bytes = (in[3] == 1) ? {in,8'd0,8'd0}:24'd0 ;
    endcase
    end
end

endmodule
