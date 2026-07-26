# Clock Definition
create_clock \
-name clk \
-period 10 \
[get_ports clk]

# Clock Uncertainty
set_clock_uncertainty 0.2 [get_clocks clk]

# Output Delay
set_output_delay 2 \
-clock clk \
[all_outputs]