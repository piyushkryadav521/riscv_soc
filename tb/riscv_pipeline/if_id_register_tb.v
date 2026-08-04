`timescale 1ns/1ps

module if_id_register_tb;

reg clk;
reg rst;

reg [31:0] if_pc;
reg [31:0] if_instruction;

wire [31:0] id_pc;
wire [31:0] id_instruction;

if_id_register dut(

.clk(clk),
.rst(rst),

.if_pc(if_pc),
.if_instruction(if_instruction),

.id_pc(id_pc),
.id_instruction(id_instruction)

);

always #5 clk = ~clk;

initial
begin

$dumpfile("if_id_register.vcd");
$dumpvars(0,if_id_register_tb);

clk = 0;
rst = 1;

if_pc = 0;
if_instruction = 0;

#20;

rst = 0;

// First instruction

if_pc = 32'd4;
if_instruction = 32'h00500093;

#10;

// Second instruction
if_pc = 32'd8;
if_instruction = 32'h002081B3;

#20;

$finish;

end

endmodule