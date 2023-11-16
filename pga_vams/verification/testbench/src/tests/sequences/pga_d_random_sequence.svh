class pga_d_random_sequence extends pga_d_base_sequence;
    `uvm_object_utils(pga_d_random_sequence)
    
    function new(string name="pga_d_random_sequence");
        super.new(.name(name));
    endfunction : new

    extern task body();

endclass : pga_d_random_sequence

task pga_d_random_sequence::body();
    `uvm_create(req)
    // req.pd_always_on.constraint_mode(0);
    req.randomize() with {
        req.gain <= 175;
    };
    `uvm_send(req);
endtask : body