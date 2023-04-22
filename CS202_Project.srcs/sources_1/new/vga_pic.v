`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/20 23:42:36
// Design Name: 
// Module Name: vga_pic
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


module vga_pic(
    input wire clk,
    input wire rst_n,
    input wire [10:0] pix_x,
    input wire [10:0] pix_y,
    input wire [63:0] data,

    output reg [11:0] pix_data
);

parameter H_VALID = 11'd800,
          V_VALID = 11'd600;

parameter   RED     = 12'hF00,
            ORANGE  = 12'hFC0,
            YELLOW  = 12'hFFE,
            GREEN   = 12'h0F0,
            CYAN    = 12'h07F,
            BLUE    = 12'h00F,
            PURPPLE = 12'hF81,
            BLACK   = 12'h000,
            WHITE   = 12'hFFF,
            GRAY    = 12'hD69;

always@ (posedge clk or negedge rst_n) begin
    if (rst_n == 1'b0) begin
        pix_data <= BLACK;
    end
    else if ((pix_x >= 11'd40) && (pix_x < 11'd120) && (pix_y >= 11'd200) && (pix_y < 11'd216) && (data[63] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd104) && (pix_x < 11'd120) && (pix_y >= 11'd200) && (pix_y < 11'd280) && (data[62] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd104) && (pix_x < 11'd120) && (pix_y >= 11'd280) && (pix_y < 11'd360) && (data[61] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd40) && (pix_x < 11'd120) && (pix_y >= 11'd344) && (pix_y < 11'd360) && (data[60] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd40) && (pix_x < 11'd56) && (pix_y >= 11'd280) && (pix_y < 11'd360) && (data[59] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd40) && (pix_x < 11'd56) && (pix_y >= 11'd200) && (pix_y < 11'd280) && (data[58] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd40) && (pix_x < 11'd120) && (pix_y >= 11'd272) && (pix_y < 11'd288) && (data[57] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd121) && (pix_x < 11'd129) && (pix_y >= 11'd352) && (pix_y < 11'd360) && (data[56] == 1'b1)) begin
        pix_data <= RED;
    end

    else if ((pix_x >= 11'd130) && (pix_x < 11'd210) && (pix_y >= 11'd200) && (pix_y < 11'd216) && (data[55] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd194) && (pix_x < 11'd210) && (pix_y >= 11'd200) && (pix_y < 11'd280) && (data[54] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd194) && (pix_x < 11'd210) && (pix_y >= 11'd280) && (pix_y < 11'd360) && (data[53] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd130) && (pix_x < 11'd210) && (pix_y >= 11'd344) && (pix_y < 11'd360) && (data[52] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd130) && (pix_x < 11'd146) && (pix_y >= 11'd280) && (pix_y < 11'd360) && (data[51] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd130) && (pix_x < 11'd146) && (pix_y >= 11'd200) && (pix_y < 11'd280) && (data[50] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd130) && (pix_x < 11'd210) && (pix_y >= 11'd272) && (pix_y < 11'd288) && (data[49] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd211) && (pix_x < 11'd219) && (pix_y >= 11'd352) && (pix_y < 11'd360) && (data[48] == 1'b1)) begin
        pix_data <= RED;
    end

    else if ((pix_x >= 11'd220) && (pix_x < 11'd300) && (pix_y >= 11'd200) && (pix_y < 11'd216) && (data[47] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd284) && (pix_x < 11'd300) && (pix_y >= 11'd200) && (pix_y < 11'd280) && (data[46] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd284) && (pix_x < 11'd300) && (pix_y >= 11'd280) && (pix_y < 11'd360) && (data[45] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd220) && (pix_x < 11'd300) && (pix_y >= 11'd344) && (pix_y < 11'd360) && (data[44] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd220) && (pix_x < 11'd236) && (pix_y >= 11'd280) && (pix_y < 11'd360) && (data[43] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd220) && (pix_x < 11'd236) && (pix_y >= 11'd200) && (pix_y < 11'd280) && (data[42] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd220) && (pix_x < 11'd300) && (pix_y >= 11'd272) && (pix_y < 11'd288) && (data[41] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd301) && (pix_x < 11'd309) && (pix_y >= 11'd352) && (pix_y < 11'd360) && (data[40] == 1'b1)) begin
        pix_data <= RED;
    end

    else if ((pix_x >= 11'd310) && (pix_x < 11'd390) && (pix_y >= 11'd200) && (pix_y < 11'd216) && (data[39] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd374) && (pix_x < 11'd390) && (pix_y >= 11'd200) && (pix_y < 11'd280) && (data[38] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd374) && (pix_x < 11'd390) && (pix_y >= 11'd280) && (pix_y < 11'd360) && (data[37] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd310) && (pix_x < 11'd390) && (pix_y >= 11'd344) && (pix_y < 11'd360) && (data[36] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd310) && (pix_x < 11'd326) && (pix_y >= 11'd280) && (pix_y < 11'd360) && (data[35] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd310) && (pix_x < 11'd326) && (pix_y >= 11'd200) && (pix_y < 11'd280) && (data[34] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd310) && (pix_x < 11'd390) && (pix_y >= 11'd272) && (pix_y < 11'd288) && (data[33] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd391) && (pix_x < 11'd399) && (pix_y >= 11'd352) && (pix_y < 11'd360) && (data[32] == 1'b1)) begin
        pix_data <= RED;
    end

    else if ((pix_x >= 11'd400) && (pix_x < 11'd480) && (pix_y >= 11'd200) && (pix_y < 11'd216) && (data[31] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd464) && (pix_x < 11'd480) && (pix_y >= 11'd200) && (pix_y < 11'd280) && (data[30] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd464) && (pix_x < 11'd480) && (pix_y >= 11'd280) && (pix_y < 11'd360) && (data[29] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd400) && (pix_x < 11'd480) && (pix_y >= 11'd344) && (pix_y < 11'd360) && (data[28] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd400) && (pix_x < 11'd416) && (pix_y >= 11'd280) && (pix_y < 11'd360) && (data[27] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd400) && (pix_x < 11'd416) && (pix_y >= 11'd200) && (pix_y < 11'd280) && (data[26] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd400) && (pix_x < 11'd480) && (pix_y >= 11'd272) && (pix_y < 11'd288) && (data[25] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd481) && (pix_x < 11'd489) && (pix_y >= 11'd352) && (pix_y < 11'd360) && (data[24] == 1'b1)) begin
        pix_data <= RED;
    end

    else if ((pix_x >= 11'd490) && (pix_x < 11'd570) && (pix_y >= 11'd200) && (pix_y < 11'd216) && (data[23] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd554) && (pix_x < 11'd570) && (pix_y >= 11'd200) && (pix_y < 11'd280) && (data[22] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd554) && (pix_x < 11'd570) && (pix_y >= 11'd280) && (pix_y < 11'd360) && (data[21] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd490) && (pix_x < 11'd570) && (pix_y >= 11'd344) && (pix_y < 11'd360) && (data[20] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd490) && (pix_x < 11'd506) && (pix_y >= 11'd280) && (pix_y < 11'd360) && (data[19] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd490) && (pix_x < 11'd506) && (pix_y >= 11'd200) && (pix_y < 11'd280) && (data[18] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd490) && (pix_x < 11'd570) && (pix_y >= 11'd272) && (pix_y < 11'd288) && (data[17] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd571) && (pix_x < 11'd579) && (pix_y >= 11'd352) && (pix_y < 11'd360) && (data[16] == 1'b1)) begin
        pix_data <= RED;
    end

    else if ((pix_x >= 11'd580) && (pix_x < 11'd660) && (pix_y >= 11'd200) && (pix_y < 11'd216) && (data[15] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd644) && (pix_x < 11'd660) && (pix_y >= 11'd200) && (pix_y < 11'd280) && (data[14] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd644) && (pix_x < 11'd660) && (pix_y >= 11'd280) && (pix_y < 11'd360) && (data[13] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd580) && (pix_x < 11'd660) && (pix_y >= 11'd344) && (pix_y < 11'd360) && (data[12] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd580) && (pix_x < 11'd596) && (pix_y >= 11'd280) && (pix_y < 11'd360) && (data[11] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd580) && (pix_x < 11'd596) && (pix_y >= 11'd200) && (pix_y < 11'd280) && (data[10] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd580) && (pix_x < 11'd660) && (pix_y >= 11'd272) && (pix_y < 11'd288) && (data[9] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd661) && (pix_x < 11'd669) && (pix_y >= 11'd352) && (pix_y < 11'd360) && (data[8] == 1'b1)) begin
        pix_data <= RED;
    end

    else if ((pix_x >= 11'd670) && (pix_x < 11'd750) && (pix_y >= 11'd200) && (pix_y < 11'd216) && (data[7] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd734) && (pix_x < 11'd750) && (pix_y >= 11'd200) && (pix_y < 11'd280) && (data[6] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd734) && (pix_x < 11'd750) && (pix_y >= 11'd280) && (pix_y < 11'd360) && (data[5] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd670) && (pix_x < 11'd750) && (pix_y >= 11'd344) && (pix_y < 11'd360) && (data[4] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd670) && (pix_x < 11'd686) && (pix_y >= 11'd280) && (pix_y < 11'd360) && (data[3] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd670) && (pix_x < 11'd686) && (pix_y >= 11'd200) && (pix_y < 11'd280) && (data[2] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd670) && (pix_x < 11'd750) && (pix_y >= 11'd272) && (pix_y < 11'd288) && (data[1] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd751) && (pix_x < 11'd759) && (pix_y >= 11'd352) && (pix_y < 11'd360) && (data[0] == 1'b1)) begin
        pix_data <= RED;
    end

    else begin
        pix_data <= BLACK;
    end
end
endmodule