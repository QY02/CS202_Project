-makelib ies_lib/xil_defaultlib -sv \
  "D:/Programs/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "D:/Programs/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "D:/Programs/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../CS202_Project.srcs/sources_1/ip/uart_bmpg_0/uart_bmpg.v" \
  "../../../../CS202_Project.srcs/sources_1/ip/uart_bmpg_0/upg.v" \
  "../../../../CS202_Project.srcs/sources_1/ip/uart_bmpg_0/sim/uart_bmpg_0.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

