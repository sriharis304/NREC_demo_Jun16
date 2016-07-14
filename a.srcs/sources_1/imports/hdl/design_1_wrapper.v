//Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2014.4 (win64) Build 1071353 Tue Nov 18 18:29:27 MST 2014
//Date        : Tue Jan 19 15:12:11 2016
//Host        : Centaurus running 64-bit Service Pack 1  (build 7601)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (DDR_addr,
    DDR_ba,
    DDR_cas_n,
    DDR_ck_n,
    DDR_ck_p,
    DDR_cke,
    DDR_cs_n,
    DDR_dm,
    DDR_dq,
    DDR_dqs_n,
    DDR_dqs_p,
    DDR_odt,
    DDR_ras_n,
    DDR_reset_n,
    DDR_we_n,
    FIXED_IO_ddr_vrn,
    FIXED_IO_ddr_vrp,
    FIXED_IO_mio,
    FIXED_IO_ps_clk,
    FIXED_IO_ps_porb,
    FIXED_IO_ps_srstb,
    channel_x_clk_n,
    channel_x_clk_p,
    channel_x_data_n,
    channel_x_data_p,
    channel_y_clk_n,
    channel_y_clk_p,
    channel_y_data_n,
    channel_y_data_p,
    channel_z_clk_n,
    channel_z_clk_p,
    channel_z_data_n,
    channel_z_data_p,
    diff_clock_clk_n,
    diff_clock_clk_p,
    pixel_clk_out_p,
    pixel_clk_out_n,
    rst_n,
    vid_io_out_active_video_p,
    vid_io_out_active_video_n,
    vid_io_out_data_p,
    vid_io_out_data_n,
     vid_io_out_hsync_p,
    vid_io_out_hsync_n,
    vid_io_out_vsync_p,
    vid_io_out_vsync_n);
  inout [14:0]DDR_addr;
  inout [2:0]DDR_ba;
  inout DDR_cas_n;
  inout DDR_ck_n;
  inout DDR_ck_p;
  inout DDR_cke;
  inout DDR_cs_n;
  inout [3:0]DDR_dm;
  inout [31:0]DDR_dq;
  inout [3:0]DDR_dqs_n;
  inout [3:0]DDR_dqs_p;
  inout DDR_odt;
  inout DDR_ras_n;
  inout DDR_reset_n;
  inout DDR_we_n;
  inout FIXED_IO_ddr_vrn;
  inout FIXED_IO_ddr_vrp;
  inout [53:0]FIXED_IO_mio;
  inout FIXED_IO_ps_clk;
  inout FIXED_IO_ps_porb;
  inout FIXED_IO_ps_srstb;
  input channel_x_clk_n;
  input channel_x_clk_p;
  input [3:0]channel_x_data_n;
  input [3:0]channel_x_data_p;
  input channel_y_clk_n;
  input channel_y_clk_p;
  input [3:0]channel_y_data_n;
  input [3:0]channel_y_data_p;
  input channel_z_clk_n;
  input channel_z_clk_p;
  input [3:0]channel_z_data_n;
  input [3:0]channel_z_data_p;
  input diff_clock_clk_n;
  input diff_clock_clk_p;
  
  input rst_n;
  
    output pixel_clk_out_p;
    output pixel_clk_out_n;
    output vid_io_out_active_video_p;
    output vid_io_out_active_video_n;
    output [15:0]vid_io_out_data_p;
    output [15:0]vid_io_out_data_n;
    //output vid_io_out_field;
    //output vid_io_out_hblank;
    output vid_io_out_hsync_p;
    output vid_io_out_hsync_n;
    //output vid_io_out_vblank;
    output vid_io_out_vsync_p;
    output vid_io_out_vsync_n;

  wire [14:0]DDR_addr;
  wire [2:0]DDR_ba;
  wire DDR_cas_n;
  wire DDR_ck_n;
  wire DDR_ck_p;
  wire DDR_cke;
  wire DDR_cs_n;
  wire [3:0]DDR_dm;
  wire [31:0]DDR_dq;
  wire [3:0]DDR_dqs_n;
  wire [3:0]DDR_dqs_p;
  wire DDR_odt;
  wire DDR_ras_n;
  wire DDR_reset_n;
  wire DDR_we_n;
  wire FIXED_IO_ddr_vrn;
  wire FIXED_IO_ddr_vrp;
  wire [53:0]FIXED_IO_mio;
  wire FIXED_IO_ps_clk;
  wire FIXED_IO_ps_porb;
  wire FIXED_IO_ps_srstb;
  wire channel_x_clk_n;
  wire channel_x_clk_p;
  wire [3:0]channel_x_data_n;
  wire [3:0]channel_x_data_p;
  wire channel_y_clk_n;
  wire channel_y_clk_p;
  wire [3:0]channel_y_data_n;
  wire [3:0]channel_y_data_p;
  wire channel_z_clk_n;
  wire channel_z_clk_p;
  wire [3:0]channel_z_data_n;
  wire [3:0]channel_z_data_p;
  wire diff_clock_clk_n;
  wire diff_clock_clk_p;
  wire pixel_clk_out;
  wire rst_n;
  wire vid_io_out_active_video;
  wire [15:0]vid_io_out_data;
  wire [0:0]vid_io_out_hsync;
  wire [0:0]vid_io_out_vsync;

