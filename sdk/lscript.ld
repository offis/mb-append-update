/*****************************************************************************/
/* Copyright (c) 2019 OFFIS Institute for Information Technology             */
/*                          Oldenburg, Germany                               */
/*                                                                           */ 
/* Licensed under the Apache License, Version 2.0 (the "License");           */
/* you may not use this file except in compliance with the License.          */
/* You may obtain a copy of the License at                                   */ 
/*                                                                           */
/*     http://www.apache.org/licenses/LICENSE-2.0                            */
/*                                                                           */
/* Unless required by applicable law or agreed to in writing, software       */
/* distributed under the License is distributed on an "AS IS" BASIS,         */ 
/* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  */
/* See the License for the specific language governing permissions and       */
/* limitations under the License.                                            */
/*                                                                           */  
/* \file   lscript.ld                                                        */
/* \author Patrick Uven <patrick.uven@offis.de>                              */
/* \brief  MicroBlaze Linker Script for the append online update example     */
/*****************************************************************************/

_STACK_SIZE = DEFINED(_STACK_SIZE) ? _STACK_SIZE : 0x400;
_HEAP_SIZE = DEFINED(_HEAP_SIZE) ? _HEAP_SIZE : 0x800;

/* Define Memories in the system */

MEMORY
{
   uuu_microblaze_0_local_memory_dlmb_bram_if_cntlr_Mem : ORIGIN = 0x50, LENGTH = 0x1FFB0
}

/* Specify the default entry point to the program */

ENTRY(_start)

/* Define the sections, and where they are mapped in memory */

