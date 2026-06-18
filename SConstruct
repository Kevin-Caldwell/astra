
import os

from SCons import Options

WORK_LIB = "work"
VSIM = "vsim"
BUILD_DIR = 'build'

RISCV_C_COMPILER =      'riscv64-unknown-elf-gcc'
RISCV_CXX_COMPILER =    'riscv64-unknown-elf-g++'

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

env = Environment()

build_dir = "build"
env['BUILD_DIR'] = "build"

Export('env')

SConscript('SConscript', variant_dir=BUILD_DIR)
