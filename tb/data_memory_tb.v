`timescale 1ns/1ps

module data_memory_tb;

    reg clk;
    reg MemRead;
    reg MemWrite;
    reg [31:0] addr;
    reg [31:0] write_data;

    wire [31:0] read_data;

    // Instantiate DUT
    data_memory dut (
        .clk(clk),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .addr(addr),
        .write_data(write_data),
        .read_data(read_data)
    );

    // Clock Generation
    always #5 clk = ~clk;

    initial begin

        $dumpfile("data_memory.vcd");
        $dumpvars(0, data_memory_tb);

        clk = 0;
        MemRead = 0;
        MemWrite = 0;
        addr = 0;
        write_data = 0;

        // Write 100 to address 0
        #10;
        MemWrite = 1;
        addr = 32'd0;
        write_data = 32'd100;
        #10;

        // Write 200 to address 4
        addr = 32'd4;
        write_data = 32'd200;
        #10;

        MemWrite = 0;

        // Read address 0
        MemRead = 1;
        addr = 32'd0;
        #10;
        $display("Read Address 0 = %d", read_data);

        // Read address 4
        addr = 32'd4;
        #10;
        $display("Read Address 4 = %d", read_data);

        MemRead = 0;

        #10;
        $finish;

    end

endmodule