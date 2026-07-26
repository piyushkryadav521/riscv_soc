`timescale 1ns/1ps

module cdc_sync (

    input  wire clk,
    input  wire rst,
    input  wire async_signal,

    output wire sync_signal

);

reg ff1;
reg ff2;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        ff1 <= 1'b0;
        ff2 <= 1'b0;
    end
    else begin
        ff1 <= async_signal;
        ff2 <= ff1;
    end
end

assign sync_signal = ff2;

endmodule