`timescale 1ns/1ps

module program_counter_tb;

    reg clk;
    reg rst;
    reg [31:0] pc_next;
    wire [31:0] pc;

    // Instantiate DUT
    program_counter dut (
        .clk(clk),
        .rst(rst),
        .pc_next(pc_next),
        .pc(pc)
    );

    // Clock generation (10 ns period)
    always #5 clk = ~clk;

    initial begin
        // Dump waveform
        $dumpfile("program_counter.vcd");
$dumpvars(0, program_counter_tb);

        // Initialize signals
        clk = 0;
        rst = 1;
        pc_next = 32'd0;

        // Hold reset
        #10;
        rst = 0;

        // Update PC values
        #10 pc_next = 32'd4;
        #10 pc_next = 32'd8;
        #10 pc_next = 32'd12;
        #10 pc_next = 32'd16;

        #20;
        $finish;
    end;

endmodule