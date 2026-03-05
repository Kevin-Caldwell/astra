import subprocess

VSIM_EXE = "/home/kcal/altera_lite/25.1std/questa_fse/bin/vsim"
# subprocess.run(["/home/kcal/altera_lite/25.1std/questa_fse/bin/vsim",
#   "-c",
#   "-do",
#   "'sim.do; quit -f'"])

# subprocess.run(["do", "sim.do"])

# import mti

# def run():
#     print("Python is now triggering the simulation...")
#     mti.do("do sim.do")

# if __name__ == "__main__":
#     run()

import subprocess
import shutil
import sys

def run_simulation():
    # 1. Check if vsim is in your PATH
    vsim_path = VSIM_EXE
    if not vsim_path:
        print("Error: 'vsim' not found in system PATH.")
        # Optional: Hardcode path if not in PATH
        # vsim_path = "/path/to/mentor/questa/bin/vsim"
        sys.exit(1)

    # 2. Construct the command
    # -c: Command line mode (no GUI). Remove -c if you want the GUI to open.
    # -do: The Tcl command to execute immediately.
    # "quit -f": Ensures the shell closes after the simulation finishes.
    cmd = [vsim_path, "-c", "-do", "do sim.do; quit -f"]

    print(f"Executing: {' '.join(cmd)}")

    try:
        # 3. Run the subprocess
        # text=True captures output as a string instead of bytes
        result = subprocess.run(cmd, capture_output=True, text=True, check=True)

        # Print the Questa log to your Python terminal
        print("--- Questa Output ---")
        print(result.stdout)
        print("---------------------")
        print("Simulation completed successfully.")

    except subprocess.CalledProcessError as e:
        print(f"Simulation failed with exit code {e.returncode}")
        print(e.stdout)
        print(e.stderr)

if __name__ == "__main__":
    run_simulation()