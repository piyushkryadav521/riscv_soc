`timescale 1ns/1ps

module memory_stage_tb;

reg clk;

reg mem_read;
reg mem_write;

reg [31:0] address;
reg [31:0] write_data;

wire [31:0] read_data;

memory_stage dut(

.clk(clk),

.mem_read(mem_read),
.mem_write(mem_write),

.address(address),
.write_data(write_data),

.read_data(read_data)

);

always #5 clk = ~clk;

initial
begin

$dumpfile("memory_stage.vcd");
$dumpvars(0,memory_stage_tb);

clk = 0;

mem_read = 0;
mem_write = 0;

address = 0;
write_data = 0;

// Store 1234 at address 16
#10;
address = 32'd16;
write_data = 32'd1234;
mem_write = 1;

#10;
mem_write = 0;

// Read from address 16
mem_read = 1;

#10;
mem_read = 0;

#20;
$finish;

end

endmodule