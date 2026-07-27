module typedef_example;

typedef logic [31:0] word_t;

word_t instruction;
word_t data;

initial begin
    instruction = 32'h12345678;
    data = 32'hDEADBEEF;

    $display("Instruction = %h", instruction);
    $display("Data        = %h", data);
end

endmodule