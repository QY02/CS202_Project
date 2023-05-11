`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/07 23:25:07
// Design Name: 
// Module Name: decoder
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


module decoder32(
    input clk,
    input rst_n,

    input [4:0] read_reg1,
    input [4:0] read_reg2,
    input [4:0] write_reg,
    input [10:0] to_extend_data_low11,
    input [31:0] write_data,
    input reg_write,

    output [31:0] read_data1,
    output [31:0] read_data2,
    output reg [31:0] sign_extend
);

reg [31:0] registers [0:31];
assign read_data1 = registers[read_reg1];
assign read_data2 = registers[read_reg2];

integer i;

always @(*) begin
    if (write_reg[4] == 1'b1) begin
        sign_extend = {16'b1111_1111_1111_1111, write_reg, to_extend_data_low11};
    end
    else begin
        sign_extend = {16'b0000_0000_0000_0000, write_reg, to_extend_data_low11};
    end
end

always @(posedge clk, negedge rst_n) begin
    if (~rst_n) begin
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] <= 32'b0;
        end
    end
    else begin
        if (reg_write) begin
            registers[write_reg] <= write_data;
        end
    end
end

endmodule
