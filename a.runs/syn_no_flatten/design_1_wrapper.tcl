# 
# Synthesis run script generated by Vivado
# 

debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7z030fbg676-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.cache/wt [current_project]
set_property parent.project_path /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_repo_paths /home/ilim/Headlight_COdes/arm_core_load_single_channle/repo [current_project]
add_files /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/design_1.bd
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_rst_clk_wiz_1_100M_0/design_1_rst_clk_wiz_1_100M_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_rst_clk_wiz_1_100M_0/design_1_rst_clk_wiz_1_100M_0.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_rst_clk_wiz_1_100M_0/design_1_rst_clk_wiz_1_100M_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0/design_1_processing_system7_0_0.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_axi_bram_ctrl_0_0/design_1_axi_bram_ctrl_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_blk_mem_gen_0_0/design_1_blk_mem_gen_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_axis_dwidth_converter_0_0/design_1_axis_dwidth_converter_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_blk_mem_gen_1_0/design_1_blk_mem_gen_1_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_fifo_generator_0_0/design_1_fifo_generator_0_0/design_1_fifo_generator_0_0_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_fifo_generator_0_0/design_1_fifo_generator_0_0/design_1_fifo_generator_0_0.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_fifo_generator_0_0/design_1_fifo_generator_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_bus_doubler_0_0/hari_bdbl/hari_bdbl.srcs/sources_1/bd/dw_conv/dw_conv_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_bus_doubler_0_0/hari_bdbl/hari_bdbl.srcs/sources_1/bd/dw_conv/ip/dw_conv_axis_dwidth_converter_0_0/dw_conv_axis_dwidth_converter_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_bus_doubler_0_0/hari_bdbl/hari_bdbl.srcs/sources_1/bd/dw_conv/ip/dw_conv_axis_dwidth_converter_0_0/dw_conv_axis_dwidth_converter_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_c_shift_ram_0_0/design_1_c_shift_ram_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_c_shift_ram_1_0/design_1_c_shift_ram_1_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_proc_sys_reset_0_0/design_1_proc_sys_reset_0_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_proc_sys_reset_0_0/design_1_proc_sys_reset_0_0.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_proc_sys_reset_0_0/design_1_proc_sys_reset_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_clk_wiz_0_0/design_1_clk_wiz_0_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_clk_wiz_0_0/design_1_clk_wiz_0_0.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_clk_wiz_0_0/design_1_clk_wiz_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_proc_sys_reset_1_0/design_1_proc_sys_reset_1_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_proc_sys_reset_1_0/design_1_proc_sys_reset_1_0.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_proc_sys_reset_1_0/design_1_proc_sys_reset_1_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_cameralink_to_axis_1_0/ip/v_vid_in_axi4s_0/v_vid_in_axi4s_0_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_cameralink_to_axis_1_0/ip/v_vid_in_axi4s_0/v_vid_in_axi4s_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_blk_mem_gen_0_1/design_1_blk_mem_gen_0_1_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_axi_bram_ctrl_1_0/design_1_axi_bram_ctrl_1_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_0_0/design_1_axi_gpio_0_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_0_0/design_1_axi_gpio_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_0_0/design_1_axi_gpio_0_0.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_1_0/design_1_axi_gpio_1_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_1_0/design_1_axi_gpio_1_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_1_0/design_1_axi_gpio_1_0.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_xbar_0/design_1_xbar_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_2_0/design_1_axi_gpio_2_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_2_0/design_1_axi_gpio_2_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_2_0/design_1_axi_gpio_2_0.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_auto_pc_0/design_1_auto_pc_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_auto_pc_1/design_1_auto_pc_1_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_auto_pc_2/design_1_auto_pc_2_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/ip/design_1_auto_pc_3/design_1_auto_pc_3_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/design_1_ooc.xdc]
set_property is_locked true [get_files /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/bd/design_1/design_1.bd]

read_verilog -library xil_defaultlib /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/sources_1/imports/hdl/design_1_wrapper.v
read_xdc /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/constrs_1/imports/new/Cameralink_deca.xdc
set_property used_in_implementation false [get_files /home/ilim/Headlight_COdes/arm_core_load_single_channle/a.srcs/constrs_1/imports/new/Cameralink_deca.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
synth_design -top design_1_wrapper -part xc7z030fbg676-1 -flatten_hierarchy none
write_checkpoint -noxdef design_1_wrapper.dcp
catch { report_utilization -file design_1_wrapper_utilization_synth.rpt -pb design_1_wrapper_utilization_synth.pb }
