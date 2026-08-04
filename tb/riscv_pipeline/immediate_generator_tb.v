`timescale 1ns/1ps

module immediate_generator_tb;

reg [31:0] instruction;

wire [31:0] immediate;

immediate_generator dut(

.instruction(instruction),
.immediate(immediate)

);

initial
begin

$dumpfile("immediate_generator.vcd");
$dumpvars(0,immediate_generator_tb);

// addi x1,x0,5
instruction = 32'h00500093;

#20;

// sw x1,8(x0)

instruction = 32'h00102423;

#20;

// beq x1,x2,16

instruction = 32'h00208863;

#20;

$finish;

end

endmodule