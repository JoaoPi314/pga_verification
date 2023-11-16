class pga_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(pga_scoreboard)
    
    typedef pga_a_packet T;
    // typedef uvm_in_order_class_comparator #(T) pga_comparator;

    pga_comparator pga_comp;
    pga_refmod pga_rfm;

    uvm_analysis_port#(pga_a_packet) a_rfm_port;
    uvm_analysis_port#(pga_d_packet) d_rfm_port;
    uvm_analysis_port#(pga_a_packet) a_comp_port;

    function new(string name="pga_scoreboard", uvm_component parent);
        super.new(.name(name), .parent(parent));

        a_rfm_port = new("a_rfm_port", this);
        d_rfm_port = new("d_rfm_port", this);
        a_comp_port = new("a_comp_port", this);
    endfunction : new

    extern function void build_phase(uvm_phase phase);

    extern function void connect_phase(uvm_phase phase);

endclass : pga_scoreboard


function void pga_scoreboard::build_phase(uvm_phase phase);
    super.build_phase(phase);

    pga_comp = pga_comparator::type_id::create(.name("pga_comp"), .parent(this));
    pga_rfm = pga_refmod::type_id::create(.name("pga_rfm"), .parent(this));
    
endfunction : pga_scoreboard

function void pga_scoreboard::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    a_rfm_port.connect(pga_rfm.a_in_port);
    d_rfm_port.connect(pga_rfm.d_in_port);
    a_comp_port.connect(pga_comp.from_monitor_out.analysis_export);

    pga_rfm.a_out_port.connect(pga_comp.from_refmod.analysis_export);

endfunction : connect_phase