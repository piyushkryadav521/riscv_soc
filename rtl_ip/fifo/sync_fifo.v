module sync_fifo #

(

parameter WIDTH = 8,
parameter DEPTH = 8

)

(

input clk,
input rst,

input wr_en,
input rd_en,

input [WIDTH-1:0] data_in,

output reg [WIDTH-1:0] data_out,

output full,
output empty,

output reg overflow,
output reg underflow

);

reg [WIDTH-1:0] mem [0:DEPTH-1];

reg [2:0] wr_ptr;
reg [2:0] rd_ptr;

reg [3:0] count;

assign full = (count == DEPTH);

assign empty = (count == 0);

always @(posedge clk or posedge rst)
begin
    if (rst)
    begin
        wr_ptr <= 0;
        rd_ptr <= 0;
        count <= 0;
        data_out <= 0;
        overflow <= 0;
        underflow <= 0;
    end
    else
    begin
        overflow <= 0;
        underflow <= 0;

        // WRITE
        if (wr_en)
        begin
            if (!full)
            begin
                mem[wr_ptr] <= data_in;
                wr_ptr <= wr_ptr + 1;

                if (!(rd_en && !empty))
                    count <= count + 1;
            end
            else
                overflow <= 1;
        end

        // READ
        if (rd_en)
        begin
            if (!empty)
            begin
                data_out <= mem[rd_ptr];
                rd_ptr <= rd_ptr + 1;

                if (!(wr_en && !full))
                    count <= count - 1;
            end
            else
                underflow <= 1;
        end
    end
end

endmodule