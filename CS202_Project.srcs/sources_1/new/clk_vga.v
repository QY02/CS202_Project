`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/22 14:45:40
// Design Name: 
// Module Name: clk_vga
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


module clk_vga(input clk, rst_n, output reg clk_out);
    
parameter period = 2;
reg [1:0] cnt;

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
