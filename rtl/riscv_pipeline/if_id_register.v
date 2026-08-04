module if_id_register(

input clk,
input rst,

input [31:0] if_pc,
input [31:0] if_instruction,

output reg [31:0] id_pc,
output reg [31:0] id_instruction

);

always @(posedge clk or posedge rst)
begin

    if(rst)
    begin

        id_pc <= 32'd0;
        id_instruction <= 32'd0;

    end

    else
    begin

        id_pc <= if_pc;
        id_instruction <= if_instruction;

    end

end

endmodule