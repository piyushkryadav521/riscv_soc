# Pipelined RISC-V CPU

## Overview

This project implements a 32-bit 5-stage pipelined RISC-V processor using Verilog HDL.

## Features

- Program Counter
- Instruction Memory
- Register File
- Immediate Generator
- Control Unit
- ALU Control
- ALU
- Data Memory
- IF/ID Pipeline Register
- ID/EX Pipeline Register
- EX/MEM Pipeline Register
- MEM/WB Pipeline Register
- Hazard Detection Unit
- Forwarding Unit
- Branch Unit
- Flush Unit
- PC Multiplexer

## Tools Used

- Verilog HDL
- Icarus Verilog
- GTKWave
- Visual Studio Code
- Ubuntu (WSL)
- Git & GitHub

## Folder Structure

```
riscv_soc/
├── rtl/
├── tb/
├── sim/
├── docs/
└── README.md
```

## How to Compile

```bash
iverilog rtl/*.v tb/pipeline_riscv_cpu_tb.v -o sim/pipeline_sim
```

## How to Simulate

```bash
vvp sim/pipeline_sim
```

## View Waveform

```bash
gtkwave pipelined_cpu.vcd
```

## Author

**Piyush Kumar Yadav**
