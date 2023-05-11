`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/01 16:30:38
// Design Name: 
// Module Name: display_main
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


module display(
    input wire clk,
    input wire clk_vga,
    input wire rst_n,

    input [1:0] mode, //显示模式
    input [26:0] data,
    input [4:0] message_code, //信息代码

    output [7:0] seg_en, //数码显示管使能信号
    output [7:0] seg_out0, //数码显示管显示内容

    output hsync,
    output vsync,
    output [11:0] vga_rgb
    );

wire [63:0] digits;
convert_to_eight_digits cted(data, digits);

wire [63:0] messages;
convert_to_message ctm(message_code, messages);

reg [63:0] display_in;

always @(*) begin
    case (mode)
        2'b00:
            display_in = digits;
        2'b01:
            display_in = messages;
        default:
            display_in = 64'b0;
    endcase
end


wire [7:0] seg_en_active_high;
wire [7:0] seg_out0_active_high;
wire [7:0] seg_out1_active_high;
seven_seg ss(clk, rst_n, display_in, seg_en_active_high, seg_out0_active_high);

assign seg_en = ~seg_en_active_high;
assign seg_out0 = ~seg_out0_active_high;

vga_main vgam(clk_vga, rst_n, display_in, hsync, vsync, vga_rgb);

endmodule
