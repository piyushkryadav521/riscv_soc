`timescale 1ns/1ps

module instruction_fetch_tb;

reg clk;
reg rst;

wire [31:0] pc;
wire [31:0] instruction;

instruction_fetch dut(

.clk(clk),
.rst(rst),

.pc(pc),
.instruction(instruction)

);

always #5 clk = ~clk;

initial begin

$dumpfile("instruction_fetch.vcd");
$dumpvars(0,instruction_fetch_tb);

clk = 0;
rst = 1;

#20;

rst = 0;

#100;

$finish;

end

endmodule