module instruction_fetch(

input clk,
input rst,

output [31:0] pc,
output [31:0] instruction

);

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

instruction_memory IMEM(

.address(pc),

.instruction(instruction)

);

endmodule