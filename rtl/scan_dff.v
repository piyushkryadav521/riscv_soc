`timescale 1ns/1ps

module scan_dff(

    input  wire clk,
    input  wire rst,

    input  wire d,
    input  wire scan_in,
    input  wire scan_en,

    output reg q

);

always @(posedge clk or posedge rst) begin

    if (rst)
        q <= 1'b0;

    else if (scan_en)
        q <= scan_in;

    else
        q <= d;

end

endmodule