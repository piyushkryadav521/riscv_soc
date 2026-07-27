module apb_master (

    input clk,
    input rst,

    input start,
    input write,

    input [31:0] addr,
    input [31:0] wdata,

    input PREADY,

    output reg PSEL,
    output reg PENABLE,
    output reg PWRITE,

    output reg [31:0] PADDR,
    output reg [31:0] PWDATA

);

localparam IDLE   = 2'd0;
localparam SETUP  = 2'd1;
localparam ACCESS = 2'd2;

reg [1:0] state;

always @(posedge clk or posedge rst) begin

    if (rst) begin

        state <= IDLE;

        PSEL <= 0;
        PENABLE <= 0;
        PWRITE <= 0;

        PADDR <= 0;
        PWDATA <= 0;

    end
    else begin

        case(state)

        IDLE:

            begin

                if(start) begin

                    PSEL <= 1;
                    PENABLE <= 0;

                    PWRITE <= write;

                    PADDR <= addr;
                    PWDATA <= wdata;

                    state <= SETUP;

                end

            end

        SETUP:

            begin

                PENABLE <= 1;

                state <= ACCESS;

            end

        ACCESS:

            begin

                if(PREADY) begin

                    PSEL <= 0;
                    PENABLE <= 0;

                    state <= IDLE;

                end

            end

        endcase

    end

end

endmodule