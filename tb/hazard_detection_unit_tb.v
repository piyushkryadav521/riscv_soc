`timescale 1ns/1ps

module hazard_detection_unit_tb;

reg MemRead_EX;
reg [4:0] rd_EX;

reg [4:0] rs1_ID;
reg [4:0] rs2_ID;

wire PCWrite;
wire IF_ID_Write;
wire ControlMux;

hazard_detection_unit DUT (

    .MemRead_EX(MemRead_EX),
    .rd_EX(rd_EX),

    .rs1_ID(rs1_ID),
    .rs2_ID(rs2_ID),

    .PCWrite(PCWrite),
    .IF_ID_Write(IF_ID_Write),
    .ControlMux(ControlMux)

);

initial begin

    $dumpfile("hazard_detection_unit.vcd");
    $dumpvars(0, hazard_detection_unit_tb);

    // Test Case 1: No Hazard
    MemRead_EX = 0;
    rd_EX = 5'd5;
    rs1_ID = 5'd1;
    rs2_ID = 5'd2;
    #10;

    // Test Case 2: Hazard with rs1
    MemRead_EX = 1;
    rd_EX = 5'd5;
    rs1_ID = 5'd5;
    rs2_ID = 5'd2;
    #10;

    // Test Case 3: Hazard with rs2
    MemRead_EX = 1;
    rd_EX = 5'd7;
    rs1_ID = 5'd1;
    rs2_ID = 5'd7;
    #10;

    // Test Case 4: No Hazard
    MemRead_EX = 1;
    rd_EX = 5'd8;
    rs1_ID = 5'd2;
    rs2_ID = 5'd3;
    #10;

    $finish;

end

endmodule