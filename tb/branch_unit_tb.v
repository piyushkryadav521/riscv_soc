`timescale 1ns/1ps

module branch_unit_tb;

reg Branch;
reg Zero;

wire PCSrc;

branch_unit DUT(

    .Branch(Branch),
    .Zero(Zero),
    .PCSrc(PCSrc)

);

initial begin

    $dumpfile("branch_unit.vcd");
    $dumpvars(0, branch_unit_tb);

    // Case 1
    Branch = 0;
    Zero   = 0;
    #10;

    // Case 2
    Branch = 1;
    Zero   = 0;
    #10;

    // Case 3
    Branch = 0;
    Zero   = 1;
    #10;

    // Case 4
    Branch = 1;
    Zero   = 1;
    #10;

    $finish;

end

endmodule