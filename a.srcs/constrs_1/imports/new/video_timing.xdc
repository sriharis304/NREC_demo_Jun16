#############################################################################
## Copyright (c) 2012-2015 Xilinx, Inc.
## This design is confidential and proprietary of Xilinx, All Rights Reserved.
##############################################################################
##   ____  ____
##  /   /\/   /
## /___/  \  /   Vendor: Xilinx
## \   \   \/    Version: 1.2
##  \   \        Filename: top5x2_7to1_ddr_rx.xdc
##  /   /        Date Last Modified:  21JAN2015
## /___/   /\    Date Created: 30JUN2012
## \   \  / ##  \___\/\___ ##
##Device: 	7 Series
##Purpose:  	SDR receiver timing constraints for Vivado
##
##Reference:	XAPP585.pdf
##
##Revision History:
##    Rev 1.0 - First created (nicks)
##    Rev 1.2 - Updated format (brandond)
##############################################################################
##
##  Disclaimer:
##
##		This disclaimer is not a license and does not grant any rights to the materials
##              distributed herewith. Except as otherwise provided in a valid license issued to you
##              by Xilinx, and to the maximum extent permitted by applicable law:
##              (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND WITH ALL FAULTS,
##              AND XILINX HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY,
##              INCLUDING BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-INFRINGEMENT, OR
##              FITNESS FOR ANY PARTICULAR PURPOSE; and (2) Xilinx shall not be liable (whether in contract
##              or tort, including negligence, or under any other theory of liability) for any loss or damage
##              of any kind or nature related to, arising under or in connection with these materials,
##              including for any direct, or any indirect, special, incidental, or consequential loss
##              or damage (including loss of data, profits, goodwill, or any type of loss or damage suffered
##              as a result of any action brought by a third party) even if such damage or loss was
##              reasonably foreseeable or Xilinx had been advised of the possibility of the same.
##
##  Critical Applications:
##
##		Xilinx products are not designed or intended to be fail-safe, or for use in any application
##		requiring fail-safe performance, such as life-support or safety devices or systems,
##		Class III medical devices, nuclear facilities, applications related to the deployment of airbags,
##		or any other applications that could lead to death, personal injury, or severe property or
##		environmental damage (individually and collectively, "Critical Applications"). Customer assumes
##		the sole risk and liability of any use of Xilinx products in Critical Applications, subject only
##		to applicable laws and regulations governing limitations on product liability.
##
##  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE AT ALL TIMES.
##
##############################################################################
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
set_property PACKAGE_PIN AC24 [get_ports channel_x_clk_n]
set_property IOSTANDARD LVDS_25 [get_ports channel_x_clk_n]
set_property DIFF_TERM TRUE [get_ports channel_x_clk_n]

