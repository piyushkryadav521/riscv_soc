module spi_master #

(
    parameter CLK_DIV = 4
)

(

    input clk,
    input rst,

    input start,
    input [7:0] tx_data,
    input miso,

    output reg sclk,
    output reg mosi,
    output reg cs_n,
    output reg [7:0] rx_data,

    output reg busy
);

reg [7:0] shift_reg;
reg [7:0] rx_shift_reg;
reg [2:0] bit_counter;
reg [7:0] clk_counter;

reg [1:0] state;

localparam IDLE  = 2'd0;
localparam LOAD  = 2'd1;
localparam SHIFT = 2'd2;
localparam DONE  = 2'd3;

always @(posedge clk or posedge rst)

begin

    if(rst)

    begin

        state <= IDLE;

        busy <= 0;

        cs_n <= 1;

        sclk <= 0;

        mosi <= 0;

        clk_counter <= 0;

        bit_counter <= 0;

        shift_reg <= 0;

        rx_shift_reg <= 0;
        rx_data <= 0;

    end

    else

    begin

        case(state)

        IDLE:

        begin

            busy <= 0;

            cs_n <= 1;

            sclk <= 0;

            if(start)

                state <= LOAD;

        end

        LOAD:

        begin

            busy <= 1;

            cs_n <= 0;

            shift_reg <= tx_data;

            bit_counter <= 3'd7;

            clk_counter <= 0;

            state <= SHIFT;

        end

        SHIFT:

        begin

            if(clk_counter == CLK_DIV-1)

            begin

                clk_counter <= 0;

                sclk <= ~sclk;

                if(sclk)

                begin

                    mosi <= shift_reg[7];
                    shift_reg <= {shift_reg[6:0],1'b0};

                    rx_shift_reg <= {rx_shift_reg[6:0], miso};
                    rx_data <= rx_shift_reg;

                    if(bit_counter==0)
                    begin
                        rx_data <= rx_shift_reg;
                        state <= DONE;
                    end
                    else
                    begin
                        bit_counter <= bit_counter - 1;
                    end
                end

            end

            else

                clk_counter <= clk_counter + 1;

        end

        DONE:

        begin

            busy <= 0;

            cs_n <= 1;

            sclk <= 0;

            state <= IDLE;

        end

        endcase

    end

end

endmodule