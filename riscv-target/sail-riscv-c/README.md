# The RISC-V Sail model

In this test framework we have added the C Sail model as a target.

The [Sail RISC-V formal model](https://github.com/rems-project/sail-riscv) generates two
simulators, in C and OCaml.  They can be used as test targets for this compliance suite.

For this purpose, the Sail model needs to be checked out and built on
the machine running the compliance suite.  Follow the build
instructions described the README for building the RV32 and RV64
models.  Once built, please add `$SAIL_RISCV/c_emulator` and
`$SAIL_RISCV/ocaml_emulator` to your path, where $SAIL_RISCV is the
top-level directory containing the model.

To test the compliance of the C simulator for the current RV32 and RV64 tests, use

    make RISCV_TARGET=sail-riscv-c all_variant

while the corresponding command for the OCaml simulator is

    make RISCV_TARGET=sail-riscv-ocaml all_variant


