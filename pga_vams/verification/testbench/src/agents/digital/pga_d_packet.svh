class pga_d_packet extends uvm_sequence_item;
    
    rand bit [7:0] gain;
    
    `uvm_object_utils_begin(pga_d_packet)
        `uvm_field_int(gain, UVM_ALL_ON)
    `uvm_object_utils_end
    
    function new(string name="pga_d_packet");
        super.new(.name(name));
    endfunction

endclass : pga_d_packet