class pga_a_random_sequence extends pga_a_base_sequence;
    `uvm_object_utils(pga_a_random_sequence)
    
    function new(string name="pga_a_random_sequence");
        super.new(.name(name));
    endfunction : new

    extern task body();

endclass : pga_a_random_sequence

task pga_a_random_sequence::body();
    `uvm_do(req)
endtask : body