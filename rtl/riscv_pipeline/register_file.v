module register_file(

input clk,
input rst,

input reg_write,

input [4:0] rs1,
input [4:0] rs2,
input [4:0] rd,

input [31:0] write_data,

output [31:0] rs1_data,
output [31:0] rs2_data

);

reg [31:0] reg_mem [0:31];

integer i;

always @(posedge clk or posedge rst)
begin

    if(rst)
    begin

        for(i=0;i<32;i=i+1)
            reg_mem[i] <= 32'd0;

    end

    else if(reg_write && (rd != 5'd0))
    begin

        reg_mem[rd] <= write_data;

    end

end

assign rs1_data = (rs1 == 5'd0) ? 32'd0 : reg_mem[rs1];
assign rs2_data = (rs2 == 5'd0) ? 32'd0 : reg_mem[rs2];

endmodule