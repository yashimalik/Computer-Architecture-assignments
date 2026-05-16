**Computer Architecture Assignments**

A series of progressively complex Verilog implementations building up to a fully pipelined MIPS processor, developed and simulated using Xilinx Vivado. Each assignment introduces new components and integrates them into a working processor design.


**Assignments**

Assignment 1 — Core Components
  Individual design and simulation of the ALU, Instruction Fetch unit, and Instruction Memory.

Assignment 2 — Datapath Integration
  Extended the ALU with a Register File and integrated components into a basic single-cycle datapath.

Assignment 3 — Single-Cycle MIPS Processor
  Full single-cycle MIPS processor integrating the ALU, Instruction Fetch, Instruction Memory, Register File, Main Control unit, MUX, and Sign Extension units.

Assignment 4 — Introduction to Pipelining
  Began pipelining the processor by introducing IF/ID and ID/WB pipeline registers into the processor design.

Design Assignment — 5-Stage Pipelined MIPS Processor
  Complete 5-stage pipelined MIPS processor with all pipeline registers (IF/ID, ID/EX, EX/MEM, MEM/WB), a Forwarding Unit to handle data hazards, a Stalling Unit for load-use hazards, Control Unit, Data Memory, and Register File.

  Supported instructions:
    - ADD       (Addition)
    - ORI       (OR Immediate)
    - LUI       (Load Upper Immediate)
    - MUL       (Multiply)
    - LW        (Load Word)
    - SW        (Store Word)
    - SLTI      (Set Less Than Immediate)
    - NOR       (Bitwise NOR)
    - J         (Jump)


**Tools**

- Verilog HDL
- Xilinx Vivado (simulation and synthesis)


**Note**

Each assignment folder contains design sources, simulation testbenches, and a lab report PDF.
