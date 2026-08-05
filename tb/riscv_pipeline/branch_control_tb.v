`timescale 1ns/1ps

module branch_control_tb;

reg branch;

reg [2:0] funct3;

reg zero;

wire branch_taken;

branch_control dut(

.branch(branch),

.funct3(funct3),

.zero(zero),

.branch_taken(branch_taken)

);

initial
begin

$dumpfile("branch_control.vcd");
$dumpvars(0,branch_control_tb);

// BEQ Taken
branch = 1;
funct3 = 3'b000;
zero = 1;
#20;

// BEQ Not Taken
zero = 0;
#20;

// BNE Taken
funct3 = 3'b001;
zero = 0;
#20;

// BNE Not Taken
zero = 1;
#20;

// Branch Disabled
branch = 0;

#20;

$finish;

end

endmodule