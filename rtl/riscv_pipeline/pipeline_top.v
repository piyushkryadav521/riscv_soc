module riscv_pipeline_top(

input clk,
input rst

);

// Instruction Fetch
wire [31:0] pc;

// Instruction Decode
wire [31:0] instruction;

wire [4:0] rs1;
wire [4:0] rs2;
wire [4:0] rd;

wire [6:0] opcode;

wire [2:0] funct3;

wire [6:0] funct7;

// Control Signals

wire RegWrite;

wire ALUSrc;

wire MemRead;
wire MemWrite;

wire MemtoReg;

wire Branch;

wire [1:0] ALUOp;

// Register File
wire [31:0] rs1_data;
wire [31:0] rs2_data;

// Immediate Generator
wire [31:0] immediate;

// Execute
wire [31:0] alu_result;

wire zero;

// Memory
wire [31:0] memory_data;

// Write Back
wire [31:0] write_data;

// Module Instantiations
instruction_decode ID(

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

execute_stage EX(

.operand_a(rs1_data),
.operand_b(rs2_data),

.alu_control(4'b0000),

.alu_result(alu_result),

.zero(zero)

);

memory_stage MEM(

.clk(clk),

.mem_read(memRead),
.mem_write(memWrite),

.address(alu_result),

.write_data(rs2_data),

.read_data(memory_data)

);

write_back WB(

.mem_to_reg(MemtoReg),

.alu_result(alu_result),

.memory_data(memory_data),

.write_data(write_data)

);

endmodule