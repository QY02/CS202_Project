`timescale 1ns / 1ps

module Executs32 ( 
// from Decoder
input[31:0] Read_data_1, //the source of Ainput
input[31:0] Read_data_2, //one of the sources of Binput
input[31:0] Sign_extend, //one of the sources of Binput
// from IFetch
input[5:0] Opcode, //instruction[31:26]
input[5:0] Function_opcode, //instructions[5:0]
input[4:0] Shamt, //instruction[10:6], the amount of shift bits
input[31:0] PC_plus_4, //pc+4
// from Controller
input[1:0] ALUOp, //{ (R_format || I_format) , (Branch || nBranch) }
input ALUSrc, // 1 means the 2nd operand is an immediate (except beq,bne）
input I_format, // 1 means I-Type instruction except beq, bne, LW, SW
input Sftmd, // 1 means this is a shift instruction

output reg [31:0]  ALU_Result, // the ALU calculation result
output Zero, // 1 means the ALU_reslut is zero, 0 otherwise
output[31:0] Addr_Result // the calculated instruction addres
);

wire[31:0] Ainput,Binput; // two operands for calculation
wire[5:0] Exe_code; // use to generate ALU_ctrl. (I_format==0) ? Function_opcode : { 3'b000 , Opcode[2:0] };
wire[2:0] ALU_ctl; // the control signals which affact operation in ALU directely
wire[2:0] Sftm; // identify the types of shift instruction, equals to Function_opcode[2:0]
reg[31:0] Shift_Result; // the result of shift operation
reg[31:0] ALU_output_mux; // the result of arithmetic or logic calculation
wire[32:0] Branch_Addr; // the calculated address of the instruction, Addr_Result is Branch_Addr[31:0]

assign Ainput = Read_data_1;
assign Binput = (ALUSrc == 0) ? Read_data_2 : Sign_extend[31:0];


// ALUOp ={ (R_format || I_format) , (Branch || nBranch) }
// assign Exe_code = (I_format==0)?Function_opcode :{ 3'b000 , Opcode[2:0] };
// R_format = (Opcode==6'b000000)? 1'b1:1'b0;
endmodule