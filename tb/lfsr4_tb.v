`timescale 1ns/1ps

module lfsr4_tb;

reg clk;
reg rst;

wire [3:0] lfsr;

lfsr4 DUT(

    .clk(clk),
    .rst(rst),
    .lfsr(lfsr)

);

always #5 clk = ~clk;

initial begin

    clk = 0;
    rst = 1;

    #20;
    rst = 0;

    #200;

    $finish;

end

initial begin
    $dumpfile("lfsr4.vcd");
    $dumpvars(0,lfsr4_tb);
end

endmodule