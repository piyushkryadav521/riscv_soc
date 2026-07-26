`timescale 1ns/1ps

module reset_sync_tb;

reg clk;
reg rst_async;

wire rst_sync;

reset_sync DUT (

    .clk(clk),
    .rst_async(rst_async),
    .rst_sync(rst_sync)

);

always #5 clk = ~clk;

initial begin

    clk = 0;
    rst_async = 1;

    #17;
    rst_async = 0;

    #100;

    $finish;

end

initial begin
    $dumpfile("reset_sync.vcd");
    $dumpvars(0, reset_sync_tb);
end

endmodule