SECTIONS
{
.vectors.reset 0x0 : {
   KEEP (*(.vectors.reset))
} 

.vectors.sw_exception 0x8 : {
   KEEP (*(.vectors.sw_exception))
} 

.vectors.interrupt 0x10 : {
   KEEP (*(.vectors.interrupt))
} 

.vectors.hw_exception 0x20 : {
   KEEP (*(.vectors.hw_exception))
} 

.text : {
   *(.text)
   *(.text.*)
   *(.gnu.linkonce.t.*)
} > uuu_microblaze_0_local_memory_dlmb_bram_if_cntlr_Mem

.init : {
   KEEP (*(.init))
} > uuu_microblaze_0_local_memory_dlmb_bram_if_cntlr_Mem

.fini : {
   KEEP (*(.fini))
} > uuu_microblaze_0_local_memory_dlmb_bram_if_cntlr_Mem

.ctors : {
   __CTOR_LIST__ = .;
   ___CTORS_LIST___ = .;
   KEEP (*crtbegin.o(.ctors))
   KEEP (*(EXCLUDE_FILE(*crtend.o) .ctors))
   KEEP (*(SORT(.ctors.*)))
   KEEP (*(.ctors))
   __CTOR_END__ = .;
   ___CTORS_END___ = .;
} > uuu_microblaze_0_local_memory_dlmb_bram_if_cntlr_Mem

.dtors : {
   __DTOR_LIST__ = .;
   ___DTORS_LIST___ = .;
   KEEP (*crtbegin.o(.dtors))
   KEEP (*(EXCLUDE_FILE(*crtend.o) .dtors))
   KEEP (*(SORT(.dtors.*)))
   KEEP (*(.dtors))
   PROVIDE(__DTOR_END__ = .);
   PROVIDE(___DTORS_END___ = .);
} > uuu_microblaze_0_local_memory_dlmb_bram_if_cntlr_Mem

.rodata : {
   __rodata_start = .;
   *(.rodata)
   *(.rodata.*)
   *(.gnu.linkonce.r.*)
   __rodata_end = .;
} > uuu_microblaze_0_local_memory_dlmb_bram_if_cntlr_Mem

.sdata2 : {
   . = ALIGN(8);
   __sdata2_start = .;
   *(.sdata2)
   *(.sdata2.*)
   *(.gnu.linkonce.s2.*)
   . = ALIGN(8);
   __sdata2_end = .;
} > uuu_microblaze_0_local_memory_dlmb_bram_if_cntlr_Mem

.sbss2 : {
   __sbss2_start = .;
   *(.sbss2)
   *(.sbss2.*)
   *(.gnu.linkonce.sb2.*)
   __sbss2_end = .;
} > uuu_microblaze_0_local_memory_dlmb_bram_if_cntlr_Mem

.data : {
   . = ALIGN(4);
   __data_start = .;
   *(.data)
   *(.data.*)
   *(.gnu.linkonce.d.*)
   __data_end = .;
} > uuu_microblaze_0_local_memory_dlmb_bram_if_cntlr_Mem

.got : {
   *(.got)
} > uuu_microblaze_0_local_memory_dlmb_bram_if_cntlr_Mem

.got1 : {
   *(.got1)
} > uuu_microblaze_0_local_memory_dlmb_bram_if_cntlr_Mem

.got2 : {
   *(.got2)
} > uuu_microblaze_0_local_memory_dlmb_bram_if_cntlr_Mem

.eh_frame : {
   *(.eh_frame)
} > uuu_microblaze_0_local_memory_dlmb_bram_if_cntlr_Mem

.jcr : {
   *(.jcr)
} > uuu_microblaze_0_local_memory_dlmb_bram_if_cntlr_Mem

.gcc_except_table : {
   *(.gcc_except_table)
} > uuu_microblaze_0_local_memory_dlmb_bram_if_cntlr_Mem

.sdata : {
   . = ALIGN(8);
   __sdata_start = .;
   *(.sdata)
   *(.sdata.*)
   *(.gnu.linkonce.s.*)
   __sdata_end = .;
} > uuu_microblaze_0_local_memory_dlmb_bram_if_cntlr_Mem

.sbss (NOLOAD) : {
   . = ALIGN(4);
   __sbss_start = .;
   *(.sbss)
   *(.sbss.*)
   *(.gnu.linkonce.sb.*)
   . = ALIGN(8);
   __sbss_end = .;
} > uuu_microblaze_0_local_memory_dlmb_bram_if_cntlr_Mem

.tdata : {
   __tdata_start = .;
   *(.tdata)
   *(.tdata.*)
   *(.gnu.linkonce.td.*)
   __tdata_end = .;
} > uuu_microblaze_0_local_memory_dlmb_bram_if_cntlr_Mem

.tbss : {
   __tbss_start = .;
   *(.tbss)
   *(.tbss.*)
   *(.gnu.linkonce.tb.*)
   __tbss_end = .;
} > uuu_microblaze_0_local_memory_dlmb_bram_if_cntlr_Mem

.bss (NOLOAD) : {
   . = ALIGN(4);
   __bss_start = .;
   *(.bss)
   *(.bss.*)
   *(.gnu.linkonce.b.*)
   *(COMMON)
   . = ALIGN(4);
   __bss_end = .;
} > uuu_microblaze_0_local_memory_dlmb_bram_if_cntlr_Mem

_SDA_BASE_ = __sdata_start + ((__sbss_end - __sdata_start) / 2 );

_SDA2_BASE_ = __sdata2_start + ((__sbss2_end - __sdata2_start) / 2 );

/* Generate Stack and Heap definitions */

.heap (NOLOAD) : {
   . = ALIGN(8);
   _heap = .;
   _heap_start = .;
   . += _HEAP_SIZE;
   _heap_end = .;
} > uuu_microblaze_0_local_memory_dlmb_bram_if_cntlr_Mem

.stack (NOLOAD) : {
   _stack_end = .;
   . += _STACK_SIZE;
   . = ALIGN(8);
   _stack = .;
   __stack = _stack;
} > uuu_microblaze_0_local_memory_dlmb_bram_if_cntlr_Mem

.update_1 : {
   *(.update_1)
   KEEP (*(.update_1))
} > uuu_microblaze_0_local_memory_dlmb_bram_if_cntlr_Mem

_end = .;
}

