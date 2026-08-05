`timescale 1ns/1ps

module pipeline_flush_tb;

reg branch_taken;

wire flush_if_id;
wire flush_id_ex;

pipeline_flush dut(

.branch_taken(branch_taken),

.flush_if_id(flush_if_id),
.flush_id_ex(flush_id_ex)

);

initial
begin

$dumpfile("pipeline_flush.vcd");
$dumpvars(0,pipeline_flush_tb);

// No Flush
branch_taken = 0;

#20;

// Flush Pipeline
branch_taken = 1;

#20;

// Continue Execution
branch_taken = 0;

#20;

$finish;

end

endmodule