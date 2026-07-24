`timescale 1ns/1ps

module ex_mem_pipeline(

    input wire clk,
    input wire rst,

    // Data Inputs
    input wire [31:0] alu_result_in,
    input wire [31:0] write_data_in,
    input wire [4:0]  rd_in,

    // Control Inputs
    input wire MemRead_in,
    input wire MemWrite_in,
    input wire MemtoReg_in,
    input wire RegWrite_in,

    // Data Outputs
    output reg [31:0] alu_result_out,
    output reg [31:0] write_data_out,
    output reg [4:0]  rd_out,

    // Control Outputs
    output reg MemRead_out,
    output reg MemWrite_out,
    output reg MemtoReg_out,
    output reg RegWrite_out

);

always @(posedge clk or posedge rst) begin

    if (rst) begin
        alu_result_out <= 32'd0;
        write_data_out <= 32'd0;
        rd_out         <= 5'd0;

        MemRead_out    <= 1'b0;
        MemWrite_out   <= 1'b0;
        MemtoReg_out   <= 1'b0;
        RegWrite_out   <= 1'b0;
    end
    else begin
        alu_result_out <= alu_result_in;
        write_data_out <= write_data_in;
        rd_out         <= rd_in;

        MemRead_out    <= MemRead_in;
        MemWrite_out   <= MemWrite_in;
        MemtoReg_out   <= MemtoReg_in;
        RegWrite_out   <= RegWrite_in;
    end

end

endmodule