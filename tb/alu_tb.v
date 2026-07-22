`timescale 1ns/1ps

module alu_tb;

    reg  [31:0] a;
    reg  [31:0] b;
    reg  [3:0]  alu_control;

    wire [31:0] result;
    wire zero;

    // Instantiate DUT
    alu dut (
        .a(a),
        .b(b),
        .alu_control(alu_control),
        .result(result),
        .zero(zero)
    );

    initial begin

        $dumpfile("alu.vcd");
        $dumpvars(0, alu_tb);

        // ADD
        a = 20; b = 10; alu_control = 4'b0000;
        #10;
        $display("ADD : %d", result);

        // SUB
        a = 20; b = 10; alu_control = 4'b0001;
        #10;
        $display("SUB : %d", result);

        // AND
        a = 32'hF0F0F0F0; b = 32'h0F0F0F0F; alu_control = 4'b0010;
        #10;
        $display("AND : %h", result);

        // OR
        alu_control = 4'b0011;
        #10;
        $display("OR  : %h", result);

        // XOR
        alu_control = 4'b0100;
        #10;
        $display("XOR : %h", result);

        // Shift Left
        a = 1; b = 4; alu_control = 4'b0101;
        #10;
        $display("SLL : %d", result);

        // Shift Right
        a = 16; b = 2; alu_control = 4'b0110;
        #10;
        $display("SRL : %d", result);

        // Set Less Than
        a = 5; b = 10; alu_control = 4'b0111;
        #10;
        $display("SLT : %d", result);

        // Zero flag
        a = 10; b = 10; alu_control = 4'b0001;
        #10;
        $display("ZERO = %b", zero);

        $finish;

    end

endmodule