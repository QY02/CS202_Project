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
    input wire [63:0] display_in,

    output reg [11:0] pix_data
);

// parameter H_VALID = 11'd800,
//           V_VALID = 11'd600;

parameter   RED     = 12'hF00,
            // ORANGE  = 12'hFC0,
            // YELLOW  = 12'hFFE,
            // GREEN   = 12'h0F0,
            // CYAN    = 12'h07F,
            // BLUE    = 12'h00F,
            // PURPPLE = 12'hF81,
            BLACK   = 12'h000;
            // WHITE   = 12'hFFF,
            // GRAY    = 12'hD69;

always@ (posedge clk or negedge rst_n) begin
    if (rst_n == 1'b0) begin
        pix_data <= BLACK;
    end
    else if ((pix_x >= 11'd40) && (pix_x < 11'd120) && (pix_y >= 11'd200) && (pix_y < 11'd216) && (display_in[63] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd104) && (pix_x < 11'd120) && (pix_y >= 11'd200) && (pix_y < 11'd280) && (display_in[62] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd104) && (pix_x < 11'd120) && (pix_y >= 11'd280) && (pix_y < 11'd360) && (display_in[61] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd40) && (pix_x < 11'd120) && (pix_y >= 11'd344) && (pix_y < 11'd360) && (display_in[60] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd40) && (pix_x < 11'd56) && (pix_y >= 11'd280) && (pix_y < 11'd360) && (display_in[59] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd40) && (pix_x < 11'd56) && (pix_y >= 11'd200) && (pix_y < 11'd280) && (display_in[58] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd40) && (pix_x < 11'd120) && (pix_y >= 11'd272) && (pix_y < 11'd288) && (display_in[57] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd121) && (pix_x < 11'd129) && (pix_y >= 11'd352) && (pix_y < 11'd360) && (display_in[56] == 1'b1)) begin
        pix_data <= RED;
    end

    else if ((pix_x >= 11'd130) && (pix_x < 11'd210) && (pix_y >= 11'd200) && (pix_y < 11'd216) && (display_in[55] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd194) && (pix_x < 11'd210) && (pix_y >= 11'd200) && (pix_y < 11'd280) && (display_in[54] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd194) && (pix_x < 11'd210) && (pix_y >= 11'd280) && (pix_y < 11'd360) && (display_in[53] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd130) && (pix_x < 11'd210) && (pix_y >= 11'd344) && (pix_y < 11'd360) && (display_in[52] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd130) && (pix_x < 11'd146) && (pix_y >= 11'd280) && (pix_y < 11'd360) && (display_in[51] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd130) && (pix_x < 11'd146) && (pix_y >= 11'd200) && (pix_y < 11'd280) && (display_in[50] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd130) && (pix_x < 11'd210) && (pix_y >= 11'd272) && (pix_y < 11'd288) && (display_in[49] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd211) && (pix_x < 11'd219) && (pix_y >= 11'd352) && (pix_y < 11'd360) && (display_in[48] == 1'b1)) begin
        pix_data <= RED;
    end

    else if ((pix_x >= 11'd220) && (pix_x < 11'd300) && (pix_y >= 11'd200) && (pix_y < 11'd216) && (display_in[47] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd284) && (pix_x < 11'd300) && (pix_y >= 11'd200) && (pix_y < 11'd280) && (display_in[46] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd284) && (pix_x < 11'd300) && (pix_y >= 11'd280) && (pix_y < 11'd360) && (display_in[45] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd220) && (pix_x < 11'd300) && (pix_y >= 11'd344) && (pix_y < 11'd360) && (display_in[44] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd220) && (pix_x < 11'd236) && (pix_y >= 11'd280) && (pix_y < 11'd360) && (display_in[43] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd220) && (pix_x < 11'd236) && (pix_y >= 11'd200) && (pix_y < 11'd280) && (display_in[42] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd220) && (pix_x < 11'd300) && (pix_y >= 11'd272) && (pix_y < 11'd288) && (display_in[41] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd301) && (pix_x < 11'd309) && (pix_y >= 11'd352) && (pix_y < 11'd360) && (display_in[40] == 1'b1)) begin
        pix_data <= RED;
    end

    else if ((pix_x >= 11'd310) && (pix_x < 11'd390) && (pix_y >= 11'd200) && (pix_y < 11'd216) && (display_in[39] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd374) && (pix_x < 11'd390) && (pix_y >= 11'd200) && (pix_y < 11'd280) && (display_in[38] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd374) && (pix_x < 11'd390) && (pix_y >= 11'd280) && (pix_y < 11'd360) && (display_in[37] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd310) && (pix_x < 11'd390) && (pix_y >= 11'd344) && (pix_y < 11'd360) && (display_in[36] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd310) && (pix_x < 11'd326) && (pix_y >= 11'd280) && (pix_y < 11'd360) && (display_in[35] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd310) && (pix_x < 11'd326) && (pix_y >= 11'd200) && (pix_y < 11'd280) && (display_in[34] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd310) && (pix_x < 11'd390) && (pix_y >= 11'd272) && (pix_y < 11'd288) && (display_in[33] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd391) && (pix_x < 11'd399) && (pix_y >= 11'd352) && (pix_y < 11'd360) && (display_in[32] == 1'b1)) begin
        pix_data <= RED;
    end

    else if ((pix_x >= 11'd400) && (pix_x < 11'd480) && (pix_y >= 11'd200) && (pix_y < 11'd216) && (display_in[31] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd464) && (pix_x < 11'd480) && (pix_y >= 11'd200) && (pix_y < 11'd280) && (display_in[30] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd464) && (pix_x < 11'd480) && (pix_y >= 11'd280) && (pix_y < 11'd360) && (display_in[29] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd400) && (pix_x < 11'd480) && (pix_y >= 11'd344) && (pix_y < 11'd360) && (display_in[28] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd400) && (pix_x < 11'd416) && (pix_y >= 11'd280) && (pix_y < 11'd360) && (display_in[27] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd400) && (pix_x < 11'd416) && (pix_y >= 11'd200) && (pix_y < 11'd280) && (display_in[26] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd400) && (pix_x < 11'd480) && (pix_y >= 11'd272) && (pix_y < 11'd288) && (display_in[25] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd481) && (pix_x < 11'd489) && (pix_y >= 11'd352) && (pix_y < 11'd360) && (display_in[24] == 1'b1)) begin
        pix_data <= RED;
    end

    else if ((pix_x >= 11'd490) && (pix_x < 11'd570) && (pix_y >= 11'd200) && (pix_y < 11'd216) && (display_in[23] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd554) && (pix_x < 11'd570) && (pix_y >= 11'd200) && (pix_y < 11'd280) && (display_in[22] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd554) && (pix_x < 11'd570) && (pix_y >= 11'd280) && (pix_y < 11'd360) && (display_in[21] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd490) && (pix_x < 11'd570) && (pix_y >= 11'd344) && (pix_y < 11'd360) && (display_in[20] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd490) && (pix_x < 11'd506) && (pix_y >= 11'd280) && (pix_y < 11'd360) && (display_in[19] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd490) && (pix_x < 11'd506) && (pix_y >= 11'd200) && (pix_y < 11'd280) && (display_in[18] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd490) && (pix_x < 11'd570) && (pix_y >= 11'd272) && (pix_y < 11'd288) && (display_in[17] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd571) && (pix_x < 11'd579) && (pix_y >= 11'd352) && (pix_y < 11'd360) && (display_in[16] == 1'b1)) begin
        pix_data <= RED;
    end

    else if ((pix_x >= 11'd580) && (pix_x < 11'd660) && (pix_y >= 11'd200) && (pix_y < 11'd216) && (display_in[15] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd644) && (pix_x < 11'd660) && (pix_y >= 11'd200) && (pix_y < 11'd280) && (display_in[14] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd644) && (pix_x < 11'd660) && (pix_y >= 11'd280) && (pix_y < 11'd360) && (display_in[13] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd580) && (pix_x < 11'd660) && (pix_y >= 11'd344) && (pix_y < 11'd360) && (display_in[12] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd580) && (pix_x < 11'd596) && (pix_y >= 11'd280) && (pix_y < 11'd360) && (display_in[11] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd580) && (pix_x < 11'd596) && (pix_y >= 11'd200) && (pix_y < 11'd280) && (display_in[10] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd580) && (pix_x < 11'd660) && (pix_y >= 11'd272) && (pix_y < 11'd288) && (display_in[9] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd661) && (pix_x < 11'd669) && (pix_y >= 11'd352) && (pix_y < 11'd360) && (display_in[8] == 1'b1)) begin
        pix_data <= RED;
    end

    else if ((pix_x >= 11'd670) && (pix_x < 11'd750) && (pix_y >= 11'd200) && (pix_y < 11'd216) && (display_in[7] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd734) && (pix_x < 11'd750) && (pix_y >= 11'd200) && (pix_y < 11'd280) && (display_in[6] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd734) && (pix_x < 11'd750) && (pix_y >= 11'd280) && (pix_y < 11'd360) && (display_in[5] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd670) && (pix_x < 11'd750) && (pix_y >= 11'd344) && (pix_y < 11'd360) && (display_in[4] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd670) && (pix_x < 11'd686) && (pix_y >= 11'd280) && (pix_y < 11'd360) && (display_in[3] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd670) && (pix_x < 11'd686) && (pix_y >= 11'd200) && (pix_y < 11'd280) && (display_in[2] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd670) && (pix_x < 11'd750) && (pix_y >= 11'd272) && (pix_y < 11'd288) && (display_in[1] == 1'b1)) begin
        pix_data <= RED;
    end
    else if ((pix_x >= 11'd751) && (pix_x < 11'd759) && (pix_y >= 11'd352) && (pix_y < 11'd360) && (display_in[0] == 1'b1)) begin
        pix_data <= RED;
    end

    else begin
        pix_data <= BLACK;
    end
end
endmodule