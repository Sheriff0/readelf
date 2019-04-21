	.text 0
	.globl wToHex
	.type wToHex, %function
	.align 2

wToHex:	.fnstart
	stmfd sp!, {r4-r6, lr}
	cmp r1, #0
	moveq r1, r0	
	ldr r0, [r0]
	mov r3, #0xf0
  11:	
	ldr r6, .t0
	add r6, r6, pc
	mov r4, #0	
    1:
    	cmp r4, #8
	beq 10f
	and r5, r0, r3
	cmp r3, #0xf0
	lsreq r3,r3, #4
	lsreq r5, r5, #4
	lslne r3, r3, #4
	lsrne r0, r0, #8
	ldrb r5, [r6, r5]
	strb r5, [r1, r4]
	add r4, r4, #1
	b   1b
    10:
	ldmfd sp!, {r4-r6, lr}
	bx  lr
	.align 2
	.type .t0, %object
.t0:
	.long hexes-1b	
	.fnend

	.section ".rodata.array", #alloc
	.globl hexes
	.type hexes, %object
	.align 2
   hexes:
   	  .ascii "0123456789abcdef"
	  .size hexes, 16
