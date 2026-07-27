module struct_example;

typedef struct packed {

    logic [31:0] pc;
    logic [31:0] instruction;
    logic valid;

} if_packet_t;

if_packet_t packet;

initial begin

    packet.pc = 32'h1000;
    packet.instruction = 32'h00000013;
    packet.valid = 1'b1;

    $display("PC = %h", packet.pc);

end

endmodule