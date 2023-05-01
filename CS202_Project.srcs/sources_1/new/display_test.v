`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/01 22:54:03
// Design Name: 
// Module Name: display_test
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


module display_test(
    input wire clk,
    input wire rst_n,
    input mode,
    input [21:0] data,

    output [7:0] seg_en, //数码显示管使能信号
    output [7:0] seg_out0, //数码显示管显示内容

    output hsync,
    output vsync,
    output [11:0] vga_rgb
    );


reg [4:0] message_code = 5'b00000;

display dp(clk, rst_n, {1'b0, mode}, {5'b00000, data}, message_code, seg_en, seg_out0, hsync, vsync, vga_rgb);

endmodule
