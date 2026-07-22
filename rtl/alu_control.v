`timescale 1ns/1ps

module alu_control (

    input  wire [1:0] ALUOp,
    input  wire [2:0] funct3,
    input  wire [6:0] funct7,

    output reg  [3:0] alu_ctrl

);

always @(*) begin

    case (ALUOp)

        // Load/Store -> ADD
        2'b00:
            alu_ctrl = 4'b0000;

        // Branch -> SUB
        2'b01:
            alu_ctrl = 4'b0001;

        // R-Type / I-Type
        2'b10: begin

            case ({funct7, funct3})

                10'b0000000_000: alu_ctrl = 4'b0000; // ADD
                10'b0100000_000: alu_ctrl = 4'b0001; // SUB
                10'b0000000_111: alu_ctrl = 4'b0010; // AND
                10'b0000000_110: alu_ctrl = 4'b0011; // OR
                10'b0000000_100: alu_ctrl = 4'b0100; // XOR
                10'b0000000_001: alu_ctrl = 4'b0101; // SLL
                10'b0000000_101: alu_ctrl = 4'b0110; // SRL
                10'b0000000_010: alu_ctrl = 4'b0111; // SLT

                default:
                    alu_ctrl = 4'b0000;

            endcase

        end

        default:
            alu_ctrl = 4'b0000;

    endcase

end

endmodule