#======================================================
#
# PrimeTime  Scripts (dctcl mode)
#
#======================================================

#======================================================
#  1. Set the Power Analysis Mode
#======================================================

set power_enable_analysis true
set power_analysis_mode time_based
set power_report_leakage_breakdowns true
set power_clock_network_include_register_clock_pin_power false

#======================================================
#  2. Read and link the design
#======================================================

set search_path {/home/synopsys/syn/O-2018.06-SP1/libraries/CL018G/STD/TS02LB000-FB-00000-r8p0-03eac0/arm/tsmc/cl018g/sc7_base_rvt/r8p0/db \
                /home/ICer/12/2}
set link_library {* sc7_cl018g_base_rvt_ss_typical_max_1p62v_125c.db sc7_cl018g_base_rvt_ff_typical_min_1p98v_m40c.db }
set synthetic_library {standard.sldb dw_foundation.sldb}
set target_library {sc7_cl018g_base_rvt_ss_typical_max_1p62v_125c.db sc7_cl018g_base_rvt_ff_typical_min_1p98v_m40c.db}

set DESIGN "fir"
read_verilog $DESIGN\_SYN.v
current_design $DESIGN
link

#======================================================
#  3. Set transition time / annotate parasitics
#======================================================
set_input_transition .1 [all_inputs]
read_sdc $DESIGN\_SYN.sdc
read_sdf -load_delay net $DESIGN\_SYN.sdf

#======================================================
#  4. Read Switching Activity File
#======================================================
read_vcd -strip_path TESTBED/U_FIR $DESIGN\_SYN.fsdb

#======================================================
#  5. Perform power analysis
#======================================================
check_power
update_power

#======================================================
#  6. Generate Power Report
#======================================================
# BUG command 

set_power_analysis_options -waveform_interval 1 -waveform_format out -waveform_output vcd
# vcd.out
report_power > Report/$DESIGN\_POWER 
 

exit
