module instruction_fetch(

    input clk,
    input rst,

    output reg [31:0] pc,
    output reg [31:0] instruction

);

reg [31:0] imem [0:255];

initial begin

    imem[0] = 32'h00500093; // addi x1,x0,5
    imem[1] = 32'h00A00113; // addi x2,x0,10
    imem[2] = 32'h002081B3; // add x3,x1,x2
    imem[3] = 32'h00000013; // nop

end

always @(posedge clk or posedge rst)

begin

    if(rst)

    begin

        pc <= 32'd0;

        instruction <= 32'd0;

    end

    else

    begin

        instruction <= imem[pc[9:2]];

        pc <= pc + 4;

    end

end

endmodule