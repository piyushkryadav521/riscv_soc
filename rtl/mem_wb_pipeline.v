`timescale 1ns/1ps

module mem_wb_pipeline(

    input wire clk,
    input wire rst,

    // Data Inputs
    input wire [31:0] mem_data_in,
    input wire [31:0] alu_result_in,
    input wire [4:0]  rd_in,

    // Control Inputs
    input wire MemtoReg_in,
    input wire RegWrite_in,

    // Data Outputs
    output reg [31:0] mem_data_out,
    output reg [31:0] alu_result_out,
    output reg [4:0]  rd_out,

    // Control Outputs
    output reg MemtoReg_out,
    output reg RegWrite_out

);

always @(posedge clk or posedge rst) begin

    if (rst) begin
        mem_data_out   <= 32'd0;
        alu_result_out <= 32'd0;
        rd_out         <= 5'd0;

        MemtoReg_out   <= 1'b0;
        RegWrite_out   <= 1'b0;
    end
    else begin
        mem_data_out   <= mem_data_in;
        alu_result_out <= alu_result_in;
        rd_out         <= rd_in;

        MemtoReg_out   <= MemtoReg_in;
        RegWrite_out   <= RegWrite_in;
    end

end

endmodule