	.arm
	.cpu arm7tdmi
	.arch armv4t
	.syntax unified
	.text 0
	
	
	.include "elf.utils.s"
    
.globl main
	.align 2
	.type main, %function
main:	.fnstart
	str lr, [sp, #-4]!
	ldr r0, [r1, #4]
	mov r1, #2
	bl  open
	cmn r0, #1
	beq R_ERR
	str fp, [sp, #-4]!
	mov fp, sp
	sub sp, sp, #12
	str r0, [fp, #-4]
	ldr r7, .e_ident
	add r7, r7, pc
	mov r2, #18
    20:	
    	mov r1, r7
	bl  read
	cmn r0, #-1
	beq R_ERR
	add  r5, r0, r7
	ldr r0, [fp, #-4]
	bl  close
	ldr r4, .handlers
	add r4, r4, pc
     1:
     	mov lr, pc
    21:	
	ldr pc, [r4], #4
	add r7, r7, r1
	cmp r5, r7
	bhi 1b
	mov sp, fp
	ldmfd sp!, {fp, lr}
	bx  lr
R_ERR:
   	bl __errno
	ldr r0, [r0]
	bl strerror
	mov r1, r0
	adr r0, .fmt
	bl printf
	mov r0, #-1
	ldr lr, [sp], #4
	mov pc, lr
.fmt:
    .asciz "%s\n"
    .align 2
.e_ident:
	  .long e_ident-20b
.handlers:
	.long handlers-21b
	.fnend
	
	.include "elf.data.s"
