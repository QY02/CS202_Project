`timescale 1ns / 1ps

module Switch(clk, rst, IORead, SwitchCtrl,addr_in, switch_in,switch_wdata);
    input clk;			       //  时钟信号
    input rst;			       //  复位信号
    input IORead;
    input SwitchCtrl;
    input [1:0] addr_in;
    output reg [31:0] switch_wdata;
    input [23:0] switch_in;	
    always@(negedge clk or negedge rst) begin
        if(~rst) begin
            switch_wdata <= 32'b0;
        end
		else begin
            if (SwitchCtrl && IORead) begin
                case (addr_in)
                    2'b00: switch_wdata[23:0] <= switch_in[23:0];
                    2'b01: switch_wdata[23:0] <= {8'b0, switch_in[23:8]};
                    2'b10: switch_wdata[23:0] <= {16'b0, switch_in[23:16]};
                    default: switch_wdata <= switch_wdata;
                endcase
            end
            else begin
                switch_wdata <= switch_wdata;
            end
        end
    end
endmodule