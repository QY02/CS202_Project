`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/20 23:39:03
// Design Name: 
// Module Name: vga_picture
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


module vga_main(
    input wire clk,
    input wire rst_n,
    input wire [63:0] data,

    output wire hsync,
    output wire vsync,
    output wire [11:0] vga_rgb
);


wire clk_out;
clk_vga cv(.clk_out(clk_out), .resetn(rst_n), .clk_in(clk));

wire [10:0] pix_x;
wire [10:0] pix_y;
wire is_valid;

vga_ctrl vc(
    clk_out, rst_n,
    pix_x, pix_y, hsync, vsync, is_valid
);

wire [11:0] pix_data;
vga_pic vp(
    clk_out, rst_n, pix_x, pix_y, data,
    pix_data
);

assign vga_rgb = (is_valid == 1'b1) ? pix_data : 12'h000;

endmodule