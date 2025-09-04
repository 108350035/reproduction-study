set search_path {/home/synopsys/syn/O-2018.06-SP1/libraries/CL018G/STD/TS02LB000-FB-00000-r8p0-03eac0/arm/tsmc/cl018g/sc7_base_rvt/r8p0/db \
                /home/ICer/12/3}

set synthetic_library {dw_foundation.sldb}
set link_library {* dw_foundation.sldb standard.sldb sc7_cl018g_base_rvt_ss_typical_max_1p62v_125c.db}
set target_library {sc7_cl018g_base_rvt_ss_typical_max_1p62v_125c.db}

set DESIGN "fir"
set CLK_period 20.0
#analyze -format verilog {fir3_FFA.v CSD_CSA_FFA.v}
analyze -format verilog {fir3_proposed.v CSD_CSA_proposed.v}
elaborate $DESIGN 
current_design $DESIGN

set_wire_load_mode top
set_load 0.05 [all_outputs]

create_clock -name "clk" -period $CLK_period clk 
set_input_delay  [ expr $CLK_period*0.5 ] -clock clk [all_inputs]
set_output_delay [ expr $CLK_period*0.5 ] -clock clk [all_outputs]
set_input_delay 0 -clock clk clk
set_input_delay 0 -clock clk rst_n


#======================================================
#  Optimization
#======================================================
uniquify
check_design > Report/$DESIGN\.check
set_fix_multiple_port_nets -all -buffer_constants
compile_ultra

#======================================================
#  Output Reports 
#======================================================
report_timing >  Report/$DESIGN\.timing
report_area >  Report/$DESIGN\.area
report_resource >  Report/$DESIGN\.resource

#======================================================
#  Change Naming Rule
#======================================================
set bus_inference_style "%s\[%d\]"
set bus_naming_style "%s\[%d\]"
set hdlout_internal_busses true
change_names -hierarchy -rule verilog
define_name_rules name_rule -allowed "a-z A-Z 0-9 _" -max_length 255 -type cell
define_name_rules name_rule -allowed "a-z A-Z 0-9 _[]" -max_length 255 -type net
define_name_rules name_rule -map {{"\\*cell\\*" "cell"}}
change_names -hierarchy -rules name_rule

#======================================================
#  Output Results
#======================================================

set verilogout_higher_designs_first true

write -format verilog -output Netlist/$DESIGN\_SYN.v -hierarchy

write_sdf -version 3.0 -context verilog -load_delay cell Netlist/$DESIGN\_SYN.sdf -significant_digits 6

#======================================================
#  Finish and Quit
#======================================================
report_area
report_timing
exit

