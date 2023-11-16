class pga_a_driver extends uvm_driver#(pga_a_packet);
    `uvm_component_utils(pga_a_driver)
    
    pga_bridge_proxy proxy;
    real ts;

    function new(string name="pga_a_driver", uvm_component parent);
        super.new(.name(name), .parent(parent));
    endfunction : new

    extern function void build_phase(uvm_phase phase);

    extern task main_phase(uvm_phase phase);

endclass : pga_a_driver

function void pga_a_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);

    assert(uvm_config_db#(pga_bridge_proxy)::get(this, "", "proxy", proxy))
    else `uvm_fatal(get_type_name(), "Failed to get analog proxy")
    
endfunction : build_phase


task pga_a_driver::main_phase(uvm_phase phase);
    #10
    forever begin
        seq_item_port.get_next_item(req);
        begin_tr(req, "analog_driver");
        // Power supply
        proxy.vdd = req.vdd;
        proxy.vss = req.vss;
        proxy.ibb = req.bias_current;
        proxy.vb = req.bias_voltage;
        proxy.set_power_parameters();

        // Waveform
        proxy.ampl_in = req.amplitude;
        proxy.freq = req.frequency;
        proxy.pha = req.phase;
        proxy.bias = req.bias;
        proxy.set_wave_parameters();

        #(ts * 1ns)
        end_tr(req);
        seq_item_port.item_done();
    end

endtask : main_phase