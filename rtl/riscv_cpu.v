`timescale 1ns/1ps

module riscv_cpu(

    input wire clk,
    input wire rst

);

    // Internal Wires
    wire [31:0] pc;
    wire [31:0] instruction;

    wire [31:0] immediate;
    wire [31:0] mem_data;

    // Control Signals
    wire RegWrite;
    wire ALUSrc;
    wire MemRead;
    wire MemWrite;
    wire MemtoReg;
    wire Branch;
    wire Jump;
    wire [1:0] ALUOp;

    // Register File
    wire [31:0] read_data1;
    wire [31:0] read_data2;
    wire [31:0] write_data;

    // ALU Control
    wire [3:0] alu_ctrl;

// ALU
    wire [31:0] alu_input2;
    wire [31:0] alu_result;
    wire zero;

    // Program Counter
    program_counter PC (

        .clk(clk),
        .rst(rst),
        .pc(pc)

    );

    // Instruction Memory
    instruction_memory IM (

        .addr(pc),
        .instruction(instruction)

    );

// Control Unit

    control_unit CU (

        .opcode(instruction[6:0]),

        .RegWrite(RegWrite),
        .ALUSrc(ALUSrc),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg),
        .Branch(Branch),
        .Jump(Jump),
        .ALUOp(ALUOp)

);

// Immediate Generator
    immediate_generator IMM (

        .instruction(instruction),
        .immediate(immediate)

);

// Register File
    register_file RF (

        .clk(clk),
        .rst(rst),
        .we(RegWrite),

        .rs1(instruction[19:15]),
        .rs2(instruction[24:20]),
        .rd(instruction[11:7]),

        .write_data(write_data),

        .read_data1(read_data1),
        .read_data2(read_data2)

);

// ALU Control
    alu_control ALUCTRL (

        .ALUOp(ALUOp),
        .funct3(instruction[14:12]),
        .funct7(instruction[31:25]),
        .alu_ctrl(alu_ctrl)

);

// ALU
    alu ALU (

        .a(read_data1),
        .b(alu_input2),
        .alu_control(alu_ctrl),
        .result(alu_result),
        .zero(zero)

);
    data_memory DM (

        .clk(clk),
        .MemRead(MemRead),
        .MemWrite(MemWrite),

        .addr(alu_result),
        .write_data(read_data2),

        .read_data(mem_data)

);

    assign write_data = (MemtoReg) ? mem_data : alu_result;
    assign alu_input2 = (ALUSrc) ? immediate : read_data2;
    
endmodule