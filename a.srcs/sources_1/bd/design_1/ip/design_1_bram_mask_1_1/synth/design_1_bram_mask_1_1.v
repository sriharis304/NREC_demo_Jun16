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


// IP VLNV: user.org:user:bram_mask:1.0
// IP Revision: 1

(* X_CORE_INFO = "bram_mask,Vivado 2015.2" *)
(* CHECK_LICENSE_TYPE = "design_1_bram_mask_1_1,bram_mask,{}" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_1_bram_mask_1_1 (
  clk,
  rst,
  bram_rst0,
  bram_clk0,
  bram_din0,
  bram_dout0,
  bram_en0,
  bram_we0,
  bram_addr0,
  bram_rst1,
  bram_clk1,
  bram_din1,
  bram_dout1,
  bram_en1,
  bram_we1,
  bram_addr1,
  v_s_tdata,
  v_s_tvalid,
  v_s_tready,
  v_s_tlast,
  v_s_tuser,
  v_m_tdata,
  v_m_tvalid,
  v_m_tready,
  v_m_tlast,
  v_m_tuser,
  bright_val0,
  bright_val1
);

(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
input wire clk;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst RST" *)
input wire rst;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 bram_0 RST" *)
output wire bram_rst0;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 bram_0 CLK" *)
output wire bram_clk0;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 bram_0 DIN" *)
output wire [31 : 0] bram_din0;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 bram_0 DOUT" *)
input wire [31 : 0] bram_dout0;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 bram_0 EN" *)
output wire bram_en0;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 bram_0 WE" *)
output wire bram_we0;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 bram_0 ADDR" *)
output wire [31 : 0] bram_addr0;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 bram_1 RST" *)
output wire bram_rst1;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 bram_1 CLK" *)
output wire bram_clk1;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 bram_1 DIN" *)
output wire [31 : 0] bram_din1;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 bram_1 DOUT" *)
input wire [31 : 0] bram_dout1;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 bram_1 EN" *)
output wire bram_en1;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 bram_1 WE" *)
output wire bram_we1;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 bram_1 ADDR" *)
output wire [31 : 0] bram_addr1;
input wire [15 : 0] v_s_tdata;
input wire v_s_tvalid;
output wire v_s_tready;
input wire v_s_tlast;
input wire v_s_tuser;
output wire [15 : 0] v_m_tdata;
output wire v_m_tvalid;
input wire v_m_tready;
output wire v_m_tlast;
output wire v_m_tuser;
input wire [3 : 0] bright_val0;
input wire [3 : 0] bright_val1;

  bram_mask #(
    .DW(16)
  ) inst (
    .clk(clk),
    .rst(rst),
    .bram_rst0(bram_rst0),
    .bram_clk0(bram_clk0),
    .bram_din0(bram_din0),
    .bram_dout0(bram_dout0),
    .bram_en0(bram_en0),
    .bram_we0(bram_we0),
    .bram_addr0(bram_addr0),
    .bram_rst1(bram_rst1),
    .bram_clk1(bram_clk1),
    .bram_din1(bram_din1),
    .bram_dout1(bram_dout1),
    .bram_en1(bram_en1),
    .bram_we1(bram_we1),
    .bram_addr1(bram_addr1),
    .v_s_tdata(v_s_tdata),
    .v_s_tvalid(v_s_tvalid),
    .v_s_tready(v_s_tready),
    .v_s_tlast(v_s_tlast),
    .v_s_tuser(v_s_tuser),
    .v_m_tdata(v_m_tdata),
    .v_m_tvalid(v_m_tvalid),
    .v_m_tready(v_m_tready),
    .v_m_tlast(v_m_tlast),
    .v_m_tuser(v_m_tuser),
    .bright_val0(bright_val0),
    .bright_val1(bright_val1)
  );
endmodule
