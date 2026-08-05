`timescale 1ns/1ps

module alu_control_tb;

reg [1:0] ALUOp;
reg [2:0] funct3;
reg [6:0] funct7;

wire [3:0] ALUCtrl;

alu_control dut(

.ALUOp(ALUOp),

.funct3(funct3),

.funct7(funct7),

.ALUCtrl(ALUCtrl)

);

initial begin

$dumpfile("alu_control.vcd");
$dumpvars(0,alu_control_tb);

// ADD
ALUOp = 2'b10;
funct7 = 7'b0000000;
funct3 = 3'b000;
#20;

// SUB
funct7 = 7'b0100000;
funct3 = 3'b000;
#20;

// AND
funct7 = 7'b0000000;
funct3 = 3'b111;
#20;

// OR
funct7 = 7'b0000000;
funct3 = 3'b110;
#20;

$finish;

end

endmodule