`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/03 17:12:21
// Design Name: 
// Module Name: seven_seg
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


module code_to_digit(//显像管根据 data[5:0] 匹配显示模式
    input [5:0] data,
    output reg [7:0] seg_out
    );
    
always @(*) begin
    case(data)
        6'd0: seg_out = 8'b1111_1100; //0
        6'd1: seg_out = 8'b0110_0000; //1
        6'd2: seg_out = 8'b1101_1010; //2
        6'd3: seg_out = 8'b1111_0010; //3
        6'd4: seg_out = 8'b0110_0110; //4
        6'd5: seg_out = 8'b1011_0110; //5
        6'd6: seg_out = 8'b1011_1110; //6
        6'd7: seg_out = 8'b1110_0000; //7
        6'd8: seg_out = 8'b1111_1110; //8
        6'd9: seg_out = 8'b1111_0110; //9
        6'd10: seg_out = 8'b1110_1110; //A
        6'd11: seg_out = 8'b0011_1110; //b
        6'd12: seg_out = 8'b1001_1100; //C
        6'd13: seg_out = 8'b0001_1010; //c
        6'd14: seg_out = 8'b0111_1010; //d
        6'd15: seg_out = 8'b1001_1110; //E
        6'd16: seg_out = 8'b1000_1110; //F
        6'd17: seg_out = 8'b0110_1110; //H
        6'd18: seg_out = 8'b0010_1110; //h
        6'd19: seg_out = 8'b0111_0000; //J
        6'd20: seg_out = 8'b0001_1100; //L
        6'd21: seg_out = 8'b0010_1010; //n
        6'd22: seg_out = 8'b0011_1010; //o
        6'd23: seg_out = 8'b1100_1110; //P
        6'd24: seg_out = 8'b0000_1010; //r
        6'd25: seg_out = 8'b1011_0110; //S
        6'd26: seg_out = 8'b0001_1110; //t
        6'd28: seg_out = 8'b0111_1100; //U
        6'd29: seg_out = 8'b0011_1000; //u
        6'd30: seg_out = 8'b0111_0110; //y
        6'd63: seg_out = 8'b0000_0000; //null
        default: seg_out = 8'b0000_0000; //.
    endcase    
end

endmodule
