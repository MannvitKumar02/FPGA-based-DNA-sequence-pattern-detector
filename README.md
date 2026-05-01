# FPGA-based-DNA-sequence-pattern-detector
# Sequence Matching Technique from DNA Expression for Disease Detection

## Overview

This project implements hardware-accelerated DNA sequence matching using **Verilog HDL**, simulated in **Vivado**. It encodes nucleotides (A, T, C, G) as **7-bit ASCII characters** and performs sequence alignment using three progressively advanced approaches — from a simple inline counter to a full **Smith-Waterman local alignment** engine.

The system is designed for real-time genomic analysis and disease detection, with the goal of eventual deployment on **FPGA hardware**.

##  Objectives

- Detect and count character-level matches between a query DNA sequence and a reference
- Handle large genomic datasets via file-based input
- Implement the **Smith-Waterman algorithm** in RTL for optimal local sequence alignment
- Compare chimpanzee and human DNA sequences against COVID-19 genome sequences
- Enable real-time performance through hardware acceleration (FPGA-ready design)

##  Tools & Technologies

| **Tool**           | **Purpose** |
                    
| **Xilinx Vivado**  | Simulation, RTL synthesis, waveform analysis 
| **Verilog HDL**    | Hardware design and testbench 
| **Python 3**       | Dataset extraction and preprocessing 
| **Pandas**         | CSV parsing for COVID genome dataset 
| **FPGA (planned)** | Hardware deployment for real-time analysis 

### Requisites
- Xilinx Vivado (2020.x or later) for simulation
- Python 3.x with `pandas` installed for dataset preprocessing

##  Future Scope

- Deploy on **FPGA hardware** (Xilinx Zynq / Artix-7) for real-time genomic processing
- Integrate **GPU acceleration** for large-scale dataset analysis
- Add **machine learning** post-processing for mutation classification
- Extend to support **RNA sequences** and **protein sequence alignment**
- Optimize Smith-Waterman with **systolic array** architecture for higher throughput

