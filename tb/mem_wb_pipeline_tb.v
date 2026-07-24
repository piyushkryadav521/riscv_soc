`timescale 1ns/1ps

module mem_wb_pipeline_tb;

    reg clk;
    reg rst;

    // Inputs
    reg [31:0] mem_data_in;
    reg [31:0] alu_result_in;
    reg [4:0]  rd_in;

    reg MemtoReg_in;
    reg RegWrite_in;

    // Outputs
    wire [31:0] mem_data_out;
    wire [31:0] alu_result_out;
    wire [4:0]  rd_out;

    wire MemtoReg_out;
    wire RegWrite_out;

    // DUT
    mem_wb_pipeline DUT (

        .clk(clk),
        .rst(rst),

        .mem_data_in(mem_data_in),
        .alu_result_in(alu_result_in),
        .rd_in(rd_in),

        .MemtoReg_in(MemtoReg_in),
        .RegWrite_in(RegWrite_in),

        .mem_data_out(mem_data_out),
        .alu_result_out(alu_result_out),
        .rd_out(rd_out),

        .MemtoReg_out(MemtoReg_out),
        .RegWrite_out(RegWrite_out)

    );

    // Clock
    always #5 clk = ~clk;

    initial begin

        $dumpfile("mem_wb_pipeline.vcd");
        $dumpvars(0, mem_wb_pipeline_tb);

        clk = 0;
        rst = 1;

        mem_data_in   = 0;
        alu_result_in = 0;
        rd_in         = 0;
        MemtoReg_in   = 0;
        RegWrite_in   = 0;

        #10;
        rst = 0;

        // Test Case 1
        mem_data_in   = 32'd100;
        alu_result_in = 32'd200;
        rd_in         = 5'd5;
        MemtoReg_in   = 1;
        RegWrite_in   = 1;

        #10;

        // Test Case 2
        mem_data_in   = 32'd300;
        alu_result_in = 32'd400;
        rd_in         = 5'd10;
        MemtoReg_in   = 0;
        RegWrite_in   = 1;

        #10;

        $display("MEM Data   = %d", mem_data_out);
        $display("ALU Result = %d", alu_result_out);
        $display("RD         = %d", rd_out);
        $display("MemtoReg   = %b", MemtoReg_out);
        $display("RegWrite   = %b", RegWrite_out);

        #10;
        $finish;

    end

endmodule