module uart_rx #(
    parameter CLK_FREQ  = 50000000,
    parameter BAUD_RATE = 115200
)(
    input clk,
    input rst,
    input rx,

    output reg [7:0] rx_data,
    output reg rx_done
);

localparam BAUD_COUNT = CLK_FREQ / BAUD_RATE;

reg [15:0] baud_counter;
reg [2:0] bit_counter;
reg [7:0] shift_reg;

reg receiving;

always @(posedge clk or posedge rst)
begin

    if(rst)
    begin

        baud_counter <= 0;
        bit_counter <= 0;

        receiving <= 0;
        bit_counter<=0;

        rx_done <= 0;

        rx_data <= 0;
        shift_reg <= 0;

    end

    else
    begin

        rx_done <= 0;

        if(!receiving)
        begin

            if(rx==0)
            begin

                receiving <= 1;

                baud_counter <= 0;

                bit_counter <= 0;

            end

        end

        else
        begin

            if(baud_counter == BAUD_COUNT-1)
            begin

                baud_counter <= 0;

                if(bit_counter <3'd7)
                begin

                    shift_reg[bit_counter] <= rx;
                    bit_counter <= bit_counter + 1;

                end

                else
                begin
                    shift_reg[bit_counter] <= rx;
                    rx_data <= {rx, shift_reg[6:0]};

                end

            end

            else

                baud_counter <= baud_counter + 1;

        end

    end

end

endmodule