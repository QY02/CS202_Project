`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/03 17:39:52
// Design Name: 
// Module Name: convert_to_digits
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

module convert_to_eight_digits(//将27位二进制数字转换成8位十进制数字，便于显像管使用
    input [26:0] data,
    output [63:0] digits
    );

reg [58:0] temp;
reg [31:0] bcd_code;
wire [7:0] digit0;
wire [7:0] digit1;
wire [7:0] digit2;
wire [7:0] digit3;
wire [7:0] digit4;
wire [7:0] digit5;
wire [7:0] digit6;
wire [7:0] digit7;
code_to_digit to_digit0({2'b00, bcd_code[3:0]}, digit0);
code_to_digit to_digit1({2'b00, bcd_code[7:4]}, digit1);
code_to_digit to_digit2({2'b00, bcd_code[11:8]}, digit2);
code_to_digit to_digit3({2'b00, bcd_code[15:12]}, digit3);
code_to_digit to_digit4({2'b00, bcd_code[19:16]}, digit4);
code_to_digit to_digit5({2'b00, bcd_code[23:20]}, digit5);
code_to_digit to_digit6({2'b00, bcd_code[27:24]}, digit6);
code_to_digit to_digit7({2'b00, bcd_code[31:28]}, digit7);
integer i;

assign digits = {digit7, digit6, digit5, digit4, digit3, digit2, digit1, digit0};

always @(*) begin
    temp = {32'b0000_0000_0000_0000_0000_0000_0000_0000, data};
    for(i = 0; i < 26; i = i + 1) begin
        temp = temp << 1'b1;
        if(temp[30:27] > 4'd4)
            temp[30:27] = temp[30:27] + 4'd3;
        else
            temp[30:27] = temp[30:27];
        if(temp[34:31] > 4'd4)
            temp[34:31] = temp[34:31] + 4'd3;
        else
            temp[34:31] = temp[34:31];
        if(temp[38:35] > 4'd4)
            temp[38:35] = temp[38:35] + 4'd3;
        else
            temp[38:35] = temp[38:35];
        if(temp[42:39] > 4'd4)
            temp[42:39] = temp[42:39] + 4'd3;
        else
            temp[42:39] = temp[42:39];
        if(temp[46:43] > 4'd4)
            temp[46:43] = temp[46:43] + 4'd3;
        else
            temp[46:43] = temp[46:43];
        if(temp[50:47] > 4'd4)
            temp[50:47] = temp[50:47] + 4'd3;
        else
            temp[50:47] = temp[50:47];
        if(temp[54:51] > 4'd4)
            temp[54:51] = temp[54:51] + 4'd3;
        else
            temp[54:51] = temp[54:51];
        if(temp[58:55] > 4'd4)
            temp[58:55] = temp[58:55] + 4'd3;
        else
            temp[58:55] = temp[58:55];
    end
    temp = temp << 1'b1;
    bcd_code = temp[58:27];
end

endmodule
