`timescale 1ns/1ps

module spi_loopback_tb;

reg clk;
reg rst;
reg start;
reg [7:0] tx_data;

wire sclk;
wire mosi;
wire cs_n;
wire busy;
wire miso;

wire [7:0] rx_data;
wire rx_done;

// SPI Master
spi_master #(
    .CLK_DIV(4)
)
master(

    .clk(clk),
    .rst(rst),

    .start(start),
    .tx_data(tx_data),

    .sclk(sclk),
    .mosi(mosi),
    .cs_n(cs_n),

    .busy(busy)
    .miso(miso),

);

// SPI Slave
spi_slave slave(

    .sclk(sclk),
    .rst(rst),

    .cs_n(cs_n),

    .mosi(mosi),

    .rx_data(rx_data),
    .rx_done(rx_done)

);

// System clock
always #5 clk = ~clk;

initial
begin

    $dumpfile("spi_loopback.vcd");
    $dumpvars(0, spi_loopback_tb);

    clk = 0;
    rst = 1;

    start = 0;

    tx_data = 8'hA5;

    #20;
    rst = 0;

    #20;

    start = 1;

    #10;

    start = 0;

    wait(rx_done);

    if(rx_data == 8'hA5)
        $display("PASS : SPI Loopback Successful");

    else
        $display("FAIL : Received = %h", rx_data);

    #50;

    $finish;

end

endmodule