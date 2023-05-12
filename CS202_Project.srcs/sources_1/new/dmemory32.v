`timescale 1ns / 1ps


module dmemory32(clock,memWrite,address,writeData,readData,upg_rst_i,upg_clk_i,upg_wen_i,upg_adr_i,upg_dat_i,upg_done_i );

    input clock, memWrite;  //memWrite 来自controller，为1'b1时表示要对data-memory做写操作

    input [31:0] address;   //address 以字节为单位

    input [31:0] writeData; //writeData ：向data-memory中写入的数据

    output[31:0] readData;  //writeData ：从data-memory中读出的数据

    // UART Programmer Pinouts
    input upg_rst_i; // UPG reset (Active High)
    input upg_clk_i; // UPG ram_clk_i (10MHz)
    input upg_wen_i; // UPG write enable
    input [13:0] upg_adr_i; // UPG write address
    input [31:0] upg_dat_i; // UPG write data
    input upg_done_i; // 1 if programming is finished

    /* CPU work on normal mode when kickOff is 1. CPU work on Uart communicate mode when kickOff is 0.*/
    wire kickOff = upg_rst_i | (~upg_rst_i & upg_done_i);

    wire clk;
    assign clk= !clock;
    RAM ram (
    .clka(kickOff?clk:upg_clk_i), // input wire clka
    .wea(kickOff?memWrite:upg_wen_i), // input wire [0 : 0] wea
    .addra(kickOff?address[15:2]:upg_adr_i), // input wire [13 : 0] addra
    .dina(kickOff?writeData:upg_dat_i), // input wire [31 : 0] dina
    .douta(readData) // output wire [31 : 0] douta
    );
   
endmodule
