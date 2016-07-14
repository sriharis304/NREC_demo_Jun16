#
# In sdc, all clocks are related by default. This differs from ucf, where clocks are unrelated unless specified otherwise.

# SDR receiver timing constraints

set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

#create_clock -period 5.000 -name diff_clock_clk_p -add [get_ports diff_clock_clk_p]
##create_clock -period 5.000 -name refclkin_n -add [get_ports refclkin_n]

#set_property IOSTANDARD LVDS [get_ports diff_clock_clk_p]
#set_property DIFF_TERM TRUE [get_ports diff_clock_clk_p]
#set_property PACKAGE_PIN L4 [get_ports diff_clock_clk_n]
#set_property IOSTANDARD LVDS [get_ports diff_clock_clk_n]
#set_property DIFF_TERM TRUE [get_ports diff_clock_clk_n]


#set_property IOSTANDARD LVCMOS25 [get_ports rst_n]
#set_property PACKAGE_PIN AE26 [get_ports rst_n]
create_clock -period 30.769 -name channel_x_clk_p -add [get_ports channel_x_clk_p]
#create_clock -period 20.833 -name channel_y_clk_p -add [get_ports channel_y_clk_p]
#create_clock -period 20.833 -name channel_z_clk_p -add [get_ports channel_z_clk_p]


create_clock -period 5.000 -name diff_clock_clk_p -add [get_ports diff_clock_clk_p]

# Ignore false path from clock input to clock input serdes
set_false_path -from [get_ports channel_x_clk_p] -to [get_pins -hier -filter {name =~ *rx*iserdes_c?/DDLY}]
set_false_path -from [get_clocks clk_out1_design_1_clk_wiz_0_0] -to [get_clocks clk_out2_design_1_clk_wiz_0_0]
set_false_path -from [get_clocks -of_objects [get_pins design_1_i/clk_wiz_0/inst/plle2_adv_inst/CLKOUT1]] -to [get_clocks -of_objects [get_pins design_1_i/clk_wiz_0/inst/plle2_adv_inst/CLKOUT0]]
set_false_path -from [get_clocks clk_out1_design_1_clk_wiz_0_0] -to [get_clocks clk_out2_design_1_clk_wiz_0_0]
#set_false_path -from [get_clocks -of_objects [get_pins design_1_i/clk_wiz_0/inst/plle2_adv_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins design_1_i/clk_wiz_0/inst/plle2_adv_inst/CLKOUT1]]
# sof of vert cropping to dmd --- to see how much time it takes
#set_property IOSTANDARD LVCMOS33 [get_ports sof]
#set_property PACKAGE_PIN Y10 [get_ports sof]
#set_false_path -from [get_clocks -of_objects [get_pins design_1_i/clk_wiz_0/inst/mmcm_adv_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins design_1_i/clk_wiz_0/inst/mmcm_adv_inst/CLKOUT1]]

# debug -- count

#set_property IOSTANDARD LVCMOS18 [get_ports count_op]
#set_property PACKAGE_PIN E6 [get_ports count_op]

# Pin constraints
set_property IOSTANDARD LVDS_25 [get_ports channel_x_clk_p]
set_property DIFF_TERM TRUE [get_ports channel_x_clk_p]
set_property PACKAGE_PIN AD24 [get_ports channel_x_clk_n]
set_property IOSTANDARD LVDS_25 [get_ports channel_x_clk_n]
set_property DIFF_TERM TRUE [get_ports channel_x_clk_n]

