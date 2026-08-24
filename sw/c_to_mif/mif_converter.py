import argparse
import math

RADIX_MAP = {
  2:    "BIN", 
  10:   "DEC",
  16:   "HEX"
}

class MIFFile:
  width: int = 0
  depth: int = 0
  address_radix: int = 0
  data_radix: int = 0
  data: list[bytes]

  def __init__(self, width: int, address_radix: int, data_radix: int):
    self.width = width
    self.address_radix = address_radix
    self.data_radix = data_radix

  def read_bin(self, file_name: str):
    with open(file_name, 'rb') as file:
      self.data = file.read()

    self.depth = math.ceil(len(self.data) / self.width)

  def print_header(self):
    print("------------- BIN TO MIF --------------")
    print(f"WIDTH = {self.width}")
    print(f"DEPTH = {self.depth}")
    print(f"ADDRESS_RADIX = {self.address_radix}")
    print(f"DATA_RADIX = {self.data_radix}")
    print("--------------------------------------")

  def write_mif(self, file_name: str):
    with open(file_name, 'w') as file:
      file.write(f"WIDTH={self.width};\n")
      file.write(f"DEPTH={self.depth};\n")
      file.write(f"ADDRESS_RADIX={self.address_radix};\n")
      file.write(f"DATA_RADIX={self.data_radix};\n")
      file.write(f"CONTENT BEGIN\n")
      address = 0
      for i in range(self.depth):
        byte_array = ""
        for j in range(self.width // 8):
          byte_array += f"{(self.data[address + j] & 0xFFFF):0x}"
        file.write(f"\t{address:0{math.floor(math.log2(self.depth) / math.log2(8))}d} : {byte_array};\n")
        address += self.width // 8
      file.write(f"END;")

def parse_arguments():
  parser = argparse.ArgumentParser(
    prog = 'MIF Generator', 
    description = 'Generate a MIF file from a Binary file.'
  )
  parser.add_argument('-i', '--bin')
  parser.add_argument('-o', '--mif', default='a.mif')
  parser.add_argument('--width', default=8, type=int)
  parser.add_argument('--address_radix', default="BIN")
  parser.add_argument('--data_radix', default="BIN")
  return parser.parse_args()

def main():
  args = parse_arguments()
  file = MIFFile(args.width, args.address_radix, args.data_radix)

  file.print_header()
  file.read_bin(args.bin)
  file.write_mif(args.mif)

if __name__ == "__main__":
  main()
