# Single-Cycle 32-bit RISC-V Processor

## Overview

This project implements a single-cycle 32-bit RISC-V (RV32I) processor in Verilog. The design follows a Harvard architecture and executes each instruction in a single clock cycle. The project was created using VS Code and simulated with ModelSim and Vivado.

## Features

- 32-bit ALU supporting add, subtract, shift, XOR, OR, and AND operations
- Register file with two read ports and one write port
- Program counter with branch handling logic
- Separate instruction and data memory modules
- Control unit with main decoder and ALU decoder
- Sign extension unit for immediate values

## Files

- **src/**: Verilog RTL source files
- **sim/**: Simulation files and test programs
- **docs/**: Project documentation and screenshots

## Simulation

The processor was tested using ModelSim and Vivado. A sample Fibonacci program (assembly and machine code) was used to verify instruction execution and control flow. Screenshots and detailed steps can be found in `docs/Single Cycle RV-32I.pdf`.

## How to run

1. Clone or download the repository.
2. Open in VS Code with Verilog/SystemVerilog support.
3. Compile and simulate using ModelSim or Vivado simulator.
4. Check waveform outputs to verify functionality.

## Author

Raghad Nabih — 2025
