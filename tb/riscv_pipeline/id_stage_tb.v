`timescale 1ns/1ps

module id_stage_tb;

reg clk;
reg rst;

reg [31:0] instruction;
reg [31:0] write_data;

wire [31:0] rs1_data;
wire [31:0] rs2_data;
wire [31:0] immediate;

wire RegWrite;
wire ALUSrc;
wire MemRead;
wire MemWrite;
wire MemtoReg;
wire Branch;

wire [1:0] ALUOp;

wire [4:0] rs1;
wire [4:0] rs2;
wire [4:0] rd;

wire [2:0] funct3;
wire [6:0] funct7;

id_stage DUT(

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

always #5 clk = ~clk;

initial begin

$dumpfile("id_stage.vcd");
$dumpvars(0,id_stage_tb);

clk = 0;
rst = 1;

instruction = 32'h00500093;   // addi x1,x0,5
write_data = 0;

#20;

rst = 0;

#100;

$finish;

end

endmodule