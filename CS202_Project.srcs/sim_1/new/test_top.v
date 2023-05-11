`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/11 21:47:29
// Design Name: 
// Module Name: test_top
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


module test_top();

reg clk = 1'b0;
reg [23:0] switch = 24'b0;
reg rst_h = 1'b0;

wire [23:0] led_out;
wire [7:0] seg_out;
wire [7:0] seg_en;
wire hsync;
wire vsync;
wire [11:0] vga_rgb;

cpu_top cpu_top(clk, switch, rst_h, led_out, seg_out, seg_en, hsync, vsync, vga_rgb);

initial begin
    forever #5 clk = ~clk;
end

initial begin
    repeat (100) #20 switch = switch + 1;
end

endmodule
