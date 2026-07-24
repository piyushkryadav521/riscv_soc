`timescale 1ns/1ps

module forwarding_unit(

    input wire RegWrite_MEM,
    input wire RegWrite_WB,

    input wire [4:0] rd_MEM,
    input wire [4:0] rd_WB,

    input wire [4:0] rs1_EX,
    input wire [4:0] rs2_EX,

    output reg [1:0] ForwardA,
    output reg [1:0] ForwardB

);

always @(*) begin

    // Default: No forwarding
    ForwardA = 2'b00;
    ForwardB = 2'b00;

    // EX/MEM forwarding
    if (RegWrite_MEM && (rd_MEM != 5'd0) && (rd_MEM == rs1_EX))
        ForwardA = 2'b10;

    if (RegWrite_MEM && (rd_MEM != 5'd0) && (rd_MEM == rs2_EX))
        ForwardB = 2'b10;

    // MEM/WB forwarding
    if (RegWrite_WB &&
        (rd_WB != 5'd0) &&
        !(RegWrite_MEM && (rd_MEM != 5'd0) && (rd_MEM == rs1_EX)) &&
        (rd_WB == rs1_EX))
        ForwardA = 2'b01;

    if (RegWrite_WB &&
        (rd_WB != 5'd0) &&
        !(RegWrite_MEM && (rd_MEM != 5'd0) && (rd_MEM == rs2_EX)) &&
        (rd_WB == rs2_EX))
        ForwardB = 2'b01;

end

endmodule