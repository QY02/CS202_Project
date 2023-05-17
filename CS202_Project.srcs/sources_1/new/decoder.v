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
    input jal,

    input extend_mode,
    input [4:0] read_reg1,
    input [4:0] read_reg2,
    input [4:0] write_reg,
    input [15:0] to_extend_data,
    input [31:0] write_data,
    input reg_write,

    output [31:0] read_data1,
    output [31:0] read_data2,
    output reg [31:0] extended_data
);

reg [31:0] registers [0:31];
assign read_data1 = registers[read_reg1];
assign read_data2 = registers[read_reg2];

integer i;

always @(*) begin
    if (extend_mode) begin
        extended_data = {16'b0000_0000_0000_0000, to_extend_data};
    end
    else begin
        if (write_reg[4] == 1'b1) begin
            extended_data = {16'b1111_1111_1111_1111, to_extend_data};
        end
        else begin
            extended_data = {16'b0000_0000_0000_0000, to_extend_data};
        end
    end
end

reg [31:0] jal_addr;
reg last_jal;
always @(negedge clk, negedge rst_n) begin
    if (~rst_n) begin
        jal_addr <= 32'b0;
        last_jal <= 1'b0;
    end
    else begin
        jal_addr <= write_data;
        last_jal <= jal;
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
            if (~last_jal) begin
                registers[write_reg] <= write_data;
            end
            else begin
                registers[write_reg] <= jal_addr;
            end
        end
    end
end

endmodule
