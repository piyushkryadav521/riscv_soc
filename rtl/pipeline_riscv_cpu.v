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

endmodule