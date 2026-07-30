wire tx_line;

uart_tx tx_inst(
    ...
    .tx(tx_line)
);

uart_rx rx_inst(
    ...
    .rx(tx_line)
);

if(rx_data == 8'h5A)
    $display("LOOPBACK PASS");
else
    $display("LOOPBACK FAIL");