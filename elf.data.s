	.section ".rodata", #alloc
	.align 2
ET_PTR:
	.long ET_NONE-ET_PTR, ET_REL-ET_PTR, ET_EXEC-ET_PTR, ET_DYN-ET_PTR, ET_CORE-ET_PTR 

ET_NONE:
	.asciz "No File Type"
	.size ET_NONE, .-ET_NONE
	.type ET_NONE, %object
ET_REL:
	.asciz "Relocatable File"
	.size ET_REL, .-ET_REL
	.type ET_REL, %object
ET_EXEC:
	.asciz "Executable File"
	.size ET_EXEC, .-ET_EXEC   
	.type ET_EXEC, %object
ET_DYN:
	.asciz "Shared Object File/Dynamically Linked Library"
	.size ET_DYN, .-ET_DYN   
	.type ET_DYN, %object
ET_CORE:
	.asciz "Core File"
	.size ET_CORE, .-ET_CORE
	.type ET_CORE, %object
/*__________________________________*/
	

	.data 0
	.align 2
colDelim:
.asciz " : "


monoSL:
	.asciz "%s\n"
biSL:
	.asciz "%s%s\n"
triSL:
	.asciz "%s%s%s\n"
quadSLB_3:
	.asciz "%s%s%s %s\n"
	.align 2
ei_mag:
.asciz "EI_MAG(Magic)"

ei_class:
.asciz "EI_CLASS(Arch Type)"

ei_data:
.asciz "EI_DATA(Sign Type & Endianess)"

ei_version:
.asciz "EI_VERSION(Elf Version)"

ei_type:
.asciz "Object File Type"
	.align 2
handlers:
  .long getMagic, getMtype, getEndia, getElfV, ET_REDIRECTOR
	.size .data, .-.data

	.section ".bss", #alloc, #write
	.align 2
	.globl EI_NIDENT
	.equiv EI_NIDENT, 16
	.globl  e_ident
	.globl EI_MAG0
	.globl EI_MAG1
	.globl EI_MAG2
	.globl EI_MAG3
	.globl EI_CLASS
	.globl EI_DATA
	.globl EI_VERSION
	.globl EI_PAD

.equiv e_ident, EI_MAG0
EI_MAG0:
	.byte 0
EI_MAG1:
	.byte 0
EI_MAG2:
	.byte 0
EI_MAG3:
	.byte 0
EI_CLASS:
	 .byte 0
EI_DATA:
	.byte 0
EI_VERSION:
	    .byte 0
EI_PAD:
	.space 18, 0 
	.size  e_ident, EI_NIDENT
	.size .bss, EI_NIDENT
