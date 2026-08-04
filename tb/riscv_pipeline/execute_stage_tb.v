`timescale 1ns/1ps

module execute_stage_tb;

reg [31:0] operand_a;
reg [31:0] operand_b;

reg [3:0] alu_control;

wire [31:0] alu_result;
wire zero;

execute_stage dut(

.operand_a(operand_a),
.operand_b(operand_b),

.alu_control(alu_control),

.alu_result(alu_result),
.zero(zero)

);

initial
begin

$dumpfile("execute_stage.vcd");
$dumpvars(0,execute_stage_tb);

// ADD

operand_a = 20;
operand_b = 10;

alu_control = 4'b0000;

#20;

// SUB

alu_control = 4'b0001;

#20;

// AND

alu_control = 4'b0010;

#20;

// OR

alu_control = 4'b0011;

#20;

// XOR

alu_control = 4'b0100;

#20;

$finish;

end

endmodule