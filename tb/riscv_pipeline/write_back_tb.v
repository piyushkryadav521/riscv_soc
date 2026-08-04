`timescale 1ns/1ps

module write_back_tb;

reg mem_to_reg;

reg [31:0] alu_result;
reg [31:0] memory_data;

wire [31:0] write_data;

write_back dut(

.mem_to_reg(mem_to_reg),

.alu_result(alu_result),
.memory_data(memory_data),

.write_data(write_data)

);

initial
begin

$dumpfile("write_back.vcd");
$dumpvars(0,write_back_tb);

// ALU Result
alu_result = 32'd100;
memory_data = 32'd500;

mem_to_reg = 0;

#20;

// Memory Result
mem_to_reg = 1;

#20;

$finish;

end

endmodule