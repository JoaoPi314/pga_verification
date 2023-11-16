class pga_d_packet extends uvm_sequence_item;
    
    rand bit [2:0] vcvga;
    rand bit pd;
    
    `uvm_object_utils_begin(pga_d_packet)
        `uvm_field_int(vcvga, UVM_ALL_ON)
        `uvm_field_int(pd, UVM_ALL_ON)
    `uvm_object_utils_end
    
    constraint pd_always_on{
        pd == 1'b0;
    }
    
    function new(string name="pga_d_packet");
        super.new(.name(name));
    endfunction

endclass : pga_d_packet