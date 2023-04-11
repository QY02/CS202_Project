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


module display(
    input clk, //时钟
    input rst_n, //重置
    input [1:0] mode, //显示模式
    input [4:0] message_code, //信息代码
    input [10:0] data, //数据，如卡内余额
    input [6:0] minute, //分钟
    input [6:0] hour, //小时
    output reg [7:0] seg_en, //数码显示管使能信号
    output reg [7:0] seg_out0, //数码显示管显示内容
    output reg [7:0] seg_out1  //数码显示管显示内容
    );
    
wire clk_out;
reg [2:0] scan_cnt;
clk_display cd(clk, rst_n, clk_out);

wire [7:0] digit0;
wire [7:0] digit1;
wire [7:0] digit2;
convert_to_digits ctd_data(data[9:0], digit0, digit1, digit2);

wire [7:0] message0;
wire [7:0] message1;
wire [7:0] message2;
wire [7:0] message3;
wire [7:0] message4;
wire [7:0] message5;
wire [7:0] message6;
wire [7:0] message7;
convert_to_message ctm(message_code, message0, message1, message2, message3, message4, message5, message6, message7);

wire [7:0] minute_digit0;
wire [7:0] minute_digit1;
wire [7:0] useless_digit_minute;
convert_to_digits ctd_minute({3'b000, minute}, minute_digit0, minute_digit1, useless_digit_minute);

wire [7:0] hour_digit0;
wire [7:0] hour_digit1;
wire [7:0] useless_digit_hour;
convert_to_digits ctd_hour({3'b000, hour}, hour_digit0, hour_digit1, useless_digit_hour);

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
                case (mode)
                    2'b00:
                        seg_out0 <= message0;
                    2'b01:
                        seg_out0 <= digit0;
                    2'b10:
                        seg_out0 <= message0;
                    2'b11:
                        seg_out0 <= minute_digit0;
                endcase
                seg_en <= 8'h01;
            end
            3'b001: begin
                case (mode)
                    2'b00:
                        seg_out0 <= message1;
                    2'b01:
                        seg_out0 <= digit1;
                    2'b10:
                        seg_out0 <= message1;
                    2'b11:
                        seg_out0 <= minute_digit1;
                endcase
                seg_en <= 8'h02;
            end
            3'b010: begin
                case (mode)
                    2'b00:
                        seg_out0 <= message2;
                    2'b01:
                        seg_out0 <= digit2;
                    2'b10:
                        seg_out0 <= message2;
                    2'b11:
                        seg_out0 <= 8'b0000_0010;
                endcase
                seg_en <= 8'h04;
            end
            3'b011: begin
                case (mode)
                    2'b00:
                        seg_out0 <= message3;
                    2'b01:
                        seg_out0 <= {6'b00_0000, data[10], 1'b0};
                    2'b10:
                        seg_out0 <= message3;
                    2'b11:
                        seg_out0 <= hour_digit0;
                endcase
                seg_en <= 8'h08;
            end
            3'b100: begin
                case (mode)
                    2'b00:
                        seg_out1 <= message4;
                    2'b01:
                        seg_out1 <= 8'b0000_0000;
                    2'b10:
                        seg_out1 <= digit0;
                    2'b11:
                        seg_out1 <= hour_digit1;
                endcase
                seg_en <= 8'h10;
            end
            3'b101: begin
                case (mode)
                    2'b00:
                        seg_out1 <= message5;
                    2'b01:
                        seg_out1 <= 8'b0000_0000;
                    2'b10:
                        seg_out1 <= digit1;
                    2'b11:
                        seg_out1 <= message5;
                endcase
                seg_en <= 8'h20;
            end
            3'b110: begin
                case (mode)
                    2'b00:
                        seg_out1 <= message6;
                    2'b01:
                        seg_out1 <= 8'b0000_0000;
                    2'b10:
                        seg_out1 <= digit2;
                    2'b11:
                        seg_out1 <= message6;
                endcase
                seg_en <= 8'h40;
            end
            3'b111: begin
                case (mode)
                    2'b00:
                        seg_out1 <= message7;
                    2'b01:
                        seg_out1 <= 8'b0000_0000;
                    2'b10:
                        seg_out1 <= {6'b00_0000, data[10], 1'b0};
                    2'b11:
                        seg_out1 <= message7;
                endcase
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
