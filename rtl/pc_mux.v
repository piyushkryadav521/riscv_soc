`timescale 1ns/1ps

module pc_mux(

    input  wire [31:0] pc_plus4,
    input  wire [31:0] branch_target,

    input  wire PCSrc,

    output wire [31:0] next_pc

);

assign next_pc = (PCSrc) ? branch_target : pc_plus4;

endmodule