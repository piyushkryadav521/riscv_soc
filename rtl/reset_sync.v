`timescale 1ns/1ps

module reset_sync (

    input  wire clk,
    input  wire rst_async,

    output wire rst_sync

);

reg ff1;
reg ff2;

always @(posedge clk or posedge rst_async) begin
    if (rst_async) begin
        ff1 <= 1'b1;
        ff2 <= 1'b1;
    end
    else begin
        ff1 <= 1'b0;
        ff2 <= ff1;
    end
end

assign rst_sync = ff2;

endmodule