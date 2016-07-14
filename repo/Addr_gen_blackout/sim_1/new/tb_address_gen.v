`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2015 05:00:12 PM
// Design Name: 
// Module Name: tb_address_gen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ps
module tb_address_gen();

reg    clk, reset_n,sof,tvalid;
wire [12:0]  bram_addr_in;
wire write_enable;

initial begin 

clk<=0;
forever 
#5 clk = ~clk;
end

initial begin 
sof =0;
tvalid =1;
reset_n <=0;
# 100 reset_n<=1;
#150 sof <=1;
end

adress_gen v1 ( .clk,
             .resetn(reset_n),
             .sof,
             .tvalid,
             .write_enable,
             .bram_addr_in);


endmodule
