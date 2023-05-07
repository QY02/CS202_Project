`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/10 16:20:18
// Design Name: 
// Module Name: control32
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module control32(Opcode,func,Alu_resultHigh,jr,jmp,jal,branch,nbranch,regDST,memIOToReg,regWrite,IORead,IOWrite,memWrite,ALUSrc,I_format,Sftmd,ALUOp);
input [5:0] Opcode;
input [5:0] func;
input [21:0] Alu_resultHigh;
output jr ; // 1 indicates the instruction is "jr", otherwise it's not "jr" output Jmp; // 1 indicate the instruction is "j", otherwise it's not
output jmp;
output jal; // 1 indicate the instruction is "jal", otherwise it's not
output branch; // 1 indicate the instruction is "beq" , otherwise it's not
output nbranch; // 1 indicate the instruction is "bne", otherwise it's not
output regDST; // 1 indicate destination register is "rd"(R),otherwise it's "rt"(I)
output memIOToReg; // 1 indicate read data from memory and write it into register
output regWrite; // 1 indicate write register(R,I(lw)), otherwise it's not
output IORead; // 1 indicate read data from IO, otherwise it's not
output IOWrite; // 1 indicate write data into IO, otherwise it's not
output memWrite; // 1 indicate write data memory, otherwise it's not
output ALUSrc; // 1 indicate the 2nd data is immidiate (except "beq","bne")
output I_format;
output Sftmd; // 1 indicate the instruction is shift
output [1:0] ALUOp;


wire R_format;
assign R_format = (Opcode==6'b000000)?1'b1:1'b0;
assign I_format = (Opcode[5:3]==3'b001)?1'b1:1'b0;//except beq bne lw sw

//jr
assign jr = ((Opcode==6'b000000)&&(func==6'b001000)?1'b1:1'b0);
assign jmp = (Opcode==6'b000010)?1'b1:1'b0;
assign jal = (Opcode==6'b000011)?1'b1:1'b0;
assign branch = (Opcode==6'b000100)?1'b1:1'b0;
assign nbranch = (Opcode==6'b000101)?1'b1:1'b0;
assign regDST = R_format;

//
wire lw = (Opcode==6'b100011)?1'b1:1'b0;
wire sw = (Opcode==6'b101011)?1'b1:1'b0;
assign memIOToReg = IORead||memRead;
assign regWrite = (R_format||lw||jal||I_format)&&!(jr);
assign memWrite = ((sw==1) && (Alu_resultHigh[21:0] != 22'h3FFFFF)) ? 1'b1:1'b0;
assign memRead = ((lw==1) && (Alu_resultHigh[21:0] != 22'h3FFFFF)) ? 1'b1:1'b0;
assign IOWrite = ((sw==1) && (Alu_resultHigh[21:0] == 22'h3FFFFF)) ? 1'b1:1'b0;
assign IORead = ((lw==1) && (Alu_resultHigh[21:0] == 22'h3FFFFF)) ? 1'b1:1'b0;
assign ALUSrc = I_format||lw|sw;
assign Sftmd = (((func==6'b000000)||(func==6'b000010)||(func==6'b000011)||(func==6'b000100)||(func==6'b000110)||(func==6'b000111))&& R_format)? 1'b1:1'b0;
assign ALUOp = {(R_format||I_format),(branch||nbranch)};     

endmodule
