# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "HSYNC_COUNT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "VSYNC_COUNT" -parent ${Page_0}


}

proc update_PARAM_VALUE.HSYNC_COUNT { PARAM_VALUE.HSYNC_COUNT } {
	# Procedure called to update HSYNC_COUNT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.HSYNC_COUNT { PARAM_VALUE.HSYNC_COUNT } {
	# Procedure called to validate HSYNC_COUNT
	return true
}

proc update_PARAM_VALUE.VSYNC_COUNT { PARAM_VALUE.VSYNC_COUNT } {
	# Procedure called to update VSYNC_COUNT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VSYNC_COUNT { PARAM_VALUE.VSYNC_COUNT } {
	# Procedure called to validate VSYNC_COUNT
	return true
}


proc update_MODELPARAM_VALUE.HSYNC_COUNT { MODELPARAM_VALUE.HSYNC_COUNT PARAM_VALUE.HSYNC_COUNT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.HSYNC_COUNT}] ${MODELPARAM_VALUE.HSYNC_COUNT}
}

proc update_MODELPARAM_VALUE.VSYNC_COUNT { MODELPARAM_VALUE.VSYNC_COUNT PARAM_VALUE.VSYNC_COUNT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VSYNC_COUNT}] ${MODELPARAM_VALUE.VSYNC_COUNT}
}

