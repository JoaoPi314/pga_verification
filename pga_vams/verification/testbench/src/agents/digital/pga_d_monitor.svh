class pga_d_monitor extends uvm_monitor;
    `uvm_component_utils(pga_d_monitor)

    pga_d_packet req_pkt;
    uvm_analysis_port#(pga_d_packet) req_port;

    pga_d_vif vif;

    function new(string name="pga_d_monitor", uvm_component parent);
        super.new(.name(name), .parent(parent));
        req_port = new("req_port", this);
    endfunction

    extern function void build_phase(uvm_phase phase);

    extern task main_phase(uvm_phase phase);
endclass : pga_d_monitor


function void pga_d_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);

    req_pkt = pga_d_packet::type_id::create(.name("req_pkt"), .contxt(get_full_name()));
endfunction : build_phase

task pga_d_monitor::main_phase(uvm_phase phase);
    forever begin
        @(vif.gain);
        begin_tr(req_pkt, "digital_monitor");
        req_pkt.gain = vif.gain;
        req_port.write(req_pkt);
        end_tr(req_pkt);
    end
endtask : main_phase