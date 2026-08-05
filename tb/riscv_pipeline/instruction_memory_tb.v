`timescale 1ns/1ps

module instruction_memory_tb;

reg [31:0] address;

wire [31:0] instruction;

instruction_memory dut(

.address(address),
.instruction(instruction)

);

initial begin

$dumpfile("instruction_memory.vcd");
$dumpvars(0,instruction_memory_tb);

address = 0;
#20;

address = 4;
#20;

address = 8;
#20;

address = 12;
#20;

address = 16;
#20;

$finish;

end

endmodule