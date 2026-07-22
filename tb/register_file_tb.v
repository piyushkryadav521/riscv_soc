`timescale 1ns/1ps

module register_file_tb;

    reg clk;
    reg rst;
    reg we;

    reg [4:0] rs1;
    reg [4:0] rs2;
    reg [4:0] rd;

    reg [31:0] write_data;

    wire [31:0] read_data1;
    wire [31:0] read_data2;

    // Instantiate DUT
    register_file dut (
        .clk(clk),
        .rst(rst),
        .we(we),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // Clock Generation
    always #5 clk = ~clk;

    initial begin

        $dumpfile("register_file.vcd");
        $dumpvars(0, register_file_tb);

        clk = 0;
        rst = 1;
        we = 0;

        rs1 = 0;
        rs2 = 0;
        rd = 0;
        write_data = 0;

        #10;
        rst = 0;

        // Write 100 into x1
        we = 1;
        rd = 5'd1;
        write_data = 32'd100;
        #10;

        // Write 200 into x2
        rd = 5'd2;
        write_data = 32'd200;
        #10;

        // Disable write
        we = 0;

        // Read x1 and x2
        rs1 = 5'd1;
        rs2 = 5'd2;
        #10;

        $display("x1 = %d", read_data1);
        $display("x2 = %d", read_data2);

        // Read x0 (must always be zero)
        rs1 = 5'd0;
        #10;

        $display("x0 = %d", read_data1);

        $finish;

    end

endmodule