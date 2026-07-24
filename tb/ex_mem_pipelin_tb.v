`timescale 1ns/1ps

module ex_mem_pipeline_tb;

    reg clk;
    reg rst;

    // Data Inputs
    reg [31:0] alu_result_in;
    reg [31:0] write_data_in;
    reg [4:0]  rd_in;

    // Control Inputs
    reg MemRead_in;
    reg MemWrite_in;
    reg MemtoReg_in;
    reg RegWrite_in;

    // Data Outputs
    wire [31:0] alu_result_out;
    wire [31:0] write_data_out;
    wire [4:0]  rd_out;

    // Control Outputs
    wire MemRead_out;
    wire MemWrite_out;
    wire MemtoReg_out;
    wire RegWrite_out;

    // Instantiate DUT
    ex_mem_pipeline DUT (

        .clk(clk),
        .rst(rst),

        .alu_result_in(alu_result_in),
        .write_data_in(write_data_in),
        .rd_in(rd_in),

        .MemRead_in(MemRead_in),
        .MemWrite_in(MemWrite_in),
        .MemtoReg_in(MemtoReg_in),
        .RegWrite_in(RegWrite_in),

        .alu_result_out(alu_result_out),
        .write_data_out(write_data_out),
        .rd_out(rd_out),

        .MemRead_out(MemRead_out),
        .MemWrite_out(MemWrite_out),
        .MemtoReg_out(MemtoReg_out),
        .RegWrite_out(RegWrite_out)

    );

    // Clock Generation
    always #5 clk = ~clk;

    initial begin

        $dumpfile("ex_mem_pipeline.vcd");
        $dumpvars(0, ex_mem_pipeline_tb);

        clk = 0;
        rst = 1;

        // Initialize inputs
        alu_result_in = 32'd0;
        write_data_in = 32'd0;
        rd_in         = 5'd0;

        MemRead_in    = 0;
        MemWrite_in   = 0;
        MemtoReg_in   = 0;
        RegWrite_in   = 0;

        // Release reset
        #10;
        rst = 0;

        // Test Case 1
        alu_result_in = 32'd500;
        write_data_in = 32'd123;
        rd_in         = 5'd10;

        MemRead_in    = 1;
        MemWrite_in   = 0;
        MemtoReg_in   = 1;
        RegWrite_in   = 1;

        #10;

        // Test Case 2
        alu_result_in = 32'd1000;
        write_data_in = 32'd456;
        rd_in         = 5'd20;

        MemRead_in    = 0;
        MemWrite_in   = 1;
        MemtoReg_in   = 0;
        RegWrite_in   = 1;

        #10;

        // Display outputs
        $display("ALU Result = %d", alu_result_out);
        $display("Write Data = %d", write_data_out);
        $display("RD         = %d", rd_out);
        $display("MemRead    = %b", MemRead_out);
        $display("MemWrite   = %b", MemWrite_out);
        $display("MemtoReg   = %b", MemtoReg_out);
        $display("RegWrite   = %b", RegWrite_out);

        #10;
        $finish;

    end

endmodule