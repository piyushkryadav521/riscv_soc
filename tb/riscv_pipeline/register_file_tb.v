`timescale 1ns/1ps

module register_file_tb;

reg clk;
reg rst;

reg reg_write;

reg [4:0] rs1;
reg [4:0] rs2;
reg [4:0] rd;

reg [31:0] write_data;

wire [31:0] rs1_data;
wire [31:0] rs2_data;

register_file dut(

.clk(clk),
.rst(rst),

.reg_write(reg_write),

.rs1(rs1),
.rs2(rs2),
.rd(rd),

.write_data(write_data),

.rs1_data(rs1_data),
.rs2_data(rs2_data)

);

always #5 clk = ~clk;

initial
begin

$dumpfile("register_file.vcd");
$dumpvars(0,register_file_tb);

clk = 0;
rst = 1;

reg_write = 0;

rs1 = 0;
rs2 = 0;
rd = 0;
write_data = 0;

#20;

rst = 0;

// Write x1 = 25

@(posedge clk);

reg_write = 1;
rd = 5'd1;
write_data = 32'd25;

@(posedge clk);

// Write x2 = 50

rd = 5'd2;
write_data = 32'd50;

@(posedge clk);

reg_write = 0;

// Read x1 and x2

rs1 = 5'd1;
rs2 = 5'd2;

#20;

$finish;

end

endmodule