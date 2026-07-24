`timescale 1ns/1ps

module if_id_pipeline_tb;

reg clk;
reg rst;

reg [31:0] pc_in;
reg [31:0] instruction_in;

wire [31:0] pc_out;
wire [31:0] instruction_out;

if_id_pipeline DUT(

    .clk(clk),
    .rst(rst),

    .pc_in(pc_in),
    .instruction_in(instruction_in),

    .pc_out(pc_out),
    .instruction_out(instruction_out)

);

always #5 clk = ~clk;

initial begin

    $dumpfile("if_id_pipeline.vcd");
    $dumpvars(0, if_id_pipeline_tb);

    clk = 0;
    rst = 1;

    pc_in = 0;
    instruction_in = 0;

    #10;

    rst = 0;

    pc_in = 32'd4;
    instruction_in = 32'h00500093;

    #10;

    pc_in = 32'd8;
    instruction_in = 32'h00A00113;

    #10;

    $finish;

end

endmodule