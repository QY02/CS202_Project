`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/11 17:37:27
// Design Name: 
// Module Name: io_address_convert
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


module io_address_convert(//把实际的地址转换成IO的地址
    input LEDCtrl, SwitchCtrl, displayCtrl,
    input [31:0] addr_in,
    output reg [31:0] addr_out
    );

always @(*) begin
    if (LEDCtrl) begin
        addr_out = addr_in - 32'hFFFFFC60;//00 01 10
    end
    else if (SwitchCtrl) begin
        addr_out = addr_in - 32'hFFFFFC70;
    end
    else if (displayCtrl) begin
        addr_out = addr_in - 32'hFFFFFC90;
    end
    else begin
        addr_out = 32'b0;
    end
end


endmodule