set_property IOSTANDARD LVDS_25 [get_ports {channel_x_data_p[0]}]
set_property DIFF_TERM TRUE [get_ports {channel_x_data_p[0]}]
set_property PACKAGE_PIN AA23 [get_ports {channel_x_data_n[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_x_data_n[0]}]
set_property DIFF_TERM TRUE [get_ports {channel_x_data_n[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_x_data_p[1]}]
set_property DIFF_TERM TRUE [get_ports {channel_x_data_p[1]}]
set_property PACKAGE_PIN AF23 [get_ports {channel_x_data_n[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_x_data_n[1]}]
set_property DIFF_TERM TRUE [get_ports {channel_x_data_n[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_x_data_p[2]}]
set_property DIFF_TERM TRUE [get_ports {channel_x_data_p[2]}]
set_property PACKAGE_PIN AF22 [get_ports {channel_x_data_n[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_x_data_n[2]}]
set_property DIFF_TERM TRUE [get_ports {channel_x_data_n[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_x_data_p[3]}]
set_property DIFF_TERM TRUE [get_ports {channel_x_data_p[3]}]
set_property PACKAGE_PIN AB22 [get_ports {channel_x_data_n[3]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_x_data_n[3]}]
set_property DIFF_TERM TRUE [get_ports {channel_x_data_n[3]}]

set_property IOSTANDARD LVDS_25 [get_ports channel_y_clk_p]
set_property DIFF_TERM TRUE [get_ports channel_y_clk_p]
set_property PACKAGE_PIN AC22 [get_ports channel_y_clk_n]
set_property IOSTANDARD LVDS_25 [get_ports channel_y_clk_n]
set_property DIFF_TERM TRUE [get_ports channel_y_clk_n]

set_property IOSTANDARD LVDS_25 [get_ports {channel_y_data_p[0]}]
set_property DIFF_TERM TRUE [get_ports {channel_y_data_p[0]}]
set_property PACKAGE_PIN AF20 [get_ports {channel_y_data_n[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_y_data_n[0]}]
set_property DIFF_TERM TRUE [get_ports {channel_y_data_n[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_y_data_p[1]}]
set_property DIFF_TERM TRUE [get_ports {channel_y_data_p[1]}]
set_property PACKAGE_PIN AF18 [get_ports {channel_y_data_n[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_y_data_n[1]}]
set_property DIFF_TERM TRUE [get_ports {channel_y_data_n[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_y_data_p[2]}]
set_property DIFF_TERM TRUE [get_ports {channel_y_data_p[2]}]
set_property PACKAGE_PIN AE21 [get_ports {channel_y_data_n[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_y_data_n[2]}]
set_property DIFF_TERM TRUE [get_ports {channel_y_data_n[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_y_data_p[3]}]
set_property DIFF_TERM TRUE [get_ports {channel_y_data_p[3]}]
set_property PACKAGE_PIN AD19 [get_ports {channel_y_data_n[3]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_y_data_n[3]}]
set_property DIFF_TERM TRUE [get_ports {channel_y_data_n[3]}]

set_property IOSTANDARD LVDS_25 [get_ports channel_z_clk_p]
set_property DIFF_TERM TRUE [get_ports channel_z_clk_p]
set_property PACKAGE_PIN AD24 [get_ports channel_z_clk_n]
set_property IOSTANDARD LVDS_25 [get_ports channel_z_clk_n]
set_property DIFF_TERM TRUE [get_ports channel_z_clk_n]

set_property IOSTANDARD LVDS_25 [get_ports {channel_z_data_p[0]}]
set_property DIFF_TERM TRUE [get_ports {channel_z_data_p[0]}]
set_property PACKAGE_PIN AB25 [get_ports {channel_z_data_n[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_z_data_n[0]}]
set_property DIFF_TERM TRUE [get_ports {channel_z_data_n[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_z_data_p[1]}]
set_property DIFF_TERM TRUE [get_ports {channel_z_data_p[1]}]
set_property PACKAGE_PIN AC26 [get_ports {channel_z_data_n[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_z_data_n[1]}]
set_property DIFF_TERM TRUE [get_ports {channel_z_data_n[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_z_data_p[2]}]
set_property DIFF_TERM TRUE [get_ports {channel_z_data_p[2]}]
set_property PACKAGE_PIN AB24 [get_ports {channel_z_data_n[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_z_data_n[2]}]
set_property DIFF_TERM TRUE [get_ports {channel_z_data_n[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {channel_z_data_p[3]}]
set_property DIFF_TERM TRUE [get_ports {channel_z_data_p[3]}]
set_property PACKAGE_PIN AD26 [get_ports {channel_z_data_n[3]}]
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


set_property MARK_DEBUG true [get_nets vid_io_out_hsync]
set_property MARK_DEBUG true [get_nets {vid_io_out_data[0]}]
set_property MARK_DEBUG true [get_nets {vid_io_out_data[6]}]
set_property MARK_DEBUG true [get_nets {vid_io_out_data[13]}]
set_property MARK_DEBUG true [get_nets {vid_io_out_data[2]}]
set_property MARK_DEBUG true [get_nets {vid_io_out_data[15]}]
set_property MARK_DEBUG true [get_nets {vid_io_out_data[8]}]
set_property MARK_DEBUG true [get_nets vid_io_out_active_video]
set_property MARK_DEBUG true [get_nets {vid_io_out_data[4]}]
set_property MARK_DEBUG true [get_nets {vid_io_out_data[10]}]
set_property MARK_DEBUG true [get_nets vid_io_out_vsync]
set_property MARK_DEBUG true [get_nets {vid_io_out_data[12]}]
set_property MARK_DEBUG true [get_nets {vid_io_out_data[14]}]
set_property MARK_DEBUG true [get_nets {vid_io_out_data[5]}]
set_property MARK_DEBUG true [get_nets {vid_io_out_data[11]}]
set_property MARK_DEBUG true [get_nets {vid_io_out_data[1]}]
set_property MARK_DEBUG true [get_nets {vid_io_out_data[3]}]
set_property MARK_DEBUG true [get_nets {vid_io_out_data[9]}]
set_property MARK_DEBUG true [get_nets {vid_io_out_data[7]}]
set_property MARK_DEBUG true [get_nets {design_1_i/homography_latest_0/inst/doLookUpInst/count_data[4]}]
set_property MARK_DEBUG true [get_nets {design_1_i/homography_latest_0/inst/doLookUpInst/count_data[6]}]
set_property MARK_DEBUG true [get_nets {design_1_i/homography_latest_0/inst/doLookUpInst/count_data[5]}]
set_property MARK_DEBUG true [get_nets {design_1_i/homography_latest_0/inst/doLookUpInst/count_data[3]}]
set_property MARK_DEBUG true [get_nets {design_1_i/homography_latest_0/inst/doLookUpInst/count_data[2]}]
set_property MARK_DEBUG true [get_nets {design_1_i/homography_latest_0/inst/doLookUpInst/count_data[1]}]
set_property MARK_DEBUG true [get_nets {design_1_i/homography_latest_0/inst/doLookUpInst/count_data[0]}]
set_property MARK_DEBUG true [get_nets {design_1_i/homography_latest_0/inst/doLookUpInst/addr_lut_offsets[4]}]
set_property MARK_DEBUG true [get_nets {design_1_i/homography_latest_0/inst/doLookUpInst/addr_lut_offsets[1]}]
set_property MARK_DEBUG true [get_nets {design_1_i/homography_latest_0/inst/doLookUpInst/addr_lut_offsets[5]}]
set_property MARK_DEBUG true [get_nets {design_1_i/homography_latest_0/inst/doLookUpInst/addr_lut_offsets[3]}]
set_property MARK_DEBUG true [get_nets {design_1_i/homography_latest_0/inst/doLookUpInst/addr_lut_offsets[2]}]
set_property MARK_DEBUG true [get_nets {design_1_i/homography_latest_0/inst/doLookUpInst/addr_lut_offsets[6]}]
set_property MARK_DEBUG true [get_nets {design_1_i/homography_latest_0/inst/doLookUpInst/addr_lut_offsets[7]}]
set_property MARK_DEBUG true [get_nets {design_1_i/homography_latest_0/inst/doLookUpInst/addr_lut_offsets[0]}]
set_property MARK_DEBUG true [get_nets {design_1_i/homography_latest_0/inst/doLookUpInst/addr_lut_offsets[8]}]
set_property MARK_DEBUG true [get_nets {design_1_i/homography_latest_0/inst/doLookUpInst/is_valid_reg[0]}]
set_property MARK_DEBUG true [get_nets {design_1_i/homography_latest_0/inst/doLookUpInst/is_valid_reg[1]}]
set_property MARK_DEBUG true [get_nets {design_1_i/homography_latest_0/inst/doLookUpInst/is_valid_reg[5]}]
set_property MARK_DEBUG true [get_nets {design_1_i/homography_latest_0/inst/doLookUpInst/is_valid_reg[4]}]
set_property MARK_DEBUG true [get_nets {design_1_i/homography_latest_0/inst/doLookUpInst/is_valid_reg[7]}]
set_property MARK_DEBUG true [get_nets {design_1_i/homography_latest_0/inst/doLookUpInst/is_valid_reg[6]}]
set_property MARK_DEBUG true [get_nets {design_1_i/homography_latest_0/inst/doLookUpInst/is_valid_reg[3]}]
set_property MARK_DEBUG true [get_nets {design_1_i/homography_latest_0/inst/doLookUpInst/is_valid_reg[2]}]
create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 2 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL true [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 2 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list design_1_i/clk_wiz_0_clk_out2]]
set_property port_width 16 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {vid_io_out_data[0]} {vid_io_out_data[1]} {vid_io_out_data[2]} {vid_io_out_data[3]} {vid_io_out_data[4]} {vid_io_out_data[5]} {vid_io_out_data[6]} {vid_io_out_data[7]} {vid_io_out_data[8]} {vid_io_out_data[9]} {vid_io_out_data[10]} {vid_io_out_data[11]} {vid_io_out_data[12]} {vid_io_out_data[13]} {vid_io_out_data[14]} {vid_io_out_data[15]}]]
connect_debug_port u_ila_0/probe1 [get_nets [list {design_1_i/homography_latest_0/inst/doLookUpInst/addr_lut_offsets[0]} {design_1_i/homography_latest_0/inst/doLookUpInst/addr_lut_offsets[1]} {design_1_i/homography_latest_0/inst/doLookUpInst/addr_lut_offsets[2]} {design_1_i/homography_latest_0/inst/doLookUpInst/addr_lut_offsets[3]} {design_1_i/homography_latest_0/inst/doLookUpInst/addr_lut_offsets[4]} {design_1_i/homography_latest_0/inst/doLookUpInst/addr_lut_offsets[5]} {design_1_i/homography_latest_0/inst/doLookUpInst/addr_lut_offsets[6]} {design_1_i/homography_latest_0/inst/doLookUpInst/addr_lut_offsets[7]} {design_1_i/homography_latest_0/inst/doLookUpInst/addr_lut_offsets[8]}]]
create_debug_port u_ila_0 probe
set_property port_width 7 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {design_1_i/homography_latest_0/inst/doLookUpInst/count_data[0]} {design_1_i/homography_latest_0/inst/doLookUpInst/count_data[1]} {design_1_i/homography_latest_0/inst/doLookUpInst/count_data[2]} {design_1_i/homography_latest_0/inst/doLookUpInst/count_data[3]} {design_1_i/homography_latest_0/inst/doLookUpInst/count_data[4]} {design_1_i/homography_latest_0/inst/doLookUpInst/count_data[5]} {design_1_i/homography_latest_0/inst/doLookUpInst/count_data[6]}]]
create_debug_port u_ila_0 probe
set_property port_width 8 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {design_1_i/homography_latest_0/inst/doLookUpInst/is_valid_reg[7]} {design_1_i/homography_latest_0/inst/doLookUpInst/is_valid_reg[6]} {design_1_i/homography_latest_0/inst/doLookUpInst/is_valid_reg[5]} {design_1_i/homography_latest_0/inst/doLookUpInst/is_valid_reg[4]} {design_1_i/homography_latest_0/inst/doLookUpInst/is_valid_reg[3]} {design_1_i/homography_latest_0/inst/doLookUpInst/is_valid_reg[2]} {design_1_i/homography_latest_0/inst/doLookUpInst/is_valid_reg[1]} {design_1_i/homography_latest_0/inst/doLookUpInst/is_valid_reg[0]}]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list vid_io_out_active_video]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list vid_io_out_hsync]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list vid_io_out_vsync]]

set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets u_ila_0_clk_wiz_0_clk_out2]
