`timescale 1ns/1ps

module spi_slave_tb;

reg sclk;
reg rst;
reg cs_n;
reg mosi;

wire [7:0] rx_data;
wire rx_done;

spi_slave dut (
    .sclk(sclk),
    .rst(rst),
    .cs_n(cs_n),
    .mosi(mosi),
    .rx_data(rx_data),
    .rx_done(rx_done)
);

initial begin
    $dumpfile("spi_slave.vcd");
    $dumpvars(0, spi_slave_tb);

    sclk = 0;
    rst  = 1;
    cs_n = 1;
    mosi = 0;

    #20 rst = 0;
    #20 cs_n = 0;

    // Send 8'b10100101 (MSB first)
    mosi = 1; #5 sclk = 1; #5 sclk = 0;
    mosi = 0; #5 sclk = 1; #5 sclk = 0;
    mosi = 1; #5 sclk = 1; #5 sclk = 0;
    mosi = 0; #5 sclk = 1; #5 sclk = 0;
    mosi = 0; #5 sclk = 1; #5 sclk = 0;
    mosi = 1; #5 sclk = 1; #5 sclk = 0;
    mosi = 0; #5 sclk = 1; #5 sclk = 0;
    mosi = 1; #5 sclk = 1; #5 sclk = 0;

    cs_n = 1;

    #20;
    $display("Received Data = %h", rx_data);

    $finish;
end

endmodule