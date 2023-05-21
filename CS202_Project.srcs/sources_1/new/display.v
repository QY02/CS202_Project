`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/01 16:30:38
// Design Name: 
// Module Name: display_main
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


module display(
    input clk,
    input clk_cpu,
    input clk_vga,
    input IOWrite,
    input displayCtrl,
    input upg_rst,
    input rst_n,

    input addr_in,
    input [31:0] writeData,

    output [7:0] seg_en, //数码显示管使能信号
    output [7:0] seg_out0, //数码显示管显示内容

    output hsync,
    output vsync,
    output [11:0] vga_rgb
    );

// reg upg_rst_save;
reg [31:0] data;

reg sign;
reg [31:0] dataPositive;

always @(*) begin
    if (data[31] == 1'b1) begin
        sign = 1'b1;
        dataPositive = ~data + 32'b1;
    end
    else begin
        sign = 1'b0;
        dataPositive = data;
    end
end


reg [1:0] mode;
reg [4:0] message_code;

always @(negedge clk_cpu, negedge rst_n) begin
    if (~rst_n) begin
        // upg_rst_save <= 1'b0;
        mode <= 2'b01;
        data <= 31'b0;
        message_code <= 5'b0;
    end
    else begin
        if (~upg_rst) begin
            // upg_rst_save <= 1'b1;
            mode <= 2'b01;
            data <= 31'b0;
            message_code <= 5'b1;
        end
        else begin
            if (displayCtrl && IOWrite) begin
                case (addr_in)
                    1'b0: begin
                        mode <= 2'b00;
                        data <= writeData;
                        message_code <= 5'b0;
                    end
                    1'b1: begin
                        mode <= 2'b01;
                        data <= 31'b0;
                        message_code <= writeData[4:0];
                    end
                    default: begin
                        mode <= mode;
                        data <= data;
                        message_code <= message_code;
                    end
                endcase
            end
            // else if (upg_rst_save) begin
            //     upg_rst_save <= 1'b0;
            //     mode <= 2'b01;
            //     data <= 27'b0;
            //     message_code <= 5'b0;
            // end
            else begin
                mode <= mode;
                data <= data;
                message_code <= message_code;
            end
        end
    end
end




wire [63:0] digits;
convert_to_eight_digits cted(dataPositive[26:0], digits);

wire [63:0] messages;
convert_to_message ctm(message_code, messages);

reg [63:0] display_in;

always @(*) begin
    case (mode)
        2'b00:
            if (~sign) begin
                display_in = digits;
            end
            else begin
                display_in = {8'b0000_0010, digits[55:0]};
            end
        2'b01:
            display_in = messages;
        default:
            display_in = 64'b0;
    endcase
end


wire [7:0] seg_en_active_high;
wire [7:0] seg_out0_active_high;
wire [7:0] seg_out1_active_high;
seven_seg ss(clk, rst_n, display_in, seg_en_active_high, seg_out0_active_high);

assign seg_en = ~seg_en_active_high;
assign seg_out0 = ~seg_out0_active_high;

vga_main vgam(clk_vga, rst_n, display_in, hsync, vsync, vga_rgb);

endmodule
