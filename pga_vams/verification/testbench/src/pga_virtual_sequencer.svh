class pga_virtual_sequencer extends uvm_sequencer;
    `uvm_component_utils(pga_virtual_sequencer)
    
    function new(string name="pga_virtual_sequencer", uvm_component parent);
        super.new(.name(name), .parent(parent));
    endfunction : new

    pga_d_sequencer pga_d_sqr;
    pga_a_sequencer pga_a_sqr;

endclass : pga_virtual_sequencer