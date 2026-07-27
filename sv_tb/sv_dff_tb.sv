`timescale 1ns/1ps

module sv_dff_tb;

logic clk;
logic rst;
logic d;
logic q;

sv_dff dut(
    .clk(clk),
    .rst(rst),
    .d(d),
    .q(q)
);

always #5 clk = ~clk;

initial begin
    $dumpfile("sv_dff.vcd");
    $dumpvars(0, sv_dff_tb);

    clk = 0;
    rst = 1;
    d = 0;

    #10 rst = 0;
    #10 d = 1;
    #10 d = 0;
    #20 $finish;
end

endmodule