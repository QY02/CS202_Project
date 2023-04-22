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
    output reg [7:0] message0,
    output reg [7:0] message1,
    output reg [7:0] message2,
    output reg [7:0] message3,
    output reg [7:0] message4,
    output reg [7:0] message5,
    output reg [7:0] message6,
    output reg [7:0] message7
    );

    always @(*) begin
        case (message_code)
            5'b0_0000: begin
                message0 = 8'b0000_0000;
                message1 = 8'b0000_0000;
                message2 = 8'b1111_1100;
                message3 = 8'b0001_1100;
                message4 = 8'b0001_1100;
                message5 = 8'b1001_1110;
                message6 = 8'b0110_1110;
                message7 = 8'b0000_0000;
            end
            5'b0_0001: begin
                message0 = 8'b0000_0000;
                message1 = 8'b0001_1010;
                message2 = 8'b0001_1100;
                message3 = 8'b0011_1110;
                message4 = 8'b0000_0000;
                message5 = 8'b0011_1010;
                message6 = 8'b0010_1010;
                message7 = 8'b0000_0000;
            end
            5'b0_0010: begin
                message0 = 8'b0000_0000;
                message1 = 8'b0000_0000;
                message2 = 8'b0000_0000;
                message3 = 8'b0000_0000;
                message4 = 8'b1100_1110;
                message5 = 8'b1011_0110;
                message6 = 8'b0000_0000;
                message7 = 8'b0000_0000;
            end
            5'b0_0011: begin
                message0 = 8'b0000_0000;
                message1 = 8'b0000_0000;
                message2 = 8'b0000_0000;
                message3 = 8'b0111_1010;
                message4 = 8'b0001_1110;
                message5 = 8'b1011_0110;
                message6 = 8'b0000_0000;
                message7 = 8'b0000_0000;
            end
            5'b0_0100: begin
                message0 = 8'b0000_0000;
                message1 = 8'b0000_0000;
                message2 = 8'b0000_0000;
                message3 = 8'b0000_0000;
                message4 = 8'b1100_1110;
                message5 = 8'b0001_1100;
                message6 = 8'b0000_0000;
                message7 = 8'b0000_0000;
            end
            5'b0_0101: begin
                message0 = 8'b0000_0000;
                message1 = 8'b0000_0000;
                message2 = 8'b0000_0000;
                message3 = 8'b0000_0000;
                message4 = 8'b0111_1010;
                message5 = 8'b1011_0110;
                message6 = 8'b0000_0000;
                message7 = 8'b0000_0000;
            end
            5'b0_0110: begin
                message0 = 8'b0111_1010;
                message1 = 8'b0001_1100;
                message2 = 8'b1011_0110;
                message3 = 8'b0000_0000;
                message4 = 8'b0010_1010;
                message5 = 8'b1001_1110;
                message6 = 8'b1100_1110;
                message7 = 8'b1111_1100;
            end
            5'b0_0111: begin
                message0 = 8'b0001_1110;
                message1 = 8'b0000_1010;
                message2 = 8'b1110_1110;
                message3 = 8'b0001_1110;
                message4 = 8'b1011_0110;
                message5 = 8'b1011_0110;
                message6 = 8'b0000_1010;
                message7 = 8'b1100_1110;
            end

            5'b0_1000: begin
                message0 = 8'b0000_0000;
                message1 = 8'b1100_1110;
                message2 = 8'b1011_0110;
                message3 = 8'b0000_0000;
                message4 = 8'b0000_0000;
                message5 = 8'b0000_0000;
                message6 = 8'b0000_0000;
                message7 = 8'b0000_0000;
            end
            5'b0_1001: begin
                message0 = 8'b0111_1010;
                message1 = 8'b0001_1110;
                message2 = 8'b1011_0110;
                message3 = 8'b0000_0000;
                message4 = 8'b0000_0000;
                message5 = 8'b0000_0000;
                message6 = 8'b0000_0000;
                message7 = 8'b0000_0000;
            end
            5'b0_1010: begin
                message0 = 8'b0000_0000;
                message1 = 8'b1100_1110;
                message2 = 8'b0001_1100;
                message3 = 8'b0000_0000;
                message4 = 8'b0000_0000;
                message5 = 8'b0000_0000;
                message6 = 8'b0000_0000;
                message7 = 8'b0000_0000;
            end
            5'b0_1011: begin //yUAn
                message0 = 8'b1110_1100;
                message1 = 8'b1110_1110;
                message2 = 8'b0111_1100;
                message3 = 8'b0111_0110;
                message4 = 8'b0000_0000;
                message5 = 8'b0000_0000;
                message6 = 8'b0000_0000;
                message7 = 8'b0000_0000;
            end
            5'b0_1100: begin //EpS
                message0 = 8'b1011_0110;
                message1 = 8'b1100_1110;
                message2 = 8'b1001_1110;
                message3 = 8'b0000_0000;
                message4 = 8'b0000_0000;
                message5 = 8'b0000_0000;
                message6 = 8'b0000_0000;
                message7 = 8'b0000_0000;
            end
            5'b0_1101: begin //bLc
                message0 = 8'b0001_1010;
                message1 = 8'b0001_1100;
                message2 = 8'b0011_1110;
                message3 = 8'b0000_0000;
                message4 = 8'b0000_0000;
                message5 = 8'b0000_0000;
                message6 = 8'b0000_0000;
                message7 = 8'b0000_0000;
            end
            5'b0_1110: begin //t o cLS
                message0 = 8'b1011_0110;
                message1 = 8'b0001_1100;
                message2 = 8'b0001_1010;
                message3 = 8'b0000_0000;
                message4 = 8'b0011_1010;
                message5 = 8'b0000_0000;
                message6 = 8'b0001_1110;
                message7 = 8'b0000_0000;
            end
            5'b0_1111: begin //SLd OPEn
                message0 = 8'b0010_1010;
                message1 = 8'b1001_1110;
                message2 = 8'b1100_1110;
                message3 = 8'b1111_1100;
                message4 = 8'b0000_0000;
                message5 = 8'b0111_1010;
                message6 = 8'b0001_1100;
                message7 = 8'b1011_0110;
            end
            5'b1_0000: begin //End
                message0 = 8'b0000_0000;
                message1 = 8'b0000_0000;
                message2 = 8'b0000_0000;
                message3 = 8'b0000_0000;
                message4 = 8'b0000_0000;
                message5 = 8'b0111_1010;
                message6 = 8'b0010_1010;
                message7 = 8'b1001_1110;
            end
            5'b1_0001: begin //Adn
                message0 = 8'b0000_0000;
                message1 = 8'b0000_0000;
                message2 = 8'b0010_1010;
                message3 = 8'b0111_1010;
                message4 = 8'b1110_1110;
                message5 = 8'b0000_0000;
                message6 = 8'b0000_0000;
                message7 = 8'b0000_0000;
            end
            5'b1_0010: begin //Stc
                message0 = 8'b0000_0000;
                message1 = 8'b0000_0000;
                message2 = 8'b0001_1010;
                message3 = 8'b0001_1110;
                message4 = 8'b1011_0110;
                message5 = 8'b0000_0000;
                message6 = 8'b0000_0000;
                message7 = 8'b0000_0000;
            end
            5'b1_0011: begin //Cst
                message0 = 8'b0000_0000;
                message1 = 8'b0000_0000;
                message2 = 8'b0001_1110;
                message3 = 8'b1011_0110;
                message4 = 8'b1001_1100;
                message5 = 8'b0000_0000;
                message6 = 8'b0000_0000;
                message7 = 8'b0000_0000;
            end
            5'b1_0100: begin //rst
                message0 = 8'b0000_0000;
                message1 = 8'b0000_0000;
                message2 = 8'b0001_1110;
                message3 = 8'b1011_0110;
                message4 = 8'b0000_1010;
                message5 = 8'b0000_0000;
                message6 = 8'b0000_0000;
                message7 = 8'b0000_0000;
            end
            5'b1_0101: begin //C
                message0 = 8'b0000_0000;
                message1 = 8'b0000_0000;
                message2 = 8'b0000_0000;
                message3 = 8'b1001_1100;
                message4 = 8'b0000_0000;
                message5 = 8'b0000_0000;
                message6 = 8'b0000_0000;
                message7 = 8'b0000_0000;
            end
            5'b1_0110: begin //t1
                message0 = 8'b0000_0000;
                message1 = 8'b0000_0000;
                message2 = 8'b0000_0000;
                message3 = 8'b0110_0000;
                message4 = 8'b0001_1110;
                message5 = 8'b0000_0000;
                message6 = 8'b0000_0000;
                message7 = 8'b0000_0000;
            end
            5'b1_0111: begin //t2
                message0 = 8'b0000_0000;
                message1 = 8'b0000_0000;
                message2 = 8'b0000_0000;
                message3 = 8'b1101_1010;
                message4 = 8'b0001_1110;
                message5 = 8'b0000_0000;
                message6 = 8'b0000_0000;
                message7 = 8'b0000_0000;
            end
            5'b1_1000: begin //SucS
                message0 = 8'b0000_0000;
                message1 = 8'b0000_0000;
                message2 = 8'b1011_0110;
                message3 = 8'b0001_1010;
                message4 = 8'b0011_1000;
                message5 = 8'b1011_0110;
                message6 = 8'b0000_0000;
                message7 = 8'b0000_0000;
            end
            5'b1_1001: begin //ALL
                message0 = 8'b0000_0000;
                message1 = 8'b0000_0000;
                message2 = 8'b0001_1100;
                message3 = 8'b0001_1100;
                message4 = 8'b1110_1110;
                message5 = 8'b0000_0000;
                message6 = 8'b0000_0000;
                message7 = 8'b0000_0000;
            end
            5'b1_1010: begin //dEt
                message0 = 8'b0000_0000;
                message1 = 8'b0001_1110;
                message2 = 8'b1001_1110;
                message3 = 8'b0111_1010;
                message4 = 8'b0000_0000;
                message5 = 8'b0010_1110;
                message6 = 8'b0001_1010;
                message7 = 8'b0000_0000;
            end
            5'b1_1011: begin //dbg
                message0 = 8'b0000_0000;
                message1 = 8'b0000_0000;
                message2 = 8'b1111_0110;
                message3 = 8'b0011_1110;
                message4 = 8'b0111_1010;
                message5 = 8'b0000_0000;
                message6 = 8'b0000_0000;
                message7 = 8'b0000_0000;
            end
            5'b1_1100: begin //AL
                message0 = 8'b0000_0000;
                message1 = 8'b0000_0000;
                message2 = 8'b0000_0000;
                message3 = 8'b0000_0000;
                message4 = 8'b0000_0000;
                message5 = 8'b0000_0000;
                message6 = 8'b0001_1100;
                message7 = 8'b1110_1110;
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
