-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.4.1 (win64) Build 2117270 Tue Jan 30 15:32:00 MST 2018
-- Date        : Thu May 11 16:31:54 2023
-- Host        : LAPTOP-OF4B8OJA running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               d:/Projects/CO/Project/CS202_Project/CS202_Project.srcs/sources_1/ip/clk_main/clk_main_stub.vhdl
-- Design      : clk_main
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tfgg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_main is
  Port ( 
    clk_out : out STD_LOGIC;
    resetn : in STD_LOGIC;
    clk_in : in STD_LOGIC
  );

end clk_main;

architecture stub of clk_main is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_out,resetn,clk_in";
begin
end;