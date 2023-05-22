`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/11 17:17:54
// Design Name: 
// Module Name: led
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


module led(
    input clk, rst_n, IOWrite, LEDCtrl,
    input [1:0] addr_in,
    input [31:0] data,
    output reg [23:0] LED
    );

always @(negedge clk, negedge rst_n) begin
    if (~rst_n) begin
        LED <= 24'b0;
    end
    else begin
        if (LEDCtrl && IOWrite) begin
            case (addr_in)
                2'b00: LED[23:0] <= data[23:0];//分段处理读入的信号  FFFF FC60
                2'b01: LED[23:0] <= {data[15:0], LED[7:0]};//分段处理读入的信号  FFFF FC61
                2'b10: LED[23:0] <= {data[7:0], LED[15:0]};//分段处理读入的信号  FFFF FC62
                default: LED <= LED;
            endcase
        end
        else begin
            LED <= LED;
        end
    end
end

endmodule
