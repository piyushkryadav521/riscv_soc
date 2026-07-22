`timescale 1ns/1ps

// Module: Instruction Memory

// Stores 32-bit RISC-V instructions.

module instruction_memory(

    input  wire [31:0] addr,
    output wire [31:0] instruction

);

    // 256 x 32-bit instruction memory
    reg [31:0] memory [0:255];

    // Initialize instructions
    initial begin

        // addi x1, x0, 5
        memory[0] = 32'h00500093;

        // addi x2, x0, 10
        memory[1] = 32'h00A00113;

        // add x3, x1, x2
        memory[2] = 32'h002081B3;

        // nop
        memory[3] = 32'h00000013;

    end

    // Word aligned access
    assign instruction = memory[addr[9:2]];

endmodule