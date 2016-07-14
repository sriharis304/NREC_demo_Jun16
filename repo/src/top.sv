module bram_mask #(parameter integer DW = 16) 
   (input                 clk, // same for all things in here
    input                 rst,

    // bram used for frame data
    output                bram_rst0,
    output                bram_clk0,
    output logic [31:0]   bram_din0,
    input logic [31:0]    bram_dout0,
    output                bram_en0,
    output logic          bram_we0,
    output logic [31:0]   bram_addr0,
    
    output                bram_rst1,
    output                bram_clk1,
    output logic [31:0]   bram_din1,
    input logic [31:0]    bram_dout1,
    output                bram_en1,
    output logic          bram_we1,
    output logic [31:0]   bram_addr1,
    // strean into module
    input wire [DW-1:0]   v_s_tdata,
    input wire            v_s_tvalid,
    output logic          v_s_tready,
    input wire            v_s_tlast,
    input wire            v_s_tuser,

    // stream out
    output logic [DW-1:0] v_m_tdata,
    output logic          v_m_tvalid,
    input wire            v_m_tready,
    output logic          v_m_tlast,
    output logic          v_m_tuser,

    //allow different brightness
    (* dont_touch = "yes"*)input wire [3:0]      bright_val0,
    (* dont_touch = "yes"*)input wire [3:0]      bright_val1
    );
   
   (* dont_touch = "yes"*) reg [7:0] pwm_LUT [8:0];
   always @(posedge clk)
   begin
        if(rst)
        begin
            pwm_LUT[8] = 8'b11111111;
            pwm_LUT[7] = 8'b01111111;
            pwm_LUT[6] = 8'b01110111;
            pwm_LUT[5] = 8'b01101101;
            pwm_LUT[4] = 8'b01010101;
            pwm_LUT[3] = 8'b10010010;
            pwm_LUT[2] = 8'b10001000;
            pwm_LUT[1] = 8'b10000000;
            pwm_LUT[0] = 8'b00000000;
        end
   end  
   // we don't write to BRAM
   assign bram_en0 = 1;
   assign bram_we0 = 0;
   assign bram_din0 = 0;
   assign bram_en1 = 1;
   assign bram_we1 = 0;
   assign bram_din1 = 0;
   // these signals are the same
   assign bram_rst0 = rst;
   assign bram_clk0 = clk;
   assign bram_rst1 = rst;
   assign bram_clk1 = clk;

   //pwm the mask
   logic [2:0]            pwm_count;
   logic [DW-1:0]         frame_on0;
   //logic [2:0]            pwm_count1;
   logic [DW-1:0]         frame_on1;
   
   //May be too slow
   always_comb begin
      /*if({1'b0,pwm_count} < bright_val0) begin
         frame_on0 = 16'hffff;
      end
      else begin
         frame_on0 = 16'h0000;
      end*/
      frame_on0 = {16{pwm_LUT[bright_val0][pwm_count]}};
   end
   always_comb begin
   /*
         if({1'b0,pwm_count} < bright_val1) begin
            frame_on1 = 16'hffff;
         end
         else begin
            frame_on1 = 16'h0000;
         end*/
         frame_on1 = {16{pwm_LUT[bright_val1][pwm_count]}};
   end
   //Logic for reading bot 16bit words
   logic stepAddress = 0;

   
   
   
   
   // buffering some input signals by 2 cycles to stay in sync with data
   logic [15:0]           v_s_tdata_r0;
   logic [15:0]           v_s_tdata_r1;
   
   logic                  v_s_tvalid_r0;
   logic                  v_s_tvalid_r1;
   
   logic                  v_s_tlast_r0;
   logic                  v_s_tlast_r1;
   
   logic                  v_s_tuser_r0;
   logic                  v_s_tuser_r1;
   
   
   assign v_s_tready = v_m_tready; // instant, since the whole pipeline stops
   
   // zero all bits in data corresponding to 1's in the bram mask
   always_comb begin
       if(stepAddress)begin
          v_m_tdata = v_s_tdata_r1 & ((bram_dout0[DW-1:0] & frame_on0) | (bram_dout1[DW-1:0] & frame_on1));
       end else begin
          v_m_tdata = v_s_tdata_r1 & ((bram_dout0[31:DW] & frame_on0) | (bram_dout1[31:DW] & frame_on1));
       end
   end
   
   
   always_ff @(posedge clk) begin
      if(rst) begin
         bram_addr0 <= 0;
         bram_addr1 <= 0;
         pwm_count <=0;


         
      end else if (v_m_tready) begin // stop the show if not ready
         v_s_tvalid_r0 <= v_s_tvalid;
         v_m_tvalid <= v_s_tvalid_r0;

         v_s_tlast_r0 <= v_s_tlast;
         v_m_tlast <= v_s_tlast_r0;
         
         v_s_tuser_r0 <= v_s_tuser;
         v_m_tuser <= v_s_tuser_r0;
         
         v_s_tdata_r0 <= v_s_tdata;
         v_s_tdata_r1 <= v_s_tdata_r0;
         //v_m_tdata <= v_s_tdata_r0 & ~bram_dout[DW-1:0];
         
         if(v_s_tuser) begin
            bram_addr0 <= 0;
            bram_addr1 <= 0;
            
            stepAddress <= 0;
            if(~v_s_tuser_r0) begin
                pwm_count <= pwm_count + 1;
            end
         end else if(v_s_tvalid) begin
            stepAddress <= ~stepAddress;

            if(stepAddress) begin
                bram_addr0 <= bram_addr0 + 4;
                bram_addr1 <= bram_addr1 + 4;
            end

         end
         
      end
      
      
   end
   
endmodule
