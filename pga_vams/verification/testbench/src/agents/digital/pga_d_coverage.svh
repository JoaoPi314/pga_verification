class pga_d_coverage extends uvm_subscriber #(pga_d_packet);
    `uvm_component_utils(pga_d_coverage)
    
    pga_d_packet d_pkt;

    covergroup digital_gain_cg;
        option.per_instance = 1;
        option.at_least = 20;

        gain : coverpoint d_pkt.gain;

    endgroup : digital_gain_cg

    function new(string name="pga_d_coverage", uvm_component parent);
        super.new(.name(name), .parent(parent));
        digital_gain_cg = new();
    endfunction : new

    extern virtual function void write(pga_d_packet t);

endclass : pga_d_coverage

function void pga_d_coverage::write(pga_d_packet t);
    d_pkt = pga_d_packet::type_id::create(.name("d_pkt"), .contxt(get_full_name()));
    d_pkt.copy(t);
    digital_gain_cg.sample();
endfunction :write