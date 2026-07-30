module spi_slave(

    input sclk,
    input rst,

    input cs_n,

    input mosi,

    output reg [7:0] rx_data,
    output reg rx_done

);

reg [7:0] shift_reg;
reg [2:0] bit_counter;

always @(posedge sclk or posedge rst)

begin

    if(rst)

    begin

        shift_reg <= 8'd0;

        rx_data <= 8'd0;

        bit_counter <= 3'd0;

        rx_done <= 1'b0;

    end

    else

    begin

        rx_done <= 1'b0;

        if(!cs_n)

        begin

            shift_reg <= {shift_reg[6:0], mosi};

            if(bit_counter == 3'd7)

            begin

                rx_data <= {shift_reg[6:0], mosi};

                rx_done <= 1'b1;

                bit_counter <= 3'd0;

            end

            else

            begin

                bit_counter <= bit_counter + 1;

            end

        end

        else

        begin

            bit_counter <= 3'd0;

        end

    end

end

endmodule