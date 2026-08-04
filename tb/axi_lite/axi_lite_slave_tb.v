`timescale 1ns/1ps

module axi_lite_slave_tb;

reg ACLK;
reg ARESETn;

reg [31:0] AWADDR;
reg AWVALID;
wire AWREADY;

reg [31:0] WDATA;
reg WVALID;
wire WREADY;

wire [1:0] BRESP;
wire BVALID;

reg BREADY;

reg [31:0] ARADDR;
reg ARVALID;

wire ARREADY;

wire [31:0] RDATA;
wire [1:0] RRESP;
wire RVALID;

reg RREADY;

axi_lite_slave dut(

.ACLK(ACLK),
.ARESETn(ARESETn),

.AWADDR(AWADDR),
.AWVALID(AWVALID),
.AWREADY(AWREADY),

.WDATA(WDATA),
.WVALID(WVALID),
.WREADY(WREADY),

.BRESP(BRESP),
.BVALID(BVALID),
.BREADY(BREADY),

.ARADDR(ARADDR),
.ARVALID(ARVALID),
.ARREADY(ARREADY),

.RDATA(RDATA),
.RRESP(RRESP),
.RVALID(RVALID),
.RREADY(RREADY)

);

always #5 ACLK = ~ACLK;

initial
begin

    $dumpfile("axi_lite_slave.vcd");
    $dumpvars(0,axi_lite_slave_tb);

    ACLK = 0;

    ARESETn = 0;

    AWADDR = 0;
    AWVALID = 0;

    WDATA = 0;
    WVALID = 0;

    BREADY = 0;

    ARADDR = 0;
    ARVALID = 0;

    RREADY = 0;

    #20;
    ARESETn = 1;

// AXI Write Transaction
@(posedge ACLK);

AWADDR = 32'h00000008;
AWVALID = 1;

WDATA = 32'h12345678;
WVALID = 1;

@(posedge ACLK);

AWVALID = 0;
WVALID = 0;

BREADY = 1;

@(posedge ACLK);

BREADY = 0;

// AXI Read Transaction
@(posedge ACLK);
ARADDR = 32'h00000008;
ARVALID = 1;

@(posedge ACLK);
ARVALID = 0;
RREADY = 1;

@(posedge ACLK);
RREADY = 0;

    #100;

    $finish;

end

endmodule