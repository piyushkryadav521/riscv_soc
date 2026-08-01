`timescale 1ns/1ps

module spi_master_tb;

reg clk;
reg rst;
reg start;
reg [7:0] tx_data;

wire sclk;
wire mosi;
wire cs_n;
wire busy;

spi_master #(
    .CLK_DIV(4)
) dut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .tx_data(tx_data),
    .sclk(sclk),
    .mosi(mosi),
    .cs_n(cs_n),
    .busy(busy)
);

always #5 clk = ~clk;

initial begin
    $dumpfile("spi_master.vcd");
    $dumpvars(0, spi_master_tb);

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

    #500;
    $finish;
end

endmodule