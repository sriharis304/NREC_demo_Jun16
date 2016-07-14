module bram_mask #(parameter integer DW = 16) (
        input clk, // same for all things in here
        input rst,
        
        // bram used for frame data
        output bram_rst,
        output bram_clk,
        output logic [31:0] bram_din,
        input logic [31:0] bram_dout,
        output bram_en,
        output logic bram_we,
        output logic [31:0] bram_addr,
                
        // strean into module
        input  wire [DW-1:0] v_s_tdata,
        input  wire v_s_tvalid,
        output logic v_s_tready,
        input  wire v_s_tlast,
        input  wire v_s_tuser,
       
        // stream out
        output logic [DW-1:0] v_m_tdata,
        output logic v_m_tvalid,
        input  wire v_m_tready,
        output logic v_m_tlast,
        output logic v_m_tuser
        );
    
    // we don't write to BRAM
    assign bram_en = 1;
    assign bram_we = 0;
    assign bram_din = 0;
    
    // these signals are the same
    assign bram_rst = rst;
    assign bram_clk = clk;
    
    
    
    // zero all bits in data corresponding to 1's in the bram mask
    assign v_m_tdata = v_s_tdata_r1 | bram_dout[DW-1:0];
    
    
    
    // buffering some input signals by 2 cycles to stay in sync with data
    logic [15:0] v_s_tdata_r0;
    logic [15:0] v_s_tdata_r1;
    
    logic v_s_tvalid_r0;
    logic v_s_tvalid_r1;
      
    logic v_s_tlast_r0;
    logic v_s_tlast_r1;
  
    logic v_s_tuser_r0;
    logic v_s_tuser_r1;
        
    assign v_s_tready = v_m_tready; // instant, since the whole pipeline stops
    
    
    always_ff @(posedge clk) begin
        if(rst) begin
            bram_addr <= 0;
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
            
            if(v_s_tuser ) begin
                bram_addr <= 0;
            end else if(v_s_tvalid) begin
                bram_addr <= bram_addr + 4;
            end
        
        end
        
        
    end
    
endmodule
