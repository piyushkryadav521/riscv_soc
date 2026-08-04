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

reg [3:0] wr_gray;
reg [3:0] rd_gray;

reg [3:0] wr_gray_sync1;
reg [3:0] wr_gray_sync2;

reg [3:0] rd_gray_sync1;
reg [3:0] rd_gray_sync2;

assign empty = (rd_gray == wr_gray_sync2);
assign full =
    (wr_gray ==
    {~rd_gray_sync2[3:2], rd_gray_sync2[1:0]});

always @(posedge wr_clk or posedge rst) begin
    if (rst) begin
        wr_ptr <= 0;
        wr_gray <= 0;

        rd_gray_sync1 <=0;
        rd_gray_sync2 <=0;

    end
    else begin
        rd_gray_sync1 <=rd_gray;
        rd_gray_sync2 <=rd_gray_sync1;

        if (wr_en && !full) begin
            mem[wr_ptr] <= data_in;
            wr_ptr <= wr_ptr + 1'b1;
            wr_gray <= (wr_ptr + 1'b1) ^ ((wr_ptr + 1'b1) >> 1);
        end
    end
end

always @(posedge rd_clk or posedge rst) begin
    if (rst) begin
        rd_ptr <= 0;
        rd_gray <= 0;
        data_out <= 0;

        wr_gray_sync1 <= 0;
        wr_gray_sync2 <= 0;

    end
    else begin
        wr_gray_sync1 <= wr_gray;
        wr_gray_sync2 <= wr_gray_sync1;

        if (rd_en && !empty) begin
            data_out <= mem[rd_ptr];
            rd_ptr <= rd_ptr + 1'b1;
            rd_gray <= (rd_ptr + 1'b1) ^ ((rd_ptr + 1'b1) >> 1);
        end
    end
end

endmodule