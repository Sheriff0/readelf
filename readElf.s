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
	stmfd sp!, {r4-r10, fp, lr}
	mov fp, sp
	sub sp, sp, #36
	ldr r0, [r1, #4]
	mov r1, #64
	bl  open
	str r0, [fp, #-4]
	ldr r7, .fns
	add r7, r7, pc
fns .req r7
	ldr r5, .strs
   h0:	
	add r5, r5, pc
        ldr r6, .e_ident
   h1:	
	add r6, r6, pc
buff .req r6
	mov r1, buff
   h2:	
	mov r9, buff
buffOff .req r9
	mov r2, #16
   stmia sp, {r5-r7, r9}
	ldr r0, [fp, #-4]
	bl  read
	cmp r0, #0
	beq e0
	stmia sp, {r5-r7, r9}
strs .req r5
	adr r4, .fmt
fmt  .req r4
	adr r8, .delims
delims .req r8
	mov r10, #0
     t0:	
	mov r0, fmt
	mov r1, strs
stmia sp, {fmt, strs, buff, fns, delims, buffOff, r10}
	bl  printf
	cmp r0, #0
	beq e0
ldmia sp, {fmt, strs, buff, fns, delims, buffOff, r10}
	add strs, strs, r0
	add strs, strs, #1
	mov r0, buffOff
	ldr r1, [fns]
	mov lr, pc
	bx  r1
	add buffOff, buffOff, r0
	add fns, fns, #4
stmia sp, {r1, fmt, strs, buff, fns, delims, buffOff, r10}
	mov r0, fmt
	mov r1, delims
	bl  printf
ldmia sp, {r1, fmt, strs, buff, fns, delims, buffOff, r10}
	mov r0, fmt
stmia sp, {fmt, strs, buff, fns, delims, buffOff, r10}
	bl  printf
	mov r0, #10
	bl  putchar
ldmia sp, {fmt, strs, buff, fns, delims, buffOff, r10}
	add r10, r10, #1
	cmp r10, #4
	beq e0
	b   t0
  e0:
	ldr r0, [fp, #-4]
	bl  close
	mov sp, fp
	ldmfd sp!, {r4-r10, fp, lr} 
	bx  lr
.delims:
	.asciz " : "
	.align 2
.fmt:
	.asciz "%s"
	.align 2
.fns:
	.long handlers-h0 
.strs:
	.long strUA-h1
.e_ident:
	.long e_ident-h2
	.fnend
	.include "elf.data.s"
