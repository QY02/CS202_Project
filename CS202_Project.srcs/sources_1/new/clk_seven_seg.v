`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/03 17:00:09
// Design Name: 
// Module Name: clk_display
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


module clk_seven_seg(input clk, rst_n, output reg clk_out);//一个给七位数码显像管的分频器
    
parameter period = 200000;
reg [17:0] cnt;

always@(posedge clk, negedge rst_n) begin
    if(~rst_n)begin//reset
        cnt <= 0;
        clk_out <= 0;
    end
    else if(cnt == ((period>>1) - 1)) begin //分频
        clk_out <= ~clk_out;
        cnt <= 0;
    end
    else begin
        cnt <= cnt + 1;
    end
end

endmodule
