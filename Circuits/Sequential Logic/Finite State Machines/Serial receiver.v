// HDLBits: Serial receiver
// Category: Sequential Logic - Finite State Machines
// Author: Ahmed Husseiny

module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 


localparam IDLE      = 3'd0, // الانتظار حتى يصبح المدخل 0 (اكتشاف الـ Start bit).
           DATA      = 3'd1, // البقاء في هذه الحالة لمدة 8 دورات ساعة لجمع البيانات.
           STOP      = 3'd2, // التحقق من وجود الـ Stop bit (القيمة 1).
           WAIT_STOP = 3'd3, // في حال كان الـ Stop bit خاطئاً (0)، ننتظر هنا حتى يعود الخط للقيمة 1 قبل البدء من جديد
           DONE      = 3'd4;

reg [2:0] state, next_state;
reg [3:0] count_up_8;

always @(posedge clk ) begin
    if (reset) begin
        state <= IDLE ;
        count_up_8 <= 4'd0;
    end else begin
        state <= next_state ;

        if (state == DATA) begin
            count_up_8 <= count_up_8 + 1'b1;
        end else begin
            count_up_8 <= 4'd0;
        end

    end
end

always @(*) begin
    case (state)
        IDLE      : next_state = (in == 1'b0)         ? DATA : IDLE     ;  
        DATA      : next_state = (count_up_8 == 4'd7) ? STOP : DATA     ;  
        STOP      : next_state = (in == 1'b1)         ? DONE : WAIT_STOP;  
        WAIT_STOP : next_state = (in == 1'b1)         ? IDLE : WAIT_STOP;
        DONE      : next_state = (in == 1'b0)         ? DATA : IDLE     ;
        default: next_state = IDLE;
    endcase
end

assign done = (state == DONE);
endmodule