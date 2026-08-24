# Do Files

Do files are meant to script compilation, setup,
and execution of simulations in HDL through
Questa.

## Creating a work library

Running `vlib work` in a .do file will initialize
a working directory. Required as boilerplate.

## Compile Verilog Code

`vlog <verilog_file>` 


## Compile binary files into mem files

```perl
od -An -tx4 -v a.bin > a.mem
```