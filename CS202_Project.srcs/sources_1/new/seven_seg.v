`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/03 17:03:27
// Design Name: 
// Module Name: display
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


module seven_seg(
    input clk, //时钟
    input rst_n, //重置
    input [63:0] display_in, //待显示的八位字符
    output reg [7:0] seg_en, //数码显示管使能信号
    output reg [7:0] seg_out0, //数码显示管显示内容
    output reg [7:0] seg_out1  //数码显示管显示内容
    );
    
wire clk_out;
reg [2:0] scan_cnt;
clk_seven_seg css(clk, rst_n, clk_out);

always@(posedge clk_out, negedge rst_n) begin
    if (!rst_n) begin
        seg_en <= 8'b0;
        seg_out0 <= 8'b0;
        seg_out1 <= 8'b0;
        scan_cnt <= 3'b000;
    end
    else begin
        case (scan_cnt)
            3'b000: begin
                seg_out0 <= display_in[7:0];
                seg_en <= 8'h01;
            end
            3'b001: begin
                seg_out0 <= display_in[15:8];
                seg_en <= 8'h02;
            end
            3'b010: begin
                seg_out0 <= display_in[23:16];
                seg_en <= 8'h04;
            end
            3'b011: begin
                seg_out0 <= display_in[31:24];
                seg_en <= 8'h08;
            end
            3'b100: begin
                seg_out1 <= display_in[39:32];
                seg_en <= 8'h10;
            end
            3'b101: begin
                seg_out1 <= display_in[47:40];
                seg_en <= 8'h20;
            end
            3'b110: begin
                seg_out1 <= display_in[55:48];
                seg_en <= 8'h40;
            end
            3'b111: begin
                seg_out1 <= display_in[63:56];
                seg_en <= 8'h80;
            end
        endcase

        if(scan_cnt == 3'b111)
            scan_cnt <= 3'b000;
        else
            scan_cnt <= scan_cnt + 1;
    end
end

endmodule
