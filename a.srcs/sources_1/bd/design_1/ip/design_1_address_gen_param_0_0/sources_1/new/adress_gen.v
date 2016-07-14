`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2015 03:30:43 PM
// Design Name: 
// Module Name: adress_gen
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

module address_gen_param(sof,tvalid, clk,resetn,write_enable,bram_addr_in,sof_to_homography,data_in,data_out,BLANKING_WIDTH,BLANKING_POSITION,BLANKING_HEIGHT);

parameter START_LINE_FOR_HOMOGRAPHY =0;
parameter HEIGHT =340;
parameter WIDTH =960;
localparam SIZE = (HEIGHT*WIDTH)/8 ;
localparam LINE_SIZE = WIDTH/8 ;
reg [(LINE_SIZE -1):0 ] flag_blackout;
input    clk, resetn,sof,tvalid;
input [7:0] data_in;
output [7:0] data_out;
output reg [12:0]  bram_addr_in;
output write_enable;
output sof_to_homography;
input [3:0] BLANKING_WIDTH;
input [3:0] BLANKING_POSITION;
input [9:0] BLANKING_HEIGHT; 
reg start;
reg sof_to_homography_reg;
reg [(LINE_SIZE -1):0 ] flag_blackout_mask;

//reg [LINE_SIZE-1 :0][9:0] start_of_blanking_line  ; 
reg [9:0] end_of_blanking_line [0:LINE_SIZE] ;
reg[LINE_SIZE-1 :0] flag_update_end_of_blanking;


(* dont_touch = "yes" *)reg  [9:0] line_counter;
(* dont_touch = "yes" *)reg [15:0]frame_counter;
(* dont_touch = "yes" *)reg [16:0] data_count;
(* dont_touch = "yes" *)reg [7:0] line_pos_counter;
assign sof_to_homography = sof_to_homography_reg;
always @(posedge clk)
begin
if (~resetn)
    begin 
    sof_to_homography_reg <=0;
    end
    else
    if( line_counter == START_LINE_FOR_HOMOGRAPHY && line_pos_counter ==0 && tvalid ==1'b1 && sof_to_homography_reg==0)
    begin
    sof_to_homography_reg<=1;
    end
    else begin
    sof_to_homography_reg <=0;
    end
end

/*
always @(posedge clk)
begin
    if 
    if( data < 8'hFF)
    begin
        flag [line_pos_counter] = 1'b1;
    end
*/
    
assign data_out =  (flag_blackout[line_pos_counter]  && (line_counter <end_of_blanking_line[line_pos_counter]) )? 0 :  data_in;
always @(posedge clk)
begin
    if (~resetn)
    begin
       bram_addr_in <=0;
         
          line_counter<=0;
          frame_counter <=0;
          line_pos_counter <=0;
          data_count <=0;
          flag_blackout =0;
    end
    else
    begin
        if(write_enable)
        begin 
         
        
            if (data_count <(SIZE-1)) begin
                data_count <=data_count + 1;
                if (bram_addr_in <13'h1FFF)
                bram_addr_in <= bram_addr_in +1; // will the overflow not work ?
                else
                bram_addr_in <= 0;
                if( line_pos_counter <(LINE_SIZE-1))
                        line_pos_counter <= line_pos_counter +1;
                else begin
                            line_pos_counter <=0;
                            line_counter <=line_counter +1;
                 end
                  if( data_in < 8'hFF )
                  begin
				  		if(line_counter +BLANKING_HEIGHT < (HEIGHT))
							end_of_blanking_line [line_pos_counter] =  line_counter + BLANKING_HEIGHT  ;
						else
	 						end_of_blanking_line [line_pos_counter] = HEIGHT ;
					
				  	   if( line_pos_counter> ((6+BLANKING_WIDTH)/2 + BLANKING_POSITION -8))
                       begin
                        flag_blackout_mask <= (( (1<< (6+BLANKING_WIDTH))-1) << (line_pos_counter - ((6+BLANKING_WIDTH)/2) + BLANKING_POSITION -8));
                        flag_blackout<= flag_blackout | flag_blackout_mask;
						flag_update_end_of_blanking <= flag_update_end_of_blanking | flag_blackout_mask ;
                        end
                       else begin
                        flag_blackout_mask <= (1<<(6+BLANKING_WIDTH)) -1 ;
                        flag_blackout <= flag_blackout | flag_blackout_mask;
						flag_update_end_of_blanking <= flag_update_end_of_blanking | flag_blackout_mask ;
						
                       
                       end
                   end
				   else	if (flag_blackout[line_pos_counter] ==1'b1 && flag_update_end_of_blanking[line_pos_counter] ==1'b1) 
					begin
							if(line_counter +BLANKING_HEIGHT < (HEIGHT) )
								end_of_blanking_line [line_pos_counter] =  line_counter + BLANKING_HEIGHT  ;
							else
	 							end_of_blanking_line [line_pos_counter] = HEIGHT ;



							flag_update_end_of_blanking[line_pos_counter] <=0;
					end



                
            end else begin
                flag_blackout <=0;
                data_count <=0;
                line_counter<=0;
                bram_addr_in <= 0;
                frame_counter <= frame_counter+1;
                line_pos_counter <=0;
                flag_blackout_mask<=0;
				flag_update_end_of_blanking <=0;
            end
        end
    end
end

always @(posedge clk)

begin
    if (~resetn)
       start <=0;
    else
    begin
    if(sof==1)
    start<=1;
    end
end
assign write_enable =  tvalid & (sof |start) ? 1:0;

endmodule

