#!usr/bin/tclsh

package require json

# Initialize the array
set title_duration_dict [dict create]

set input_file [open "/home/melqjp/Documentos/estagio/pga/verification/testbench/rundir/pga_report/report_data/pga_report.report" "r"]
set pattern {\{"expanded":false,"Index":"\d+","title":"/pga_tests/([^"]+)","Status":"[^"]+","Duration \(sec\.\)":"([^"]+)","Top Files":"[^"]+"\}}

# Read the file line by line
while {[gets $input_file line] != -1} {
    # Check if the line matches the expected pattern
    if {[regexp $pattern $line match title duration]} {
        # Check if the title exists in the outer dictionary
        if {![dict exists $title_duration_dict $title]} {
            # If it doesn't exist, create an inner dictionary for the title
            set title_duration_inner_dict [dict create]
        } else {
            # If it exists, get the existing inner dictionary
            set title_duration_inner_dict [dict get $title_duration_dict $title]
        }
        
        # Add the duration to the inner dictionary
        dict set title_duration_inner_dict [expr {[dict size $title_duration_inner_dict] + 1}] $duration
        
        # Store the inner dictionary back in the outer dictionary
        dict set title_duration_dict $title $title_duration_inner_dict    }
} 

# Close the input file
close $input_file

# Iterate over the dictionary
dict for {title inner_dict} $title_duration_dict {
    # Create a file with the title as the filename
    set filename "$title.txt"
    
    # Check if the file exists; create it if it doesn't
    if {![file exists $filename]} {
        set file_handle [open $filename "w"]
        # Close the file immediately to create an empty file
        close $file_handle
    }

    # Open the file for writing
    set file_handle [open $filename "a"]

    # Iterate over the inner dictionary and write durations to the file
    dict for {index duration} $inner_dict {
        puts $file_handle $duration
    }

    # Close the file
    close $file_handle
}


# Done