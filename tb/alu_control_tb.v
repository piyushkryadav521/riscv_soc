`timescale 1ns/1ps

module alu_control_tb;

    reg  [1:0] ALUOp;
    reg  [2:0] funct3;
    reg  [6:0] funct7;

    wire [3:0] alu_ctrl;

    // Instantiate DUT
    alu_control dut (
        .ALUOp(ALUOp),
        .funct3(funct3),
        .funct7(funct7),
        .alu_ctrl(alu_ctrl)
    );

    initial begin

        $dumpfile("alu_control.vcd");
        $dumpvars(0, alu_control_tb);

        // Load/Store -> ADD
        ALUOp = 2'b00;
        funct3 = 3'b000;
        funct7 = 7'b0000000;
        #10;
        $display("LOAD/STORE : alu_ctrl = %b", alu_ctrl);

        // Branch -> SUB
        ALUOp = 2'b01;
        #10;
        $display("BRANCH     : alu_ctrl = %b", alu_ctrl);

        // ADD
        ALUOp = 2'b10;
        funct3 = 3'b000;
        funct7 = 7'b0000000;
        #10;
        $display("ADD        : alu_ctrl = %b", alu_ctrl);

        // SUB
        funct7 = 7'b0100000;
        #10;
        $display("SUB        : alu_ctrl = %b", alu_ctrl);

        // AND
        funct3 = 3'b111;
        funct7 = 7'b0000000;
        #10;
        $display("AND        : alu_ctrl = %b", alu_ctrl);

        // OR
        funct3 = 3'b110;
        #10;
        $display("OR         : alu_ctrl = %b", alu_ctrl);

        // XOR
        funct3 = 3'b100;
        #10;
        $display("XOR        : alu_ctrl = %b", alu_ctrl);

        // SLL
        funct3 = 3'b001;
        #10;
        $display("SLL        : alu_ctrl = %b", alu_ctrl);

        // SRL
        funct3 = 3'b101;
        #10;
        $display("SRL        : alu_ctrl = %b", alu_ctrl);

        // SLT
        funct3 = 3'b010;
        #10;
        $display("SLT        : alu_ctrl = %b", alu_ctrl);

        $finish;

    end

endmodule