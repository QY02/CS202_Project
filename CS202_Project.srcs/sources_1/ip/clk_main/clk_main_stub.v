// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4.1 (win64) Build 2117270 Tue Jan 30 15:32:00 MST 2018
// Date        : Wed May 17 20:32:18 2023
// Host        : LAPTOP-OF4B8OJA running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               D:/Projects/CO/Project/CS202_Project/CS202_Project/CS202_Project.srcs/sources_1/ip/clk_main/clk_main_stub.v
// Design      : clk_main
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tfgg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_main(clk_out1, clk_out2, clk_out3, clk_in)
/* synthesis syn_black_box black_box_pad_pin="clk_out1,clk_out2,clk_out3,clk_in" */;
  output clk_out1;
  output clk_out2;
  output clk_out3;
  input clk_in;
endmodule
