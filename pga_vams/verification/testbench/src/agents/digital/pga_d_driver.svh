class pga_d_driver extends uvm_driver#(pga_d_packet);
    `uvm_component_utils(pga_d_driver)
    
    pga_d_vif vif;
    real ts;

    
    function new(string name="pga_d_driver", uvm_component parent);
        super.new(.name(name), .parent(parent));
    endfunction : new

    extern function void build_phase(uvm_phase phase);

    extern task main_phase(uvm_phase phase);

endclass : pga_d_driver

function void pga_d_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);

endfunction : build_phase


task pga_d_driver::main_phase(uvm_phase phase);
    #10
    forever begin
        seq_item_port.get_next_item(req);
        begin_tr(req, "digital_driver");
        vif.gain <= req.gain;
        #(ts * 1ns)
        end_tr(req);
        seq_item_port.item_done();
    end

endtask : main_phase