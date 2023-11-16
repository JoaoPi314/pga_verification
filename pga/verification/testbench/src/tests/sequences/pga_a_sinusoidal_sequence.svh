class pga_a_sinusoidal_sequence extends pga_a_base_sequence;
    `uvm_object_utils(pga_a_sinusoidal_sequence)
    
    function new(string name="pga_a_sinusoidal_sequence");
        super.new(.name(name));
    endfunction : new

    extern task body();

endclass : pga_a_sinusoidal_sequence

task pga_a_sinusoidal_sequence::body();
    `uvm_create(req)
    req.randomize() with{
        req.amplitude == 1;
        req.frequency == 15e6;
        req.bias == 0;
        req.phase == 0;
        
        req.vdd == 12;
        req.vss == 0;
    };
    `uvm_send(req)

endtask : body