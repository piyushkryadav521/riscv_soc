module uart_tx #

(

parameter CLK_FREQ = 50000000,
parameter BAUD_RATE = 115200

)

(

input clk,
input rst,

input tx_start,
input [7:0] tx_data,

output reg tx,
output reg tx_busy

);

localparam BAUD_COUNT = CLK_FREQ / BAUD_RATE;
reg [15:0] baud_counter;
reg [3:0] bit_counter;

reg [9:0] shift_reg;

always @(posedge clk or posedge rst)

begin

    if(rst)

    begin

        tx <= 1'b1;
        tx<=1'b0;

        shift_reg <= {1'b1,tx_data,1'b0};

    end

    else

    begin

        if(!tx_busy)

        begin

            if(tx_start)

            begin

                tx_busy <= 1;

                shift_reg <= {1'b1,tx_data,1'b0};

                baud_counter <= 0;

                bit_counter <= 0;

            end

        end

        else

        begin

            if(baud_counter == BAUD_COUNT-1)

            begin

                baud_counter <= 0;

                tx <= shift_reg[0];

                shift_reg <= {1'b1,shift_reg[9:1]};

                bit_counter <= bit_counter + 1;

                if(bit_counter == 4'd9)

                begin
                    tx<=1'b1;
                    tx_busy <= 0;

                    tx <= 1'b1;

                end

            end

            else

                baud_counter <= baud_counter + 1;

        end

    end

end

endmodule