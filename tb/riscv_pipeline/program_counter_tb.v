`timescale 1ns/1ps

module program_counter_tb;

reg clk;
reg rst;

wire [31:0] pc;
wire [31:0] next_pc;

program_counter PC(

.clk(clk),
.rst(rst),

.next_pc(next_pc),

.pc(pc)

);

pc_plus4 ADDER(

.pc(pc),

.next_pc(next_pc)

);

always #5 clk = ~clk;

initial
begin

$dumpfile("program_counter.vcd");
$dumpvars(0,program_counter_tb);

clk = 0;
rst = 1;

#20;

rst = 0;

#100;

$finish;

end

endmodule