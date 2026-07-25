`timescale 1ns/1ps

module branch_unit(

    input  wire Branch,
    input  wire Zero,

    output wire PCSrc

);

assign PCSrc = Branch & Zero;

endmodule