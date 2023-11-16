class pga_a_packet extends uvm_sequence_item;

    // General waveform parameters
    rand real frequency;
    rand real bias;
    rand real amplitude;
    rand real phase;

    // Power control
    rand real vdd;
    rand real vss;
    rand real bias_voltage;
    rand real bias_current;

    // Tolerance (In decimal houses)
    int TOLERANCE = 4;

    `uvm_object_utils_begin(pga_a_packet)
        `uvm_field_real(frequency, UVM_NOCOMPARE)
        `uvm_field_real(bias, UVM_NOCOMPARE)
        `uvm_field_real(amplitude, UVM_NOCOMPARE)
        `uvm_field_real(phase, UVM_NOCOMPARE)
        `uvm_field_real(vdd, UVM_NOCOMPARE)
        `uvm_field_real(vss, UVM_NOCOMPARE)
        `uvm_field_real(bias_voltage, UVM_NOCOMPARE)
        `uvm_field_real(bias_current, UVM_NOCOMPARE)
        `uvm_field_real(frequency, UVM_NOCOMPARE)
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
        frequency < 20e6;
        frequency > 5e6;

    }

    constraint small_power_values {
        vdd >= -12;
        vdd <= 12;
        vss >= -12;
        vss <= 12;
    }

    // Design specific constraints - classified

    function new(string name="pga_a_packet");
        super.new(.name(name));
    endfunction

    extern virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);

endclass : pga_a_packet

function bit pga_a_packet::do_compare(uvm_object rhs, uvm_comparer comparer);
    bit res;
    real epsilon = $pow(10, -TOLERANCE);
    pga_a_packet _obj;
    
    $cast(_obj, rhs);
    
    res = super.do_compare(_obj, comparer) &&
    ((amplitude - _obj.amplitude) < epsilon) &&
    ((amplitude - _obj.amplitude) > -epsilon);
        
    return res;

endfunction : do_compare