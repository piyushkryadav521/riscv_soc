`timescale 1ns/1ps

module flush_unit(

    input  wire PCSrc,

    output wire IF_ID_Flush

);

assign IF_ID_Flush = PCSrc;

endmodule