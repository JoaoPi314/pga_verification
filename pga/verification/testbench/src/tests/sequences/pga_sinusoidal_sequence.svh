class pga_sinusoidal_sequence extends pga_virtual_sequence;
    `uvm_object_utils(pga_sinusoidal_sequence)
    `uvm_declare_p_sequencer(pga_virtual_sequencer)

    pga_a_sinusoidal_sequence a_seq;
    pga_d_random_sequence d_seq;

    function new(string name="pga_sinusoidal_sequence");
        super.new(.name(name));
    endfunction : new

    extern task body();
    
endclass : pga_sinusoidal_sequence


task pga_sinusoidal_sequence::body();
    
    fork
        `uvm_do_on(a_seq, p_sequencer.pga_a_sqr)
        `uvm_do_on(d_seq, p_sequencer.pga_d_sqr)
    join_any


endtask : body