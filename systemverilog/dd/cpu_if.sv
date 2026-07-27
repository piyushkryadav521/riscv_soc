interface cpu_if;

    logic clk;
    logic rst;

    logic [31:0] data_in;
    logic [31:0] data_out;

    logic valid;
    logic ready;

endinterface