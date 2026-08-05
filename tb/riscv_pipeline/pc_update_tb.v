`timescale 1ns/1ps

module pc_update_tb;

reg [31:0] pc_plus4;
reg [31:0] branch_target;

reg branch_taken;

wire [31:0] next_pc;

pc_update dut(

.pc_plus4(pc_plus4),
.branch_target(branch_target),

.branch_taken(branch_taken),

.next_pc(next_pc)

);

initial
begin

$dumpfile("pc_update.vcd");
$dumpvars(0,pc_update_tb);

// Normal Execution
pc_plus4 = 32'd104;
branch_target = 32'd200;

branch_taken = 0;

#20;

// Branch Taken
branch_taken = 1;

#20;

// Change Values
pc_plus4 = 32'd108;
branch_target = 32'd300;

branch_taken = 0;

#20;

branch_taken = 1;

#20;

$finish;

end

endmodule