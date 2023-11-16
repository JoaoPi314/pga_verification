#!usr/bin/sh
rm -rf pga_report  *.txt
vmanager -exec ../scripts/report_runs.tcl
mv pga_report/report_data/*.report pga_report/report_data/pga_report.report
tclsh ../scripts/extract_simulation_times.tcl
