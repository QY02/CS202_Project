`timescale 1ns / 1ps

module cpu_top (
input clock,  //时钟
input[23:0] switch,  //24个拨码开关
input fpga_rst,  //???
output[23:0] led_out, //17个led输出（测试场景1）
// input[3:0] row,
// output[3:0] col,
output[7:0] seg_out, 
output[7:0] seg_en  //数码显像管
// input start_pg, //active high
// input rx, //receive data by UART
// output tx //send data by UART
);


//d_memory  inputs
wire clk; //给d_memory专用的clk（下降沿）
wire [31:0] address;// 地址 -->d_memory  inputs
wire [31:0] writeData;//写入的data -->d_memory  inputs
//d_memory  outputs
wire[31:0] readData; //读出来的data


//IF  inputs
wire IFreset; //reset
wire Branch; // while Branch is 1,it means current instruction is beq
wire nBranch; // while nBranch is 1,it means current instruction is bnq
wire Jmp; // while Jmp 1, it means current instruction is jump
wire Jal; // while Jal is 1, it means current instruction is jal
wire Jr; // while Jr is 1, it means current instruction is jr
//IF  outputs
wire [31:0] Instruction; //读出的指令
wire [31:0] branch_base_addr; // (pc+4) to ALU which is used by branch type instruction -->ALU  inputs
wire [31:0] link_addr; // (pc+4) to Decoder which is used by jal instruction


//controller  outputs
wire memWrite;// d_memory使能信号 -->d_memory  inputs
wire [1:0] ALUOp; //{ (R_format || I_format) , (Branch || nBranch) } -->ALU  inputs
wire ALUSrc; // 1 means the 2nd operand is an immediate (except beq,bne） -->ALU  inputs
wire I_format; // 1 means I-Type instruction except beq, bne, LW, SW -->ALU  inputs
wire Sftmd; // 1 means this is a shift instruction -->ALU  inputs

//ALU  outputs
wire Zero; // while Zero is 1, it means the ALUresult is 0  -->IF  inputs
wire [31:0] Addr_Result;// the calculated address from ALU -->IF  inputs
wire [31:0] ALU_Result; //计算结果


//Decoder  outputs
wire [31:0] Read_data_1;//读出的第一个data -->IF  inputs (the address of instruction used by jr instruction)
//-->ALU  inputs(the source of Ainput)
wire [31:0] Read_data_2;//读出的第二个data -->ALU  inputs (one of the sources of Binput)
wire [31:0] Sign_extend;//16-32 -->ALU  inputs


//instruction related
wire [5:0]Opcode;
wire[5:0] Function_opcode;
wire[4:0] Shamt;
    
assign Shamt=Instruction[10:6];
assign Opcode=Instruction[31:26]; 
assign Function_opcode=Instruction[5:0];

//Data memory
dmemory32 uram(clock,memWrite,address,writeData,readData);
/*The ‘clock’ is from CPU-TOP, suppose its one edge has been used at the upstream module of data memory, such as IFetch, Why Data-Memroy DO NOT use the same edge as other module ? */
assign clk = !clock;


//Instruction Fetch
IFetc32 ifetch(Instruction, branch_base_addr, link_addr, clock, IFreset, Addr_result,
 Read_data_1, Branch, nBranch, Jmp, Jal, Jr, Zero);

//ALU
executs32 alu(Read_data_1,Read_data_2,Sign_extend,Opcode,Function_opcode,Shamt,branch_base_addr,ALUOp
                        ,ALUSrc,I_format,Sftmd,ALU_Result,Zero,Addr_Result);
endmodule