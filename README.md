# Parallel Programming (PPC) - Final Research Project

This repository contains my final research project for the Parallel Programming (PPC) course. The project investigates the theoretical and practical computational limitations of a modern heterogeneous mobile processor.

## Hardware Evaluated
* **CPU:** 13th Gen Intel® Core™ i7-13700H (14 Cores / 20 Threads, Raptor Lake)
* **GPU:** NVIDIA GeForce RTX 4060 Laptop GPU (8GB GDDR6, Ada Lovelace)
* **OS Environment:** Windows Subsystem for Linux (WSL - Ubuntu)

## Repository Structure

* `report.pdf` 
  * The comprehensive final written report answering research questions (a), (b), and (c), including theoretical calculations, telemetry analysis, and the "Memory Wall" discussion.
* `part_b/` 
  * Contains the synthetic benchmark implementation (`benchmark.cc`), the generated assembly code (`benchmark.s`), and the execution logs/telemetry screenshots demonstrating hardware throttling limits.
* `part_c/` 
  * Contains the fastest CP solution evaluated (`cp.cc` from CP9a) along with local and server benchmark logs to provide a real-world algorithm performance comparison.
* `source_materials/` 
  * Contains links to the official Intel and NVIDIA architectural reference manuals used for theoretical FLOPs calculations.
