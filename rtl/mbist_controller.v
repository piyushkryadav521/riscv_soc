`timescale 1ns/1ps

module mbist_controller(

    input wire clk,
    input wire rst,
    input wire start,

    output reg done,
    output reg fail

);

reg [2:0] state;

localparam IDLE   = 3'd0,
           WRITE0 = 3'd1,
           READ0  = 3'd2,
           WRITE1 = 3'd3,
           READ1  = 3'd4,
           PASS   = 3'd5;

always @(posedge clk or posedge rst) begin

    if (rst) begin
        state <= IDLE;
        done  <= 0;
        fail  <= 0;
    end
    else begin

        case(state)

            IDLE:
                if(start)
                    state <= WRITE0;

            WRITE0:
                state <= READ0;

            READ0:
                state <= WRITE1;

            WRITE1:
                state <= READ1;

            READ1:
                state <= PASS;

            PASS: begin
                done <= 1;
                fail <= 0;
            end

        endcase

    end

end

endmodule