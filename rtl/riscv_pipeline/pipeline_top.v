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

// ALU Control
wire [3:0] ALUCtrl; 

wire [31:0] operand_b_mux;

execute_stage EX(

.operand_a(rs1_data),
.operand_b(operand_b_mux),

.alu_control(ALUCtrl),

.alu_result(alu_result),

.zero(zero)

);

memory_stage MEM(

.clk(clk),

.mem_read(MemRead),
.mem_write(MemWrite),

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

instruction_fetch IF(
.clk(clk),
.rst(rst),

.pc(pc),
.instruction(instruction)
);

id_stage ID(

.clk(clk),
.rst(rst),

.instruction(instruction),
.write_data(write_data),

.rs1_data(rs1_data),
.rs2_data(rs2_data),
.immediate(immediate),

.RegWrite(RegWrite),
.ALUSrc(ALUSrc),
.MemRead(MemRead),
.MemWrite(MemWrite),
.MemtoReg(MemtoReg),
.Branch(Branch),

.ALUOp(ALUOp),

.rs1(rs1),
.rs2(rs2),
.rd(rd),

.funct3(funct3),
.funct7(funct7)
);

alu_control ALUCTRL(

.ALUOp(ALUOp),
.funct3(funct3),
.funct7(funct7),

.ALUCtrl(ALUCtrl)
);

endmodule