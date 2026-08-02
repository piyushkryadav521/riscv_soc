`timescale 1ns/1ps

module i2c_master_tb;

reg clk;
reg rst;
reg start;
reg sda_in;
reg [7:0] tx_data;
wire ack_error;

reg [6:0] slave_addr;
reg rw;

wire scl;
wire sda;
wire busy;

i2c_master dut(
    .clk(clk),
    .rst(rst),
    .start(start),
    .slave_addr(slave_addr),
    .rw(rw),
    .scl(scl),
    .sda(sda),
    .busy(busy),
    .sda_in(sda_in),
    .ack_error(ack_error),
    .tx_data(tx_data)
);

always #5 clk = ~clk;

initial begin
    $dumpfile("i2c_master.vcd");
    $dumpvars(0,i2c_master_tb);

    clk = 0;
    rst = 1;
    start = 0;
    slave_addr = 7'h50;
    rw = 0; 
// first transition (ACK)
    tx_data = 8'hA5;
    sda_in=0;
    #20 rst = 0;
    #20 start = 1;
    #10 start = 0;
    
    #200;
// second transition (NACK)
    sda_in=1;
    #20 start=1;
    #10 start=0;
    #200;
    $finish;
end

endmodule