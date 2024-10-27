#Read All Files
analyze -format verilog  {geofence.v  DW01_addsub.v  DW_sqrt.v}  
elaborate geofence
#read_file -format sverilog  geofence.v
current_design geofence
link

#Setting Clock Constraints
source -echo -verbose geofence.sdc
check_design
set high_fanout_net_threshold 0
uniquify
set_fix_multiple_port_nets -all -buffer_constants [get_designs *]

#Synthesis all design
#compile -map_effort high -area_effort high
#compile -map_effort high -area_effort high -inc
compile_ultra 

write -format ddc     -hierarchy -output "geofence_syn.ddc"
write_sdf -version 1.0  geofence_syn.sdf
write -format verilog -hierarchy -output geofence_syn.v
report_area > area.log
report_timing > timing.log
report_qor   >  geofence_syn.qor
