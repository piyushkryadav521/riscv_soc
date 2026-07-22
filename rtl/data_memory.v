`timescale 1ns/1ps

module data_memory (

    input  wire        clk,
    input  wire        MemRead,
    input  wire        MemWrite,
    input  wire [31:0] addr,
    input  wire [31:0] write_data,

    output reg  [31:0] read_data

);

    // 256 x 32-bit memory
    reg [31:0] memory [0:255];

    integer i;

    // Initialize memory
    initial begin
        for (i = 0; i < 256; i = i + 1)
            memory[i] = 32'd0;
    end

    // Write Operation (Synchronous)
    always @(posedge clk) begin
        if (MemWrite)
            memory[addr[9:2]] <= write_data;
    end

    // Read Operation (Combinational)
    always @(*) begin
        if (MemRead)
            read_data = memory[addr[9:2]];
        else
            read_data = 32'd0;
    end

endmodule