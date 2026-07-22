`timescale 1ns/1ps

module register_file (

    input wire clk,
    input wire rst,

    input wire we,

    input wire [4:0] rs1,
    input wire [4:0] rs2,
    input wire [4:0] rd,

    input wire [31:0] write_data,

    output wire [31:0] read_data1,
    output wire [31:0] read_data2

);

    // 32 Registers
    reg [31:0] registers [0:31];

    integer i;

    // Reset and Write Logic
    always @(posedge clk) begin

        if (rst) begin

            for(i = 0; i < 32; i = i + 1)
                registers[i] <= 32'b0;

        end
        else if (we && (rd != 0)) begin

            registers[rd] <= write_data;

        end

    end

    // Combinational Read
    assign read_data1 = (rs1 == 0) ? 32'b0 : registers[rs1];
    assign read_data2 = (rs2 == 0) ? 32'b0 : registers[rs2];

endmodule