`timescale 1ns / 1ps

module cpu_top (
input clock,  //时钟
input[23:0] switch,  //24个拨码开关
input reset_h,  
output[23:0] led_out, //17个led输出（测试场景1）
output[7:0] seg_out, 
output[7:0] seg_en,  //数码显像管
output hsync,
output vsync,
output [11:0] vga_rgb
);

assign reset = ~reset_h;

wire clk_cpu;

clk_main clk_main(
    .clk_out(clk_cpu),
    .resetn(reset),
    .clk_in(clock)
);

//d_memory  inputs
wire clk; //给d_memory专用的clk（下降沿）
//d_memory  outputs
wire[31:0] readData; //读出来的data


//IF  outputs
wire [31:0] Instruction; //读出的指令 -->decoder  input
wire [31:0] branch_base_addr; // (pc+4) to ALU which is used by branch type instruction -->ALU  inputs
wire [31:0] link_addr; // (pc+4) to Decoder which is used by jal instruction


//controller  outputs
wire jr ; // 1 indicates the instruction is "jr", otherwise it's not "jr" output Jmp; -->IF  inputs
wire jmp; // 1 indicate the instruction is "j", otherwise it's not  -->IF  inputs
wire jal; // 1 indicate the instruction is "jal", otherwise it's not  -->IF  inputs
wire branch; // 1 indicate the instruction is "beq" , otherwise it's not  -->IF  inputs
wire nbranch; // 1 indicate the instruction is "bne", otherwise it's not  -->IF  inputs
wire regDST; // 1 indicate destination register is "rd"(R),otherwise it's "rt"(I) -->decoder  input
wire memIOToReg; // 1 indicate read data from memory and write it into register
wire regWrite; // 1 indicate write register(R,I(lw)), otherwise it's not -->decoder  input
wire IORead; // 1 indicate read data from IO, otherwise it's not
//assign IORead = 1'b0;
wire IOWrite; // 1 indicate write data into IO, otherwise it's not
wire memWrite; // 1 indicate write data memory, otherwise it's not -->d_memory  inputs
wire ALUSrc; // 1 indicate the 2nd data is immidiate (except "beq","bne") -->ALU  inputs
wire I_format; // 1 means I-Type instruction except beq, bne, LW, SW -->ALU  inputs
wire Sftmd; // 1 indicate the instruction is shift   -->ALU  inputs
wire [1:0] ALUOp;//{ (R_format || I_format) , (Branch || nBranch) } -->ALU  inputs


//ALU  outputs
wire Zero; // while Zero is 1, it means the ALUresult is 0  -->IF  inputs
wire [31:0] Addr_Result;// the calculated address from ALU -->IF  inputs
wire [31:0] ALU_Result; //计算结果


//Decoder  outputs
wire [31:0] Read_data_1;//读出的第一个data -->IF  inputs (the address of instruction used by jr instruction)
//-->ALU  inputs(the source of Ainput)
wire [31:0] Read_data_2;//读出的第二个data -->ALU  inputs (one of the sources of Binput)
wire [31:0] Sign_extend;//16-32 -->ALU  inputs


wire [31:0] io_rdata;
//assign io_rdata = 16'b0;

//MemOrIO  outputs
wire [31:0] address;// 地址 -->d_memory  inputs
wire [31:0] r_wdata;// data to decoder(register file) -->decoder  input
wire [31:0] writeData;//写入的data -->d_memory  inputs
wire LEDCtrl, SwitchCtrl;


//instruction related
wire [5:0]Opcode;
wire[5:0] Function_opcode;
wire[4:0] Shamt;
    
assign Shamt=Instruction[10:6];
assign Opcode=Instruction[31:26]; 
assign Function_opcode=Instruction[5:0];

//display
display dis(clock,reset,2'b0,27'b110,5'b0, seg_en, seg_out,hsync,vsync,vga_rgb);


//Data memory
dmemory32 uram(clk_cpu,memWrite,address,writeData,readData);
/*The ‘clock’ is from CPU-TOP, suppose its one edge has been used at the upstream module of data memory, such as IFetch, Why Data-Memroy DO NOT use the same edge as other module ? */
assign clk = !clk_cpu;


//Instruction Fetch
IFetc32 ifetch(Instruction, branch_base_addr, link_addr, clk_cpu, reset, Addr_Result,
 Read_data_1, branch, nbranch, jmp, jal, jr, Zero);

//ALU
Executs32 alu(Read_data_1,Read_data_2,Sign_extend,Opcode,Function_opcode,Shamt,branch_base_addr,ALUOp
                        ,ALUSrc,I_format,Sftmd,ALU_Result,Zero,Addr_Result);

//controller
control32 control(Opcode,Function_opcode,ALU_Result[31:10],jr,jmp,jal,branch,nbranch,regDST,memIOToReg,regWrite,IORead,IOWrite,memWrite,ALUSrc,I_format,Sftmd,ALUOp);

//decoder
decoder32 decoder(clk_cpu, reset, Instruction[25:21], Instruction[20:16], Instruction[15:11], r_wdata, regWrite, Read_data_1, Read_data_2);

//MemOrIO
MemOrIO mem(memIOToReg, memWrite, IORead, IOWrite, Addr_Result, address, readData, io_rdata, r_wdata, 
Read_data_1, writeData, LEDCtrl, SwitchCtrl);

wire [31:0] address_io;
io_address_convert iac(LEDCtrl, SwitchCtrl, address, address_io);

led led(clk_cpu, reset, LEDCtrl, address_io[1:0], writeData, led_out);

Switch switch0(clk_cpu, reset, SwitchCtrl, address_io[1:0], switch, io_rdata);

endmodule