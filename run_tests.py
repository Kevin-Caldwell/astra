import subprocess
import shutil
import sys

VSIM_EXE = "/home/kcal/altera_lite/25.1std/questa_fse/bin/vsim"

def run_simulation():
    vsim_path = VSIM_EXE
    if not vsim_path:
        print("Error: 'vsim' not found in system PATH.")
        sys.exit(1)

    cmd = [vsim_path, "-c", "-do", "do sim.do; quit -f"]

    print(f"Executing: {' '.join(cmd)}")

    try:
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