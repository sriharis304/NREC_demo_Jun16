module bus_doubler
	(  
		rst_n,
		in_clk,
		in_hsync,
		in_vsync,
		in_den,
		in_data,

		out_clk,
		out_hsync,
		out_vsync,
		out_den,
		out_data
  );
  parameter INPUT_WIDTH = 8 ;
  parameter OUTPUT_WIDTH = 2*INPUT_WIDTH;

 input  rst_n;
  input  in_clk;
  input   in_hsync;
  input  in_vsync;
  input in_den;
  input [INPUT_WIDTH-1:0] in_data;
    
    
    wire out_den_temp;
    wire [OUTPUT_WIDTH-1:0] out_data_temp;
    reg [OUTPUT_WIDTH-1:0]out_data_temp_q;
    wire extended_den;
    reg out_den_reg;
    reg extended_den_reg;
    wire out_hysnc_w;
    wire out_vsync_w;
    reg out_vsync_q;
    reg out_hsync_q;
    reg out_vsync_2q;
    reg out_hsync_2q;
    reg in_hsync_reg;
    reg in_vsync_reg;
    
  output reg out_clk;
  output reg out_hsync;
  output reg out_vsync;
  output  reg out_den;
  
  reg out_den_2q;
  output reg  [OUTPUT_WIDTH-1:0] out_data;
dw_conv_wrapper dw_conv_wrapper_i
         (.in_clk(in_clk),
          .in_data(in_data),
          .in_den(in_den),
          .out_data(out_data_temp),
          .out_den(out_den_temp),
          .rst_n(rst_n));


always @(posedge in_clk) 
		begin: counter
		if (~rst_n) begin
		//	count = 1'b0;
			out_clk = 1'b0;
			out_den_reg<=0;
			out_den_2q<=0;
			//out_data_temp_q<=0;
		end else begin
			//count <= (in_den) ? ~count : count;
			out_clk <= ~out_clk;
			out_den_reg <= out_den_temp;
			out_den_2q <= out_den_reg;
			//out_data_temp_q<=out_data_temp;
			
		end
	end: counter
	
	// ---safer DEN and data-------//
	always @(negedge in_clk)
	begin
	 if (~rst_n) begin
	 extended_den_reg <=0;
	 out_data_temp_q<=0;
	 end else begin 
	 extended_den_reg <= extended_den;
	 out_data_temp_q<=out_data_temp;
	 in_hsync_reg <= in_hsync;
	 in_vsync_reg <= in_vsync;
	 end
	 end
	 //---safer DEN------------//
	 
	 
	assign extended_den = out_den_reg| out_den_temp ;
	assign out_hysnc_w = in_hsync_reg;
	assign out_vsync_w = in_vsync_reg;
always @(posedge out_clk) 
            begin
            if (~rst_n) begin
                out_hsync= 1'b0;
                out_vsync = 1'b0;
                out_den<=0;
                out_data<=0;
            end else begin
                out_hsync <= in_hsync;
                out_vsync <= in_vsync;
                out_den <= extended_den_reg;
                out_data<={out_data_temp_q[7:0],out_data_temp_q[15:8]};
                out_hsync_q <= out_hysnc_w;
                out_hsync_2q<=out_hsync_q;
                out_hsync <=out_hsync_2q;
                out_vsync_q <=out_vsync_w;
                out_vsync_2q <= out_vsync_q;
                out_vsync <=out_vsync_2q;
                
            end
        end


/*
	reg [1:0]out_hsync_buff;
	reg [1:0]out_vsync_buff;
	
	reg [1:0]out_den_buff;
	 wire [1:0] out_den_buff_w;
	 
	 reg [INPUT_WIDTH-1:0] out_data_buff[0:1];
	 wire [INPUT_WIDTH*2-1:0] out_data_buff_w ;
	 
	
	reg [1:0]out_den_buff_q;
	//reg [INPUT_WIDTH-1:0] out_data_buff[0:1];
    wire out_den_w;
    reg out_den_hari;
	reg count;
   
    wire count_w;
    reg [15:0] out_data_reg;
    wire [15:0]out_data_w;
    
    
    wire [15:0] out_data_w_domain2;
    reg [15:0] out_data_reg_dom2;
    reg out_den_reg;
    wire out_den_w_domain2;
    reg out_den_reg_domain2;
    reg out_hsync_domain2;
    reg out_vsync_domain2;
    assign out_data_w =(out_den_buff[0] & out_den_buff[1]) ?{out_data_buff[0],out_data_buff[1]} :out_data_w;
    
    assign out_data_buff_w = {out_data_buff[0],out_data_buff[1]};
    assign out_den_buff_w = out_den_buff;
    
    always @(posedge in_clk, negedge rst_n) 
            begin: out_data_logic
            if (~rst_n) begin
                out_data_reg <= 0;
                out_den_reg <=0;
            end else begin
               // out_data_reg  <= out_data_w;
               out_data_reg <=(out_den_buff_w[0] & out_den_buff_w[1])  ? out_data_buff_w :out_data_reg ;
               out_den_reg <=(out_den_buff_w[0] & out_den_buff_w[1])?1:0;
            end
     end
     assign out_den_w_domain2 = out_den_reg;
     assign out_data_w_domain2 = out_data_reg;
     
     always @ (posedge out_clk)
     begin
     if (~rst_n) begin
                 out_data_reg_dom2 <= 0;
                 out_den_reg_domain2 <=0;
             end else begin
             out_data_reg_dom2 <= out_data_w_domain2;
            // out_den_reg_domain2 <= out_data_w_domain2;
            out_den_reg_domain2 <=out_den;
            out_hsync_domain2<=out_hsync;
            out_vsync_domain2<=out_vsync;
             end
      end
    assign count_w = count;
	always @(posedge in_clk, negedge rst_n) 
		begin: counter
		if (~rst_n) begin
			count = 1'b0;
			out_clk = 1'b0;
		end else begin
			count <= (in_den) ? ~count : count;
			out_clk <= ~out_clk;
		end
	end: counter

	always @(posedge in_clk, negedge rst_n) 
		begin: out_buff_logic
		if (~rst_n) begin
			out_data_buff[0] = 0;
			out_data_buff[1] = 0;
		end else begin
			out_data_buff[count] <= (in_den)? in_data : out_data_buff[count];
			out_hsync_buff[count] <= in_hsync;
			out_vsync_buff[count] <= in_vsync;
			out_den_buff[count]   <= in_den;
			out_den_buff_q[0] <=  out_den_buff[0];
			out_den_buff_q[1] <= out_den_buff[1];
			if(count==0)
				out_den_buff[1] <=0;
				
		end
	end: out_buff_logic
    

    
    assign out_den_w = out_den_buff[0] | out_den_buff[1] & ~count;
	always @(posedge out_clk, negedge rst_n) 
		begin 
		if (~rst_n) begin
			out_data = 0;
		end else begin
            out_data  <= {out_data_buff[0], out_data_buff[1]};
            out_hsync <= out_hsync_buff[0] | out_hsync_buff[1];
            out_vsync <= out_vsync_buff[0] | out_vsync_buff[1];
            out_den   <= (out_den_buff[0] & out_den_buff[1] )|(out_den_buff_q[0] & out_den_buff_q[1]);  
            out_den_hari <= out_den_w;
		end
	end

*/
endmodule
