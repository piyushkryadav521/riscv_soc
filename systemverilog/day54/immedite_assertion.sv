module immediate_assertion;

logic [3:0] a;
logic [3:0] b;

initial begin

    a = 4'd5;
    b = 4'd5;

    assert (a == b)
        $display("PASS: a equals b");
    else
        $error("FAIL: a does not equal b");

    b = 4'd3;

    assert (a == b)
        $display("PASS");
    else
        $error("FAIL: assertion triggered");

end

endmodule