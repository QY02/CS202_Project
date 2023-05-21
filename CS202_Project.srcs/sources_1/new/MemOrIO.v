`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/07 20:03:05
// Design Name: 
// Module Name: MemOrIO
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


module MemOrIO(mRead, mWrite, ioRead, ioWrite, addr_in, addr_out, m_rdata, io_rdata, r_wdata, r_rdata, write_data, LEDCtrl, SwitchCtrl,KeyBoardCtrl);

input mRead, mWrite, ioRead, ioWrite;

input [31:0] addr_in;
output [31:0] addr_out;

input [31:0] m_rdata;
input [31:0] io_rdata;
output reg [31:0] r_wdata;

input [31:0] r_rdata;
output reg [31:0] write_data;

output LEDCtrl, SwitchCtrl, KeyBoardCtrl;

assign addr_out = addr_in;

always @(*) begin
    if (mRead && (~ioRead)) begin
        r_wdata = m_rdata;
    end
    else if ((~mRead) && ioRead) begin
        r_wdata = io_rdata;
    end
    else if ((~mRead) && (~ioRead)) begin
        r_wdata = addr_in;
    end
    else begin
        r_wdata = 32'hZZZZZZZZ;
    end
end

always @(*) begin
    if (mWrite || ioWrite) begin
        write_data = r_rdata;
    end
    else begin
        write_data = 32'hZZZZZZZZ;
    end
end

assign LEDCtrl = ((addr_in >= 32'hFFFFFC60) && (addr_in <= 32'hFFFFFC62)) ? 1'b1 : 1'b0;

assign SwitchCtrl = ((addr_in >= 32'hFFFFFC70) && (addr_in <= 32'hFFFFFC72)) ? 1'b1 : 1'b0;

assign KeyBoardCtrl = (addr_in == 32'hFFFFFC80) ? 1'b1 : 1'b0;


endmodule
