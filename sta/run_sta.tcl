# Read Liberty Library
read_liberty libs/sky130_fd_sc_hd__tt_025C_1v80.lib

# Read synthesized netlist
read_verilog synthesis/netlist.v

# Set top module
link_design pipelined_riscv_cpu

# Read timing constraints
read_sdc constraints/cpu.sdc

# Check design
check_setup

# Report timing
report_checks

# Exit
exit