class pga_comparator extends uvm_component;
    `uvm_component_utils(pga_comparator)

    uvm_tlm_analysis_fifo #(pga_a_packet) from_monitor_out;
    uvm_tlm_analysis_fifo #(pga_a_packet) from_refmod;

    pga_a_packet rfm_pkt, mon_pkt;

    int match_count;
    int miss_count;

    event got_mon_packet, got_rfm_packet;

    function new(string name="pga_comparator", uvm_component parent);
        super.new(.name(name), .parent(parent));

        match_count = 0;
        miss_count = 0;

        from_monitor_out = new("from_monitor_out", this);
        from_refmod = new("from_refmod", this);
    endfunction : new

    extern task main_phase(uvm_phase phase);

    extern function void report_phase(uvm_phase phase);

endclass : pga_comparator

task pga_comparator::main_phase(uvm_phase phase);
    forever begin

        from_monitor_out.get_peek_export.get(mon_pkt);
        from_refmod.get_peek_export.get(rfm_pkt);

        if(rfm_pkt != null && mon_pkt != null) begin 
            rfm_pkt.compare(mon_pkt);
            if(~mon_pkt.compare(rfm_pkt)) begin
                `uvm_error("MISSMATCH_CMP", $sformatf("Missmatch comparing %s with %s. %f - %f exceeds the tolerance of %f\%", mon_pkt.get_full_name(), rfm_pkt.get_full_name(), mon_pkt.amplitude, rfm_pkt.amplitude, rfm_pkt.TOLERANCE))
                miss_count++;
            end else begin
                `uvm_info("MATCH_CMP", $sformatf("match comparing %s with %s", mon_pkt.get_type_name(), rfm_pkt.get_type_name()), UVM_HIGH)
                match_count++;
            end
        end
    end

endtask : main_phase


function void pga_comparator::report_phase(uvm_phase phase);

    string message_report;

    if(miss_count == 0) begin
        message_report = "\n\
        __/\\\\\\\\\\\\\\\\\\\\\\\\\\_______/\\\\\\\\\\\\\\\\\\________/\\\\\\\\\\\\\\\\\\\\\\_______/\\\\\\\\\\\\\\\\\\\\\\___        \n\
         _\\/\\\\\\/////////\\\\\\___/\\\\\\\\\\\\\\\\\\\\\\\\\\____/\\\\\\/////////\\\\\\___/\\\\\\/////////\\\\\\_       \n\
          _\\/\\\\\\_______\\/\\\\\\__/\\\\\\/////////\\\\\\__\\//\\\\\\______\\///___\\//\\\\\\______\\///__      \n\
           _\\/\\\\\\\\\\\\\\\\\\\\\\\\\\/__\\/\\\\\\_______\\/\\\\\\___\\////\\\\\\___________\\////\\\\\\_________     \n\
            _\\/\\\\\\/////////____\\/\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\______\\////\\\\\\___________\\////\\\\\\______    \n\
             _\\/\\\\\\_____________\\/\\\\\\/////////\\\\\\_________\\////\\\\\\___________\\////\\\\\\___   \n\
              _\\/\\\\\\_____________\\/\\\\\\_______\\/\\\\\\__/\\\\\\______\\//\\\\\\___/\\\\\\______\\//\\\\\\__  \n\
               _\\/\\\\\\_____________\\/\\\\\\_______\\/\\\\\\_\\///\\\\\\\\\\\\\\\\\\\\\\/___\\///\\\\\\\\\\\\\\\\\\\\\\/___ \n\
                _\\///______________\\///________\\///____\\///////////_______\\///////////_____\n\n\
        ";
    
    end else begin
        message_report = "\n\
        __/\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\_____/\\\\\\\\\\\\\\\\\\_____/\\\\\\\\\\\\\\\\\\\\\\__/\\\\\\_____________        \n\
         _\\/\\\\\\///////////____/\\\\\\\\\\\\\\\\\\\\\\\\\\__\\/////\\\\\\///__\\/\\\\\\_____________       \n\
          _\\/\\\\\\______________/\\\\\\/////////\\\\\\_____\\/\\\\\\_____\\/\\\\\\_____________      \n\
           _\\/\\\\\\\\\\\\\\\\\\\\\\_____\\/\\\\\\_______\\/\\\\\\_____\\/\\\\\\_____\\/\\\\\\_____________     \n\
            _\\/\\\\\\///////______\\/\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\_____\\/\\\\\\_____\\/\\\\\\_____________    \n\
             _\\/\\\\\\_____________\\/\\\\\\/////////\\\\\\_____\\/\\\\\\_____\\/\\\\\\_____________   \n\
              _\\/\\\\\\_____________\\/\\\\\\_______\\/\\\\\\_____\\/\\\\\\_____\\/\\\\\\_____________  \n\
               _\\/\\\\\\_____________\\/\\\\\\_______\\/\\\\\\__/\\\\\\\\\\\\\\\\\\\\\\_\\/\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\_ \n\
                _\\///______________\\///________\\///__\\///////////__\\///////////////__\n\
        ";
    end

    `uvm_info(get_type_name(), $sformatf("%s\n - Total Match = %d\n - Total Missmatch = %d\n", message_report, match_count, miss_count), UVM_NONE)


endfunction : report_phase