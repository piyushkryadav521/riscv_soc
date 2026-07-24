`timescale 1ns/1ps

module id_ex_pipeline(

    input wire clk,
    input wire rst,

    // Data signals
    input wire [31:0] read_data1_in,
    input wire [31:0] read_data2_in,
    input wire [31:0] immediate_in,
    input wire [4:0] rd_in,

    // Control signals
    input wire [1:0] ALUOp_in,
    input wire ALUSrc_in,
    input wire MemRead_in,
    input wire MemWrite_in,
    input wire MemtoReg_in,
    input wire RegWrite_in,

    // Outputs
    output reg [31:0] read_data1_out,
    output reg [31:0] read_data2_out,
    output reg [31:0] immediate_out,
    output reg [4:0] rd_out,

    output reg [1:0] ALUOp_out,
    output reg ALUSrc_out,
    output reg MemRead_out,
    output reg MemWrite_out,
    output reg MemtoReg_out,
    output reg RegWrite_out

);

always @(posedge clk or posedge rst) begin

    if (rst) begin

        read_data1_out <= 32'd0;
        read_data2_out <= 32'd0;
        immediate_out  <= 32'd0;
        rd_out         <= 5'd0;

        ALUOp_out      <= 2'b00;
        ALUSrc_out     <= 1'b0;
        MemRead_out    <= 1'b0;
        MemWrite_out   <= 1'b0;
        MemtoReg_out   <= 1'b0;
        RegWrite_out   <= 1'b0;

    end
    else begin

        read_data1_out <= read_data1_in;
        read_data2_out <= read_data2_in;
        immediate_out  <= immediate_in;
        rd_out         <= rd_in;

        ALUOp_out      <= ALUOp_in;
        ALUSrc_out     <= ALUSrc_in;
        MemRead_out    <= MemRead_in;
        MemWrite_out   <= MemWrite_in;
        MemtoReg_out   <= MemtoReg_in;
        RegWrite_out   <= RegWrite_in;

    end

end

endmodule