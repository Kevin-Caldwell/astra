# Pipelining

Pipelining splits the processor's functionality into multiple
distinct stages.

For the Astra RV32I processor, the stages are:

1. **Fetch**: Instruction is fetched from instruction memory.
2. **Decode**: Instructions are decoded into constituents that are easier to use. This is not as useful now.
3. **Register File**: Relevant registers are read to be moved to other stages
4. **ALU**: Does arithmetic on values from the registers, or calculates memory addresses.
5. **Memory**: Interacts with the MMIO through the memory controller.
6. **Program Counter Update**: The Program Counter is updated with the next
   instruction address.
7. **Writeback**: Writes data back to pipeline stages.

## Fetch

The Fetch instruction stage loads an instruction from the Instruction
memory.

Inputs:

- Program Counter
- Clock
- ResetN

Outputs:

- Instruction

## Decode

The Decode stage is where the instruction is split into flags. This
might not be useful since the RISC-V instruction is already fairly
compressed, and the relevant flags can be extracted when it is required.

This may become part of the Dispatch stage later. Left as a buffer register
for now.

If needed, some flags may be calculated here to reduce pressure on a
single pipeline stage.

The type of instruction would be useful to figure out here.

## Register File

Unchanged from the implementation

## ALU

Unchanged from the Implementation.

## Memory

> TODO

## PC Update

> TODO

## Lifecycle of an Instruction

An instruction is fetched from I-Memory, sent to the register file for
the registers to read.

## Implementation Details

The packed signals for each pipeline stage are named after the pipeline
they come out of (aka the struct is the `output`).
This means each pipeline stage is responsible for calculating its
formatted inputs as well.
