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

        function real get_inn_voltage();
            return core.get_inn_voltage(0);
        endfunction

        function real get_out_voltage();
            return core.get_out_voltage(0);
        endfunction

         // Pull functions
        function void get_wave_parameters();
            freq = core.freq_in;
            ampl_in = get_inn_voltage();
            ampl_out = get_out_voltage();
        endfunction : set_wave_parameters
        
    endclass : pga_proxy
    
    pga_proxy proxy = new();

    pga_bridge_core core();

endmodule : pga_bridge