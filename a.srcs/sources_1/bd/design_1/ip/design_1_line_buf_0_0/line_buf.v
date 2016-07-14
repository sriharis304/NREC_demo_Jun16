`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2015 05:45:35 PM
// Design Name: 
// Module Name: line_buf
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


module line_buf(clk,rst_n,in_data,in_hsync,in_vsync,in_tvalid,out_data,out_hsync,out_vsync,out_tvalid  );


parameter HEIGHT = 384;
input clk;
input rst_n;
input [15:0] in_data;
input in_hsync;
input in_vsync;
input in_tvalid;

output [15:0] out_data;
output out_hsync;
output out_vsync;
output out_tvalid;

reg hsync;
reg vsync;
reg [15:0] data;
reg tvalid; 

reg hsync_t;
reg hsync_t_q;

reg vsync_t;
reg vsync_t_q;
reg [15:0] out_data_reg;
reg out_tvalid_reg;


reg [15:0] line_buf[0:63];
reg [9:0] line_count;
reg [5:0] re_p;
reg [5:0] re_p_q;
reg[5:0] wr_p;

assign out_hsync = hsync_t_q;
assign out_vsync =vsync_t_q;
assign out_data = out_data_reg;
assign out_tvalid = out_tvalid_reg;

// --sampling on negedge for safety
always @(negedge clk)
begin
    if(~rst_n) begin
    hsync<=0 ;
    vsync<=0;
    data <=0;
    tvalid <=0;	
    
    end
    else begin
    hsync<= in_hsync;
    vsync<=in_vsync;
    data <=in_data;
    tvalid <=in_tvalid;
    end
    
 end
  
  // --------write to line_buf--------//
always @(posedge clk)
begin
 if(~rst_n) begin
   
   wr_p<=0;
   end
//    if(hsync ==1) begin
//        wr_p= 0;
//    end
    if(tvalid ==1) begin
        wr_p <= wr_p +1;
        line_buf[wr_p] <= data;
    end
    
end



// --read line_buf and send to DMD
reg [1:0] pulse_counter;
always @(posedge clk)
begin
   if(~rst_n) begin
     out_data_reg <=0 ;
     out_tvalid_reg <=0;
     re_p<=0;
     re_p_q<=0;
     hsync_t_q <=0;
     vsync_t_q<=0; 
     hsync_t <=0;
     vsync_t<=0;
    pulse_counter<=0;
    line_count <=0; 
   end 
   else begin
       hsync_t_q <= hsync_t;
       vsync_t_q<= vsync_t; 
        re_p_q <=re_p;
    // --just to intiate read op
       if(wr_p ==63 && re_p== 0) begin
        out_data_reg <= line_buf[re_p];
        out_tvalid_reg <=1;
        re_p <= re_p+1;
        end
        
   //----------------------------------------//     
       
            if(re_p_q == 63) begin // 64 coz read_pointer is always ahead of data
                       hsync_t <=1;
                       out_tvalid_reg <=0;
                       if(line_count == HEIGHT-1) begin
                                vsync_t <=1;
                                line_count <=0;
                        end else    
                                line_count <= line_count+1;
            end
            else begin  
             if(re_p!=0) begin                   
                out_data_reg <= line_buf[re_p];
                out_tvalid_reg <=1;
                re_p <= re_p+1;
            end
         end
      
         
         if(hsync_t ==1 ) begin 
             if(pulse_counter <1)
                pulse_counter <= pulse_counter+1;
             else begin
                 pulse_counter <=0;
                 hsync_t <=0;
                 vsync_t<=0; 
             end
         end
     end
  end  
        
    
    

endmodule
