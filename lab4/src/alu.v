`include "alu_op.vh"

module alu(
    input [31:0] a, b,
    input [3:0] alu_op,
    output [31:0] out
);

// Your code goes here
reg [31:0] alu_out;

always @(*) begin
    case(alu_op)
        `ALU_ADD   : alu_out = a+b;
        `ALU_SUB   : alu_out = a-b;
        `ALU_AND   : alu_out = a&b;
        `ALU_OR    : alu_out = a|b;
        `ALU_XOR   : alu_out = a^b;
        `ALU_SLT   : alu_out = ($signed(b)>$signed(a)) ? 1:0;
        `ALU_SLTU  : alu_out = (b>a) ? 1:0;
        `ALU_SLL   : alu_out = (a << b[4:0]);
        `ALU_SRA   : alu_out = ($signed(a) >>> b[4:0]);
        `ALU_SRL   : alu_out = (a >> b[4:0]);
        `ALU_COPY_B: alu_out = b;
        `ALU_XXX   : alu_out = 0;
    endcase
end
    assign out = alu_out;
endmodule
