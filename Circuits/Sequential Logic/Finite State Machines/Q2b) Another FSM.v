// HDLBits: Q2b: Another FSM
// Category: Sequential Logic - Finite State Machines
// Author: Ahmed Husseiny

module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 

localparam  A          = 4'b0000,
            PULSE_F    = 4'b0001,
            X1         = 4'b0010,
            X2         = 4'b0011,
            X3         = 4'b0100,
            G_ON       = 4'b0101,
            WAIT_Y     = 4'b0110,
            PERM_G_ON  = 4'b0111,
            PERM_G_OFF = 4'b1000;

reg [3:0] state, next_state;

    always @(posedge clk) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            A:          next_state = PULSE_F;
            PULSE_F:    next_state = X1;
            X1:         next_state = (x) ? X2 : X1;
            X2:         next_state = (x) ? X2 : X3;
            X3:         next_state = (x) ? G_ON : X1;
            G_ON:       next_state = (y) ? PERM_G_ON : WAIT_Y;
            WAIT_Y:     next_state = (y) ? PERM_G_ON : PERM_G_OFF;
            PERM_G_ON:  next_state = PERM_G_ON;
            PERM_G_OFF: next_state = PERM_G_OFF;
            default:    next_state = A;
        endcase
    end

    assign f = (state == PULSE_F);
    assign g = (state == G_ON || state == WAIT_Y || state == PERM_G_ON);

endmodule