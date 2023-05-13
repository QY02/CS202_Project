`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/13 16:31:58
// Design Name: 
// Module Name: button_FSA
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


module button_FSA(
    input clk,
    input rst_n,
    input button,
    output reg uart_en
    );

reg count;

always @(posedge clk, negedge rst_n) begin
    if (~rst_n) begin
        uart_en <= 1'b0;
        count <= 1'b0;
    end
    else begin
        if (button == 1'b1) begin
            if (count == 1'b0) begin
                uart_en <= ~uart_en;
                count <= 1'b1;
            end
            else begin
                uart_en <= uart_en;
                count <= count;
            end
        end
        else begin
            uart_en <= uart_en;
            count <= 1'b0;
        end
    end
end

endmodule
