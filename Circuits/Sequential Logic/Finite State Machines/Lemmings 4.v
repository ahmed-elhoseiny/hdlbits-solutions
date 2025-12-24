// HDLBits: Lemmings 4
// Category: Sequential Logic - Finite State Machines
// Author: Ahmed Husseiny

module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 

localparam WALK_LEFT=3'd0, WALK_RIGHT=3'd1;
localparam FALL_LEFT=3'd2, FALL_RIGHT=3'd3;
localparam DIG_LEFT=3'd4, DIG_RIGHT=3'd5;
localparam SPLAT=3'd6;

    reg [2:0] state, next_state;
    reg [$clog2(100)-1:0] counter;

    always @(posedge clk , posedge areset) begin
        if (areset) begin
            counter <= 0;
        end else if (aaah == 1'b0) begin
            counter <= 0;
        end else if (aaah == 1'b1) begin
            counter <= counter + 1'b1;
        end else begin
            counter <= 0;
        end
    end

    always @(*) begin
        // State transition logic
        case (state)
            WALK_LEFT : if (ground == 1'b0) begin
                next_state = FALL_LEFT; 
            end else if (dig == 1'b1) begin
                next_state = DIG_LEFT; 
            end else if (bump_left == 1'b1) begin
                next_state = WALK_RIGHT; 
            end else begin
                next_state = WALK_LEFT; 
            end 
            WALK_RIGHT: if (ground == 1'b0) begin
                next_state = FALL_RIGHT; 
            end else if (dig == 1'b1) begin
                next_state = DIG_RIGHT; 
            end else if (bump_right == 1'b1) begin
                next_state = WALK_LEFT; 
            end else begin
                next_state = WALK_RIGHT; 
            end
            FALL_LEFT:  if ((ground == 1'b1) && (counter <= 19)) begin
                next_state = WALK_LEFT; 
            end else if ((ground == 1'b1) && (counter >= 20) ) begin
                next_state = SPLAT;
            end else begin
                next_state = FALL_LEFT;
            end
            FALL_RIGHT: if ((ground == 1'b1) && (counter <= 19)) begin
                next_state = WALK_RIGHT; 
            end else if ((ground == 1'b1) && (counter >= 20) ) begin
                next_state = SPLAT;
            end else begin
                next_state = FALL_RIGHT;
            end
            DIG_LEFT: if (ground == 1'b0) begin
                next_state = FALL_LEFT; 
            end else begin
                next_state = DIG_LEFT; 
            end
            DIG_RIGHT: if (ground == 1'b0) begin
                next_state = FALL_RIGHT; 
            end else begin
                next_state = DIG_RIGHT; 
            end
            SPLAT: next_state = SPLAT; 

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
    assign walk_left = (state == WALK_LEFT) && !(state == SPLAT);
    assign walk_right = (state == WALK_RIGHT) && !(state == SPLAT);
    assign aaah = ((state == FALL_LEFT) || (state == FALL_RIGHT)) && !(state == SPLAT);
    assign digging = ((state == DIG_LEFT) || (state == DIG_RIGHT)) && !(state == SPLAT);

endmodule