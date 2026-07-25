`timescale 1ns/1ps

module hazard_detection_unit(

    input wire MemRead_EX,
    input wire [4:0] rd_EX,

    input wire [4:0] rs1_ID,
    input wire [4:0] rs2_ID,

    output reg PCWrite,
    output reg IF_ID_Write,
    output reg ControlMux

);

always @(*) begin

    if (MemRead_EX &&
        ((rd_EX == rs1_ID) || (rd_EX == rs2_ID)) &&
        (rd_EX != 5'd0))
    begin
        // Stall pipeline
        PCWrite    = 1'b0;
        IF_ID_Write = 1'b0;
        ControlMux = 1'b1;
    end
    else begin
        // Normal operation
        PCWrite    = 1'b1;
        IF_ID_Write = 1'b1;
        ControlMux = 1'b0;
    end

end

endmodule