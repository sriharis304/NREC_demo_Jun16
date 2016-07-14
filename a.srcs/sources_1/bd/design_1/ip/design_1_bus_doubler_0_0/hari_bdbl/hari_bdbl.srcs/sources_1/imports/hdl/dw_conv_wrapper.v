//Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2014.4 (win64) Build 1071353 Tue Nov 18 18:29:27 MST 2014
//Date        : Sun Nov 15 11:31:09 2015
//Host        : Centaurus running 64-bit Service Pack 1  (build 7601)
//Command     : generate_target dw_conv_wrapper.bd
//Design      : dw_conv_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module dw_conv_wrapper
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

  wire in_clk;
  wire [7:0]in_data;
  wire in_den;
  wire [15:0]out_data;
  wire out_den;
  wire rst_n;

dw_conv dw_conv_i
       (.in_clk(in_clk),
        .in_data(in_data),
        .in_den(in_den),
        .out_data(out_data),
        .out_den(out_den),
        .rst_n(rst_n));
endmodule
