`timescale 1ns/1ps

module apb_system_tb;

reg clk;
reg rst;

reg start;
reg write;

reg [31:0] addr;
reg [31:0] wdata;

wire PSEL;
wire PENABLE;
wire PWRITE;

wire [31:0] PADDR;
wire [31:0] PWDATA;
wire [31:0] PRDATA;

wire PREADY;

apb_master master(

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

apb_slave slave(

.clk(clk),
.rst(rst),

.PSEL(PSEL),
.PENABLE(PENABLE),
.PWRITE(PWRITE),

.PADDR(PADDR),
.PWDATA(PWDATA),

.PRDATA(PRDATA),
.PREADY(PREADY)

);

always #5 clk = ~clk;

initial begin

$dumpfile("apb_system.vcd");
$dumpvars(0,apb_system_tb);

clk = 0;
rst = 1;

start = 0;
write = 1;

addr = 32'h00000004;
wdata = 32'hA5A5A5A5;

#20;

rst = 0;
// WRITE
#20;

start = 1;

#10;

start = 0;

#40;

// READ
write = 0;

#20;

start = 1;

#10;

start = 0;

#60;

$display("---");
$display("Read Data = %h",PRDATA);
$display("----");

$finish;

end

endmodule