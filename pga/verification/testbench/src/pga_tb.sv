module pga_tb;

    `include "uvm_macros.svh"
    import uvm_pkg::*;
    import pga_pkg::*;
    
    pga_bridge pga_bridge();

    pga pga(
        .VCVGA(pga_bridge.d_if.VCVGA),
        .PD(pga_bridge.d_if.PD),
        .INN(pga_bridge.core.INN),
        .INP(pga_bridge.core.INP),
        .VDD(pga_bridge.core.VDD),
        .VSS(pga_bridge.core.VSS),
        .VB(pga_bridge.core.VB),
        .IBB(pga_bridge.core.IBB),
        .OUTP(pga_bridge.core.OUTP),
        .OUTN(pga_bridge.core.OUTN)
    );

    initial begin
        $cds_set_temperature(50);
        uvm_config_db#(pga_d_vif)::set(uvm_root::get(), "*", "d_vif", pga_bridge.d_if);
        uvm_config_db#(pga_bridge_proxy)::set(uvm_root::get(), "*", "proxy", pga_bridge.proxy);

    end

    initial begin
		`ifdef XCELIUM
			$recordvars();
		`endif
		`ifdef VCS
			$vcdpluson;
		`endif
		`ifdef QUESTA
			$w1fdumpvars();
			set_config_init("*", "recording _detail", 1);
		`endif
    end

    initial begin
        run_test("pga_test_base");
    end

endmodule