class pga_test_base extends uvm_test;
    `uvm_component_utils(pga_test_base)
    
    pga_env env;

    real d_ts_drv, a_ts_drv, a_ts_mon;

    int num_transactions;

    function new(string name="pga_test_base", uvm_component parent);
        super.new(.name(name), .parent(parent));
        num_transactions = 100;
    endfunction : new

    extern function void build_phase(uvm_phase phase);

    extern function void end_of_elaboration_phase(uvm_phase phase);
endclass : pga_test_base

function void pga_test_base::build_phase(uvm_phase phase);
    super.build_phase(phase);

    if($value$plusargs("A_TS_DRV=%f", a_ts_drv))
        `uvm_info(get_type_name(), "Loaded Sample time form Makefile into Analog driver", UVM_HIGH)

    if($value$plusargs("D_TS_DRV=%f", d_ts_drv))
        `uvm_info(get_type_name(), "Loaded Sample time form Makefile into Digital driver", UVM_HIGH)
        
    if($value$plusargs("A_TS_MON=%f", a_ts_mon))
        `uvm_info(get_type_name(), "Loaded Sample time form Makefile into Analog monitor", UVM_HIGH)

    if($value$plusargs("NUM_TRANSACTIONS=%d", num_transactions))
        `uvm_info(get_type_name(), "Loaded num of transactions into test base", UVM_HIGH)
    

    env = pga_env::type_id::create(.name("env"), .parent(this));
    
    env.a_ts_drv = a_ts_drv;
    env.a_ts_mon = a_ts_mon;
    env.d_ts_drv = d_ts_drv;
endfunction : build_phase

function void pga_test_base::end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
endfunction : end_of_elaboration_phase