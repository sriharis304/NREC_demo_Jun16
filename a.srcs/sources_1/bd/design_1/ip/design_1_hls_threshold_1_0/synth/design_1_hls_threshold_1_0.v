// (c) Copyright 1995-2016 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: Xilinx:user:hls_threshold:1.0
// IP Revision: 2

(* X_CORE_INFO = "hls_threshold,Vivado 2015.2" *)
(* CHECK_LICENSE_TYPE = "design_1_hls_threshold_1_0,hls_threshold,{}" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_1_hls_threshold_1_0 (
  ap_clk,
  ap_rst_n,
  src_TDATA,
  src_TVALID,
  src_TREADY,
  src_TKEEP,
  src_TSTRB,
  src_TUSER,
  src_TLAST,
  src_TID,
  src_TDEST,
  ap_const_lv8_64,
  dst_TDATA,
  dst_TVALID,
  dst_TREADY,
  dst_TKEEP,
  dst_TSTRB,
  dst_TUSER,
  dst_TLAST,
  dst_TID,
  dst_TDEST
);

(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ap_signal_clock CLK" *)
input wire ap_clk;
input wire ap_rst_n;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 src TDATA" *)
input wire [63 : 0] src_TDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 src TVALID" *)
input wire src_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 src TREADY" *)
output wire src_TREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 src TKEEP" *)
input wire [7 : 0] src_TKEEP;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 src TSTRB" *)
input wire [7 : 0] src_TSTRB;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 src TUSER" *)
input wire [0 : 0] src_TUSER;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 src TLAST" *)
input wire [0 : 0] src_TLAST;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 src TID" *)
input wire [0 : 0] src_TID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 src TDEST" *)
input wire [0 : 0] src_TDEST;
input wire [7 : 0] ap_const_lv8_64;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 dst TDATA" *)
output wire [7 : 0] dst_TDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 dst TVALID" *)
output wire dst_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 dst TREADY" *)
input wire dst_TREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 dst TKEEP" *)
output wire [0 : 0] dst_TKEEP;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 dst TSTRB" *)
output wire [0 : 0] dst_TSTRB;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 dst TUSER" *)
output wire [0 : 0] dst_TUSER;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 dst TLAST" *)
output wire [0 : 0] dst_TLAST;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 dst TID" *)
output wire [0 : 0] dst_TID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 dst TDEST" *)
output wire [0 : 0] dst_TDEST;

  hls_threshold #(
    .ap_const_logic_1(1'B1),
    .ap_const_logic_0(1'B0),
    .ap_ST_st1_fsm_0(1'B1),
    .ap_const_lv32_0(32'H00000000),
    .ap_const_lv1_1(1'B1),
    .ap_const_lv32_8(32'H00000008),
    .ap_const_lv32_F(32'H0000000F),
    .ap_const_lv32_10(32'H00000010),
    .ap_const_lv32_17(32'H00000017),
    .ap_const_lv32_18(32'H00000018),
    .ap_const_lv32_1F(32'H0000001F),
    .ap_const_lv32_20(32'H00000020),
    .ap_const_lv32_27(32'H00000027),
    .ap_const_lv32_28(32'H00000028),
    .ap_const_lv32_2F(32'H0000002F),
    .ap_const_lv32_30(32'H00000030),
    .ap_const_lv32_37(32'H00000037),
    .ap_const_lv32_38(32'H00000038),
    .ap_const_lv32_3F(32'H0000003F),
    .ap_true(1'B1)
  ) inst (
    .ap_clk(ap_clk),
    .ap_rst_n(ap_rst_n),
    .src_TDATA(src_TDATA),
    .src_TVALID(src_TVALID),
    .src_TREADY(src_TREADY),
    .src_TKEEP(src_TKEEP),
    .src_TSTRB(src_TSTRB),
    .src_TUSER(src_TUSER),
    .src_TLAST(src_TLAST),
    .src_TID(src_TID),
    .src_TDEST(src_TDEST),
    .ap_const_lv8_64(ap_const_lv8_64),
    .dst_TDATA(dst_TDATA),
    .dst_TVALID(dst_TVALID),
    .dst_TREADY(dst_TREADY),
    .dst_TKEEP(dst_TKEEP),
    .dst_TSTRB(dst_TSTRB),
    .dst_TUSER(dst_TUSER),
    .dst_TLAST(dst_TLAST),
    .dst_TID(dst_TID),
    .dst_TDEST(dst_TDEST)
  );
endmodule
