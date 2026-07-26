`timescale 1ns/1ps

module scan_chain(

    input clk,
    input rst,

    input scan_en,
    input scan_in,

    input [2:0] d,

    output [2:0] q,

    output scan_out

);

scan_dff FF0(
    .clk(clk),
    .rst(rst),
    .d(d[0]),
    .scan_in(scan_in),
    .scan_en(scan_en),
    .q(q[0])
);

scan_dff FF1(
    .clk(clk),
    .rst(rst),
    .d(d[1]),
    .scan_in(q[0]),
    .scan_en(scan_en),
    .q(q[1])
);

scan_dff FF2(
    .clk(clk),
    .rst(rst),
    .d(d[2]),
    .scan_in(q[1]),
    .scan_en(scan_en),
    .q(q[2])
);

assign scan_out = q[2];

endmodule