`timescale 1ns/1ps

module data_hazard_tb;

reg [4:0] ex_rd;

reg ex_reg_write;

reg [4:0] id_rs1;
reg [4:0] id_rs2;

wire hazard;

data_hazard dut(

.ex_rd(ex_rd),
.ex_reg_write(ex_reg_write),

.id_rs1(id_rs1),
.id_rs2(id_rs2),

.hazard(hazard)

);

initial
begin

$dumpfile("data_hazard.vcd");
$dumpvars(0,data_hazard_tb);

// Hazard
ex_rd = 5'd3;

ex_reg_write = 1;

id_rs1 = 5'd3;
id_rs2 = 5'd5;

#20;

// No Hazard
id_rs1 = 5'd1;
id_rs2 = 5'd2;

#20;

// x0 should never create hazard
ex_rd = 5'd0;

id_rs1 = 5'd0;

#20;

$finish;

end

endmodule