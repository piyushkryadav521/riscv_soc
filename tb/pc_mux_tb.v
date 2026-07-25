`timescale 1ns/1ps

module pc_mux_tb;

reg [31:0] pc_plus4;
reg [31:0] branch_target;

reg PCSrc;

wire [31:0] next_pc;

pc_mux DUT(

    .pc_plus4(pc_plus4),
    .branch_target(branch_target),
    .PCSrc(PCSrc),
    .next_pc(next_pc)

);

initial begin

    $dumpfile("pc_mux.vcd");
    $dumpvars(0, pc_mux_tb);

    // Normal execution
    pc_plus4      = 32'd104;
    branch_target = 32'd200;
    PCSrc         = 0;

    #10;

    // Branch taken
    PCSrc = 1;

    #10;

    $finish;

end

endmodule