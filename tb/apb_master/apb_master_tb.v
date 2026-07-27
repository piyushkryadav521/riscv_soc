`timescale 1ns/1ps

module apb_master_tb;

reg clk;
reg rst;

reg start;
reg write;

reg [31:0] addr;
reg [31:0] wdata;

reg PREADY;

wire PSEL;
wire PENABLE;
wire PWRITE;

wire [31:0] PADDR;
wire [31:0] PWDATA;

apb_master dut(

.clk(clk),
.rst(rst),

.start(start),
.write(write),

.addr(addr),
.wdata(wdata),

.PREADY(PREADY),

.PSEL(PSEL),
.PENABLE(PENABLE),
.PWRITE(PWRITE),

.PADDR(PADDR),
.PWDATA(PWDATA)

);

always #5 clk = ~clk;

initial begin

$dumpfile("apb_master.vcd");
$dumpvars(0,apb_master_tb);

clk = 0;
rst = 1;

start = 0;
write = 1;

addr = 32'h1000;
wdata = 32'hABCD1234;

PREADY = 0;

#20;

rst = 0;

#10;

start = 1;

#10;

start = 0;

#20;

PREADY = 1;

#20;

$finish;

end

endmodule