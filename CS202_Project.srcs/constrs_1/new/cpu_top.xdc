#reset,clk
set_property IOSTANDARD LVCMOS33 [get_ports fpga_clk]
set_property IOSTANDARD LVCMOS33 [get_ports reset_h]
set_property PACKAGE_PIN Y18 [get_ports fpga_clk]
set_property PACKAGE_PIN P20 [get_ports reset_h]


#display
set_property IOSTANDARD LVCMOS33 [get_ports {seg_en[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_en[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_en[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_en[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_en[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_en[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_en[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_en[7]}]

set_property IOSTANDARD LVCMOS33 [get_ports {seg_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_out[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_out[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_out[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_out[7]}]

set_property IOSTANDARD LVCMOS33 [get_ports hsync]
set_property IOSTANDARD LVCMOS33 [get_ports vsync]

set_property IOSTANDARD LVCMOS33 [get_ports {vga_rgb[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_rgb[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_rgb[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_rgb[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_rgb[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_rgb[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_rgb[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_rgb[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_rgb[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_rgb[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_rgb[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_rgb[11]}]




set_property PACKAGE_PIN C19 [get_ports {seg_en[0]}]
set_property PACKAGE_PIN E19 [get_ports {seg_en[1]}]
set_property PACKAGE_PIN D19 [get_ports {seg_en[2]}]
set_property PACKAGE_PIN F18 [get_ports {seg_en[3]}]
set_property PACKAGE_PIN E18 [get_ports {seg_en[4]}]
set_property PACKAGE_PIN B20 [get_ports {seg_en[5]}]
set_property PACKAGE_PIN A20 [get_ports {seg_en[6]}]
set_property PACKAGE_PIN A18 [get_ports {seg_en[7]}]

set_property PACKAGE_PIN E13 [get_ports {seg_out[0]}]
set_property PACKAGE_PIN C15 [get_ports {seg_out[1]}]
set_property PACKAGE_PIN C14 [get_ports {seg_out[2]}]
set_property PACKAGE_PIN E17 [get_ports {seg_out[3]}]
set_property PACKAGE_PIN F16 [get_ports {seg_out[4]}]
set_property PACKAGE_PIN F14 [get_ports {seg_out[5]}]
set_property PACKAGE_PIN F13 [get_ports {seg_out[6]}]
set_property PACKAGE_PIN F15 [get_ports {seg_out[7]}]

set_property PACKAGE_PIN M21 [get_ports hsync]
set_property PACKAGE_PIN L21 [get_ports vsync]

set_property PACKAGE_PIN H20 [get_ports {vga_rgb[0]}]
set_property PACKAGE_PIN G20 [get_ports {vga_rgb[1]}]
set_property PACKAGE_PIN K21 [get_ports {vga_rgb[2]}]
set_property PACKAGE_PIN K22 [get_ports {vga_rgb[3]}]
set_property PACKAGE_PIN H17 [get_ports {vga_rgb[4]}]
set_property PACKAGE_PIN H18 [get_ports {vga_rgb[5]}]
set_property PACKAGE_PIN J22 [get_ports {vga_rgb[6]}]
set_property PACKAGE_PIN H22 [get_ports {vga_rgb[7]}]
set_property PACKAGE_PIN G17 [get_ports {vga_rgb[8]}]
set_property PACKAGE_PIN G18 [get_ports {vga_rgb[9]}]
set_property PACKAGE_PIN J15 [get_ports {vga_rgb[10]}]
set_property PACKAGE_PIN H15 [get_ports {vga_rgb[11]}]


#led
set_property PACKAGE_PIN K17 [get_ports {led_out[23]}]
set_property PACKAGE_PIN L13 [get_ports {led_out[22]}]
set_property PACKAGE_PIN M13 [get_ports {led_out[21]}]
set_property PACKAGE_PIN K14 [get_ports {led_out[20]}]
set_property PACKAGE_PIN K13 [get_ports {led_out[19]}]
set_property PACKAGE_PIN M20 [get_ports {led_out[18]}]
set_property PACKAGE_PIN N20 [get_ports {led_out[17]}]
set_property PACKAGE_PIN N19 [get_ports {led_out[16]}]
set_property PACKAGE_PIN M17 [get_ports {led_out[15]}]
set_property PACKAGE_PIN M16 [get_ports {led_out[14]}]
set_property PACKAGE_PIN M15 [get_ports {led_out[13]}]
set_property PACKAGE_PIN K16 [get_ports {led_out[12]}]
set_property PACKAGE_PIN L16 [get_ports {led_out[11]}]
set_property PACKAGE_PIN L15 [get_ports {led_out[10]}]
set_property PACKAGE_PIN L14 [get_ports {led_out[9]}]
set_property PACKAGE_PIN J17 [get_ports {led_out[8]}]
set_property PACKAGE_PIN F21 [get_ports {led_out[7]}]
set_property PACKAGE_PIN G22 [get_ports {led_out[6]}]
set_property PACKAGE_PIN G21 [get_ports {led_out[5]}]
set_property PACKAGE_PIN D21 [get_ports {led_out[4]}]
set_property PACKAGE_PIN E21 [get_ports {led_out[3]}]
set_property PACKAGE_PIN D22 [get_ports {led_out[2]}]
set_property PACKAGE_PIN E22 [get_ports {led_out[1]}]
set_property PACKAGE_PIN A21 [get_ports {led_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[23]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[22]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[21]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[20]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[19]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[18]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[17]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[16]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[0]}]

#switch
set_property IOSTANDARD LVCMOS33 [get_ports {switch[23]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[22]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[21]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[20]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[19]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[18]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[17]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[16]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[0]}]
set_property PACKAGE_PIN AA8 [get_ports {switch[18]}]
set_property PACKAGE_PIN V8 [get_ports {switch[17]}]
set_property PACKAGE_PIN V9 [get_ports {switch[16]}]
set_property PACKAGE_PIN Y9 [get_ports {switch[23]}]
set_property PACKAGE_PIN W9 [get_ports {switch[22]}]
set_property PACKAGE_PIN Y7 [get_ports {switch[21]}]
set_property PACKAGE_PIN Y8 [get_ports {switch[20]}]
set_property PACKAGE_PIN AB8 [get_ports {switch[19]}]
set_property PACKAGE_PIN AB6 [get_ports {switch[15]}]
set_property PACKAGE_PIN AB7 [get_ports {switch[14]}]
set_property PACKAGE_PIN V7 [get_ports {switch[13]}]
set_property PACKAGE_PIN AA6 [get_ports {switch[12]}]
set_property PACKAGE_PIN Y6 [get_ports {switch[11]}]
set_property PACKAGE_PIN T6 [get_ports {switch[10]}]
set_property PACKAGE_PIN R6 [get_ports {switch[9]}]
set_property PACKAGE_PIN V5 [get_ports {switch[8]}]
set_property PACKAGE_PIN U6 [get_ports {switch[7]}]
set_property PACKAGE_PIN W5 [get_ports {switch[6]}]
set_property PACKAGE_PIN W6 [get_ports {switch[5]}]
set_property PACKAGE_PIN U5 [get_ports {switch[4]}]
set_property PACKAGE_PIN T5 [get_ports {switch[3]}]
set_property PACKAGE_PIN T4 [get_ports {switch[2]}]
set_property PACKAGE_PIN R4 [get_ports {switch[1]}]
set_property PACKAGE_PIN W4 [get_ports {switch[0]}]

#uart
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN Y19} [get_ports rx]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN V18} [get_ports tx]
set_property IOSTANDARD LVCMOS33 [get_ports start_pg]
set_property PACKAGE_PIN P4 [get_ports start_pg]


#keyboard
set_property IOSTANDARD LVCMOS33 [get_ports {col[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {col[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {col[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {col[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {row[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {row[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {row[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {row[0]}]
set_property PACKAGE_PIN M2 [get_ports {col[3]}]
set_property PACKAGE_PIN K6 [get_ports {col[2]}]
set_property PACKAGE_PIN J6 [get_ports {col[1]}]
set_property PACKAGE_PIN L5 [get_ports {col[0]}]

set_property PACKAGE_PIN K4 [get_ports {row[3]}]
set_property PACKAGE_PIN J4 [get_ports {row[2]}]
set_property PACKAGE_PIN L3 [get_ports {row[1]}]
set_property PACKAGE_PIN K3 [get_ports {row[0]}]
