module pga_bridge();
    import pga_pkg::*;
    pga_d_if d_if();

    class pga_proxy extends pga_bridge_proxy;
    
         // Push functions
        function void set_wave_parameters();
            core.a_in = ampl_in;
            core.freq_in = freq;
            core.pha_in = pha;
            core.bias_in = bias;
        endfunction : set_wave_parameters
        
        function void set_power_parameters();
            core.VDD_in = vdd;
            core.VSS_in = vss;
            core.IBB_in = ibb;
            core.VB_in = vb;
        endfunction : set_power_parameters
    
         // Pull functions
        function void get_wave_parameters();
            ampl_in = core.ampl_in;
            ampl_out = core.ampl_out;
            freq = core.freq_in;
        endfunction : set_wave_parameters
        
        function void get_power_parameters();
            vdd = core.VDD_out;
            vss = core.VSS_out;
            ibb = core.IBB_out;
            vb = core.VB_out;
        endfunction : set_power_parameters
    
    endclass : pga_proxy
    
    pga_proxy proxy = new();

    pga_bridge_core core();

endmodule : pga_bridge