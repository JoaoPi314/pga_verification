# -debug_opts verisium_interactive
# -gui
GUI ?= OFF
A_TS_DRV ?= 200
A_TS_MON ?= 1
D_TS_DRV ?= 200
NUM_TRANSACTIONS ?= 100
VERBOSITY ?= UVM_MEDIUM
TEST_NAME ?= pga_test_sinusoidal
ELAB_PATH ?= ./
ELAB_NAME ?= pga_libs.d

ifeq ($(GUI), ON)
	GUI_OPTIONS = -debug_opts verisium_interactive
endif


all: elab run
run:
	g++ -g -fPIC -Wall -std=c++0x ../../refmodel/gain.cpp -shared -o test.so
	xrun -R -64 -input probe.tcl +access+rwc -timescale 1ns/1ns -sysv -ams -uvm -incdir ../src/ ../src/agents/digital/pga_d_if.sv ../src/pga_pkg.sv ../src/ms_bridge/pga_bridge_core.vams ../src/ms_bridge/pga_bridge.sv \
		../../../frontend/design/pga.vams ../src/pga_tb.sv   +UVM_VERBOSITY=$(VERBOSITY)  -svseed random +UVM_TESTNAME=$(TEST_NAME) +uvm_set_config_int=*,recording_detail,1 \
		$(GUI_OPTIONS) +A_TS_DRV=$(A_TS_DRV) +A_TS_MON=$(A_TS_MON) +D_TS_DRV=$(D_TS_DRV) +NUM_TRANSACTIONS=$(NUM_TRANSACTIONS) -sv_lib test.so -xmlibdirname $(ELAB_NAME) \

elab:
	g++ -g -fPIC -Wall -std=c++0x ../../refmodel/gain.cpp -shared -o test.so
	xrun -64 -elaborate +access+rwc -timescale 1ns/1ns -sysv -uvm -incdir ../src/ ../src/agents/digital/pga_d_if.sv ../src/pga_pkg.sv ../src/ms_bridge/pga_bridge_core.vams ../src/ms_bridge/pga_bridge.sv \
		../../../frontend/design/pga.vams ../src/pga_tb.sv -svseed random  +uvm_set_config_int=*,recording_detail,1 -coverage all -covoverwrite -xmlibdirpath $(ELAB_PATH) -xmlibdirname $(ELAB_NAME)\


clean:
	@rm -rf .simvision *.shm *.d *.dump xrun* *.diag *.vcd pga_tb* cov_work/ *.log verisium* *.db .verisium* *.err *.out *.so 