set_property IOSTANDARD LVDS_25 [get_ports {channel_x_data_p[0]}]
set_property DIFF_TERM TRUE [get_ports {channel_x_data_p[0]}]
set_property PACKAGE_PIN AD26 [get_ports {channel_x_data_n[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_x_data_n[0]}]
set_property DIFF_TERM TRUE [get_ports {channel_x_data_n[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_x_data_p[1]}]
set_property DIFF_TERM TRUE [get_ports {channel_x_data_p[1]}]
set_property PACKAGE_PIN AB24 [get_ports {channel_x_data_n[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_x_data_n[1]}]
set_property DIFF_TERM TRUE [get_ports {channel_x_data_n[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_x_data_p[2]}]
set_property DIFF_TERM TRUE [get_ports {channel_x_data_p[2]}]
set_property PACKAGE_PIN AC26 [get_ports {channel_x_data_n[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_x_data_n[2]}]
set_property DIFF_TERM TRUE [get_ports {channel_x_data_n[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_x_data_p[3]}]
set_property DIFF_TERM TRUE [get_ports {channel_x_data_p[3]}]
set_property PACKAGE_PIN AB25 [get_ports {channel_x_data_n[3]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_x_data_n[3]}]
set_property DIFF_TERM TRUE [get_ports {channel_x_data_n[3]}]

set_property IOSTANDARD LVDS_25 [get_ports channel_y_clk_p]
set_property DIFF_TERM TRUE [get_ports channel_y_clk_p]
set_property PACKAGE_PIN AD21 [get_ports channel_y_clk_n]
set_property IOSTANDARD LVDS_25 [get_ports channel_y_clk_n]
set_property DIFF_TERM TRUE [get_ports channel_y_clk_n]

set_property IOSTANDARD LVDS_25 [get_ports {channel_y_data_p[0]}]
set_property DIFF_TERM TRUE [get_ports {channel_y_data_p[0]}]
set_property PACKAGE_PIN AC19 [get_ports {channel_y_data_n[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_y_data_n[0]}]
set_property DIFF_TERM TRUE [get_ports {channel_y_data_n[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_y_data_p[1]}]
set_property DIFF_TERM TRUE [get_ports {channel_y_data_p[1]}]
set_property PACKAGE_PIN AB19 [get_ports {channel_y_data_n[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_y_data_n[1]}]
set_property DIFF_TERM TRUE [get_ports {channel_y_data_n[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_y_data_p[2]}]
set_property DIFF_TERM TRUE [get_ports {channel_y_data_p[2]}]
set_property PACKAGE_PIN AA18 [get_ports {channel_y_data_n[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_y_data_n[2]}]
set_property DIFF_TERM TRUE [get_ports {channel_y_data_n[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_y_data_p[3]}]
set_property DIFF_TERM TRUE [get_ports {channel_y_data_p[3]}]
set_property PACKAGE_PIN AD19 [get_ports {channel_y_data_n[3]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_y_data_n[3]}]
set_property DIFF_TERM TRUE [get_ports {channel_y_data_n[3]}]

set_property IOSTANDARD LVDS_25 [get_ports channel_z_clk_p]
set_property DIFF_TERM TRUE [get_ports channel_z_clk_p]
set_property PACKAGE_PIN AC22 [get_ports channel_z_clk_n]
set_property IOSTANDARD LVDS_25 [get_ports channel_z_clk_n]
set_property DIFF_TERM TRUE [get_ports channel_z_clk_n]

set_property IOSTANDARD LVDS_25 [get_ports {channel_z_data_p[0]}]
set_property DIFF_TERM TRUE [get_ports {channel_z_data_p[0]}]
set_property PACKAGE_PIN AE21 [get_ports {channel_z_data_n[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_z_data_n[0]}]
set_property DIFF_TERM TRUE [get_ports {channel_z_data_n[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_z_data_p[1]}]
set_property DIFF_TERM TRUE [get_ports {channel_z_data_p[1]}]
set_property PACKAGE_PIN AF18 [get_ports {channel_z_data_n[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_z_data_n[1]}]
set_property DIFF_TERM TRUE [get_ports {channel_z_data_n[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_z_data_p[2]}]
set_property DIFF_TERM TRUE [get_ports {channel_z_data_p[2]}]
set_property PACKAGE_PIN AF20 [get_ports {channel_z_data_n[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_z_data_n[2]}]
set_property DIFF_TERM TRUE [get_ports {channel_z_data_n[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_z_data_p[3]}]
set_property DIFF_TERM TRUE [get_ports {channel_z_data_p[3]}]
set_property PACKAGE_PIN AF25 [get_ports {channel_z_data_n[3]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_z_data_n[3]}]
set_property DIFF_TERM TRUE [get_ports {channel_z_data_n[3]}]

set_property IOSTANDARD LVDS [get_ports diff_clock_clk_p]
set_property DIFF_TERM TRUE [get_ports diff_clock_clk_p]
set_property PACKAGE_PIN L4 [get_ports diff_clock_clk_n]
set_property IOSTANDARD LVDS [get_ports diff_clock_clk_n]
set_property DIFF_TERM TRUE [get_ports diff_clock_clk_n]


set_property PACKAGE_PIN AE26 [get_ports rst_n]
set_property IOSTANDARD LVCMOS25 [get_ports rst_n]
#set_property IOSTANDARD LVCMOS18 [get_ports {data_out[27]}]

set_clock_groups -name cameralink -asynchronous -group [get_clocks {rx_mmcmout_x1 rx_mmcmout_xs channel_x_clk_p}]
set_clock_groups -name refclock -asynchronous -group [get_clocks diff_clock_clk_p]


#set_property IOSTANDARD LVCMOS18 [get_ports locked]
#set_property PACKAGE_PIN E6 [get_ports locked]

set_property IOSTANDARD LVDS [get_ports pixel_clk_out_p]
set_property DIFF_TERM TRUE [get_ports pixel_clk_out_p]
set_property PACKAGE_PIN F7 [get_ports pixel_clk_out_n]
set_property IOSTANDARD LVDS [get_ports pixel_clk_out_n]
set_property DIFF_TERM TRUE [get_ports pixel_clk_out_n]

set_property IOSTANDARD LVDS [get_ports {vid_io_out_data_p[0]}]
set_property DIFF_TERM TRUE [get_ports {vid_io_out_data_p[0]}]
set_property PACKAGE_PIN H8 [get_ports {vid_io_out_data_n[0]}]
set_property IOSTANDARD LVDS [get_ports {vid_io_out_data_n[0]}]
set_property DIFF_TERM TRUE [get_ports {vid_io_out_data_n[0]}]

set_property IOSTANDARD LVDS [get_ports {vid_io_out_data_p[1]}]
set_property DIFF_TERM TRUE [get_ports {vid_io_out_data_p[1]}]
set_property PACKAGE_PIN L7 [get_ports {vid_io_out_data_n[1]}]
set_property IOSTANDARD LVDS [get_ports {vid_io_out_data_n[1]}]
set_property DIFF_TERM TRUE [get_ports {vid_io_out_data_n[1]}]

set_property IOSTANDARD LVDS [get_ports {vid_io_out_data_p[2]}]
set_property DIFF_TERM TRUE [get_ports {vid_io_out_data_p[2]}]
set_property PACKAGE_PIN N6 [get_ports {vid_io_out_data_n[2]}]
set_property IOSTANDARD LVDS [get_ports {vid_io_out_data_n[2]}]
set_property DIFF_TERM TRUE [get_ports {vid_io_out_data_n[2]}]

set_property IOSTANDARD LVDS [get_ports {vid_io_out_data_p[3]}]
set_property DIFF_TERM TRUE [get_ports {vid_io_out_data_p[3]}]
set_property PACKAGE_PIN K7 [get_ports {vid_io_out_data_n[3]}]
set_property IOSTANDARD LVDS [get_ports {vid_io_out_data_n[3]}]
set_property DIFF_TERM TRUE [get_ports {vid_io_out_data_n[3]}]

set_property IOSTANDARD LVDS [get_ports {vid_io_out_data_p[4]}]
set_property DIFF_TERM TRUE [get_ports {vid_io_out_data_p[4]}]
set_property PACKAGE_PIN L8 [get_ports {vid_io_out_data_n[4]}]
set_property IOSTANDARD LVDS [get_ports {vid_io_out_data_n[4]}]
set_property DIFF_TERM TRUE [get_ports {vid_io_out_data_n[4]}]

set_property IOSTANDARD LVDS [get_ports {vid_io_out_data_p[5]}]
set_property DIFF_TERM TRUE [get_ports {vid_io_out_data_p[5]}]
set_property PACKAGE_PIN J6 [get_ports {vid_io_out_data_n[5]}]
set_property IOSTANDARD LVDS [get_ports {vid_io_out_data_n[5]}]
set_property DIFF_TERM TRUE [get_ports {vid_io_out_data_n[5]}]

set_property IOSTANDARD LVDS [get_ports {vid_io_out_data_p[6]}]
set_property DIFF_TERM TRUE [get_ports {vid_io_out_data_p[6]}]
set_property PACKAGE_PIN J5 [get_ports {vid_io_out_data_n[6]}]
set_property IOSTANDARD LVDS [get_ports {vid_io_out_data_n[6]}]
set_property DIFF_TERM TRUE [get_ports {vid_io_out_data_n[6]}]

set_property IOSTANDARD LVDS [get_ports {vid_io_out_data_p[7]}]
set_property DIFF_TERM TRUE [get_ports {vid_io_out_data_p[7]}]
set_property PACKAGE_PIN N2 [get_ports {vid_io_out_data_n[7]}]
set_property IOSTANDARD LVDS [get_ports {vid_io_out_data_n[7]}]
set_property DIFF_TERM TRUE [get_ports {vid_io_out_data_n[7]}]

set_property IOSTANDARD LVDS [get_ports {vid_io_out_data_p[8]}]
set_property DIFF_TERM TRUE [get_ports {vid_io_out_data_p[8]}]
set_property PACKAGE_PIN L2 [get_ports {vid_io_out_data_n[8]}]
set_property IOSTANDARD LVDS [get_ports {vid_io_out_data_n[8]}]
set_property DIFF_TERM TRUE [get_ports {vid_io_out_data_n[8]}]

set_property IOSTANDARD LVDS [get_ports {vid_io_out_data_p[9]}]
set_property DIFF_TERM TRUE [get_ports {vid_io_out_data_p[9]}]
set_property PACKAGE_PIN M1 [get_ports {vid_io_out_data_n[9]}]
set_property IOSTANDARD LVDS [get_ports {vid_io_out_data_n[9]}]
set_property DIFF_TERM TRUE [get_ports {vid_io_out_data_n[9]}]

set_property IOSTANDARD LVDS [get_ports {vid_io_out_data_p[10]}]
set_property DIFF_TERM TRUE [get_ports {vid_io_out_data_p[10]}]
set_property PACKAGE_PIN H3 [get_ports {vid_io_out_data_n[10]}]
set_property IOSTANDARD LVDS [get_ports {vid_io_out_data_n[10]}]
set_property DIFF_TERM TRUE [get_ports {vid_io_out_data_n[10]}]

set_property IOSTANDARD LVDS [get_ports {vid_io_out_data_p[11]}]
set_property DIFF_TERM TRUE [get_ports {vid_io_out_data_p[11]}]
set_property PACKAGE_PIN H1 [get_ports {vid_io_out_data_n[11]}]
set_property IOSTANDARD LVDS [get_ports {vid_io_out_data_n[11]}]
set_property DIFF_TERM TRUE [get_ports {vid_io_out_data_n[11]}]

set_property IOSTANDARD LVDS [get_ports {vid_io_out_data_p[12]}]
set_property DIFF_TERM TRUE [get_ports {vid_io_out_data_p[12]}]
set_property PACKAGE_PIN G1 [get_ports {vid_io_out_data_n[12]}]
set_property IOSTANDARD LVDS [get_ports {vid_io_out_data_n[12]}]
set_property DIFF_TERM TRUE [get_ports {vid_io_out_data_n[12]}]

set_property IOSTANDARD LVDS [get_ports {vid_io_out_data_p[13]}]
set_property DIFF_TERM TRUE [get_ports {vid_io_out_data_p[13]}]
set_property PACKAGE_PIN K1 [get_ports {vid_io_out_data_n[13]}]
set_property IOSTANDARD LVDS [get_ports {vid_io_out_data_n[13]}]
set_property DIFF_TERM TRUE [get_ports {vid_io_out_data_n[13]}]

set_property IOSTANDARD LVDS [get_ports {vid_io_out_data_p[14]}]
set_property DIFF_TERM TRUE [get_ports {vid_io_out_data_p[14]}]
set_property PACKAGE_PIN F4 [get_ports {vid_io_out_data_n[14]}]
set_property IOSTANDARD LVDS [get_ports {vid_io_out_data_n[14]}]
set_property DIFF_TERM TRUE [get_ports {vid_io_out_data_n[14]}]

set_property IOSTANDARD LVDS [get_ports {vid_io_out_data_p[15]}]
set_property DIFF_TERM TRUE [get_ports {vid_io_out_data_p[15]}]
set_property PACKAGE_PIN E3 [get_ports {vid_io_out_data_n[15]}]
set_property IOSTANDARD LVDS [get_ports {vid_io_out_data_n[15]}]
set_property DIFF_TERM TRUE [get_ports {vid_io_out_data_n[15]}]


set_property IOSTANDARD LVDS [get_ports vid_io_out_vsync_p]
set_property DIFF_TERM TRUE [get_ports vid_io_out_vsync_p]
set_property PACKAGE_PIN E1 [get_ports vid_io_out_vsync_n]
set_property IOSTANDARD LVDS [get_ports vid_io_out_vsync_n]
set_property DIFF_TERM TRUE [get_ports vid_io_out_vsync_n]


set_property IOSTANDARD LVDS [get_ports vid_io_out_hsync_p]
set_property DIFF_TERM TRUE [get_ports vid_io_out_hsync_p]
set_property PACKAGE_PIN C1 [get_ports vid_io_out_hsync_n]
set_property IOSTANDARD LVDS [get_ports vid_io_out_hsync_n]
set_property DIFF_TERM TRUE [get_ports vid_io_out_hsync_n]

set_property IOSTANDARD LVDS [get_ports vid_io_out_active_video_p]
set_property DIFF_TERM TRUE [get_ports vid_io_out_active_video_p]
set_property PACKAGE_PIN F2 [get_ports vid_io_out_active_video_n]
set_property IOSTANDARD LVDS [get_ports vid_io_out_active_video_n]
set_property DIFF_TERM TRUE [get_ports vid_io_out_active_video_n]



set_false_path -from [get_clocks clk_fpga_0] -to [get_clocks clk_out1_design_1_clk_wiz_0_0]
