class pga_test_random extends pga_test_base;
    `uvm_component_utils(pga_test_random)
    
    pga_random_sequence seq;

    function new(string name="pga_test_random", uvm_component parent);
        super.new(.name(name), .parent(parent));
    endfunction

    extern function void build_phase(uvm_phase phase);

    extern task main_phase(uvm_phase phase);
endclass

function void pga_test_random::build_phase(uvm_phase phase);
    super.build_phase(phase);

endfunction : build_phase

task pga_test_random::main_phase(uvm_phase phase);
    phase.raise_objection(this);
        
    for(int i = 0; i < 100; i++) begin
        seq = pga_random_sequence::type_id::create(.name("seq"), .contxt(get_full_name()));
        seq.start(env.pga_v_sqr);
    end


    phase.phase_done.set_drain_time(this, 200);
    phase.drop_objection(this);

endtask : build_phase