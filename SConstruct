
import os

WORK_LIB = "work"
VSIM = "vsim"

def build_design(target, source):
    subprocess.run(["yosys", "-c", f"synth -top {SIM_TOP_MODULE} {SOURCES}"])

Alias("build", build_design)

def simulate_design(target, source):
    print("--- Running Questa Simulation Stage ---")
    vsim_command = [
        QUEN_BIN,
        "-c",
        f"-do", f"run -all"
    ]

    vsim_command.extend(SOURCES + [TESTBENCH])
    subprocess.run(vsim_command)

Alias("simulate", simulate_design)

Alias("clean", lambda target, source: print("Cleaning build directory..."))

@Action("all")
def build_and_test(target, source):
    simulate_design(target, source)
    run_tests(target, source)

env = Environment()

build_dir = "build"
env['BUILD_DIR'] = "build"



Export('env')
