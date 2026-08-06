# 32-bit Pipelined RISC-V Processor (Verilog HDL)

## Overview

This project is a 32-bit pipelined RISC-V processor developed in Verilog HDL as part of my RTL Design learning journey.

The objective of this project was to understand processor architecture, RTL design, simulation, and pipeline implementation using industry-standard open-source tools.

---

## Features

- 32-bit RISC-V architecture
- Five-stage pipeline
  - Instruction Fetch (IF)
  - Instruction Decode (ID)
  - Execute (EX)
  - Memory (MEM)
  - Write Back (WB)
- ALU
- ALU Control
- Register File
- Instruction Memory
- Data Memory
- Immediate Generator
- Hazard Detection Unit
- Forwarding Unit
- Pipeline Registers
- Branch Control
- Pipeline Flush Logic

---

## Project Structure

```
riscv_soc/
│
├── rtl/
│   ├── control_unit.v
│   ├── alu.v
│   ├── register_file.v
│   ├── data_memory.v
│   ├── instruction_memory.v
│   └── riscv_pipeline/
│
├── tb/
│
├── sim/
│
├── docs/
│
└── README.md
```

---

## Tools Used

- Verilog HDL
- Icarus Verilog
- GTKWave
- Ubuntu WSL
- VS Code
- Git
- GitHub

---

## How to Compile

Example:

```bash
iverilog -g2012 \
rtl/control_unit.v \
rtl/riscv_pipeline/*.v \
tb/riscv_pipeline/pipeline_top_tb.v \
-o sim/pipeline_top
```

---

## How to Run

```bash
vvp sim/pipeline_top
```

---

## View Waveform

```bash
gtkwave riscv_pipeline_top.vcd
```

---

## Learning Outcomes

During this project I learned:

- RTL Coding in Verilog
- Modular Design
- Pipeline Architecture
- Control Signal Generation
- ALU Design
- Register File Design
- Memory Design
- Hazard Detection
- Forwarding Logic
- Testbench Development
- Simulation using Icarus Verilog
- Waveform Debugging using GTKWave
- Git & GitHub Workflow

---

## Current Status

- ✔ Individual RTL modules implemented
- ✔ Module-level simulations completed
- ✔ Pipeline architecture developed
- ✔ Top-level integration in progress

This repository documents my RTL design learning journey and will continue to be improved.

---

## Future Improvements

- Complete top-level pipeline integration
- Pipeline verification
- Branch prediction
- Cache implementation
- FPGA implementation
- DFT support (Scan Chain, MBIST)

---

## Author

**Piyush Kumar Yadav**

Electronics & Communication Engineering

Interested in:

- RTL Design
- Digital VLSI
- FPGA
- Computer Architecture

GitHub: https://github.com/piyushkryadav521
LinkedIn: www.linkedin.com/in/piyush-kr-yadav-261799218
