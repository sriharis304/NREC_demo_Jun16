
################################################################
# This is a generated script based on design: design_1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2015.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   puts "ERROR: This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_1_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7z030fbg676-1

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}



# CHANGE DESIGN NAME HERE
set design_name design_1

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "ERROR: Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      puts "INFO: Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   puts "INFO: Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   puts "INFO: Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   puts "INFO: Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

puts "INFO: Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   puts $errMsg
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR ]
  set FIXED_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]
  set channel_x [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:channel_link_rtl:1.0 channel_x ]
  set channel_y [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:channel_link_rtl:1.0 channel_y ]
  set channel_z [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:channel_link_rtl:1.0 channel_z ]
  set diff_clock [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 diff_clock ]

  # Create ports
  set pixel_clk_out [ create_bd_port -dir O -type clk pixel_clk_out ]
  set rst_n [ create_bd_port -dir I -type rst rst_n ]
  set vid_io_out_active_video [ create_bd_port -dir O vid_io_out_active_video ]
  set vid_io_out_data [ create_bd_port -dir O -from 15 -to 0 vid_io_out_data ]
  set vid_io_out_hsync [ create_bd_port -dir O -from 0 -to 0 -type data vid_io_out_hsync ]
  set vid_io_out_vsync [ create_bd_port -dir O -from 0 -to 0 -type data vid_io_out_vsync ]

  # Create instance: address_gen_param_0, and set properties
  set address_gen_param_0 [ create_bd_cell -type ip -vlnv Srihari:user:address_gen_param:1.0 address_gen_param_0 ]
  set_property -dict [ list CONFIG.START_LINE_FOR_HOMOGRAPHY {19}  ] $address_gen_param_0

  # Create instance: axi_bram_ctrl_0, and set properties
  set axi_bram_ctrl_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.0 axi_bram_ctrl_0 ]
  set_property -dict [ list CONFIG.SINGLE_PORT_BRAM {1}  ] $axi_bram_ctrl_0

  # Create instance: axi_bram_ctrl_1, and set properties
  set axi_bram_ctrl_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.0 axi_bram_ctrl_1 ]
  set_property -dict [ list CONFIG.SINGLE_PORT_BRAM {1}  ] $axi_bram_ctrl_1

  # Create instance: axi_gpio_0, and set properties
  set axi_gpio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_0 ]
  set_property -dict [ list CONFIG.C_ALL_OUTPUTS {1} CONFIG.C_GPIO_WIDTH {4}  ] $axi_gpio_0

  # Create instance: axi_gpio_1, and set properties
  set axi_gpio_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_1 ]
  set_property -dict [ list CONFIG.C_ALL_OUTPUTS {1} CONFIG.C_DOUT_DEFAULT {0x000000F0} CONFIG.C_GPIO_WIDTH {8}  ] $axi_gpio_1

  # Create instance: axi_gpio_2, and set properties
  set axi_gpio_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_2 ]
  set_property -dict [ list CONFIG.C_ALL_OUTPUTS {1} CONFIG.C_ALL_OUTPUTS_2 {1} CONFIG.C_DOUT_DEFAULT {0x00000000} CONFIG.C_DOUT_DEFAULT_2 {0x00000008} CONFIG.C_GPIO2_WIDTH {4} CONFIG.C_GPIO_WIDTH {4} CONFIG.C_IS_DUAL {1}  ] $axi_gpio_2

  # Create instance: axi_mem_intercon, and set properties
  set axi_mem_intercon [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_mem_intercon ]
  set_property -dict [ list CONFIG.NUM_MI {5}  ] $axi_mem_intercon

  # Create instance: axis_dwidth_converter_0, and set properties
  set axis_dwidth_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0 ]
  set_property -dict [ list CONFIG.HAS_MI_TKEEP {1} CONFIG.HAS_TLAST {1} CONFIG.M_TDATA_NUM_BYTES {8} CONFIG.S_TDATA_NUM_BYTES {10} CONFIG.TUSER_BITS_PER_BYTE {1}  ] $axis_dwidth_converter_0

  # Create instance: blk_mem_gen_0, and set properties
  set blk_mem_gen_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.2 blk_mem_gen_0 ]
  set_property -dict [ list CONFIG.Enable_B {Use_ENB_Pin} CONFIG.Memory_Type {True_Dual_Port_RAM} CONFIG.Port_B_Clock {100} CONFIG.Port_B_Enable_Rate {100} CONFIG.Port_B_Write_Rate {50} CONFIG.Use_RSTB_Pin {true}  ] $blk_mem_gen_0

  # Create instance: blk_mem_gen_1, and set properties
  set blk_mem_gen_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.2 blk_mem_gen_1 ]
  set_property -dict [ list CONFIG.Enable_32bit_Address {false} CONFIG.Enable_B {Use_ENB_Pin} CONFIG.Memory_Type {Simple_Dual_Port_RAM} CONFIG.Operating_Mode_A {NO_CHANGE} CONFIG.Port_B_Clock {100} CONFIG.Port_B_Enable_Rate {100} CONFIG.Read_Width_B {8} CONFIG.Register_PortB_Output_of_Memory_Primitives {false} CONFIG.Use_Byte_Write_Enable {false} CONFIG.Write_Width_A {8} CONFIG.Write_Width_B {8} CONFIG.use_bram_block {Stand_Alone}  ] $blk_mem_gen_1

  # Create instance: blk_mem_gen_2, and set properties
  set blk_mem_gen_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.2 blk_mem_gen_2 ]
  set_property -dict [ list CONFIG.Enable_B {Use_ENB_Pin} CONFIG.Memory_Type {True_Dual_Port_RAM} CONFIG.Port_B_Clock {100} CONFIG.Port_B_Enable_Rate {100} CONFIG.Port_B_Write_Rate {50} CONFIG.Use_RSTB_Pin {true}  ] $blk_mem_gen_2

  # Create instance: bram_mask_1, and set properties
  set bram_mask_1 [ create_bd_cell -type ip -vlnv user.org:user:bram_mask:1.0 bram_mask_1 ]

  # Create instance: bus_doubler_0, and set properties
  set bus_doubler_0 [ create_bd_cell -type ip -vlnv Srihari:user:bus_doubler:1.0 bus_doubler_0 ]

  # Create instance: c_shift_ram_0, and set properties
  set c_shift_ram_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_shift_ram:12.0 c_shift_ram_0 ]
  set_property -dict [ list CONFIG.AsyncInitVal {0} CONFIG.DefaultData {0} CONFIG.Depth {2} CONFIG.Width {1}  ] $c_shift_ram_0

  # Create instance: c_shift_ram_1, and set properties
  set c_shift_ram_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_shift_ram:12.0 c_shift_ram_1 ]
  set_property -dict [ list CONFIG.AsyncInitVal {0} CONFIG.DefaultData {0} CONFIG.Depth {250} CONFIG.Width {1}  ] $c_shift_ram_1

  # Create instance: cameralink_to_axis_1, and set properties
  set cameralink_to_axis_1 [ create_bd_cell -type ip -vlnv Xilinx.com:user:cameralink_to_axis:1.0 cameralink_to_axis_1 ]

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.1 clk_wiz_0 ]
  set_property -dict [ list CONFIG.CLKOUT1_JITTER {214.261} CONFIG.CLKOUT1_PHASE_ERROR {317.963} CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {40.625} CONFIG.CLKOUT2_JITTER {196.072} CONFIG.CLKOUT2_PHASE_ERROR {317.963} CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {79} CONFIG.CLKOUT2_USED {true} CONFIG.NUM_OUT_CLKS {2} CONFIG.PRIMITIVE {PLL} CONFIG.RESET_TYPE {ACTIVE_LOW}  ] $clk_wiz_0

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:12.0 fifo_generator_0 ]
  set_property -dict [ list CONFIG.Fifo_Implementation {Independent_Clocks_Block_RAM} CONFIG.Input_Data_Width {1} CONFIG.Input_Depth {16} CONFIG.Output_Data_Width {1}  ] $fifo_generator_0

  # Create instance: hls_threshold_1, and set properties
  set hls_threshold_1 [ create_bd_cell -type ip -vlnv Xilinx:user:hls_threshold:1.0 hls_threshold_1 ]

  # Create instance: homography_latest_0, and set properties
  set homography_latest_0 [ create_bd_cell -type ip -vlnv Srihari:user:homography_latest:1.0 homography_latest_0 ]

  # Create instance: line_buf_0, and set properties
  set line_buf_0 [ create_bd_cell -type ip -vlnv Srihari:user:line_buf:1.0 line_buf_0 ]

  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0 ]

  # Create instance: proc_sys_reset_1, and set properties
  set proc_sys_reset_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_1 ]

  # Create instance: processing_system7_0, and set properties
  set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0 ]
  set_property -dict [ list CONFIG.PCW_APU_PERIPHERAL_FREQMHZ {666} \
CONFIG.PCW_ENET0_ENET0_IO {MIO 16 .. 27} CONFIG.PCW_ENET0_GRP_MDIO_ENABLE {1} \
CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {1} CONFIG.PCW_ENET_RESET_ENABLE {0} \
CONFIG.PCW_EN_CLK1_PORT {1} CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100} \
CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {100} CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1} \
CONFIG.PCW_I2C0_PERIPHERAL_ENABLE {1} CONFIG.PCW_I2C_RESET_ENABLE {0} \
CONFIG.PCW_IRQ_F2P_INTR {1} CONFIG.PCW_MIO_16_PULLUP {disabled} \
CONFIG.PCW_MIO_16_SLEW {fast} CONFIG.PCW_MIO_17_PULLUP {disabled} \
CONFIG.PCW_MIO_17_SLEW {fast} CONFIG.PCW_MIO_18_PULLUP {disabled} \
CONFIG.PCW_MIO_18_SLEW {fast} CONFIG.PCW_MIO_19_PULLUP {disabled} \
CONFIG.PCW_MIO_19_SLEW {fast} CONFIG.PCW_MIO_20_PULLUP {disabled} \
CONFIG.PCW_MIO_20_SLEW {fast} CONFIG.PCW_MIO_21_PULLUP {disabled} \
CONFIG.PCW_MIO_21_SLEW {fast} CONFIG.PCW_MIO_22_PULLUP {disabled} \
CONFIG.PCW_MIO_22_SLEW {fast} CONFIG.PCW_MIO_23_PULLUP {disabled} \
CONFIG.PCW_MIO_23_SLEW {fast} CONFIG.PCW_MIO_24_PULLUP {disabled} \
CONFIG.PCW_MIO_24_SLEW {fast} CONFIG.PCW_MIO_25_PULLUP {disabled} \
CONFIG.PCW_MIO_25_SLEW {fast} CONFIG.PCW_MIO_26_PULLUP {disabled} \
CONFIG.PCW_MIO_26_SLEW {fast} CONFIG.PCW_MIO_27_PULLUP {disabled} \
CONFIG.PCW_MIO_27_SLEW {fast} CONFIG.PCW_MIO_40_SLEW {fast} \
CONFIG.PCW_MIO_41_SLEW {fast} CONFIG.PCW_MIO_42_SLEW {fast} \
CONFIG.PCW_MIO_43_SLEW {fast} CONFIG.PCW_MIO_44_SLEW {fast} \
CONFIG.PCW_MIO_45_SLEW {fast} CONFIG.PCW_PRESET_BANK0_VOLTAGE {LVCMOS 2.5V} \
CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 2.5V} CONFIG.PCW_QSPI_GRP_FBCLK_ENABLE {1} \
CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {1} CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_SDIO_PERIPHERAL_FREQMHZ {25} CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_UART0_PERIPHERAL_ENABLE {1} CONFIG.PCW_UART0_UART0_IO {MIO 46 .. 47} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY0 {0.285} CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY1 {0.272} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY2 {0.255} CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY3 {0.243} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_0 {-0.032} CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_2 {0.043} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_3 {0.061} CONFIG.PCW_UIPARAM_DDR_FREQ_MHZ {533} \
CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41K256M16 RE-125} CONFIG.PCW_UIPARAM_DDR_TRAIN_DATA_EYE {1} \
CONFIG.PCW_UIPARAM_DDR_TRAIN_READ_GATE {1} CONFIG.PCW_UIPARAM_DDR_TRAIN_WRITE_LEVEL {1} \
CONFIG.PCW_USB0_PERIPHERAL_ENABLE {1} CONFIG.PCW_USB_RESET_ENABLE {0} \
CONFIG.PCW_USE_FABRIC_INTERRUPT {1} CONFIG.PCW_USE_M_AXI_GP1 {0} \
CONFIG.PCW_WDT_PERIPHERAL_ENABLE {1}  ] $processing_system7_0

  # Create instance: rst_clk_wiz_1_100M, and set properties
  set rst_clk_wiz_1_100M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_clk_wiz_1_100M ]

  # Create instance: util_reduced_logic_0, and set properties
  set util_reduced_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 util_reduced_logic_0 ]

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property -dict [ list CONFIG.NUM_PORTS {10}  ] $xlconcat_0

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list CONFIG.CONST_VAL {8} CONFIG.CONST_WIDTH {4}  ] $xlconstant_0

  # Create instance: xlconstant_1, and set properties
  set xlconstant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1 ]

  # Create interface connections
  connect_bd_intf_net -intf_net axi_bram_ctrl_0_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTA] [get_bd_intf_pins blk_mem_gen_0/BRAM_PORTA]
  connect_bd_intf_net -intf_net axi_bram_ctrl_1_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_1/BRAM_PORTA] [get_bd_intf_pins blk_mem_gen_2/BRAM_PORTA]
  connect_bd_intf_net -intf_net axi_mem_intercon_M00_AXI [get_bd_intf_pins axi_bram_ctrl_0/S_AXI] [get_bd_intf_pins axi_mem_intercon/M00_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M01_AXI [get_bd_intf_pins axi_bram_ctrl_1/S_AXI] [get_bd_intf_pins axi_mem_intercon/M01_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M02_AXI [get_bd_intf_pins axi_gpio_0/S_AXI] [get_bd_intf_pins axi_mem_intercon/M02_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M03_AXI [get_bd_intf_pins axi_gpio_1/S_AXI] [get_bd_intf_pins axi_mem_intercon/M03_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M04_AXI [get_bd_intf_pins axi_gpio_2/S_AXI] [get_bd_intf_pins axi_mem_intercon/M04_AXI]
  connect_bd_intf_net -intf_net bram_mask_1_bram_0 [get_bd_intf_pins blk_mem_gen_0/BRAM_PORTB] [get_bd_intf_pins bram_mask_1/bram_0]
  connect_bd_intf_net -intf_net bram_mask_1_bram_1 [get_bd_intf_pins blk_mem_gen_2/BRAM_PORTB] [get_bd_intf_pins bram_mask_1/bram_1]
  connect_bd_intf_net -intf_net channel_x_1 [get_bd_intf_ports channel_x] [get_bd_intf_pins cameralink_to_axis_1/channel_x]
  connect_bd_intf_net -intf_net channel_y_1 [get_bd_intf_ports channel_y] [get_bd_intf_pins cameralink_to_axis_1/channel_y]
  connect_bd_intf_net -intf_net channel_z_1 [get_bd_intf_ports channel_z] [get_bd_intf_pins cameralink_to_axis_1/channel_z]
  connect_bd_intf_net -intf_net diff_clock_1 [get_bd_intf_ports diff_clock] [get_bd_intf_pins cameralink_to_axis_1/refclk_in]
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_0/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_0/FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins axi_mem_intercon/S00_AXI] [get_bd_intf_pins processing_system7_0/M_AXI_GP0]

  # Create port connections
  connect_bd_net -net address_gen_param_0_bram_addr_in [get_bd_pins address_gen_param_0/bram_addr_in] [get_bd_pins blk_mem_gen_1/addra]
  connect_bd_net -net address_gen_param_0_data_out [get_bd_pins address_gen_param_0/data_out] [get_bd_pins blk_mem_gen_1/dina]
  connect_bd_net -net address_gen_param_0_sof_to_homography [get_bd_pins address_gen_param_0/sof_to_homography] [get_bd_pins fifo_generator_0/din]
  connect_bd_net -net address_gen_param_0_write_enable [get_bd_pins address_gen_param_0/write_enable] [get_bd_pins blk_mem_gen_1/wea]
  connect_bd_net -net axi_gpio_0_gpio_io_o [get_bd_pins axi_gpio_0/gpio_io_o] [get_bd_pins bram_mask_1/bright_val1]
  connect_bd_net -net axi_gpio_1_gpio_io_o [get_bd_pins axi_gpio_1/gpio_io_o] [get_bd_pins hls_threshold_1/ap_const_lv8_64]
  connect_bd_net -net axi_gpio_2_gpio2_io_o [get_bd_pins address_gen_param_0/BLANKING_POSITION] [get_bd_pins axi_gpio_2/gpio2_io_o]
  connect_bd_net -net axi_gpio_2_gpio_io_o [get_bd_pins address_gen_param_0/BLANKING_WIDTH] [get_bd_pins axi_gpio_2/gpio_io_o]
  connect_bd_net -net axis_dwidth_converter_0_m_axis_tdata [get_bd_pins axis_dwidth_converter_0/m_axis_tdata] [get_bd_pins hls_threshold_1/src_TDATA]
  connect_bd_net -net axis_dwidth_converter_0_m_axis_tkeep [get_bd_pins axis_dwidth_converter_0/m_axis_tkeep] [get_bd_pins hls_threshold_1/src_TKEEP]
  connect_bd_net -net axis_dwidth_converter_0_m_axis_tlast [get_bd_pins axis_dwidth_converter_0/m_axis_tlast] [get_bd_pins hls_threshold_1/src_TLAST]
  connect_bd_net -net axis_dwidth_converter_0_m_axis_tuser [get_bd_pins axis_dwidth_converter_0/m_axis_tuser] [get_bd_pins util_reduced_logic_0/Op1]
  connect_bd_net -net axis_dwidth_converter_0_m_axis_tvalid [get_bd_pins axis_dwidth_converter_0/m_axis_tvalid] [get_bd_pins hls_threshold_1/src_TVALID]
  connect_bd_net -net axis_dwidth_converter_0_s_axis_tready [get_bd_pins axis_dwidth_converter_0/s_axis_tready] [get_bd_pins cameralink_to_axis_1/m_axis_video_tready]
  connect_bd_net -net blk_mem_gen_1_doutb [get_bd_pins blk_mem_gen_1/doutb] [get_bd_pins homography_latest_0/dout_image_in_b]
  connect_bd_net -net bram_mask_1_v_m_tdata [get_bd_ports vid_io_out_data] [get_bd_pins bram_mask_1/v_m_tdata]
  connect_bd_net -net bram_mask_1_v_m_tvalid [get_bd_ports vid_io_out_active_video] [get_bd_pins bram_mask_1/v_m_tvalid]
  connect_bd_net -net bus_doubler_0_out_clk [get_bd_ports pixel_clk_out] [get_bd_pins bram_mask_1/clk] [get_bd_pins bus_doubler_0/out_clk] [get_bd_pins c_shift_ram_0/CLK] [get_bd_pins c_shift_ram_1/CLK] [get_bd_pins line_buf_0/clk]
  connect_bd_net -net bus_doubler_0_out_data [get_bd_pins bus_doubler_0/out_data] [get_bd_pins line_buf_0/in_data]
  connect_bd_net -net bus_doubler_0_out_den [get_bd_pins bus_doubler_0/out_den] [get_bd_pins line_buf_0/in_tvalid]
  connect_bd_net -net bus_doubler_0_out_hsync [get_bd_pins bus_doubler_0/out_hsync] [get_bd_pins line_buf_0/in_hsync]
  connect_bd_net -net bus_doubler_0_out_vsync [get_bd_pins bus_doubler_0/out_vsync] [get_bd_pins line_buf_0/in_vsync]
  connect_bd_net -net c_shift_ram_0_Q [get_bd_ports vid_io_out_hsync] [get_bd_pins c_shift_ram_0/Q]
  connect_bd_net -net c_shift_ram_1_Q [get_bd_ports vid_io_out_vsync] [get_bd_pins c_shift_ram_1/Q]
  connect_bd_net -net cameralink_to_axis_1_m_axis_video_tdata [get_bd_pins axis_dwidth_converter_0/s_axis_tdata] [get_bd_pins cameralink_to_axis_1/m_axis_video_tdata]
  connect_bd_net -net cameralink_to_axis_1_m_axis_video_tlast [get_bd_pins axis_dwidth_converter_0/s_axis_tlast] [get_bd_pins cameralink_to_axis_1/m_axis_video_tlast]
  connect_bd_net -net cameralink_to_axis_1_m_axis_video_tuser [get_bd_pins cameralink_to_axis_1/m_axis_video_tuser] [get_bd_pins xlconcat_0/In0] [get_bd_pins xlconcat_0/In1] [get_bd_pins xlconcat_0/In2] [get_bd_pins xlconcat_0/In3] [get_bd_pins xlconcat_0/In4] [get_bd_pins xlconcat_0/In5] [get_bd_pins xlconcat_0/In6] [get_bd_pins xlconcat_0/In7] [get_bd_pins xlconcat_0/In8] [get_bd_pins xlconcat_0/In9]
  connect_bd_net -net cameralink_to_axis_1_m_axis_video_tvalid [get_bd_pins axis_dwidth_converter_0/s_axis_tvalid] [get_bd_pins cameralink_to_axis_1/m_axis_video_tvalid]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins address_gen_param_0/clk] [get_bd_pins axis_dwidth_converter_0/aclk] [get_bd_pins blk_mem_gen_1/clka] [get_bd_pins cameralink_to_axis_1/aclk] [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins fifo_generator_0/wr_clk] [get_bd_pins hls_threshold_1/ap_clk] [get_bd_pins proc_sys_reset_0/slowest_sync_clk]
  connect_bd_net -net clk_wiz_0_clk_out2 [get_bd_pins blk_mem_gen_1/clkb] [get_bd_pins bus_doubler_0/in_clk] [get_bd_pins clk_wiz_0/clk_out2] [get_bd_pins fifo_generator_0/rd_clk] [get_bd_pins homography_latest_0/clk] [get_bd_pins proc_sys_reset_1/slowest_sync_clk]
  connect_bd_net -net clk_wiz_0_locked [get_bd_pins cameralink_to_axis_1/aclken] [get_bd_pins cameralink_to_axis_1/axis_enable] [get_bd_pins clk_wiz_0/locked] [get_bd_pins proc_sys_reset_0/dcm_locked] [get_bd_pins proc_sys_reset_1/dcm_locked]
  connect_bd_net -net fifo_generator_0_dout [get_bd_pins fifo_generator_0/dout] [get_bd_pins homography_latest_0/scan_start]
  connect_bd_net -net hls_threshold_1_dst_TDATA [get_bd_pins address_gen_param_0/data_in] [get_bd_pins hls_threshold_1/dst_TDATA]
  connect_bd_net -net hls_threshold_1_dst_TUSER [get_bd_pins address_gen_param_0/sof] [get_bd_pins hls_threshold_1/dst_TUSER]
  connect_bd_net -net hls_threshold_1_dst_TVALID [get_bd_pins address_gen_param_0/tvalid] [get_bd_pins hls_threshold_1/dst_TVALID]
  connect_bd_net -net hls_threshold_1_src_TREADY [get_bd_pins axis_dwidth_converter_0/m_axis_tready] [get_bd_pins hls_threshold_1/src_TREADY]
  connect_bd_net -net homography_latest_0_addr_image_in_b [get_bd_pins blk_mem_gen_1/addrb] [get_bd_pins homography_latest_0/addr_image_in_b]
  connect_bd_net -net homography_latest_0_data_to_dmd [get_bd_pins bus_doubler_0/in_data] [get_bd_pins homography_latest_0/data_to_dmd]
  connect_bd_net -net homography_latest_0_en_image_in_b [get_bd_pins blk_mem_gen_1/enb] [get_bd_pins homography_latest_0/en_image_in_b]
  connect_bd_net -net homography_latest_0_hsync [get_bd_pins bus_doubler_0/in_hsync] [get_bd_pins homography_latest_0/hsync]
  connect_bd_net -net homography_latest_0_tvalid [get_bd_pins bus_doubler_0/in_den] [get_bd_pins homography_latest_0/tvalid]
  connect_bd_net -net homography_latest_0_vsync [get_bd_pins bus_doubler_0/in_vsync] [get_bd_pins homography_latest_0/vsync]
  connect_bd_net -net line_buf_0_out_data [get_bd_pins bram_mask_1/v_s_tdata] [get_bd_pins line_buf_0/out_data]
  connect_bd_net -net line_buf_0_out_hsync [get_bd_pins c_shift_ram_0/D] [get_bd_pins line_buf_0/out_hsync]
  connect_bd_net -net line_buf_0_out_tvalid [get_bd_pins bram_mask_1/v_s_tvalid] [get_bd_pins line_buf_0/out_tvalid]
  connect_bd_net -net line_buf_0_out_vsync [get_bd_pins bram_mask_1/v_s_tuser] [get_bd_pins c_shift_ram_1/D] [get_bd_pins line_buf_0/out_vsync]
  connect_bd_net -net proc_sys_reset_0_peripheral_aresetn [get_bd_pins address_gen_param_0/resetn] [get_bd_pins axis_dwidth_converter_0/aresetn] [get_bd_pins blk_mem_gen_1/ena] [get_bd_pins cameralink_to_axis_1/aresetn] [get_bd_pins cameralink_to_axis_1/rst_n] [get_bd_pins fifo_generator_0/wr_en] [get_bd_pins hls_threshold_1/ap_rst_n] [get_bd_pins proc_sys_reset_0/peripheral_aresetn]
  connect_bd_net -net proc_sys_reset_0_peripheral_reset [get_bd_pins fifo_generator_0/rst] [get_bd_pins proc_sys_reset_0/peripheral_reset]
  connect_bd_net -net proc_sys_reset_1_peripheral_aresetn [get_bd_pins bus_doubler_0/rst_n] [get_bd_pins fifo_generator_0/rd_en] [get_bd_pins homography_latest_0/resetn] [get_bd_pins line_buf_0/rst_n] [get_bd_pins proc_sys_reset_1/peripheral_aresetn]
  connect_bd_net -net proc_sys_reset_1_peripheral_reset [get_bd_pins bram_mask_1/rst] [get_bd_pins proc_sys_reset_1/peripheral_reset]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins axi_bram_ctrl_0/s_axi_aclk] [get_bd_pins axi_bram_ctrl_1/s_axi_aclk] [get_bd_pins axi_gpio_0/s_axi_aclk] [get_bd_pins axi_gpio_1/s_axi_aclk] [get_bd_pins axi_gpio_2/s_axi_aclk] [get_bd_pins axi_mem_intercon/ACLK] [get_bd_pins axi_mem_intercon/M00_ACLK] [get_bd_pins axi_mem_intercon/M01_ACLK] [get_bd_pins axi_mem_intercon/M02_ACLK] [get_bd_pins axi_mem_intercon/M03_ACLK] [get_bd_pins axi_mem_intercon/M04_ACLK] [get_bd_pins axi_mem_intercon/S00_ACLK] [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins rst_clk_wiz_1_100M/slowest_sync_clk]
  connect_bd_net -net processing_system7_0_FCLK_CLK1 [get_bd_pins clk_wiz_0/clk_in1] [get_bd_pins processing_system7_0/FCLK_CLK1]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins rst_clk_wiz_1_100M/ext_reset_in]
  connect_bd_net -net rst_clk_wiz_1_100M_interconnect_aresetn [get_bd_pins axi_mem_intercon/ARESETN] [get_bd_pins rst_clk_wiz_1_100M/interconnect_aresetn]
  connect_bd_net -net rst_clk_wiz_1_100M_peripheral_aresetn [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn] [get_bd_pins axi_bram_ctrl_1/s_axi_aresetn] [get_bd_pins axi_gpio_0/s_axi_aresetn] [get_bd_pins axi_gpio_1/s_axi_aresetn] [get_bd_pins axi_gpio_2/s_axi_aresetn] [get_bd_pins axi_mem_intercon/M00_ARESETN] [get_bd_pins axi_mem_intercon/M01_ARESETN] [get_bd_pins axi_mem_intercon/M02_ARESETN] [get_bd_pins axi_mem_intercon/M03_ARESETN] [get_bd_pins axi_mem_intercon/M04_ARESETN] [get_bd_pins axi_mem_intercon/S00_ARESETN] [get_bd_pins rst_clk_wiz_1_100M/peripheral_aresetn]
  connect_bd_net -net rst_in_1 [get_bd_ports rst_n] [get_bd_pins clk_wiz_0/resetn] [get_bd_pins proc_sys_reset_0/ext_reset_in] [get_bd_pins proc_sys_reset_1/ext_reset_in]
  connect_bd_net -net util_reduced_logic_0_Res [get_bd_pins hls_threshold_1/src_TUSER] [get_bd_pins util_reduced_logic_0/Res]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins axis_dwidth_converter_0/s_axis_tuser] [get_bd_pins xlconcat_0/dout]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins bram_mask_1/bright_val0] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins bram_mask_1/v_m_tready] [get_bd_pins hls_threshold_1/dst_TREADY] [get_bd_pins xlconstant_1/dout]

  # Create address segments
  create_bd_addr_seg -range 0x20000 -offset 0x40000000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_bram_ctrl_0/S_AXI/Mem0] SEG_axi_bram_ctrl_0_Mem0
  create_bd_addr_seg -range 0x20000 -offset 0x42000000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_bram_ctrl_1/S_AXI/Mem0] SEG_axi_bram_ctrl_1_Mem0
  create_bd_addr_seg -range 0x10000 -offset 0x41200000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_gpio_0/S_AXI/Reg] SEG_axi_gpio_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x41210000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_gpio_1/S_AXI/Reg] SEG_axi_gpio_1_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x41220000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_gpio_2/S_AXI/Reg] SEG_axi_gpio_2_Reg
  

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


