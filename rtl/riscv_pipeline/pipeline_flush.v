module pipeline_flush(

input branch_taken,

output flush_if_id,
output flush_id_ex

);

assign flush_if_id = branch_taken;

assign flush_id_ex = branch_taken;

endmodule