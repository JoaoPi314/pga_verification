class pga_a_base_sequence extends uvm_sequence#(pga_a_packet);
    `uvm_object_utils(pga_a_base_sequence)
    
    function new(string name="pga_a_base_sequence");
        super.new(.name(name));
    endfunction : new

    extern task pre_body();

    extern task post_body();
endclass : pga_a_base_sequence

task pga_a_base_sequence::pre_body();
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

task pga_a_base_sequence::post_body();
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