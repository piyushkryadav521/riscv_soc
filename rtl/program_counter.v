`timescale 1ns/1ps

// Module : Program Counter
// Description : Stores the address of the next instruction

module program_counter (

    input wire clk,
    input wire rst,

    input wire [31:0] pc_next,

    output reg [31:0] pc

);

always @(posedge clk or posedge rst) begin
    if (rst)
        pc <= 32'd0;
    else
        pc <= pc+32'd4;
end

endmodule