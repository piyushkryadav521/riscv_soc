`timescale 1ns/1ps

module forwarding_unit_tb;

reg RegWrite_MEM;
reg RegWrite_WB;

reg [4:0] rd_MEM;
reg [4:0] rd_WB;

reg [4:0] rs1_EX;
reg [4:0] rs2_EX;

wire [1:0] ForwardA;
wire [1:0] ForwardB;

forwarding_unit DUT(

    .RegWrite_MEM(RegWrite_MEM),
    .RegWrite_WB(RegWrite_WB),

    .rd_MEM(rd_MEM),
    .rd_WB(rd_WB),

    .rs1_EX(rs1_EX),
    .rs2_EX(rs2_EX),

    .ForwardA(ForwardA),
    .ForwardB(ForwardB)

);

initial begin

    $dumpfile("forwarding_unit.vcd");
    $dumpvars(0, forwarding_unit_tb);

    // Test 1: No forwarding
    RegWrite_MEM = 0;
    RegWrite_WB  = 0;
    rd_MEM = 5'd0;
    rd_WB  = 5'd0;
    rs1_EX = 5'd1;
    rs2_EX = 5'd2;
    #10;

    // Test 2: Forward from EX/MEM to rs1
    RegWrite_MEM = 1;
    rd_MEM = 5'd5;
    rs1_EX = 5'd5;
    #10;

    // Test 3: Forward from MEM/WB to rs2
    RegWrite_MEM = 0;
    RegWrite_WB  = 1;
    rd_WB = 5'd7;
    rs2_EX = 5'd7;
    #10;

    // Test 4: Forward to both operands
    RegWrite_MEM = 1;
    rd_MEM = 5'd3;
    rs1_EX = 5'd3;
    rs2_EX = 5'd3;
    #10;

    $finish;

end

endmodule