design_1 design_1_i
       (.DDR_addr(DDR_addr),
        .DDR_ba(DDR_ba),
        .DDR_cas_n(DDR_cas_n),
        .DDR_ck_n(DDR_ck_n),
        .DDR_ck_p(DDR_ck_p),
        .DDR_cke(DDR_cke),
        .DDR_cs_n(DDR_cs_n),
        .DDR_dm(DDR_dm),
        .DDR_dq(DDR_dq),
        .DDR_dqs_n(DDR_dqs_n),
        .DDR_dqs_p(DDR_dqs_p),
        .DDR_odt(DDR_odt),
        .DDR_ras_n(DDR_ras_n),
        .DDR_reset_n(DDR_reset_n),
        .DDR_we_n(DDR_we_n),
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
        .channel_x_clk_n(channel_x_clk_n),
        .channel_x_clk_p(channel_x_clk_p),
        .channel_x_data_n(channel_x_data_n),
        .channel_x_data_p(channel_x_data_p),
        .channel_y_clk_n(channel_y_clk_n),
        .channel_y_clk_p(channel_y_clk_p),
        .channel_y_data_n(channel_y_data_n),
        .channel_y_data_p(channel_y_data_p),
        .channel_z_clk_n(channel_z_clk_n),
        .channel_z_clk_p(channel_z_clk_p),
        .channel_z_data_n(channel_z_data_n),
        .channel_z_data_p(channel_z_data_p),
        .diff_clock_clk_n(diff_clock_clk_n),
        .diff_clock_clk_p(diff_clock_clk_p),
        .pixel_clk_out(pixel_clk_out),
        .rst_n(rst_n),
        .vid_io_out_active_video(vid_io_out_active_video),
        .vid_io_out_data(vid_io_out_data),
        .vid_io_out_hsync(vid_io_out_hsync),
        .vid_io_out_vsync(vid_io_out_vsync));
        
        
      OBUFDS #(
          
          .IOSTANDARD("DEFAULT")
          
          ) OBUFDS_inst[15:0] (
          
          .O(vid_io_out_data_p),
          
          .OB(vid_io_out_data_n),
          
          .I(vid_io_out_data)
          
          );
          
          
           OBUFDS #(
          .IOSTANDARD("DEFAULT")
          
          ) OBUFDS_inst10 (
          
          .O(pixel_clk_out_p),
          
          .OB(pixel_clk_out_n),
          
          .I(pixel_clk_out)
          
          );
           OBUFDS #(
          .IOSTANDARD("DEFAULT")
          
          ) OBUFDS_inst1 (
          
          .O(vid_io_out_hsync_p),
          
          .OB(vid_io_out_hsync_n),
          
          .I(vid_io_out_hsync)
          
          );
          
           OBUFDS #(
          .IOSTANDARD("DEFAULT")
          
          ) OBUFDS_inst2 (
          
          .O(vid_io_out_active_video_p),
          
          .OB(vid_io_out_active_video_n),
          
          .I(vid_io_out_active_video)
          
          );
          
           OBUFDS #(
          .IOSTANDARD("DEFAULT")
          
          ) OBUFDS_inst3 (
          
          .O(vid_io_out_vsync_p),
          
          .OB(vid_io_out_vsync_n),
          
          .I(vid_io_out_vsync)
          
          );
                
endmodule
