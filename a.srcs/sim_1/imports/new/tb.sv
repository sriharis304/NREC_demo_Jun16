`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/24/2015 04:57:55 PM
// Design Name: 
// Module Name: tb
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


module tb();

logic diff_clock_clk_n;
logic diff_clock_clk_p;
logic locked;
logic rst_n;
logic vid_io_out_active_video;
logic [15:0]vid_io_out_data;
logic vid_io_out_field;
logic vid_io_out_hblank;
logic vid_io_out_hsync;
logic vid_io_out_vblank;
logic vid_io_out_vsync;


    design_1_wrapper design_1_wrapper_inst
       (.diff_clock_clk_n,
        .diff_clock_clk_p,
        .locked,
        .rst_n,
        .vid_io_out_active_video,
        .vid_io_out_data,
        .vid_io_out_field,
        .vid_io_out_hblank,
        .vid_io_out_hsync,
        .vid_io_out_vblank,
        .vid_io_out_vsync);
        
        
initial begin
    rst_n  = 0;
    #100
    rst_n = 1;
end

initial begin
    diff_clock_clk_p  = 0;
    forever #5 diff_clock_clk_p = ~diff_clock_clk_p;
end

assign diff_clock_clk_n = ~diff_clock_clk_p;

endmodule
