`timescale 1ns/1ps

module forwarding_unit_tb;

reg [4:0] ex_rs1;
reg [4:0] ex_rs2;

reg [4:0] mem_rd;
reg mem_reg_write;

reg [4:0] wb_rd;
reg wb_reg_write;

wire [1:0] forwardA;
wire [1:0] forwardB;

forwarding_unit dut(

.ex_rs1(ex_rs1),
.ex_rs2(ex_rs2),

.mem_rd(mem_rd),
.mem_reg_write(mem_reg_write),

.wb_rd(wb_rd),
.wb_reg_write(wb_reg_write),

.forwardA(forwardA),
.forwardB(forwardB)

);

initial begin

    $dumpfile("forwarding_unit.vcd");
    $dumpvars(0,forwarding_unit_tb);

    // EX/MEM Forwarding
    ex_rs1 = 5'd3;
    ex_rs2 = 5'd4;

    mem_rd = 5'd3;
    mem_reg_write = 1;

    wb_rd = 5'd0;
    wb_reg_write = 0;

    #20;

    // MEM/WB Forwarding
    mem_rd = 5'd0;
    mem_reg_write = 0;

    wb_rd = 5'd4;
    wb_reg_write = 1;

    #20;

    // No Forwarding
    ex_rs1 = 5'd1;
    ex_rs2 = 5'd2;

    mem_rd = 5'd5;
    wb_rd = 5'd6;

    #20;

    $finish;

end

endmodule