`timescale 1ns/1ps

module pipelined_riscv_cpu(

    input wire clk,
    input wire rst

);

// Internal Wires
wire [31:0] pc;
wire [31:0] instruction;

// IF/ID
wire [31:0] if_pc;
wire [31:0] if_instruction;

// ID/EX
wire [31:0] id_rs1;
wire [31:0] id_rs2;
wire [31:0] id_imm;

// EX/MEM
wire [31:0] ex_result;

// MEM/WB
wire [31:0] wb_result;

// Register File
wire [31:0] read_data1;
wire [31:0] read_data2;

// Immediate Generator
wire [31:0] immediate;

// ALU
wire [31:0] alu_result;
wire zero;

// Data Memory
wire [31:0] mem_read_data;

// Program Counter
program_counter PC (

    .clk(clk),
    .rst(rst),
    .pc(pc)

);

// Instruction Memory
instruction_memory IMEM (

    .addr(pc),
    .instruction(instruction)

);

// IF/ID Pipeline Register
if_id_pipeline IF_ID (

    .clk(clk),
    .rst(rst),

    .pc_in(pc),
    .instruction_in(instruction),

    .pc_out(if_pc),
    .instruction_out(if_instruction)

);

register_file RF(

    .clk(clk),
    .rst(rst),
    .we(1'b0),

    .rs1(instruction[19:15]),
    .rs2(instruction[24:20]),
    .rd(5'd0),

    .write_data(32'd0),

    .read_data1(read_data1),
    .read_data2(read_data2)

);

immediate_generator IMM(

    .instruction(instruction),
    .immediate(immediate)

);

control_unit CU(

    .opcode(instruction[6:0]),

    .RegWrite(),
    .MemRead(),
    .MemWrite(),
    .MemtoReg(),
    .ALUSrc(),
    .Branch(),
    .ALUOp()

);

alu_control ALUCTRL(

    .ALUOp(2'b10),
    .funct3(instruction[14:12]),
    .funct7(instruction[31:25]),

    .alu_ctrl(alu_ctrl)

);

alu ALU(

    .a(read_data1),
    .b(read_data2),

    .alu_control(alu_ctrl),

    .result(alu_result),
    .zero(zero)

);

data_memory DM(

    .clk(clk),

    .MemRead(1'b0),
    .MemWrite(1'b0),

    .addr(alu_result),

    .write_data(read_data2),

    .read_data(mem_read_data)

);
endmodule