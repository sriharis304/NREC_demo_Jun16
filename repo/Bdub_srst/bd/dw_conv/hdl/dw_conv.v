//Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2014.4 (win64) Build 1071353 Tue Nov 18 18:29:27 MST 2014
//Date        : Sun Nov 15 11:34:16 2015
//Host        : Centaurus running 64-bit Service Pack 1  (build 7601)
//Command     : generate_target dw_conv.bd
//Design      : dw_conv
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module dw_conv
   (in_clk,
    in_data,
    in_den,
    out_data,
    out_den,
    rst_n);
  input in_clk;
  input [7:0]in_data;
  input in_den;
  output [15:0]out_data;
  output out_den;
  input rst_n;

  wire [15:0]axis_dwidth_converter_0_m_axis_tdata;
  wire axis_dwidth_converter_0_m_axis_tvalid;
  wire in_clk_1;
  wire [7:0]in_data_1;
  wire in_den_1;
  wire rst_n_1;
  wire [0:0]xlconstant_0_dout;

  assign in_clk_1 = in_clk;
  assign in_data_1 = in_data[7:0];
  assign in_den_1 = in_den;
  assign out_data[15:0] = axis_dwidth_converter_0_m_axis_tdata;
  assign out_den = axis_dwidth_converter_0_m_axis_tvalid;
  assign rst_n_1 = rst_n;
dw_conv_axis_dwidth_converter_0_0 axis_dwidth_converter_0
       (.aclk(in_clk_1),
        .aresetn(rst_n_1),
        .m_axis_tdata(axis_dwidth_converter_0_m_axis_tdata),
        .m_axis_tready(xlconstant_0_dout),
        .m_axis_tvalid(axis_dwidth_converter_0_m_axis_tvalid),
        .s_axis_tdata(in_data_1),
        .s_axis_tvalid(in_den_1));
dw_conv_xlconstant_0_0 xlconstant_0
       (.dout(xlconstant_0_dout));
endmodule
