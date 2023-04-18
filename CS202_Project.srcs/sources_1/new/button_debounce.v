`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/09 11:04:40
// Design Name: 
// Module Name: button_debounce
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

module button_debounce(
    input clk, //时钟
    input rst_n, //重置
    input button_in, //输入按钮信号
    output reg button_out //输出防抖后的按钮信号
    );

parameter delay = 20;
wire clk_out;
reg [4:0] cnt;
clk_button_debounce cbd(clk, rst_n, clk_out);

always @(posedge clk_out, negedge rst_n) begin
    if (!rst_n) begin
        button_out <= 1'b0;
        cnt <= 5'b0;
    end
    else begin
        if ((button_in == 1'b1) && (button_out == 1'b0)) begin
            if (cnt == delay) begin
                button_out <= 1'b1;
                cnt <= 1'b0;
            end
            else
                cnt <= cnt + 1'b1;
        end
        else if ((button_in == 1'b0) && (button_out == 1'b1)) begin
            if (cnt == delay) begin
                button_out <= 1'b0;
                cnt <= 1'b0;
            end
            else
                cnt <= cnt + 1'b1;
        end
        else
            cnt <= 1'b0;
    end
end

endmodule
