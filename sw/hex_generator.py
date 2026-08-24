# Simulation Time tests require Intel Hex files.

def generate_hex(bin_file_name: str, mem_file_name: str):
  chars = 0
  with open(bin_file_name, 'rb') as bin_file:
    with open(mem_file_name, 'w') as mem_file:
      data = bin_file.read()
      for b in data:
        mem_file.write(f"{b:02x}")
        chars += 1
        if chars % 8 == 0:
          mem_file.write("\n")

if __name__ == "__main__":
  import argparse 

  parser = argparse.ArgumentParser(prog=".mem file generator")
  parser.add_argument("--bin", help="Path to binary file")
  parser.add_argument("--mem", help="Path to output mem file")

  arg = parser.parse_args()
  generate_hex(arg.bin, arg.mem)