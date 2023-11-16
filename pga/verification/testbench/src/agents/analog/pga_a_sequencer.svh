class pga_a_sequencer extends uvm_sequencer#(pga_a_packet);
    `uvm_component_utils(pga_a_sequencer)

    function new(string name = "pga_a_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    extern virtual function void build_phase(uvm_phase phase);
    
endclass: pga_a_sequencer

function void pga_a_sequencer::build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction: build_phase