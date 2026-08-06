module id_stage(

input clk,
input rst,

input [31:0] instruction,

input [31:0] write_data,

output [31:0] rs1_data,
output [31:0] rs2_data,

output [31:0] immediate,

output RegWrite,
output ALUSrc,
output MemRead,
output MemWrite,
output MemtoReg,
output Branch,

output [1:0] ALUOp,

output [4:0] rs1,
output [4:0] rs2,
output [4:0] rd,

output [2:0] funct3,
output [6:0] funct7

);

wire [6:0] opcode;

instruction_decode DEC(

.instruction(instruction),

.opcode(opcode),

.rd(rd),

.funct3(funct3),

.rs1(rs1),

.rs2(rs2),

.funct7(funct7)

);

control_unit CTRL(

.opcode(opcode),

.RegWrite(RegWrite),

.ALUSrc(ALUSrc),

.MemRead(MemRead),

.MemWrite(MemWrite),

.MemtoReg(MemtoReg),

.Branch(Branch),

.ALUOp(ALUOp)

);

register_file RF(

.clk(clk),

.rst(rst),

.RegWrite(RegWrite),

.rs1(rs1),

.rs2(rs2),

.rd(rd),

.write_data(write_data),

.rs1_data(rs1_data),

.rs2_data(rs2_data)

);

immediate_generator IMM(

.instruction(instruction),

.immediate(immediate)

);

endmodule