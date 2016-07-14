module bus_doubler_tb;

	parameter INPUT_WIDTH = 8 ;
	parameter OUTPUT_WIDTH = 2*INPUT_WIDTH;

	reg rst_n;
	reg in_clk;
	reg in_hsync;
	reg in_vsync;
	reg in_den;
	reg [INPUT_WIDTH-1:0] in_data;

	wire out_clk;
	wire out_hsync;
	wire out_vsync;
	wire out_den;
	wire [OUTPUT_WIDTH-1:0] out_data;

	bus_doubler bus_doubler_inst (.rst_n, 
								  .in_clk,
								  .in_hsync,
								  .in_vsync,
								  .in_den,
								  .in_data,
								  .out_clk,
								  .out_hsync,
								  .out_vsync,
								  .out_den,
								  .out_data);
    initial begin
      	in_clk = 0;
      
	forever #5 in_clk = ~in_clk;
	end
	
	
	initial begin
	// in_den =0;
	// in_data =1;
  
    	rst_n = 0;
    	#10 rst_n = 1;
    
  	end
/* 	
initial begin
in_den =0;
#20
//in_den=1;
forever #10 in_den= ~in_den;
end

initial begin
 #10000
 $finish;
end
/*
always @(posedge in_clk)
begin
    if(~rst_n)
    begin
    in_den <=1;
    end
    else
//    in_den <=1;
  in_den =~in_den;
end
*/

/*
always @(negedge in_clk)
begin
      if(~rst_n)
      begin
      in_data <= 1;
      end
      else begin
         // if(in_den)
         // begin
            if(in_data !=0)
                in_data <= in_data<<1;
             else
                in_data <= 1;
          end
    //   end
end
 */  
   
  	initial begin

  		in_hsync <= 0;
  		in_vsync <= 0;
  		in_den <= 1;
    
  		in_data <= 8'h08;
        #30
  		@(posedge in_clk)

  		in_hsync <= 0;
  		in_vsync <= 1;
  		in_den <= 0;

  		in_data <= 8'h03;

  		@(posedge in_clk)

  		in_hsync <= 0;
  		in_vsync <= 0;
  		in_den <= 1;

  		in_data <= 8'ha1;

  		@(posedge in_clk)

  		in_hsync <= 0;
  		in_vsync <= 0;
  		in_den <= 1;

  		in_data <= 8'h53;
  		
  		@(posedge in_clk)
  		
  		
  		in_hsync <= 0;
        in_vsync <= 0;
        in_den <= 1;
        
        in_data <= 8'h10;
          
        @(posedge in_clk)
        
        in_hsync <= 1;
        in_vsync <= 1;
        in_den <= 0;
      
        in_data <= 8'h23;
        
        @(posedge in_clk)
      
      
        in_hsync <= 1;
        in_vsync <= 1;
        in_den <= 0;
    
        in_data <= 8'h81;
      
        @(posedge in_clk)

        in_hsync <= 0;
        in_vsync <= 0;
        in_den <= 1;
    
        in_data <= 8'h12;
      
        @(posedge in_clk)
        
        in_hsync <= 0;
        in_vsync <= 0;
        in_den <= 0;
    
        in_data <= 8'h33;
      
        @(posedge in_clk)
        
        in_hsync <= 0;
        in_vsync <= 0;
        in_den <= 0;
    
        in_data <= 8'h21;
      
        @(posedge in_clk)
        
        in_hsync <= 0;
        in_vsync <= 0;
        in_den <= 1;
    
        in_data <= 8'h75;
      
        @(posedge in_clk)
        
        in_hsync <= 0;
        in_vsync <= 1;
        in_den <= 0;
    
        in_data <= 8'h45;
      
        @(posedge in_clk)

        in_hsync <= 0;
        in_vsync <= 1;
        in_den <= 0;
    
        in_data <= 8'h37;
      
        @(posedge in_clk)
  		#100;

  		$finish;

  	end;
  	

endmodule
