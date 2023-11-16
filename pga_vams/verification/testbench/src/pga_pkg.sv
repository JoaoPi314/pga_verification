package pga_pkg;
    `include "uvm_macros.svh"
    import uvm_pkg::*;

    typedef virtual pga_d_if.mst pga_d_vif;
    typedef enum int {SINUSOIDAL, RAMP, SAWTOOTH, SQUARE, NOISE} waveform_type;
    
    `include "ms_bridge/pga_bridge_proxy.svh"
    
    `include "agents/digital/pga_d_packet.svh"
    `include "agents/analog/pga_a_packet.svh"
    
    `include "agents/digital/pga_d_sequencer.svh"
    `include "agents/analog/pga_a_sequencer.svh"
    `include "tests/sequences/pga_d_base_sequence.svh"
    `include "tests/sequences/pga_a_base_sequence.svh"
    `include "tests/sequences/pga_d_random_sequence.svh"
    `include "tests/sequences/pga_a_random_sequence.svh"
    `include "tests/sequences/pga_a_sinusoidal_sequence.svh"


    `include "pga_virtual_sequencer.svh"
    `include "tests/sequences/pga_virtual_sequence.svh"
    `include "tests/sequences/pga_random_sequence.svh"
    `include "tests/sequences/pga_sinusoidal_sequence.svh"


    `include "agents/digital/pga_d_driver.svh"
    `include "agents/digital/pga_d_monitor.svh"
    `include "agents/digital/pga_d_coverage.svh"
    `include "agents/digital/pga_d_agent.svh"

    `include "agents/analog/pga_a_driver.svh"
    `include "agents/analog/pga_a_monitor.svh"
    `include "agents/analog/pga_a_coverage.svh"
    `include "agents/analog/pga_a_agent.svh"

    `include "env/pga_refmod.svh"
    `include "env/pga_comparator.svh"
    `include "env/pga_scoreboard.svh"
    `include "env/pga_env.svh"

    `include "tests/pga_test_base.svh"
    `include "tests/pga_test_random.svh"
    `include "tests/pga_test_sinusoidal.svh"


endpackage : pga_pkg