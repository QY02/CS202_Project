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

module convert_to_digits(
    input [9:0] data,
    output [7:0] digit0,
    output [7:0] digit1,
    output [7:0] digit2
    );

reg [21:0] temp;
reg [11:0] bcd_code;
code_to_digit to_digit0({2'b00, bcd_code[3:0]}, digit0);
code_to_digit to_digit1({2'b00, bcd_code[7:4]}, digit1);
code_to_digit to_digit2({2'b00, bcd_code[11:8]}, digit2);
integer i;

always @(*) begin
    temp = {12'b0000_0000_0000, data};
    for(i = 0; i < 9; i = i + 1) begin
        temp = temp << 1'b1;
        if(temp[13:10] > 4'd4)
            temp[13:10] = temp[13:10] + 4'd3;
        else
            temp[13:10] = temp[13:10];
        if(temp[17:14] > 4'd4)
            temp[17:14] = temp[17:14] + 4'd3;
        else
            temp[17:14] = temp[17:14];
        if(temp[21:18] > 4'd4)
            temp[21:18] = temp[21:18] + 4'd3;
        else
            temp[21:18] = temp[21:18];
    end
    temp = temp << 1'b1;
    bcd_code = temp[21:10];
end

endmodule
