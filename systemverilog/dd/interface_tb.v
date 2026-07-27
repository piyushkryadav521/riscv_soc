`timescale 1ns/1ps

module interface_tb;

cpu_if bus();

producer dut(bus);

always #5 bus.clk = ~bus.clk;

initial begin

    $dumpfile("interface.vcd");
    $dumpvars(0, interface_tb);

    bus.clk = 0;
    bus.rst = 1;
    bus.data_in = 10;

    #10 bus.rst = 0;

    #20 bus.data_in = 25;

    #20 $finish;

end

endmodule