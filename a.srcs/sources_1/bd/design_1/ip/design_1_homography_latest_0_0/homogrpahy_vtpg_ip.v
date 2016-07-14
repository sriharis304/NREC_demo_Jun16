module homography_latest( clk, 
            resetn,
			scan_start,
			frame_end, 
			tvalid,
			data_to_dmd,
			vsync,
			hsync,
			en_image_in_b,
			dout_image_in_b,
			addr_image_in_b
			);


parameter HSYNC_COUNT =3;
parameter VSYNC_COUNT =5;

 
input	clk, resetn;
input	scan_start;
output  frame_end;
output  tvalid ;
output  [7:0] data_to_dmd;
output reg  vsync;
output reg hsync;
output en_image_in_b;
input [7:0] dout_image_in_b;
output [12:0] addr_image_in_b;


(* dont_touch = "yes" *) reg [9:0]line_counter_homography;
(* dont_touch = "yes" *) reg [15:0] frame_counter_homography;
assign tvalid = we_image_out_a;
assign data_to_dmd = din_image_out_a;     									
wire [15:0]count_data;
reg [2:0]hsync_count ;
reg [2:0] vsync_count;
always @(posedge clk)

begin
	if (~resetn) 
	begin
	   hsync<=0;
	   hsync_count<=0;
	  
	  line_counter_homography <=0;	
	end
	else
	begin
	  	
	  if(count_data[6:0] == 7'h7F) begin
		 hsync <=1;
		 if( frame_end ==0)
		 line_counter_homography <=line_counter_homography +1; 
		 else
		 line_counter_homography <=0;
	  end
	  else if( hsync_count ==HSYNC_COUNT)
	  hsync <=0;
	 
	 if(hsync ==1)
	 hsync_count <=hsync_count + 1;
	 else
	 hsync_count <=0;
	 end
end

always @ (posedge clk )

begin
	if (~resetn) 
	begin
	   vsync<=0;
	   vsync_count<=0;
	    frame_counter_homography <=0;				
	end
	else
	begin
	  if(frame_end ==1  ) begin
	  vsync <=1; 
	  frame_counter_homography <= 	frame_counter_homography+1;
	 end
	  else if(vsync_count ==VSYNC_COUNT)
	  vsync <=0;
	 
	 if(vsync ==1)
	 vsync_count <= vsync_count + 1;
	 else
	 vsync_count <=0;
	 end
end





wire [7:0] din_image_in_a;
//wire [0:0] din_image_in_b;

//wire [7:0] dout_image_in_a;

wire en_image_out_a, en_image_out_b, we_image_out_a, we_image_out_b;

wire [15:0] addr_image_out_a;
wire [15:0] addr_image_out_b;

wire [7:0] din_image_out_a;
wire [7:0] din_image_out_b;

wire [7:0] dout_image_out_a;
wire [7:0] dout_image_out_b;

wire en_lut_a, en_lut_b;

wire [15:0] addr_lut_a;
wire [15:0] addr_lut_b;

wire [63:0] dout_lut_a;
wire [63:0] dout_lut_b;

wire en_lut_offsets;
wire [8:0] addr_lut_offsets;
wire [38:0] dout_lut_offsets;


// remove comments later
/*
   out_image_bram out_image_bram_inst(.clka(clk), 
	      										.clkb(clk), 
	      										.ena(en_image_out_a), 
	      										.enb(en_image_out_b), 
	      										.wea(we_image_out_a), 
	      										.web(we_image_out_b), 
	      										.addra(addr_image_out_a), 
	      										.addrb(addr_image_out_b), 
	      										.dia(din_image_out_a), 
	      										.dib(din_image_out_b), 
	      										.doa(dout_image_out_a), 
	      										.dob(dout_image_out_b)
	      	);
*/

	lut_bram lut_bram_inst(.clka(clk), 
									  .ena(en_lut_a), 
									  .addra(addr_lut_a), 
									  .doa(dout_lut_a), 
									  .wea(1'b0),
									  .dia(64'b0)
	      	);
	lut_offsets lut_offsets_inst(.clk(clk), 
									  .en(en_lut_offsets),
									  .addr(addr_lut_offsets), 
									  .dout(dout_lut_offsets),
									  .we(1'b0),
									  .di(39'b0)
	      	);

	doLookUp doLookUpInst(
			.clk(clk), .resetn(resetn),
			.scan_start(scan_start),
			.frame_end(frame_end),
			.addr_lut_a(addr_lut_a),
			.addr_lut_b(addr_lut_b),
			.dout_lut_a(dout_lut_a),
			.dout_lut_b(dout_lut_b),
			.en_lut_a(en_lut_a),
			.en_lut_b(en_lut_b),
			.addr_lut_offsets(addr_lut_offsets),
			.dout_lut_offsets(dout_lut_offsets),
			.en_lut_offsets(en_lut_offsets),
			.addr_image_out_a(addr_image_out_a),
			.addr_image_out_b(addr_image_out_b),
			.din_image_out_a(din_image_out_a),
			.din_image_out_b(din_image_out_b),
			.en_image_out_a(en_image_out_a),
			.en_image_out_b(en_image_out_b),
			.we_image_out_a(we_image_out_a),
			.we_image_out_b(we_image_out_b),
			.addr_image_in_bram(addr_image_in_b),
			.count_data(count_data),
			.hsync(hsync),
			.vsync(vsync),
			//.dout_image_in_a(dout_image_in_a),
			.dout_image_in_b(dout_image_in_b),
			.en_image_in_b(en_image_in_b)
		);

endmodule

module prio_encoder (resetn,
		clk,
		binary_registered_out_w , //  3 bit binary output
		encoder_in , //  8-bit input 
		enable       //  Enable for the encoder
		);
input clk;
input resetn;
output [2:0] binary_registered_out_w;

input  enable ; 
input [0:7] encoder_in ; 
reg [2:0] binary_registered_out;
wire[2:0] binary_out ;
assign binary_registered_out_w = binary_registered_out;

always @(posedge clk)
begin
	if (~resetn) 
	   binary_registered_out<= 0;
	else
	begin
	binary_registered_out <= binary_out;
	end
end

assign  binary_out  = (( ! enable) ? 0 : 
		(encoder_in[0]) ? 0 : 
		(encoder_in[1]) ? 1 : 
		(encoder_in[2]) ? 2 : 
		(encoder_in[3]) ? 3 : 
		(encoder_in[4]) ? 4 : 
		(encoder_in[5]) ? 5 : 
		(encoder_in[6]) ? 6 : 
		(encoder_in[7]) ? 7:0); 
endmodule 


module doLookUp
	( clk, resetn,
		scan_start,
		frame_end,
		addr_lut_a,
		addr_lut_b,
		dout_lut_a,
		dout_lut_b,
		en_lut_a,
		en_lut_b,
		addr_lut_offsets,
		dout_lut_offsets,
		en_lut_offsets,
		addr_image_out_a,
		addr_image_out_b,
		din_image_out_a,
		din_image_out_b,
		en_image_out_a, 
		en_image_out_b,
		we_image_out_a,
		we_image_out_b,
		addr_image_in_bram,
		count_data,
		hsync,
		vsync,
		//dout_image_in_a,
		dout_image_in_b,
		en_image_in_b
		);
		
		input clk, resetn;
		input scan_start;
		output frame_end;
		output [15:0] addr_lut_a;
		output [15:0] addr_lut_b;
		input   [63:0] dout_lut_a;
		input   [63:0] dout_lut_b;
		output 		  en_lut_a;
		output 		  en_lut_b;
		output  [8:0] addr_lut_offsets;
		input  [38:0] dout_lut_offsets;
		output 		  en_lut_offsets;
		output [15:0] addr_image_out_a;
		output [15:0] addr_image_out_b;
		output  [7:0] din_image_out_a;
		output  [7:0] din_image_out_b;
		output 		  en_image_out_a;
		output 		  en_image_out_b;
		output 		  we_image_out_a;
		output 		  we_image_out_b;
		output [12:0] addr_image_in_bram;
		//input   [0:0] dout_image_in_a;
		input   [7:0] dout_image_in_b;
		output 		  en_image_in_b;
		output reg [15:0]  count_data;
		input hsync;
		input vsync;
	parameter IN_WIDTH = 10'd960, IN_HEIGHT = 9'd340;
	parameter OUT_WIDTH = 11'd1024, OUT_HEIGHT = 9'd384; // why has he given as 1023 ?? 
	
	parameter N = 49152; //1024x384

	parameter START = 3'b001, IDLE  = 3'b010, CALC = 3'b100, CALC2 = 3'b101; 
	//=============Internal Variables======================
	reg   [2:0]          stateCLA        ;// Seq part of the FSM to calculate LUT addr
	reg   [2:0]          stateGLA        ;// Seq part of the FSM to calc adddr in in_image
	reg   [2:0]          stateGPX        ;// Seq part of the FSM to put data into out image
	//==========Code starts Here==========================

	// Calculate LUT pointer State Machine

	wire en_lut_a, en_lut_b;
	wire en_lut_offsets;

	wire  en_image_in_b;

	wire [15:0] addr_image_in_b;
	wire [12:0] addr_image_in_bram;	
	wire [8:0] addr_lut_offsets;
	
	wire stall_ala2down, stall_gla2down;
	wire stall_gla2up, stall_gpx2up;

	wire en_image_out_a, en_image_out_b;
	wire we_image_out_a, we_image_out_b;

	wire [7:0] din_image_out_a;
	wire [7:0] din_image_out_b;

	wire [7:0] dout_image_out_a;
	wire [7:0] dout_image_out_b;

	wire [15:0] addr_image_out_a;
	wire [15:0] addr_image_out_b;

	reg [15:0] lut_ptr;
	reg [15:0] img_ptr;

	reg [9:0] x_a_val[0:7], x_b_val[0:7],x_a_val_reg[0:7],y_a_val_reg[0:7];
	reg [9:0]  first_valid_x,  start_x_a,last_valid_x,start_y_a;
	reg [8:0] y_a_val[0:7], y_b_val[0:7],  prev_y_a;

	wire data_valid, data_start;

	reg [9:0] x_pos, x_pos_q;
     reg[9:0] x_pos_2q; // current position in o/p image
	 reg [8:0] y_pos, y_pos_q;
	reg[8:0] y_pos_2q;

	wire [15:0] addr_lut_a, addr_lut_b;
	
	// additions --Srihari
	reg  [0:7] flag,flag_dummy,flag_dummy_data,flag_dummy_data_q; // actually wire
	reg  [0:7] flag_reg,flag_q;
	reg  [2:0] x_offset[0:7], x_offset_reg[0:7]; //to get relevant data from input image -- something like bit select of the  8 bits read 	
	wire [2:0] index; // index of output data // basically which one of the 8 pixels
	reg [15:0] addr [0:7],addr_reg [0:7];  // addr  in i/p image needed for each pixel in o/p image
	reg  [7:0] data_out; // !! see the order 0-7 or 7-0
	reg [7:0] data_out_w;
	reg [2:0] next_state_CLA;
	reg [2:0] next_state_GLA;
	reg [2:0] next_state_GPX;
	reg [0:7] is_valid,is_valid_reg;
	wire [0:7] flag_select;	
	reg   [2:0]  stateGPX_q; 
	reg [15:0]addr_image_in_b_reg;
	reg hsync_q;
	reg vsync_q;
	reg hsync_2q;
	reg vsync_2q;
	wire frame_end;
	wire stall_ala2down_new;
	wire stall_ala_temp;
	reg we_image_out_a_reg	;
	wire we_image_out_a_temp;
	reg [7:0] din_image_out_a_reg;
	wire [7:0] din_image_out_a_temp;
	assign flag_select =    (stateGLA ==CALC) ? flag :flag_reg;
	reg [63:0] dout_lut_a_reg,dout_lut_a_reg_temp;
	prio_encoder p1(resetn, clk,index , flag_select ,1'b1);// !!check enable signal

	function [9:0] sign_extend_x;
		input [4:0] inVal;
		sign_extend_x = { {6{inVal[4]}}, inVal[3:0] };
	endfunction : sign_extend_x

	function [8:0] sign_extend_y;
		input [2:0] inVal;
		sign_extend_y = { {7{inVal[2]}}, inVal[1:0] };
	endfunction : sign_extend_y
	
	function [9:0] round_to_eight;
		input [9:0] inval;
		round_to_eight = ((inval>>3)<<3);
	endfunction
	function valid_range;
	input [9:0] x_pos_q;
	input [31:0] i;
	
	valid_range = (x_pos_2q+i>=first_valid_x && x_pos_2q+i <=last_valid_x && (last_valid_x | first_valid_x) ) ? 1 :0; 
	endfunction	 
	

	assign en_image_out_a = 1;
	assign en_image_out_b = 1;

	assign frame_end = (count_data == N-1) ? 1 : 0; // check if thi N-2 !!!
	
	// just used to change index of LUTBRAM
	always @ (*)
	 begin : CLA_state_logic
	 next_state_CLA	= 3'b000;
		 case(stateCLA)
		   START : if (scan_start ) begin // frame end aint proper -- see 
		            next_state_CLA = CALC;
		          end else begin
		            next_state_CLA = START;
		          end
		   IDLE : if (frame_end) begin
				next_state_CLA <= START;
			  end else if (~hsync &&~stall_gla2up) begin
		            next_state_CLA = CALC;
		          end else begin
		            next_state_CLA = IDLE;
		          end
		   CALC :
			  	if (frame_end) begin
		          	next_state_CLA = START;
		          	end
	
			  	else if(count_data[6:0]== 7'h7F) // line _end 
			  	 begin
			  	 next_state_CLA <= IDLE;
			   	end
			 	 else if (~hsync && ~stall_gla2up && ~frame_end) begin
			            next_state_CLA = CALC;
		         	 end else if(stall_gla2up) begin
		            	next_state_CLA = IDLE;
		          	end
			 
		   default : next_state_CLA = IDLE;
		  endcase
	end

	always @ (posedge clk)
	begin : CLA_state_logic_seq
		if (~resetn) begin
		  stateCLA <= START;
		end else
		  stateCLA <=next_state_CLA;
	
	end
	assign stall_ala_temp =  (stateCLA == CALC && hsync ==0 && vsync ==0  ) ? 0 : 1;
	// stalling other modules down the  pipe while it calcs LUt addr and gets data.
	assign stall_ala2down =	stall_ala2down_new | stall_ala_temp;
	// addition for output reg for BRAM
	assign stall_ala2down_new = ((lut_ptr - count_data < 1) && x_pos != 1016) ;
	//assign stall_ala2down_new =0;
	assign addr_lut_a = lut_ptr;
	assign addr_lut_b = lut_ptr;
	assign en_lut_offsets = (x_pos == 0) ? 1 : 0;
	assign addr_lut_offsets = y_pos;
	assign en_lut_a = (stateCLA == CALC) ? 1 : 0; // shd i change to next state is CALC !! 
	assign en_lut_b = (stateCLA == CALC) ? 1 : 0;

 // calculates addr to fetch LUT offsets ---start positions
	always @ (posedge clk) begin : CLA_work_logic
		 if(stateCLA == START) begin
		 	lut_ptr  <= 0;
		 	x_pos    <= 0;
		 	y_pos	 <= 0;
		 	x_pos_q  <= 0;
		 	y_pos_q  <= 0;
			x_pos_2q <=0;
			dout_lut_a_reg <=0;
		 end else if(stateCLA == CALC) begin
			dout_lut_a_reg  <= dout_lut_a;
		 	lut_ptr <= (lut_ptr == N-1) ? 0 : (( x_pos_q == OUT_WIDTH-8 && x_pos == OUT_WIDTH-8 ) ? lut_ptr : (lut_ptr + 1)); 
		 	x_pos <= (x_pos == OUT_WIDTH-8)  ? (count_data [6:0] == 7'h7F  ?  0:x_pos ) : (x_pos + 8); // reading 128 bits ata  time. // gotto go idle here itself !!! 
		 	y_pos <= (x_pos == OUT_WIDTH-8 && count_data[6:0] == 7'h7F) ? (y_pos + 1) : y_pos;
		 	x_pos_q <= x_pos; 
		 	y_pos_q <= y_pos;
			x_pos_2q <= x_pos_q;
			y_pos_2q <= y_pos_q;
		 end
	end


	// Get data from input image--- State Machine 

	always @ (*)
	begin :GLA_state_logic 
		 case(stateGLA)
		   START : if (~stall_ala2down) begin
	                next_state_GLA = CALC;
	              end else begin
	                next_state_GLA = START;
	              end
// ala2down -- is basically if the statemachine is calculating LUT addr and stuff.
		   IDLE : if (~stall_ala2down & ~stall_gpx2up) begin // transition to CALC2?? !!!
	                next_state_GLA = CALC;
	              end else begin
	                next_state_GLA = IDLE;
	              end
		   CALC : if (frame_end) begin
		          	next_state_GLA = START;
		          end else if(count_data[6:0] ==7'h7f) begin
				next_state_GLA = IDLE;
		   	 end else if (stateCLA == START) begin
		   		  	next_state_GLA = START;
		   	 end
 
			 else if (stall_ala2down | stall_gpx2up) begin
		   			next_state_GLA = IDLE;
	              	 end

			 else if ( flag !=0)  begin // add if flag != 0 -- in calc stage
	               		 next_state_GLA = CALC2;
			 end

			 else begin // add if flag != 0 -- in calc stage
	               		 next_state_GLA = CALC;
	             	 end
		   CALC2 :if (frame_end) begin
		          	next_state_GLA = START;
		          end else if(count_data[6:0] ==7'h7f) begin
				next_state_GLA = IDLE;
 // !! see transitions properly
			end else if (stateCLA == START) begin
		   		  	next_state_GLA = START;
		   	 end 

	//		 else if (stall_ala2down | stall_gpx2up) begin !!!!!!!! check this
	//	   			next_state_GLA = IDLE;
	  //            	 end

			 else if ( flag_dummy != ~(flag_reg))  begin // add if flag != 0 -- in calc stage
	               		 next_state_GLA = CALC2;
			 end
			 else begin // add if flag != 0 -- in calc stage
	               		 next_state_GLA = CALC;
	             	 end
	
		   default : next_state_GLA = IDLE;
		  endcase
	end
	
	always @ (posedge clk) 
	begin : GLA_state_logic_seq
		if (~resetn) begin
		  stateGLA <= START;
		  is_valid_reg <=0; 
	
		end 
		else begin
		stateGLA <= next_state_GLA;
		if(we_image_out_a ==1)
		begin
			is_valid_reg <= is_valid;
		end
		end
	end


	assign  stall_gla2down = ((stateGLA == CALC || stateGLA == CALC2)&& next_state_GLA ==CALC ) ? 0 : 1;
	assign  stall_gla2up = (stateGLA == IDLE ||next_state_GLA !=CALC  )&& hsync_2q ==0 && vsync_2q==0 && hsync==0 && vsync==0 &&(lut_ptr - count_data >1)? 1 : 0; // what ? !!!
	
	//reading from port B. 
		//assign	addr_image_in_b = x_b_val + y_b_val*IN_WIDTH;
	
	// calculating all the other stuff needed
  
	genvar i;
	assign	en_image_in_b   = ((stateGLA == CALC || stateGLA == CALC2) && data_valid) ? 1 : 0;

	always @(posedge clk)
	begin
		if (~resetn)
	 	begin
		first_valid_x <=0;
		last_valid_x  <=0;	
		start_x_a    <=0;	
		start_y_a    <=0;
		end
		else begin
			if (x_pos_q == 0) // check thois condition
			begin	
			first_valid_x   <= dout_lut_offsets[38:29]; // take care of offset -- i amt aking 8 at a time -- horrible coding style -- infers latches!!

			last_valid_x    <=  dout_lut_offsets[28:19] ;

			start_x_a 	<=  dout_lut_offsets[18: 9];

			start_y_a 	<=  dout_lut_offsets[ 8: 0] ;
			end
		end
	end
	assign  data_valid 	= ((x_pos_2q >= round_to_eight(first_valid_x)) && (x_pos_2q <= round_to_eight(last_valid_x))) ? 1 : 0;

	assign  data_start      = (x_pos_2q == (round_to_eight(first_valid_x)));
	assign	addr_image_in_b = (stateGLA == CALC)?(data_start? ((x_a_val[first_valid_x[2:0]] + (y_a_val[first_valid_x[2:0]]*1024)-(y_a_val[first_valid_x[2:0]])*64)/8):((x_a_val[0] + (y_a_val[0]*1024- y_a_val[0]*64) )/8)) : ((x_a_val_reg[index] + (y_a_val_reg[index]*1024-y_a_val_reg[index]*64) )/8) ;// add if calc and all that 
	assign  addr_image_in_bram = addr_image_in_b &13'h1fff;
// !! see other cases  for addr image b;	
	//always @(posedge clk)
	
    // optimize later--dont access bram for adddr 0;
	generate 
	for (i=0;i<8;i=i+1)
	begin
	always @(*)
	begin
//	flag_dummy[i] = (addr_reg[i] == addr_image_in_b)? 1'b0 :1'b1;
	//flag_dummy_data[i] <=1'b1;
//	flag[i] = 1'b1;
//	x_a_val[i] =1'b0;
//	y_a_val[i] =1'b0;
//	addr[i] =1'b0;	
//	is_valid[i] =1'b0;
//	x_offset[i] =1'b0;
//	is_valid[i] = valid_range(x_pos_2q,i);
	case(stateGLA)
		  CALC :begin
		  x_a_val[i] = data_valid ?  ((data_start ) ? (valid_range(x_pos_2q,i)?start_x_a+sign_extend_x(dout_lut_a_reg[7+8*(7-i):3+8*(7-i)]): 0) : (valid_range(x_pos_2q,i)?x_a_val_reg[7] +sign_extend_x(dout_lut_a_reg[7+8*(7-i):3+8*(7-i)]):0)) : 0;
		  y_a_val[i] = data_valid ?  ((data_start)  ? (valid_range(x_pos_2q,i)?start_y_a +sign_extend_y(dout_lut_a_reg[2+8*(7-i):8*(7-i)]):0)  :  (valid_range(x_pos_2q,i)?y_a_val_reg[7] +sign_extend_y(dout_lut_a_reg[2+8*(7-i):8*(7-i)]):0)) : 0;
			x_offset[i] = x_a_val[i][2:0]; 
			addr[i]    =((x_a_val[i] + (y_a_val[i]*1024- y_a_val[i]*64))/8) ;
			is_valid[i] = valid_range(x_pos_2q,i);
				if( addr[i] == addr_image_in_b || ~is_valid[i])
				begin
					flag[i] =1'b0;
				end
				else
					flag[i] = 1'b1;


			//data_out_w[i] =  (x_a_val_reg[i]==0 && y_a_val_reg[i]==0) ? 1: dout_image_in_b[x_offset[i]];
			data_out_w[7-i] = dout_image_in_b[7-x_offset_reg[i]];
			flag_dummy_data[i] = (addr[i] == addr_image_in_b) ? 1'b0:1'b1;
			flag_dummy[i] =  flag_dummy_data[i];
			end
		   CALC2 :begin
			if( addr_reg[i] == addr_image_in_b || ~is_valid[i])
			begin
			flag[i] =1'b0;
			end
			else 
				flag[i] = 1'b1;

			is_valid[i] = valid_range(x_pos_2q,i);

			flag_dummy[i] = (addr_reg[i] == addr_image_in_b)? 1'b0 :1'b1;
			flag_dummy_data[i] = (addr_reg[i] == addr_image_in_b) ? 1'b0:1'b1;
			//data_out_w[i] =  (x_a_val_reg[i]==0 && y_a_val_reg[i]==0) ? 1: dout_image_in_b[x_offset_reg[i]];
			data_out_w[7-i] = dout_image_in_b[7-x_offset_reg[i]];
				x_a_val[i] =1'b0;
				y_a_val[i] =1'b0;
				addr[i] =1'b0;	
//				is_valid[i] =1'b0;
				x_offset[i] =1'b0;

			end

			 // !! see transitions properly
		   default :begin
		   	    flag[i] = 1'b1;
			    x_a_val[i] =1'b0;
			    y_a_val[i]=1'b0;
			    x_offset[i]= 1'b0;
			    addr[i] =1'b0;
			    is_valid[i] = 1'b0;	
			    data_out_w[7-i] =1'b0;
			    flag_dummy_data[i] = 1'b1;
			    flag_dummy[i] =1'b1;
 		
			    end	
	endcase
		
	end
	end
	endgenerate


generate 
	for (i=0;i<8;i=i+1)
	begin

		always @ (posedge clk)
		begin
		if (~resetn)
	 	begin

		data_out[7-i] <=0;
		x_offset_reg[i] <=0;//x_offset[i];
		x_a_val_reg[i] <=0;//x_a_val[i];
		y_a_val_reg[i] <=0;//y_a_val[i];
		flag_reg[i]       <=1;
		end
		else 
		begin

		data_out[7-i] <=    (data_out[7-i]&flag_dummy_data_q[i] | (dout_image_in_b[7-x_offset_reg[i]] &~flag_dummy_data_q[i]));
		case(stateGLA)
		START : 
		flag_reg[i]  <=1'b1;
		 IDLE : 
		 flag_reg[i]  <=1'b1;
		CALC: begin
		addr_reg[i] <=addr[i];
		x_offset_reg[i] <=x_offset[i];
		x_a_val_reg[i] <=x_a_val[i];
		y_a_val_reg[i] <=y_a_val[i];
		if( addr[i] == addr_image_in_b)
			begin
				//data_out[i] =   is_valid[i] ? dout_image_in_b[x_offset[i]]: 1;//!! shd i make this non blocking !! change this -- dont harcode to one
				flag_reg[i]<=0;

			end
		else begin
			if (is_valid[i] )
			flag_reg[i]<=1'b1;
			else
			flag_reg[i]<=1'b0;
		end
		end
		CALC2 : if(next_state_GLA == CALC) // !!! see the is it calc2 at end or starting 
			flag_reg[i]  <=1'b1;
			else 
			begin
				if( addr_reg[i] == addr_image_in_b)
				begin
				//data_out[i] <= is_valid[i] ? dout_image_in_b[x_offset[i]] :1; // just harcoding as 1. !! take care
				flag_reg[i]<=0;
				end
			end

		endcase
		end
		end
	end
endgenerate


			 
// Get and Put Pixel value data State Machine

always @ (posedge clk)
 begin  
		if (~resetn) begin
		  stateGPX <= START;
		  flag_dummy_data_q<=0;	
		  addr_image_in_b_reg <=0;
		  count_data<=0;
		  hsync_q <=0;
		  vsync_q <=0;		
		 hsync_2q <=0;
		  vsync_2q <=0;
		 // frame_end <=0;		
		end
	     else begin 
		if (count_data == N-1)begin
			count_data <=0;
			//frame_end ==1;
		end
		stateGPX <=next_state_GPX;
		stateGPX_q<= stateGPX;
		flag_q  <=flag;
		hsync_q <= hsync;
		vsync_q <=vsync;
		hsync_2q <= hsync_q;
		vsync_2q <= vsync_q;
		flag_dummy_data_q<= flag_dummy_data;
		addr_image_in_b_reg <= addr_image_in_b;
		if(stateGPX ==CALC)
			if (count_data == N-1)
				count_data<= 0;
			else
			count_data<=count_data+1; // need to reset this at frame end 
		end
end

always @ (*)
	begin : GPX_state_logic
	next_state_GPX =0;	
		 case(stateGPX)
		   START : if (~stall_gla2down && stateGLA ==CALC/*& ~stall_ppx2up*/) begin
	                next_state_GPX = CALC;
	              end 
			else begin
	                next_state_GPX = START;
	              end
		   IDLE :if(frame_end ) begin
			   	next_state_GPX <=START;
			  end 
			  else if (~stall_gla2down /*& ~stall_ppx2up*/) begin
	                	next_state_GPX = CALC;
	              	  end
			 else begin
	               	 next_state_GPX = IDLE;
	              	  end
		   CALC : if(frame_end ) begin
				next_state_GPX <=START;
			  end 
			  else if(count_data[6:0] ==7'h7f) begin
				next_state_GPX = IDLE;
			  
			  end 
			  else if (stateGLA == START) begin
		   	 	  	next_state_GPX = START;
		   	  end
			 else if (stall_gla2down /* | stall_ppx2up*/) begin
		   			next_state_GPX = IDLE;
	                  end
			  else begin
	                  next_state_GPX = CALC;
	              	  end
		   default : next_state_GPX = IDLE;
		 endcase
	end
	
	assign process_end = ((img_ptr == N-1) && (stateGPX == IDLE))  ? 1 : 0;

	//assign stall_gpx2up = (stateGPX == IDLE) ? 1 : 0; // why are u stalling upward ?? 
	assign stall_gpx2up = 0;
	assign we_image_out_a_temp = (stateGPX == CALC) ? 1 : 0;
	//assign we_image_out_b = (stateGPX == CALC) ? 1 : 0; //dummy 
	assign we_image_out_b =0;
	assign din_image_out_a_temp = (stateGPX == CALC && stateGPX_q ==CALC  )  ? (data_out_w  & is_valid_reg) :(stateGPX == CALC && stateGPX_q ==IDLE)?( ((data_out_w &(~flag_dummy_data_q)) | data_out&(flag_dummy_data_q)) & is_valid_reg): 8'h00;// !!!!!! take care that first and last set of eight bbits u have taken care of corner case

	assign addr_image_out_a = img_ptr;
    
    assign we_image_out_a = we_image_out_a_reg;
    assign din_image_out_a = din_image_out_a_reg;
    //-------better samppling------------//
    always @ (negedge clk) begin 
     if (~resetn) begin
        we_image_out_a_reg <=0;
        din_image_out_a_reg <=0;
     end else begin
        we_image_out_a_reg <= we_image_out_a_temp;
        din_image_out_a_reg <= din_image_out_a_temp;
        end
     end
     
     //-----------better sampling-----------//
	always @ (posedge clk) begin : GPX_work_logic 
		 if(stateGPX == START) begin
		 	img_ptr <= 0;
		 end else if(stateGPX == CALC) begin
		 	img_ptr <= img_ptr + 1;
		 end
	end


endmodule
