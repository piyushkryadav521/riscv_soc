`timescale 1ns/1ps

module riscv_cpu_tb;

    reg clk;
    reg rst;

    // Instantiate CPU
    riscv_cpu DUT (

        .clk(clk),
        .rst(rst)

    );

    // Clock Generation
    always #5 clk = ~clk;

    initial begin

        $dumpfile("riscv_cpu.vcd");
        $dumpvars(0, riscv_cpu_tb);

        clk = 0;
        rst = 1;

        // Hold reset
        #20;
        rst = 0;

        // Run CPU
        #200;

        $finish;

    end

endmodule