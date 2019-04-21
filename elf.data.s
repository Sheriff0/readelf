	.data 0
	.align 2
strUA:
.asciz "Magic","Machine Type","Endianess","ELF Version"
	.align 2
handlers:
  .long getMagic, getMtype, getEndia, getElfV 
	.size .data, .-strUA

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
	.space EI_NIDENT-7, 0 
	.size  e_ident, EI_NIDENT
	.size .bss, EI_NIDENT
