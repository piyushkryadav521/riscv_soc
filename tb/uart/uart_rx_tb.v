`timescale 1ns/1ps

module uart_rx_tb;

parameter CLK_FREQ  = 1000;
parameter BAUD_RATE = 100;

localparam BAUD_PERIOD = CLK_FREQ / BAUD_RATE;

reg clk;
reg rst;
reg rx;

wire [7:0] rx_data;
wire rx_done;

uart_rx #(
    .CLK_FREQ(CLK_FREQ),
    .BAUD_RATE(BAUD_RATE)
)
dut(
    .clk(clk),
    .rst(rst),
    .rx(rx),
    .rx_data(rx_data),
    .rx_done(rx_done)
);

always #5 clk = ~clk;

task send_byte;
    input [7:0] data;
    integer i;
begin
    // Idle
    rx = 1;
    #(BAUD_PERIOD*10);

    // Start bit
    rx = 0;
    #(BAUD_PERIOD*10);

    // Data bits (LSB first)
    for(i=0;i<8;i=i+1)
    begin
        rx = data[i];
        #(BAUD_PERIOD*10);
    end

    // Stop bit
    rx = 1;
    #(BAUD_PERIOD*10);
end
endtask

initial
begin
    $dumpfile("uart_rx.vcd");
    $dumpvars(0,uart_rx_tb);

    clk = 0;
    rst = 1;
    rx = 1;

    #20;
    rst = 0;

    send_byte(8'hA5);

    #500;

    if(rx_done && rx_data==8'hA5)
        $display("PASS : UART RX received %h",rx_data);
    else
        $display("FAIL");

    $finish;
end

endmodule