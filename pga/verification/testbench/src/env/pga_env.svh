class pga_env extends uvm_env;
    `uvm_component_utils(pga_env)

    pga_a_agent pga_a_agt;
    pga_d_agent pga_d_agt;

    pga_scoreboard pga_scb;

    pga_virtual_sequencer pga_v_sqr;
    real d_ts_drv, a_ts_drv, a_ts_mon;

    function new(string name="pga_env", uvm_component parent);
        super.new(.name(name), .parent(parent));
    endfunction : new

    extern function void build_phase(uvm_phase phase);

    extern function void connect_phase(uvm_phase phase);

endclass : pga_env

function void pga_env::build_phase(uvm_phase phase);
    super.build_phase(phase);

    pga_d_agt = pga_d_agent::type_id::create(.name("pga_d_agt"), .parent(this));
    pga_a_agt = pga_a_agent::type_id::create(.name("pga_a_agt"), .parent(this));

    pga_scb = pga_scoreboard::type_id::create(.name("pga_scb"), .parent(this));

    pga_d_agt.ts_drv = d_ts_drv;
    pga_a_agt.ts_drv = a_ts_drv;
    pga_a_agt.ts_mon = a_ts_mon;

    pga_v_sqr = pga_virtual_sequencer::type_id::create(.name("pga_v_sqr"), .parent(this));
endfunction : build_phase

function void pga_env::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    pga_v_sqr.pga_a_sqr = pga_a_agt.pga_sqr;
    pga_v_sqr.pga_d_sqr = pga_d_agt.pga_sqr;

    pga_a_agt.a_agt_port_out.connect(pga_scb.a_comp_port);
    pga_a_agt.a_agt_port_in.connect(pga_scb.a_rfm_port);
    pga_d_agt.d_agt_port.connect(pga_scb.d_rfm_port);

endfunction : connect_phase