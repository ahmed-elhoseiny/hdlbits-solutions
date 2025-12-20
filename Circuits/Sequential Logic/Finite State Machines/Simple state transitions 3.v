module top_module(
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out); //

    parameter A=2'd0, B=2'd1, C=2'd2, D=2'd3;

    // State transition logic: next_state = f(state, in)
    always @(*) begin
    case (state)
        A: next_state =(in == 1'b1)? B:A ;
        B: next_state =(in == 1'b1)? B:C ;
        C: next_state =(in == 1'b1)? D:A ;
        D: next_state =(in == 1'b1)? B:C ;
    endcase
    end
    // Output logic:  out = f(state) for a Moore state machine
    always @(*) begin
    case (state)
        A: out = 1'b0 ;
        B: out = 1'b0 ;
        C: out = 1'b0 ;
        D: out = 1'b1 ;
    endcase
    end
endmodule