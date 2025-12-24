// HDLBits: Design a Moore FSM
// Category: Sequential Logic - Finite State Machines
// Author: Ahmed Husseiny

module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
);

localparam Below_S1  = 3'd0, 
           L1_Rising = 3'd1,
           L1_Falling= 3'd2,
           L2_Rising = 3'd3,
           L2_Falling= 3'd4,
           Above_S3  = 3'd5;

reg [2:0] current_state ,next_state ;
wire [2:0] S3_S2_S1;
reg [3:0] dFR_FR3_FR2_FR1;
assign S3_S2_S1 = s;
assign {dfr, fr3, fr2, fr1} = dFR_FR3_FR2_FR1;

always @(posedge clk ) begin
    if (reset) begin
        current_state <= Below_S1;
    end else begin
        current_state <= next_state ;
    end
end

always @(*) begin
    case (current_state)
        Below_S1  : begin
            if (S3_S2_S1 == 3'b001) begin
                next_state = L1_Rising;
            end else begin
                next_state = Below_S1;
            end
        end
        L1_Rising : begin
            if (S3_S2_S1 == 3'b011) begin
                next_state = L2_Rising;
            end else if (S3_S2_S1 == 3'b000) begin
                next_state = Below_S1;
            end else begin
                next_state = L1_Rising;
            end
        end
        L1_Falling: begin
            if (S3_S2_S1 == 3'b000) begin
                next_state = Below_S1;
            end else if (S3_S2_S1 == 3'b011) begin
                next_state = L2_Rising;
            end else begin
                next_state = L1_Falling;
            end
        end
        L2_Rising : begin
            if (S3_S2_S1 == 3'b111) begin
                next_state = Above_S3;
            end else if (S3_S2_S1 == 3'b001) begin
                next_state = L1_Falling;
            end else begin
                next_state = L2_Rising;
            end
        end
        L2_Falling: begin
            if (S3_S2_S1 == 3'b001) begin
                next_state = L1_Falling;
            end else if (S3_S2_S1 == 3'b111) begin
                next_state = Above_S3;
            end else begin
                next_state = L2_Falling;
            end
        end
        Above_S3  : begin
            if (S3_S2_S1 == 3'b011) begin
                next_state = L2_Falling;
            end else begin
                next_state = Above_S3;
            end
        end
        default : next_state = Below_S1;
    endcase
end





always @(*) begin
    case (current_state)
        Below_S1  : begin
            dFR_FR3_FR2_FR1 = 4'b1111;
        end
        L1_Rising : begin
            dFR_FR3_FR2_FR1 = 4'b0011;
        end
        L1_Falling: begin
            dFR_FR3_FR2_FR1 = 4'b1011;
        end
        L2_Rising : begin
            dFR_FR3_FR2_FR1 = 4'b0001;
        end
        L2_Falling: begin
            dFR_FR3_FR2_FR1 = 4'b1001;
        end
        Above_S3  : begin
            dFR_FR3_FR2_FR1 = 4'b0000;
        end
        default : dFR_FR3_FR2_FR1 = 4'b1111;
    endcase
end
endmodule

//________________________________________________________________//

// wire [7:0] a;
// assign a = 'x;

// Equivalent to:
// assign a = 8'bxxxxxxxx;

