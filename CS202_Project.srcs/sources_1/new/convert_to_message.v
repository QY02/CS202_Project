`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/05 22:40:55
// Design Name: 
// Module Name: convert_to_message
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


module convert_to_message(
    input [4:0] message_code,
    output [63:0] messages
    );

    reg [7:0] message0;
    reg [7:0] message1;
    reg [7:0] message2;
    reg [7:0] message3;
    reg [7:0] message4;
    reg [7:0] message5;
    reg [7:0] message6;
    reg [7:0] message7;

    assign messages = {message7, message6, message5, message4, message3, message2, message1, message0};

    always @(*) begin
        case (message_code)
            5'b0_0000: begin //HELLO
                message0 = 8'b0000_0000;
                message1 = 8'b0000_0000;
                message2 = 8'b1111_1100;
                message3 = 8'b0001_1100;
                message4 = 8'b0001_1100;
                message5 = 8'b1001_1110;
                message6 = 8'b0110_1110;
                message7 = 8'b0000_0000;
            end
            5'b0_0001: begin //UArt
                message0 = 8'b0000_0000;
                message1 = 8'b0000_0000;
                message2 = 8'b0001_1110;
                message3 = 8'b0000_1010;
                message4 = 8'b1110_1110;
                message5 = 8'b0111_1100;
                message6 = 8'b0000_0000;
                message7 = 8'b0000_0000;
            end
            default: begin
                message0 = 8'b0000_0000;
                message1 = 8'b0000_0000;
                message2 = 8'b0000_0000;
                message3 = 8'b0000_0000;
                message4 = 8'b0000_0000;
                message5 = 8'b0000_0000;
                message6 = 8'b0000_0000;
                message7 = 8'b0000_0000;
            end
        endcase
    end

endmodule
