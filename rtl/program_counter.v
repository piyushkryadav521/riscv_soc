`timescale 1ns/1ps

// Module : Program Counter
// Description : Stores the address of the next instruction

module program_counter (

    input wire clk,
    input wire rst,

    input wire [31:0] pc_next,

    output reg [31:0] pc

);

always @(posedge clk) begin

    if (rst)
        pc <= 32'h00000000;

    else
        pc <= pc_next;

end

endmodule