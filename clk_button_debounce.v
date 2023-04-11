`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/09 11:04:40
// Design Name: 
// Module Name: clk_button_debounce
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


module clk_button_debounce(input clk, rst_n, output reg clk_out);
    
parameter period = 100000;
reg [16:0] cnt;

always@(posedge clk, negedge rst_n) begin
    if(~rst_n)begin
        cnt <= 0;
        clk_out <= 0;
    end
    else if(cnt == ((period>>1) - 1)) begin
        clk_out <= ~clk_out;
        cnt <= 0;
    end
    else begin
        cnt <= cnt + 1;
    end
end

endmodule
