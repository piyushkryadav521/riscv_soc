`timescale 1ns/1ps

module mbist_controller_tb;

reg clk;
reg rst;
reg start;

wire done;
wire fail;

mbist_controller DUT(

    .clk(clk),
    .rst(rst),
    .start(start),

    .done(done),
    .fail(fail)

);

always #5 clk = ~clk;

initial begin

    clk = 0;
    rst = 1;
    start = 0;

    #20;

    rst = 0;

    #20;

    start = 1;

    #10;

    start = 0;

    #100;

    $finish;

end

initial begin
    $dumpfile("mbist.vcd");
    $dumpvars(0, mbist_controller_tb);
end

endmodule