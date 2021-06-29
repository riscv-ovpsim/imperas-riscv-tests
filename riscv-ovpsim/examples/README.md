riscvOVPsim/examples/README.md
---
In this directory are several examples showing the use of the riscvOVPsim platform.

Application ELF Files
---
The examples include cross-compiled C applications as  _elf_  files and scripts to load onto the processor in the riscvOVPsim platform and execute.

The source of the applications are included and it is expected that you have your own cross-compiler toolchain installed to re-compile.

Debugging Applications
---
If you want to see an example of debugging an application using GDB, then look at the [dhrystone](dhrystone) example.

Signature Dump
---
If you want to see an example of the riscv compatible signature dumper, then look at the [fibonacci](fibonacci) example.

Examples
---
There are a number of examples provided, each is self-contained in separate directories.

These include basic examples, such as Fibonacci and Dhrystone that run on the base cores.

These may also include examples for specific extensions, if the core supports the extension, such as Vector, Bit Manipulation, Crypto and DSP Extension Examples.
If these examples are not present the core contained in the fixed platform does not support the extension.

Instruction Functional Coverage
---
Imperas instruction functional coverage can be enabled on any example, please see the User Guide for the additional command line arguments.

Notes
---
You must ensure that the binary executable you try and execute is appropriate for your host computer.  
For example, if you try and run the Linux64 executable on a Linux32 host you get an error such as:

> bin/Linux64/riscvOVPsim.exe: cannot execute binary file

