`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/20 23:29:26
// Design Name: 
// Module Name: vga_ctrl
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


module vga_ctrl(
    input wire clk,
    input wire rst_n,

    output wire [10:0] pix_x,
    output wire [10:0] pix_y,
    output wire hsync,
    output wire vsync,
    output wire is_valid
    // output wire [11:0] vga_rgb
);


parameter H_SYNC = 11'd128,
          H_BACK = 11'd88,
          H_LEFT = 11'd0,
          H_VALID = 11'd800,
          H_RIGHT = 11'd0,
          H_FRONT = 11'd40,
          H_TOTAL = 11'd1056;

parameter V_SYNC = 11'd4,
          V_BACK = 11'd23,
          V_TOP = 11'd0,
          V_VALID = 11'd600,
          V_BOTTOM = 11'd0,
          V_FRONT = 11'd1,
          V_TOTAL = 11'd628;


reg [10:0] cnt_h;
reg [10:0] cnt_v;
// wire rgb_valid;
// wire pix_data_req;

always @(posedge clk or negedge rst_n) begin
    if (rst_n == 1'b0) begin
        cnt_h <= 11'd0;
    end
    else if (cnt_h == (H_TOTAL - 1'b1)) begin
        cnt_h <= 11'd0;
    end
    else begin
        cnt_h <= cnt_h + 11'd1;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (rst_n == 1'b0) begin
        cnt_v <= 11'd0;
    end
    else if ((cnt_h == (H_TOTAL - 1'b1)) && (cnt_v == (V_TOTAL - 1'b1))) begin
        cnt_v <= 11'd0;
    end
    else if (cnt_h == (H_TOTAL-1'b1)) begin
        cnt_v <= cnt_v + 11'd1;
    end
    else begin
        cnt_v <= cnt_v;
    end
end

assign is_valid = ((cnt_h >= H_SYNC + H_BACK + H_LEFT) && (cnt_h < H_SYNC + H_BACK + H_LEFT + H_VALID)
                    && (cnt_v >= V_SYNC + V_BACK + V_TOP) && (cnt_v < V_SYNC + V_BACK + V_TOP + V_VALID))
                    ? 1'b1 : 1'b0;

// assign pix_data_req = ((cnt_h >= H_SYNC + H_BACK + H_LEFT - 1'b1)
//                     && (cnt_h < H_SYNC + H_BACK + H_LEFT + H_VALID - 1'b1)
//                     && (cnt_v >= V_SYNC + V_BACK + V_TOP)
//                     && (cnt_v < V_SYNC + V_BACK + V_TOP + V_VALID))
//                     ?  1'b1 : 1'b0;

assign pix_x = (is_valid == 1'b1) ? (cnt_h - (H_SYNC + H_BACK + H_LEFT)) : 11'd0;
assign pix_y = (is_valid == 1'b1) ? (cnt_v - (V_SYNC + V_BACK + V_TOP)) : 11'd0;
assign hsync = (cnt_h < H_SYNC) ? 1'b1 : 1'b0;
assign vsync = (cnt_v < V_SYNC) ? 1'b1 : 1'b0;
// assign vga_rgb = (rgb_valid == 1'b1) ? pix_data : 12'h000;

endmodule