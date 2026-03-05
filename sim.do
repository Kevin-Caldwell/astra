# Create the work library
vlib work

# Compile the source code
vlog top.sv

# Load the simulation
vsim work.top

# Add signals to the wave window
# 'add wave -recursive *' adds everything,
# but specifically naming them is better practice:
add wave -divider "Global Signals"
add wave /top/clk
add wave -color "Yellow" /top/counter

# Log all signals so they show up in the WLF file
log -r /*

# Run the simulation
run -all

# Zoom to fit the full timeline
wave zoom full