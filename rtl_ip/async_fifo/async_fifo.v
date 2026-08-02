module async_fifo #(
    parameter WIDTH = 8,
    parameter DEPTH = 16
)(
    input wr_clk,
    input rd_clk,
    input rst,

    input wr_en,
    input rd_en,

    input  [WIDTH-1:0] data_in,
    output reg [WIDTH-1:0] data_out,

    output full,
    output empty
);

reg [WIDTH-1:0] mem [0:DEPTH-1];

reg [3:0] wr_ptr;
reg [3:0] rd_ptr;

assign full  = 1'b0;   // Placeholder
assign empty = 1'b0;   // Placeholder

endmodule