import "DPI-C" context function real calculateAmplitude(real ampl_in, int vcvga, real vdd, real vss);​

`uvm_analysis_imp_decl(_a)
`uvm_analysis_imp_decl(_d)

class pga_refmod extends uvm_component;
    `uvm_component_utils(pga_refmod)

    pga_a_packet a_rfm_in;
    pga_a_packet a_rfm_out;
    pga_d_packet d_rfm_in;

    uvm_analysis_imp_a #(pga_a_packet, pga_refmod) a_in_port;
    uvm_analysis_imp_d #(pga_d_packet, pga_refmod) d_in_port;
    uvm_analysis_port #(pga_a_packet) a_out_port;

    event begin_refmod_task;

    function new(string name="pga_refmod", uvm_component parent);
        super.new(.name(name), .parent(parent));
        a_in_port = new("a_in_port", this);
        d_in_port = new("d_in_port", this);
        a_out_port = new("a_out_port", this);
    endfunction : new

    extern function void build_phase(uvm_phase phase);

    extern virtual function write_a(pga_a_packet t);
    extern virtual function write_d(pga_d_packet t);

    extern task main_phase(uvm_phase phase);

endclass : pga_refmod

function void pga_refmod::build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction : build_phase

function pga_refmod::write_a(pga_a_packet t);
    a_rfm_in = pga_a_packet::type_id::create(.name("a_rfm_in"), .contxt(get_full_name()));
    a_rfm_in.copy(t);
    ->begin_refmod_task;
endfunction : write_a
    
function pga_refmod::write_d(pga_d_packet t);
    d_rfm_in = pga_d_packet::type_id::create(.name("d_rfm_in"), .contxt(get_full_name()));
    d_rfm_in.copy(t);
endfunction : write_d


task pga_refmod::main_phase(uvm_phase phase);
    forever begin

        @(begin_refmod_task);
        
        if(~d_rfm_in.pd) begin 
            a_rfm_out = pga_a_packet::type_id::create(.name("a_rfm_out"), .contxt(get_full_name()));
            a_rfm_out.small_wave_values.constraint_mode(0);
            // Apply gain
            a_rfm_out.amplitude = calculateAmplitude(a_rfm_in.amplitude, d_rfm_in.vcvga, a_rfm_in.vdd, a_rfm_in.vss);
            a_out_port.write(a_rfm_out);
        end
        

    end

endtask : main_phase