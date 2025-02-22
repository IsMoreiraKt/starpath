# starpath
Starpath is a re-implementation of the winner of the 64-byte category of the Lovebyte 2025 competition. The project aims to demonstrate two versions of code that implement the same visual raycasting effect, but using two different compilers: NASM and GAS.

The original code, which can be found at the [link](https://www.pouet.net/prod.php?which=103622), has been adapted to work in 16-bit BIOS mode.

## Overview
This project explores the differences between implementing code in NASM (Intel syntax) and GAS (AT&T syntax). Both versions have the same functionality, but the way they are structured and compiled can vary depending on the syntax and conventions of each assembler.

The code of both versions has the same raycasting effect on a 320x200 screen with 256 colours, maintaining the general structure of the original code, but adapted to the syntax and characteristics of each tool.

## How to run
Both versions can be compiled and run in an emulation environment (such as QEMU) using the scripts provided. The compilation and execution process is automated, so you don't need to do any manual work.

1. Clone the repository:
```bash
git clone https://github.com/IsMoreiraKt/starpath
cd starpath
```

2. Run the Script for NASM:
```bash
cd nasm
./qemu
```

3. Run the Script for GAS:
```bash
cd gas
./qemu
```
