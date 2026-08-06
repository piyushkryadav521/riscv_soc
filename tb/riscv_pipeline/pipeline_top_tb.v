`timescale 1ns/1ps

module riscv_pipeline_top_tb;

reg clk;
reg rst;

riscv_pipeline_top dut(

.clk(clk),
.rst(rst)

);

always #5 clk = ~clk;

initial
begin

$dumpfile("riscv_pipeline_top.vcd");
$dumpvars(0, riscv_pipeline_top_tb);
$dumpvars(1, dut);

clk = 0;
rst = 1;

#20;

rst = 0;

#100;

$finish;

end

endmodule