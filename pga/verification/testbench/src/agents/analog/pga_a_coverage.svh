class pga_a_coverage extends uvm_subscriber #(pga_a_packet);
    `uvm_component_utils(pga_a_coverage)
    
    pga_a_packet a_pkt;

    covergroup analog_cg;
        option.per_instance = 1;
        option.at_least = 20;

        frequency : coverpoint a_pkt.frequency{
            type_option.real_interval = 1e3;
            bins range[10] = {[5e6:10e6]};
        }

    endgroup : analog_cg

    function new(string name="pga_a_coverage", uvm_component parent);
        super.new(.name(name), .parent(parent));
        analog_cg = new();
    endfunction : new

    extern virtual function void write(pga_a_packet t);

endclass : pga_a_coverage

function void pga_a_coverage::write(pga_a_packet t);
    a_pkt = pga_a_packet::type_id::create(.name("a_pkt"), .contxt(get_full_name()));
    a_pkt.copy(t);
    analog_cg.sample();
endfunction :write