#!/bin/python3
# Compile all .sv files in the specified folder

import argparse
import os
from pathlib import Path
import subprocess

def get_sv_files(dir: str):
  return [str(file) for file in Path(dir).rglob("*.sv") if file.is_file()]

def compile_sv_file(file: str):
  subprocess.run(['vlog', file], check=True)

def argument_parser():
  parser = argparse.ArgumentParser(
    description="Compile all SystemVerilog files in a folder.")
  parser.add_argument("--src", help="Source folder")
  # parser.add_argument("vlog", default="", help="Path to Verilog Compiler")
  return parser.parse_args()

def main():
  args = argument_parser()
  os.chdir(args.src)
  files = get_sv_files(".")
  for file in files:
    print(f"Compiling {file}.")
    compile_sv_file(file)


if __name__ == "__main__":
  main()

