module i2c_master #(
    parameter CLK_DIV = 250
)(
    input  clk,
    input  rst,
    input  start,

    input  [6:0] slave_addr,
    input rw,
    input  sda_in,
    output reg ack_error,
    input [7:0] tx_data,

    output reg scl,
    output reg sda,
    output reg busy
);

localparam IDLE      = 3'd0;
localparam START     = 3'd1;
localparam SEND_ADDR = 3'd2;
localparam ACK       = 3'd3;
localparam SEND_DATA = 3'd4;
localparam STOP      = 3'd4;

reg [2:0] state;
reg [7:0] shift_reg;
reg [2:0] bit_cnt;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        state <= IDLE;
        scl   <= 1'b1;
        sda   <= 1'b1;
        busy  <= 1'b0;
        shift_reg <= 8'd0;
        bit_cnt   <= 3'd0;
        ack_error<=1'b0;
    end
    else begin
        case(state)

        IDLE: begin
            scl  <= 1'b1;
            sda  <= 1'b1;
            busy <= 1'b0;

            if(start)
                state <= START;
        end

        START: begin
            busy <= 1'b1;
            sda  <= 1'b0;
            shift_reg <= {slave_addr, rw};
            bit_cnt   <= 3'd7;

            state <= SEND_ADDR;
        end

        SEND_ADDR: begin
            // Address transmission will be added on Day
            scl<=1'b0;
            sda<=shift_reg[7];
            shift_reg <= {shift_reg[6:0],1'b0};

            if(bit_cnt == 0)
                state <= ACK;
            else
                bit_cnt <= bit_cnt - 1'b1;
        end

        ACK: begin
            scl <= 1'b1;

            if (sda_in == 1'b0) begin
                ack_error <= 1'b0;

                if (shift_reg == 8'd0) begin
                    shift_reg <= tx_data;
                    bit_cnt   <= 3'd7;
                    state <= SEND_DATA;
                end
                else begin
                    state <= STOP;
                end
            end
            else begin
                ack_error <= 1'b1;
                state <= STOP;
            end
        end
        // send data state 
        SEND_DATA: begin
            scl <= 1'b0;

            sda <= shift_reg[7];

            shift_reg <= {shift_reg[6:0],1'b0};

            if(bit_cnt == 0)
                state <= STOP;
            else
                bit_cnt <= bit_cnt - 1'b1;
        end

        STOP: begin
            scl<=1'b1;
            sda <= 1'b1;
            busy <= 1'b0;
            state <= IDLE;
            state<=STOP;
        end

        endcase
    end
end

endmodule