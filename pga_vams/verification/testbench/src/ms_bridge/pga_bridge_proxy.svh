virtual class pga_bridge_proxy;
    real ampl_in;
    real ampl_out;
    real freq;
    real pha;
    real bias;

    // Push functions
    pure virtual function void set_wave_parameters();

    // Pull functions
    pure virtual function void get_wave_parameters();

    // Auxiliar functions
    pure virtual function real get_inn_voltage();
    pure virtual function real get_out_voltage();

endclass : pga_bridge_proxy