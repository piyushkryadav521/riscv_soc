module spi_master #

(
parameter CLK_DIV = 4
)

(

input clk,
input rst,

input start,
input [7:0] tx_data,

output reg sclk,
output reg mosi,
output reg cs_n,

output reg busy

);
reg [7:0] shift_reg;
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

    end

    else

    begin

        case(state)

            IDLE:
            begin

            end

            LOAD:
            begin

            end

            SHIFT:
            begin

            end

            DONE:
            begin

            end

        endcase

    end

end