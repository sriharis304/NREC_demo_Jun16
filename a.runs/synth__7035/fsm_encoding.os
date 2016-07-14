
 add_fsm_encoding \
       {rd_chnl.rlast_sm_cs} \
       { }  \
       {{000 000} {001 010} {010 011} {011 100} {100 001} }

 add_fsm_encoding \
       {axi_data_fifo_v2_1_axic_reg_srl_fifo.state} \
       { }  \
       {{00 0100} {01 1000} {10 0001} {11 0010} }

 add_fsm_encoding \
       {axis_dwidth_converter_v1_1_axisc_upsizer.state} \
       { }  \
       {{000 00010} {001 00001} {010 10000} {011 00100} {101 01000} }

 add_fsm_encoding \
       {axis_dwidth_converter_v1_1_axisc_upsizer__parameterized0.state} \
       { }  \
       {{000 00010} {001 00001} {010 10000} {011 00100} {101 01000} }

 add_fsm_encoding \
       {serdes_1_to_7_mmcm_idelay_sdr.state2} \
       { }  \
       {{000 00001} {001 00010} {010 00100} {011 01000} {100 10000} }
