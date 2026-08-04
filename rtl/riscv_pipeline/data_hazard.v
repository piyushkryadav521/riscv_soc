module data_hazard(

input [4:0] ex_rd,
input ex_reg_write,

input [4:0] id_rs1,
input [4:0] id_rs2,

output hazard

);

assign hazard =
(
    ex_reg_write &&
    (
        (ex_rd == id_rs1) ||
        (ex_rd == id_rs2)
    ) &&
    (ex_rd != 5'd0)
);

endmodule