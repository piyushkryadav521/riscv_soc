`timescale 1ns/1ps

module sync_fifo_tb;

parameter WIDTH = 8;
parameter DEPTH = 8;

reg clk;
reg rst;

reg wr_en;
reg rd_en;

reg [WIDTH-1:0] data_in;

wire [WIDTH-1:0] data_out;

wire full;
wire empty;

wire overflow;
wire underflow;

sync_fifo #(

.WIDTH(WIDTH),
.DEPTH(DEPTH)

)

dut(

.clk(clk),
.rst(rst),

.wr_en(wr_en),
.rd_en(rd_en),

.data_in(data_in),

.data_out(data_out),

.full(full),
.empty(empty),

.overflow(overflow),
.underflow(underflow)

);

always #5 clk = ~clk;

integer i;

initial begin

    $dumpfile("sync_fifo.vcd");
    $dumpvars(0,sync_fifo_tb);

    clk = 0;
    rst = 1;

    wr_en = 0;
    rd_en = 0;

    data_in = 0;

    #20;

    rst = 0;

    // WRITE 8 VALUES
    for(i=0;i<8;i=i+1)
    begin

        @(posedge clk);

        wr_en = 1;
        data_in = i + 8'h10;

    end

    @(posedge clk);

    wr_en = 0;

    @(posedge clk);

    wr_en = 1;

    data_in = 8'hFF;

    @(posedge clk);

    wr_en = 0;

    // READ 8 VALUES
    for(i=0;i<8;i=i+1)
    begin

        @(posedge clk);

        rd_en = 1;

    end

    @(posedge clk);

    rd_en = 0;

    @(posedge clk);

    rd_en = 1;

    @(posedge clk);

    rd_en = 0;

    @(posedge clk);

    wr_en = 1;
    rd_en = 1;

    data_in = 8'hAA;

    @(posedge clk);

    wr_en = 0;
    rd_en = 0;

    #30;

    $finish;

end

endmodule