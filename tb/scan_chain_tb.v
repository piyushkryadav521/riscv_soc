`timescale 1ns/1ps

module scan_chain_tb;

reg clk;
reg rst;

reg scan_en;
reg scan_in;

reg [2:0] d;

wire [2:0] q;
wire scan_out;

scan_chain DUT(

    .clk(clk),
    .rst(rst),

    .scan_en(scan_en),
    .scan_in(scan_in),

    .d(d),

    .q(q),

    .scan_out(scan_out)

);

always #5 clk = ~clk;

initial begin

    clk = 0;
    rst = 1;

    scan_en = 0;
    scan_in = 0;

    d = 3'b101;

    #20;

    rst = 0;

    #20;

    // Functional mode
    scan_en = 0;
    d = 3'b110;

    #20;

    // Scan mode
    scan_en = 1;

    scan_in = 1;
    #10;

    scan_in = 0;
    #10;

    scan_in = 1;
    #10;

    scan_in = 1;
    #10;

    $finish;

end

initial begin
    $dumpfile("scan_chain.vcd");
    $dumpvars(0,scan_chain_tb);
end

endmodule