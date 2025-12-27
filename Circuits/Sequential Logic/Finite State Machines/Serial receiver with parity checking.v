// HDLBits: Serial receiver with parity checking
// Category: Sequential Logic - Finite State Machines
// Author: Ahmed Husseiny

module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output reg [7:0] out_byte,
    output done
); //

    // Modify FSM and datapath from Fsm_serialdata
    // Use FSM from Fsm_serial

localparam IDLE      = 3'd0, // الانتظار حتى يصبح المدخل 0 (اكتشاف الـ Start bit).
           DATA      = 3'd1, // البقاء في هذه الحالة لمدة 8 دورات ساعة لجمع البيانات.
           PARITY    = 3'd2,
           STOP      = 3'd3, // التحقق من وجود الـ Stop bit (القيمة 1).
           WAIT_STOP = 3'd4, // في حال كان الـ Stop bit خاطئاً (0)، ننتظر هنا حتى يعود الخط للقيمة 1 قبل البدء من جديد
           DONE      = 3'd5;

reg [2:0] state, next_state;
reg [3:0] count_up_8;
wire parity_odd;
wire reset_parity;

always @(posedge clk ) begin
    if (reset) begin
        state <= IDLE ;
        count_up_8 <= 4'd0;
    end else begin
        state <= next_state ;

        if (state == DATA) begin
            count_up_8 <= count_up_8 + 1'b1;
            out_byte[count_up_8] <= in;
        end else begin
            count_up_8 <= 4'd0;
        end

    end
end

always @(*) begin
    case (state)
        IDLE      : next_state = (in == 1'b0)         ? DATA : IDLE     ;  
        DATA      : next_state = (count_up_8 == 4'd7) ? PARITY : DATA   ;  
        PARITY    : next_state = STOP ;
        STOP      : begin
            if (in) begin
                next_state = (parity_odd == 1'b1)     ? DONE : IDLE; 
            end else begin
                next_state = WAIT_STOP;
            end 
        end
        WAIT_STOP : next_state = (in == 1'b1)         ? IDLE : WAIT_STOP;
        DONE      : next_state = (in == 1'b0)         ? DATA : IDLE     ;
        default: next_state = IDLE;
    endcase
end

assign done = (state == DONE);


    // New: Add parity checking.
    parity u_parity (
        .clk(clk),
        .reset(reset || (state == IDLE && next_state == DATA) || (state == DONE && next_state == DATA) || (state == DONE)),
        .in(in ),
        .odd(parity_odd)
    );

endmodule

//________________________________________________________________//
module parity (
    input clk,
    input reset,
    input in,
    output reg odd);

    always @(posedge clk)
        if (reset) odd <= 0;
        else if (in) odd <= ~odd;

endmodule