module spi_master #(
    parameter CLK_DIV = 4
)(
    input clk,
    input rst,

    input start,
    input [7:0] tx_data,

    output reg sclk,
    output reg mosi,
    output reg cs_n,
    output reg busy
);

reg [7:0] shift_reg;
reg [2:0] bit_cnt;
reg [7:0] clk_cnt;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        sclk      <= 1'b0;
        cs_n      <= 1'b1;
        busy      <= 1'b0;
        mosi      <= 1'b0;
        shift_reg <= 8'd0;
        bit_cnt   <= 3'd0;
        clk_cnt   <= 8'd0;
    end
    else begin
        if (!busy) begin
            sclk <= 1'b0;

            if (start) begin
                busy      <= 1'b1;
                cs_n      <= 1'b0;
                shift_reg <= tx_data;
                bit_cnt   <= 3'd7;
                clk_cnt   <= 0;
            end
        end
        else begin
            if (clk_cnt == CLK_DIV-1) begin
                clk_cnt <= 0;
                sclk <= ~sclk;

                if (sclk == 1'b0) begin
                    mosi <= shift_reg[7];
                    shift_reg <= {shift_reg[6:0],1'b0};

                    if (bit_cnt == 0) begin
                        busy <= 1'b0;
                        cs_n <= 1'b1;
                    end
                    else begin
                        bit_cnt <= bit_cnt - 1;
                    end
                end
            end
            else begin
                clk_cnt <= clk_cnt + 1;
            end
        end
    end
end

endmodule