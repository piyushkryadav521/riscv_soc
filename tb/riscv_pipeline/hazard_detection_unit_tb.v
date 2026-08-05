`timescale 1ns/1ps

module hazard_detection_unit_tb;

reg id_ex_mem_read;

reg [4:0] id_ex_rd;

reg [4:0] if_id_rs1;
reg [4:0] if_id_rs2;

wire stall;

hazard_detection_unit dut(

.id_ex_mem_read(id_ex_mem_read),

.id_ex_rd(id_ex_rd),

.if_id_rs1(if_id_rs1),
.if_id_rs2(if_id_rs2),

.stall(stall)

);

initial
begin

$dumpfile("hazard_detection_unit.vcd");
$dumpvars(0,hazard_detection_unit_tb);

// Load-use hazard
id_ex_mem_read = 1;

id_ex_rd = 5'd5;

if_id_rs1 = 5'd5;
if_id_rs2 = 5'd2;

#20;

// No hazard
if_id_rs1 = 5'd1;
if_id_rs2 = 5'd2;

#20;

// x0 should not stall
id_ex_rd = 5'd0;

if_id_rs1 = 5'd0;

#20;

$finish;

end

endmodule