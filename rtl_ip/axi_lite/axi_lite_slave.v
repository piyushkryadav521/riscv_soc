module axi_lite_slave(

input ACLK,
input ARESETn,

// Write Address Channel
input [31:0] AWADDR,
input AWVALID,
output reg AWREADY,

// Write Data Channel
input [31:0] WDATA,
input WVALID,
output reg WREADY,

// Write Response
output reg [1:0] BRESP,
output reg BVALID,
input BREADY,

// Read Address
input [31:0] ARADDR,
input ARVALID,
output reg ARREADY,

// Read Data
output reg [31:0] RDATA,
output reg [1:0] RRESP,
output reg RVALID,
input RREADY

);

reg [31:0] reg0;
reg [31:0] reg1;
reg [31:0] reg2;
reg [31:0] reg3;

always @(posedge ACLK or negedge ARESETn)
begin

    if(!ARESETn)
    begin

        AWREADY <= 0;
        WREADY  <= 0;

        BVALID <= 0;
        BRESP <= 2'b00;

        ARREADY <= 0;

        RVALID <= 0;
        RRESP <= 2'b00;

        RDATA <= 0;

        reg0 <= 32'd0;
        reg1 <= 32'd0;
        reg2 <= 32'd0;
        reg3 <= 32'd0;
    end

    else
    begin

// Read Address Handshake
    if(ARVALID && !ARREADY)
    begin
        ARREADY <= 1;

        case (ARADDR[5:2])

        2'd0:
            RDATA <= reg0;

        2'd1:
            RDATA <= reg1;

        2'd2:
            RDATA <= reg2;

        2'd3:
            RDATA <= reg3;

        default:
            RDATA <= 32'hDEADBEEF;
        endcase

        RRESP <= 2'b00;

        RVALID <= 1;
    end
    else
    begin
        ARREADY <= 0;
    end

// Read Response Handshake
    if(RVALID && RREADY)
    begin
        RVALID <= 0;
    end

        // Write Address Handshake
        if(AWVALID && !AWREADY)
            AWREADY <= 1;
        else
            AWREADY <= 0;

        // Write Data Handshake
        if(WVALID && !WREADY)
            WREADY <= 1;
        else
            WREADY <= 0;

        // Memory Write
        if(AWVALID && WVALID)
        begin
            case (AWADDR[5:2])

            2'd0:
                reg0 <= WDATA;

            2'd1:
                reg1 <= WDATA;

            2'd2:
                reg2 <= WDATA;

            2'd3:
                reg3 <= WDATA;

            default:
                ;

            endcase
            BRESP <= 2'b00;
            BVALID <= 1;
        end

        // Response Handshake
        if(BVALID && BREADY)
            BVALID <= 0;
    end
end

endmodule