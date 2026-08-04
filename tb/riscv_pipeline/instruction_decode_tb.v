`timescale 1ns/1ps

module instruction_decode_tb;

reg [31:0] instruction;

wire [6:0] opcode;
wire [4:0] rd;
wire [2:0] funct3;
wire [4:0] rs1;
wire [4:0] rs2;
wire [6:0] funct7;

instruction_decode dut(

.instruction(instruction),

.opcode(opcode),
.rd(rd),
.funct3(funct3),
.rs1(rs1),
.rs2(rs2),
.funct7(funct7)

);

initial
begin

$dumpfile("instruction_decode.vcd");
$dumpvars(0,instruction_decode_tb);

// add x3,x1,x2

instruction = 32'h002081B3;

#20;

$finish;

end

endmodule