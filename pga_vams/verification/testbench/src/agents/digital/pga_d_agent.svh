class pga_d_agent extends uvm_agent;
    `uvm_component_utils(pga_d_agent)

    uvm_analysis_port#(pga_d_packet) d_agt_port;
    
    pga_d_driver pga_drv;
    pga_d_monitor pga_mon;
    pga_d_sequencer pga_sqr;
    pga_d_coverage pga_d_cov;
    
    pga_d_vif vif;

    real ts_drv;

    function new(string name="pga_d_agent", uvm_component parent);
        super.new(.name(name), .parent(parent));
        d_agt_port = new("d_agt_port", this);
    endfunction : new

    extern function void build_phase(uvm_phase phase);

    extern function void connect_phase(uvm_phase phase);

endclass : pga_d_agent

function void pga_d_agent::build_phase(uvm_phase phase);
    super.build_phase(phase);

    assert(uvm_config_db#(pga_d_vif)::get(this, "", "d_vif", vif))
        else `uvm_fatal(get_type_name(), "Failed to get digital virtual interface")

    pga_drv = pga_d_driver::type_id::create(.name("pga_drv"), .parent(this));
    pga_mon = pga_d_monitor::type_id::create(.name("pga_mon"), .parent(this));
    pga_d_cov = pga_d_coverage::type_id::create(.name("pga_d_cov"), .parent(this));
    
    pga_sqr = pga_d_sequencer::type_id::create(.name("pga_sqr"), .parent(this));

    pga_drv.vif = vif;
    pga_mon.vif = vif;
    
    pga_drv.ts = ts_drv;
    
endfunction : build_phase


function void pga_d_agent::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    pga_drv.seq_item_port.connect(pga_sqr.seq_item_export);
    pga_mon.req_port.connect(d_agt_port);

    pga_mon.req_port.connect(pga_d_cov.analysis_export);

    
endfunction : connect_phase