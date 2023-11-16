class pga_d_sequencer extends uvm_sequencer#(pga_d_packet);
    `uvm_component_utils(pga_d_sequencer)

    function new(string name = "pga_d_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    extern virtual function void build_phase(uvm_phase phase);
    
endclass: pga_d_sequencer

function void pga_d_sequencer::build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction: build_phase