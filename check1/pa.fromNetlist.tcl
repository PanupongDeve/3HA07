
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name check1 -dir "D:/3HA07/check1/planAhead_run_1" -part xc3s200tq144-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "D:/3HA07/check1/keypad.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {D:/3HA07/check1} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "keypad.ucf" [current_fileset -constrset]
add_files [list {keypad.ucf}] -fileset [get_property constrset [current_run]]
open_netlist_design
