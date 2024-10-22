`timescale 1ns / 1ps

module cpu_top (
input fpga_clk,  //时钟
input[23:0] switch,  //24个拨码开关
input reset_h,  
input[3:0] row,
output[3:0] col,
output[23:0] led_out, //24个led输出
output[7:0] seg_out, 
output[7:0] seg_en,  //数码显像管
//VGA
output hsync,
output vsync,
output [11:0] vga_rgb,

//Uart 接口输入输出
input start_pg,
input rx,
output tx
);

// UART Programmer Pinouts
wire upg_clk, upg_clk_o;
wire upg_wen_o; //Uart write out enable
wire upg_done_o; //Uart rx data have done
//data to which memory unit of program_rom/dmemory32
wire [14:0] upg_adr_o;
//data to program_rom or dmemory32
wire [31:0] upg_dat_o;

wire spg_bufg;
BUFG U1(.I(start_pg), .O(spg_bufg)); // de-twitter
// Generate UART Programmer reset signal

reg upg_rst;
always @ (posedge fpga_clk) begin
    if (spg_bufg) upg_rst = 0;
    if (reset_h) upg_rst = 1;
end
//used for other modules which don't relate to UART
wire reset;
assign reset = ~(reset_h | !upg_rst);

uart_bmpg_0 uart(
    .upg_adr_o(upg_adr_o),
    .upg_clk_i(upg_clk),
    .upg_clk_o(upg_clk_o),
    .upg_dat_o(upg_dat_o),
    .upg_done_o(upg_done_o),
    .upg_rst_i(upg_rst),
    .upg_rx_i(rx),
    .upg_tx_o(tx),
    .upg_wen_o(upg_wen_o)
);

wire clk_cpu;
wire clk_vga;

clk_main clk_main(  //顶层模块分频
    .clk_out1(clk_cpu),
    .clk_out2(clk_vga),
    .clk_out3(upg_clk),
    .clk_in(fpga_clk)
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
wire memToReg; // 1 indicate read data from memory and write it into register
wire regWrite; // 1 indicate write register(R,I(lw)), otherwise it's not -->decoder  input
wire IORead; // 1 indicate read data from IO, otherwise it's not
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


wire [31:0] io_rdata1;
wire [31:0] io_rdata2;

reg [31:0] io_rdataSelected;

//MemOrIO  outputs
wire [31:0] address;// 地址 -->d_memory  inputs
wire [31:0] r_wdata_from_memIO;// data to decoder(register file) -->decoder  input
wire [31:0] writeData;//写入的data -->d_memory  inputs
wire LEDCtrl, SwitchCtrl, KeyBoardCtrl, displayCtrl;

wire [31:0] address_io;

//instruction related
wire [5:0]Opcode;
wire[5:0] Function_opcode;
wire[4:0] Shamt;

wire extend_mode;
    
assign Shamt=Instruction[10:6];
assign Opcode=Instruction[31:26]; 
assign Function_opcode=Instruction[5:0];

wire [4:0] write_reg;

wire[15:0] key_wdata;

always @(*) begin
    if (SwitchCtrl&&~KeyBoardCtrl) begin
        io_rdataSelected = io_rdata1;
    end
    else if (~SwitchCtrl&&KeyBoardCtrl) begin
        io_rdataSelected = io_rdata2;
    end
    else io_rdataSelected = 32'b0;
end


//display
display dis(fpga_clk,clk_cpu,clk_vga,IOWrite,displayCtrl,upg_rst,~reset_h,address_io,writeData,seg_en, seg_out,hsync,vsync,vga_rgb);


//Data memory
dmemory32 uram(clk_cpu,memWrite,address,writeData,readData,upg_rst,upg_clk_o,upg_wen_o&upg_adr_o[14],upg_adr_o[13:0],upg_dat_o,upg_done_o);
//The ‘clock’ is from CPU-TOP, suppose its one edge has been used at the upstream module of data memory, such as IFetch, Why Data-Memroy DO NOT use the same edge as other module ?

//Instruction Fetch
IFetc32 ifetch(Instruction, branch_base_addr, link_addr, clk_cpu, reset, Addr_Result,
 Read_data_1, branch, nbranch, jmp, jal, jr, Zero,upg_rst,upg_clk_o,upg_wen_o&(!upg_adr_o[14]),upg_adr_o[13:0],upg_dat_o,upg_done_o);

//ALU
Executs32 alu(Read_data_1,Read_data_2,Sign_extend,Opcode,Function_opcode,Shamt,branch_base_addr,ALUOp
                        ,ALUSrc,I_format,Sftmd,ALU_Result,Zero,Addr_Result);

//controller
control32 control(Opcode,Function_opcode,ALU_Result[31:10],jr,jmp,jal,branch,nbranch,regDST,memToReg,regWrite,IORead,IOWrite,memWrite,ALUSrc,I_format,Sftmd,ALUOp,extend_mode);

wire [5:0] write_regDST;
assign write_regDST = regDST ? Instruction[15:11] : Instruction[20:16];
assign write_reg = jal ? 5'b11111 : write_regDST;
wire [31:0] r_wdata;
assign r_wdata = jal ? link_addr : r_wdata_from_memIO;

//decoder
decoder32 decoder(clk_cpu, reset, jal, extend_mode, Instruction[25:21], Instruction[20:16], write_reg, Instruction[15:0], r_wdata, regWrite, Read_data_1, Read_data_2, Sign_extend);

//MemOrIO
MemOrIO mem(memToReg, memWrite, IORead, IOWrite, ALU_Result, address, readData, io_rdataSelected, r_wdata_from_memIO, 
Read_data_2, writeData, LEDCtrl, SwitchCtrl, KeyBoardCtrl, displayCtrl);

io_address_convert iac(LEDCtrl, SwitchCtrl, displayCtrl, address, address_io);

led led(clk_cpu, reset, IOWrite, LEDCtrl, address_io[1:0], writeData, led_out);

Switch switch0(clk_cpu, reset, IORead, SwitchCtrl, address_io[1:0], switch, io_rdata1);

keyboard key(clk_cpu,reset,IORead,KeyBoardCtrl,row,col,io_rdata2);


endmodule
