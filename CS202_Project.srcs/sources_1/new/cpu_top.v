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
wire memWrite;// d_memory使能信号
wire [31:0] address;// 地址
wire [31:0] writeData;//写入的data
//d_memory  outputs
wire[31:0] readData; //读出来的data


//IF  inputs

//IF  outputs
wire [31:0] Instruction; //读出的指令
wire [31:0] branch_base_addr;



//Data memory
dmemory32 uram(clock,memWrite,address,writeData,readData);
/*The ‘clock’ is from CPU-TOP, suppose its one edge has been used at the upstream module of data memory, such as IFetch, Why Data-Memroy DO NOT use the same edge as other module ? */
assign clk = !clock;


//Instruction Fetch
IFetc32 ifetch(Instruction, branch_base_addr, link_addr, clock, reset, Addr_result,
 Read_data_1, Branch, nBranch, Jmp, Jal, Jr, Zero);


endmodule