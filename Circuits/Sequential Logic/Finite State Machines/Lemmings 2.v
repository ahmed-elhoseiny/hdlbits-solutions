// HDLBits: Lemmings 2
// Category: Sequential Logic - Finite State Machines
// Author: Ahmed Husseiny

module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 

localparam WALK_LEFT=2'd0, WALK_RIGHT=2'd1;
localparam FALL_LEFT=2'd2, FALL_RIGHT=2'd3;

    reg [1:0] state, next_state;

    always @(*) begin
        // State transition logic
        case (state)
            WALK_LEFT : if (ground == 1'b0) begin
                next_state = FALL_LEFT; 
            end else if (bump_left == 1'b1) begin
                next_state = WALK_RIGHT; 
            end else begin
                next_state = WALK_LEFT; 
            end 
            WALK_RIGHT: if (ground == 1'b0) begin
                next_state = FALL_RIGHT; 
            end else if (bump_right == 1'b1) begin
                next_state = WALK_LEFT; 
            end else begin
                next_state = WALK_RIGHT; 
            end
            FALL_LEFT: if (ground == 1'b1) begin
                next_state = WALK_LEFT; 
            end else begin
                next_state = FALL_LEFT; 
            end
            FALL_RIGHT: if (ground == 1'b1) begin
                next_state = WALK_RIGHT; 
            end else begin
                next_state = FALL_RIGHT; 
            end
            default: next_state = WALK_LEFT; 
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if (areset) begin
            state <= WALK_LEFT;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    assign walk_left = (state == WALK_LEFT);
    assign walk_right = (state == WALK_RIGHT);
    assign aaah = (state == FALL_LEFT) || (state == FALL_RIGHT);

endmodule


