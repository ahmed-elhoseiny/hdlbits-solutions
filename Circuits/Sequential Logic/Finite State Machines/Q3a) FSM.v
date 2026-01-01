module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output reg z
);

localparam A = 1'b0,
            B = 1'b1;
reg  state, next_state;
reg [1:0] count, W_counter;

always @(posedge clk) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @(posedge clk) begin
    if (reset || state == A || count == 2'd2) begin
        count <= 2'b00;
    end else begin
        count <= count + 1'b1;
    end
end

always @(posedge clk) begin
        if (reset || state == A) begin
            W_counter <= 2'b00;
            z <= 1'b0;
        end else if (state == B) begin
            if (count == 2'd2) begin
                z <= (W_counter + w == 2'd2); 
                W_counter <= 2'b00;
            end else begin
                W_counter <= W_counter + w;
                z <= 1'b0; 
            end
        end
    end


always @(*) begin
    case (state)
        A: next_state = (s == 1'b1) ? B : A;
        B: next_state = B ;
        default: next_state = A;
    endcase
end


endmodule
