`timescale 1ns/1ps

module id_ex_pipeline_tb;

    reg clk;
    reg rst;

    // Data Inputs
    reg [31:0] read_data1_in;
    reg [31:0] read_data2_in;
    reg [31:0] immediate_in;
    reg [4:0]  rd_in;

    // Control Inputs
    reg [1:0] ALUOp_in;
    reg ALUSrc_in;
    reg MemRead_in;
    reg MemWrite_in;
    reg MemtoReg_in;
    reg RegWrite_in;

    // Outputs
    wire [31:0] read_data1_out;
    wire [31:0] read_data2_out;
    wire [31:0] immediate_out;
    wire [4:0]  rd_out;

    wire [1:0] ALUOp_out;
    wire ALUSrc_out;
    wire MemRead_out;
    wire MemWrite_out;
    wire MemtoReg_out;
    wire RegWrite_out;

    // Instantiate DUT
    id_ex_pipeline DUT (

        .clk(clk),
        .rst(rst),

        .read_data1_in(read_data1_in),
        .read_data2_in(read_data2_in),
        .immediate_in(immediate_in),
        .rd_in(rd_in),

        .ALUOp_in(ALUOp_in),
        .ALUSrc_in(ALUSrc_in),
        .MemRead_in(MemRead_in),
        .MemWrite_in(MemWrite_in),
        .MemtoReg_in(MemtoReg_in),
        .RegWrite_in(RegWrite_in),

        .read_data1_out(read_data1_out),
        .read_data2_out(read_data2_out),
        .immediate_out(immediate_out),
        .rd_out(rd_out),

        .ALUOp_out(ALUOp_out),
        .ALUSrc_out(ALUSrc_out),
        .MemRead_out(MemRead_out),
        .MemWrite_out(MemWrite_out),
        .MemtoReg_out(MemtoReg_out),
        .RegWrite_out(RegWrite_out)

    );

    // Clock Generation
    always #5 clk = ~clk;

    initial begin

        $dumpfile("id_ex_pipeline.vcd");
        $dumpvars(0, id_ex_pipeline_tb);

        clk = 0;
        rst = 1;

        // Initialize Inputs
        read_data1_in = 32'd0;
        read_data2_in = 32'd0;
        immediate_in  = 32'd0;
        rd_in         = 5'd0;

        ALUOp_in      = 2'b00;
        ALUSrc_in     = 0;
        MemRead_in    = 0;
        MemWrite_in   = 0;
        MemtoReg_in   = 0;
        RegWrite_in   = 0;

        #10;
        rst = 0;

        // Test Vector
        read_data1_in = 32'd100;
        read_data2_in = 32'd200;
        immediate_in  = 32'd16;
        rd_in         = 5'd3;

        ALUOp_in      = 2'b10;
        ALUSrc_in     = 1;
        MemRead_in    = 1;
        MemWrite_in   = 0;
        MemtoReg_in   = 1;
        RegWrite_in   = 1;

        #20;

        $display("ReadData1 = %d", read_data1_out);
        $display("ReadData2 = %d", read_data2_out);
        $display("Immediate = %d", immediate_out);
        $display("RD = %d", rd_out);

        $display("ALUOp = %b", ALUOp_out);
        $display("ALUSrc = %b", ALUSrc_out);
        $display("MemRead = %b", MemRead_out);
        $display("MemWrite = %b", MemWrite_out);
        $display("MemtoReg = %b", MemtoReg_out);
        $display("RegWrite = %b", RegWrite_out);

        #10;
        $finish;

    end

endmodule