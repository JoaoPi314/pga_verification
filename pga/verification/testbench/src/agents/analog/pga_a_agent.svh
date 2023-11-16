class pga_a_agent extends uvm_agent;
    `uvm_component_utils(pga_a_agent)

    uvm_analysis_port#(pga_a_packet) a_agt_port_out;
    uvm_analysis_port#(pga_a_packet) a_agt_port_in;

    pga_a_driver pga_drv;
    pga_a_monitor pga_mon;
    pga_a_sequencer pga_sqr;
    pga_a_coverage pga_a_cov;

    real ts_drv, ts_mon;

    function new(string name="pga_a_agent", uvm_component parent);
        super.new(.name(name), .parent(parent));
        a_agt_port_in = new("a_agt_port_in", this);
        a_agt_port_out = new("a_agt_port_out", this);

    endfunction : new

    extern function void build_phase(uvm_phase phase);

    extern function void connect_phase(uvm_phase phase);

endclass : pga_a_agent

function void pga_a_agent::build_phase(uvm_phase phase);
    super.build_phase(phase);

    pga_drv = pga_a_driver::type_id::create(.name("pga_drv"), .parent(this));
    pga_mon = pga_a_monitor::type_id::create(.name("pga_mon"), .parent(this));
    
    pga_sqr = pga_a_sequencer::type_id::create(.name("pga_sqr"), .parent(this));
    pga_a_cov = pga_a_coverage::type_id::create(.name("pga_a_cov"), .parent(this));

    pga_drv.ts = ts_drv;
    pga_mon.ts = ts_mon;
endfunction : build_phase


function void pga_a_agent::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    pga_drv.seq_item_port.connect(pga_sqr.seq_item_export);
    pga_mon.req_port.connect(a_agt_port_in);
    pga_mon.rsp_port.connect(a_agt_port_out);
    pga_mon.req_port.connect(pga_a_cov.analysis_export);

    
endfunction : connect_phase