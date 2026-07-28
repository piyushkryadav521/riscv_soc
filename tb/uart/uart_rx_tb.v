`timescale 1ns/1ps

module uart_rx_tb;

reg clk;
reg rst;
reg rx;

wire [7:0] rx_data;
wire rx_done;

uart_rx #(
    .CLK_FREQ(100),
    .BAUD_RATE(10)
)
dut(
    .clk(clk),
    .rst(rst),
    .rx(rx),
    .rx_data(rx_data),
    .rx_done(rx_done)
);

always #5 clk = ~clk;

// Send one UART bit
task send_bit;
input bit_value;
begin
    rx = bit_value;
    #100;
end
endtask

initial begin

    $dumpfile("uart_rx.vcd");
    $dumpvars(0, uart_rx_tb);

    clk = 0;
    rst = 1;
    rx = 1;

    #20;
    rst = 0;

    #50;

    // Start bit
    send_bit(0);

    // Data = 8'hA5 (LSB first)
    send_bit(1);
    send_bit(0);
    send_bit(1);
    send_bit(0);
    send_bit(0);
    send_bit(1);
    send_bit(0);
    send_bit(1);

    // Stop bit
    send_bit(1);

    #300;

    $display("Received Data = %h", rx_data);

    $finish;

end

endmodule