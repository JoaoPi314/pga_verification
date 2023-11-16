class pga_a_packet extends uvm_sequence_item;

    // General waveform parameters
    rand real frequency;
    rand real bias;
    rand real amplitude;
    rand real phase;

    // Tolerance (In percentage)
    int TOLERANCE = 10;

    `uvm_object_utils_begin(pga_a_packet)
        `uvm_field_real(frequency, UVM_NOCOMPARE)
        `uvm_field_real(bias, UVM_NOCOMPARE)
        `uvm_field_real(amplitude, UVM_NOCOMPARE)
        `uvm_field_real(phase, UVM_NOCOMPARE)
    `uvm_object_utils_end

    constraint small_wave_values {
        amplitude > -3;
        amplitude < 3;
        bias > -3 ;
        bias < 3;
        phase >= 0;
        phase <= 2*3.14159265;
    }

    constraint high_frequencies {
        frequency < 500e6;
        frequency > 0.5e6;

    }

    function new(string name="pga_a_packet");
        super.new(.name(name));
    endfunction

    extern virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);

endclass : pga_a_packet


function bit pga_a_packet::do_compare(uvm_object rhs, uvm_comparer comparer);
    bit res;
    real error;
    pga_a_packet _obj;
    
    $cast(_obj, rhs);
    
    error = 100*(amplitude - _obj.amplitude)/_obj.amplitude;

    res = super.do_compare(_obj, comparer) &&
    (error < TOLERANCE) &&
    (-error < TOLERANCE);
        
    return res;

endfunction : do_compare