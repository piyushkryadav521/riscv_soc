`timescale 1ns/1ps

module flush_unit_tb;

reg PCSrc;

wire IF_ID_Flush;

flush_unit DUT(

    .PCSrc(PCSrc),
    .IF_ID_Flush(IF_ID_Flush)

);

initial begin

    $dumpfile("flush_unit.vcd");
    $dumpvars(0, flush_unit_tb);

    // No branch
    PCSrc = 0;
    #10;

    // Branch taken
    PCSrc = 1;
    #10;

    // Normal execution
    PCSrc = 0;
    #10;

    $finish;

end

endmodule