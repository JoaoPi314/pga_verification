virtual class pga_bridge_proxy;
    real ampl_in;
    real ampl_out;
    real freq;
    real pha;
    real bias;

    real vdd;
    real vss;
    real ibb;
    real vb;
    
    // Push functions
    pure virtual function void set_wave_parameters();
    pure virtual function void set_power_parameters();

    // Pull functions
    pure virtual function void get_wave_parameters();
    pure virtual function void get_power_parameters();

endclass : pga_bridge_proxy
