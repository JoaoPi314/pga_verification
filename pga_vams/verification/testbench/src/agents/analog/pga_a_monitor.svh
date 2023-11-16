class pga_a_monitor extends uvm_monitor;
    `uvm_component_utils(pga_a_monitor)

    pga_a_packet rsp_pkt, req_pkt;
    uvm_analysis_port#(pga_a_packet) rsp_port;
    uvm_analysis_port#(pga_a_packet) req_port;

    pga_bridge_proxy proxy;

    real ts;

    function new(string name="pga_a_monitor", uvm_component parent);
        super.new(.name(name), .parent(parent));
        rsp_port = new("rsp_port", this);
        req_port = new("req_port", this);

    endfunction

    extern function void build_phase(uvm_phase phase);

    extern task main_phase(uvm_phase phase);

    extern task collect_analog_in();

    extern task collect_analog_out();
endclass : pga_a_monitor


function void pga_a_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);
    assert(uvm_config_db#(pga_bridge_proxy)::get(this, "", "proxy", proxy))
    else `uvm_fatal(get_type_name(), "Failed to get analog proxy")

    rsp_pkt = pga_a_packet::type_id::create(.name("rsp_pkt"), .contxt(get_full_name()));
    req_pkt = pga_a_packet::type_id::create(.name("req_pkt"), .contxt(get_full_name()));

endfunction : build_phase

task pga_a_monitor::main_phase(uvm_phase phase);
    #10
    forever begin
        fork
            collect_analog_in();
            collect_analog_out();
        join
    end
endtask : main_phase

task pga_a_monitor::collect_analog_out();
    #(ts * 0.5ns)
    begin_tr(rsp_pkt, "analog_monitor_out");
    proxy.get_wave_parameters();
    rsp_pkt.amplitude = proxy.ampl_out;
    rsp_port.write(rsp_pkt);
    #(ts * 0.5ns)
    end_tr(rsp_pkt);
endtask : collect_analog_out

task pga_a_monitor::collect_analog_in();
    #(ts * 0.5ns)
    begin_tr(req_pkt, "analog_monitor_in");
    proxy.get_wave_parameters();
    req_pkt.amplitude = proxy.ampl_in;
    req_pkt.frequency = proxy.freq;
    req_port.write(req_pkt);
    #(ts * 0.5ns)
    end_tr(req_pkt);
endtask : collect_analog_in