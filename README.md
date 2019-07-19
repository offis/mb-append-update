# mb-append-update -- Append Online Update example for the Xilinx MicroBlaze processor

This repository contains guides and source files to recreate an example project that applies an online update as described in

Patrick Uven,Philipp Ittershagen and Kim Grüttner: ***Design and Analysis of an Online Update Approach for Embedded Microprocessors*** in proceedings of *The 6th International Embedded Systems Symposium (IESS)*, 2019

## Abstract
Software updates are already used in many systems for fixing bugs and for improving or extending their functionality. For many embedded systems with strong requirements on their availability, software updates are still not used because an update cycle usually causes a down time of the system. For servers in data centers with high availability requirements, so-called live patching solutions exist for many years. Live-Patching allows updating the software without affecting the availability of the system (i.e. no restart is required). In this work, we propose the application of live patching on small embedded microprocessors. We present a proof-of-concept implementation on a Xilinx MicroBlaze processor and compare the properties of our implementation, w.r.t. the amount of transmitted update data, memory requirements and update cycle duration against a state-of-the-art full-memory update.

The full paper is available at: TBA

## Overview
This example project contains all necessary files to recreate an online update system on the ZedBoard. In the example, the MicroBlaze microprocessor will control the LEDs on the ZedBoard. In the original program, two LEDs are disabled, so the purpose of the update is to use all eight LEDs.

It was designed and tested for the ZedBoard Zynq-7000 ARM/FPGA SoC Development Board in combination with the Xilinx Vivado 2018.2 tool chain. While this project might be compatible to other hardware or a different tool chain version, this isn't covered here.

The project is split into three parts. The hardware part contains the block diagram for the FPGA as well as the guide for Xilin Vivado. The software part contains the C sources for the example project and the guide for Xilinx Vivado SDK. Finally, the update system part contains information about the PetaLinux operating system and the update process.

It should be noted that this guide is just giving the required steps to reproduce the project workflow and won't go into detail, so basic knowledge of all used tools is required.

### Additional Information
- UG898 Vivado Design Suite User Guide - Embedded Processor Hardware Design 
- UG976 PetaLinux Installation Guide
- UG980 PetaLinux Board Bringup Guide
- UG984 MicroBlaze Processor Reference Guide
- UG1144 PetaLinux Tools Documentation
- DS190 Zynq-7000 SoC Data Sheet

## Hardware Design (FPGA)
All relevant files for the hardware design are placed in the hardware folder. The .tcl-file contains the Xilinx Vivado block diagram for the project, which can be imported via "Run tcl script". After creating a new HDL wrapper and setting the given block design as top module, it can be synthesized and implemented. The output, in this case the exported hardware including the bitstream, can be found in the .hdf-file, while the .bit-file includes only the bitstream.

The hardware design itself should be self explanatory. The MicroBlaze processor is the unit under update (uuu), equipped with Block RAM as well as peripherals with access to the LEDs of the ZedBoard. The ZYNQ processing system (update system) has AXI access to the Block RAM as well as to specific ports of the MicroBlaze via GPIO modules.

## Software Design (SDK / MicroBlaze)
The software sources for the MicroBlaze are placed in the sdk folder. Using the exported .hdf-file a new project in Vivado SDK has to be created and the given files imported:

- original.c contains the original, broken code
- full_update.c contains the fixed code for the full update
- append_update.c contains the fixed code for the append update
- lscript.ld contains the adjusted linker script for the updates

Each source file has to be compiled on its own to create the ELF file. Those ELF
files can also be found in binary/compiled folder. To reduce memory usage, the ELF
files have to be stripped. As we still need the original ELF files, stripped
copies of them are placed in binary/stripped folder. Those ELF files can be converted
with the convert script, resulting in the .mem files placed in binary/converted folder. The convert script itself is placed under scripts/mem-convert.sh and uses the following syntax:

    mem-convert.sh 0x<block ram address> <software.elf>

To recreate the append_update.elf.mem, the diff from the original .mem-file and the .mem-file from the append_update.elf has to be created. Following that diff, the jump instruction has to be added manually added into the append_update.elf.mem by using the following syntax:

    0x<first address of original function> 0xb918<address of new function>

## Update System (PetaLinux)
With the created .mem-files, as well as the other two scripts from the scripts folder, only the update system is missing for the update process.

### PetaLinux Workflow
Using the avnet-digilent-zedboard-v2018.2-final.bsp obtained from Xilinx for the ZedBoard, a new PetaLinux project is created. During the configuration with the given .hdf-file, the selection of the persistent file system on the SD card is recommended. After the build process, the previously created .bit-file (see hardware design above) has to be added into the boot image. Following the default procedure for a SD card setup with a persistent file system, both boot files are placed on the first partition while the second partition contains the root file system.

## Update process
After adding the .mem-files and the scripts to the SD card, the update process can be tested. While the write.sh-script directly writes into the memory and can only be used for the online update, the other script has to be used to place the original program in the memory and reset the MicroBlaze. With

    ./pause_write_reset.sh <original.mem>

the processor will be paused via GPIO, the memory content will be written into the Block RAM and finally a reset will restart the MicroBlaze. It should now control the LEDs of the ZedBoard. At this point, either of the two update variants can be used.

    ./pause_write_reset.sh <full_update.mem>

will write the update the program in exactly the same way as the original software was installed. To use the online update approach,

    ./write <append_update.mem>

has to be used.    
