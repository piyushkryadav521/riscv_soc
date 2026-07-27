module producer(cpu_if bus);

always_ff @(posedge bus.clk) begin

    if (bus.rst) begin
        bus.data_out <= 32'd0;
        bus.ready    <= 1'b0;
    end
    else begin
        bus.data_out <= bus.data_in + 1;
        bus.ready    <= 1'b1;
    end

end

endmodule