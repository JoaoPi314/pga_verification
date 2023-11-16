class pga_random_sequence extends pga_virtual_sequence;
    `uvm_object_utils(pga_random_sequence)
    `uvm_declare_p_sequencer(pga_virtual_sequencer)

    pga_a_random_sequence a_seq;
    pga_d_random_sequence d_seq;

    function new(string name="pga_random_sequence");
        super.new(.name(name));
    endfunction : new

    extern task body();
    
endclass : pga_random_sequence


task pga_random_sequence::body();
    `uvm_info(get_type_name(), "I just entered the random_Sequence", UVM_NONE)
    
    fork
        `uvm_do_on(a_seq, p_sequencer.pga_a_sqr)
        `uvm_do_on(d_seq, p_sequencer.pga_d_sqr)
    join

    `uvm_info(get_type_name(), "I just finished the random_Sequence", UVM_NONE)

endtask : body