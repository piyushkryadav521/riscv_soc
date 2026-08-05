module branch_control(

input branch,

input [2:0] funct3,

input zero,

output reg branch_taken

);

always @(*)
begin

    branch_taken = 1'b0;

    if(branch)
    begin

        case(funct3)

        3'b000:
            branch_taken = zero;        

        3'b001:
            branch_taken = ~zero;       

        default:
            branch_taken = 1'b0;

        endcase

    end

end

endmodule