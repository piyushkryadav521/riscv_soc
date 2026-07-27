module apb_slave (

    input clk,
    input rst,

    input PSEL,
    input PENABLE,
    input PWRITE,

    input [31:0] PADDR,
    input [31:0] PWDATA,

    output reg [31:0] PRDATA,
    output reg PREADY

);

reg [31:0] mem [0:15];

integer i;

always @(posedge clk or posedge rst) begin

    if (rst) begin

        PREADY <= 0;
        PRDATA <= 0;

        for(i=0;i<16;i=i+1)
            mem[i] <= 0;

    end
    else begin

        PREADY <= 0;

        if(PSEL && PENABLE) begin

            PREADY <= 1;

            if(PWRITE)
                mem[PADDR[5:2]] <= PWDATA;
            else
                PRDATA <= mem[PADDR[5:2]];

        end

    end

end

endmodule