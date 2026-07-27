`timescale 1ns/1ps

module apb_slave_tb;

reg clk;
reg rst;

reg PSEL;
reg PENABLE;
reg PWRITE;

reg [31:0] PADDR;
reg [31:0] PWDATA;

wire [31:0] PRDATA;
wire PREADY;

apb_slave dut(

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

$dumpfile("apb_slave.vcd");
$dumpvars(0,apb_slave_tb);

clk = 0;
rst = 1;

PSEL = 0;
PENABLE = 0;
PWRITE = 0;

PADDR = 0;
PWDATA = 0;

#20;

rst = 0;

//
// WRITE
//

#10;

PSEL = 1;
PWRITE = 1;
PADDR = 4;
PWDATA = 32'h12345678;

#10;

PENABLE = 1;

#10;

PSEL = 0;
PENABLE = 0;

//
// READ
//

#20;

PSEL = 1;
PWRITE = 0;
PADDR = 4;

#10;

PENABLE = 1;

#10;

PSEL = 0;
PENABLE = 0;

#20;

$display("Read Data = %h",PRDATA);

$finish;

end

endmodule