`timescale 1ns/1ps

module immediate_generator_tb;

    reg  [31:0] instruction;
    wire [31:0] immediate;

    // Instantiate DUT
    immediate_generator dut (
        .instruction(instruction),
        .immediate(immediate)
    );

    initial begin

        $dumpfile("immediate_generator.vcd");
        $dumpvars(0, immediate_generator_tb);

        // I-Type: addi x1, x0, 5
        instruction = 32'h00500093;
        #10;
        $display("I-Type Immediate = %d", immediate);

        // S-Type: sw x1, 8(x2)
        instruction = 32'h00112423;
        #10;
        $display("S-Type Immediate = %d", immediate);

        // B-Type: beq x1, x2, 16
        instruction = 32'h00208863;
        #10;
        $display("B-Type Immediate = %d", immediate);

        // U-Type: lui x5, 0x12345
        instruction = 32'h123452B7;
        #10;
        $display("U-Type Immediate = %h", immediate);

        // J-Type: jal x1, 20
        instruction = 32'h014000EF;
        #10;
        $display("J-Type Immediate = %d", immediate);

        $finish;

    end

endmodule