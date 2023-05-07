`timescale 1ns / 1ps

module IFetc32(Instruction, branch_base_addr, link_addr, clock, reset, Addr_result, Read_data_1, Branch, nBranch, Jmp, Jal, Jr, Zero);
output[31:0] Instruction; // the instruction fetched from this module to Decoder and Controller
output[31:0] branch_base_addr; // (pc+4) to ALU which is used by branch type instruction
output[31:0] link_addr; // (pc+4) to Decoder which is used by jal instruction
//from CPU TOP
input clock, reset; // Clock and reset
// from ALU
input[31:0] Addr_result; // the calculated address from ALU
input Zero; // while Zero is 1, it means the ALUresult is zero
// from Decoder
input[31:0] Read_data_1; // the address of instruction used by jr instruction
// from Controller
input Branch; // while Branch is 1,it means current instruction is beq
input nBranch; // while nBranch is 1,it means current instruction is bnq
input Jmp; // while Jmp 1, it means current instruction is jump
input Jal; // while Jal is 1, it means current instruction is jal
input Jr; // while Jr is 1, it means current instruction is j

reg[31:0] PC, Next_PC;

always @* begin
if(((Branch == 1) && (Zero == 1 )) || ((nBranch == 1) && (Zero == 0))) // beq, bne
Next_PC = ... // the calculated new value for PC
else if(Jr == 1)
Next_PC = ... // the value of $31 register
else Next_PC = ... // PC+4
end
always @(... clock) begin
if(reset == 1)
PC <= 32'h0000_0000;
else begin
if((Jmp == 1) || (Jal == 1)) begin
PC <= ...;
end
else PC <= ...;
end
end

endmodule