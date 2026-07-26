`timescale 1ns/1ps

module cdc_sync_tb;

reg clk;
reg rst;
reg async_signal;

wire sync_signal;

cdc_sync DUT (

    .clk(clk),
    .rst(rst),
    .async_signal(async_signal),
    .sync_signal(sync_signal)

);

always #5 clk = ~clk;

initial begin

    clk = 0;
    rst = 1;
    async_signal = 0;

    #20 rst = 0;

    #13 async_signal = 1;
    #17 async_signal = 0;
    #23 async_signal = 1;
    #20 async_signal = 0;

    #50;

    $finish;

end

initial begin
    $dumpfile("cdc_sync.vcd");
    $dumpvars(0,cdc_sync_tb);
end

endmodule