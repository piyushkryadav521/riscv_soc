`timescale 1ns/1ps

module control_unit_tb;

    reg [6:0] opcode;

    wire RegWrite;
    wire ALUSrc;
    wire MemRead;
    wire MemWrite;
    wire MemtoReg;
    wire Branch;
    wire Jump;
    wire [1:0] ALUOp;

    // Instantiate DUT
    control_unit dut (
        .opcode(opcode),
        .RegWrite(RegWrite),
        .ALUSrc(ALUSrc),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg),
        .Branch(Branch),
        .Jump(Jump),
        .ALUOp(ALUOp)
    );

    initial begin

        $dumpfile("control_unit.vcd");
        $dumpvars(0, control_unit_tb);

        // R-Type
        opcode = 7'b0110011;
        #10;
        $display("R-Type  : RegWrite=%b ALUSrc=%b ALUOp=%b",
                 RegWrite, ALUSrc, ALUOp);

        // I-Type
        opcode = 7'b0010011;
        #10;
        $display("I-Type  : RegWrite=%b ALUSrc=%b ALUOp=%b",
                 RegWrite, ALUSrc, ALUOp);

        // Load
        opcode = 7'b0000011;
        #10;
        $display("LOAD    : MemRead=%b MemtoReg=%b RegWrite=%b",
                 MemRead, MemtoReg, RegWrite);

        // Store
        opcode = 7'b0100011;
        #10;
        $display("STORE   : MemWrite=%b ALUSrc=%b",
                 MemWrite, ALUSrc);

        // Branch
        opcode = 7'b1100011;
        #10;
        $display("BRANCH  : Branch=%b ALUOp=%b",
                 Branch, ALUOp);

        // Jump
        opcode = 7'b1101111;
        #10;
        $display("JUMP    : Jump=%b RegWrite=%b",
                 Jump, RegWrite);

        $finish;

    end

endmodule