module spi_mode0_tb;

    // signal declarations

    reg clk;
    reg rst;
    reg start;
    reg [7:0] tx_data;

    wire sclk;
    wire mosi;
    wire cs_n;
    wire miso;

    wire [7:0] rx_data;
    wire busy;

    // DUT instantiation
    spi_master #(
        .CLK_DIV(4)
    ) master (
        .clk(clk),
        .rst(rst),
        .start(start),
        .tx_data(tx_data),
        .miso(miso),
        .sclk(sclk),
        .mosi(mosi),
        .cs_n(cs_n),
        .rx_data(rx_data),
        .busy(busy)
    );

    // clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        start = 0;
        tx_data = 8'hA5;

        #20 rst = 0;

        #20 start = 1;
        #10 start = 0;

        #500 $finish;
    end

endmodule