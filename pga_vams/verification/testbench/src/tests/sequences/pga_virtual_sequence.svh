class pga_virtual_sequence extends uvm_sequence;
    `uvm_object_utils(pga_virtual_sequence)
    `uvm_declare_p_sequencer(pga_virtual_sequencer)

    function new(string name="pga_virtual_sequence");
        super.new(.name(name));
    endfunction : new

    extern task pre_body();

    extern task post_body();
endclass : pga_virtual_sequence

task pga_virtual_sequence::pre_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
        phase = get_starting_phase();
    `else 
        phase = starting_phase;
    `endif

    if(phase != null) begin
        phase.raise_objection(this, get_type_name());
        `uvm_info(get_type_name(), "Raised objection...", UVM_MEDIUM)        
    end
endtask: pre_body

task pga_virtual_sequence::post_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
        phase = get_starting_phase();
    `else 
        phase = starting_phase;
    `endif
    
    if(phase != null) begin
        phase.drop_objection(this, get_type_name());
        `uvm_info(get_type_name(), "Dropped objection...", UVM_MEDIUM)        
    end
endtask : post_body
    