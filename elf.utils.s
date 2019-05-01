/*
*r3 contains control flags passed to functions in the program
*r3[0] = class(0 for 32bits, 1 for 64bits objects)
*r3[1]  = data encoding(0 for little, 1 for big)
*
*/


	.text 0
.globl getMagic
	.type getMagic, %function
	.align 2
getMagic: .fnstart
	ldr r1, [r7] 	
	lsr r1, r1, #8
	str r1, [r7]
	mov r3, r7
	ldr r0, 50f
	add r0, r0, pc
	ldr r1, 51f
	add r1, r1, pc
	ldr r2, 52f
	add r2, r2, pc
	stmfd sp!, {r0, r2, lr}
	bl  printf
	ldmfd sp!, {r0, r2, lr}
	mov r1, #4
	bx  lr

50:
    .long triSL-(getMagic+(4*7))

51:
    .long ei_mag-(getMagic+(4*9))

52:
    .long colDelim-(getMagic+(4*11))
.size getMagic, .-getMagic
	  .fnend
	
	.globl getEndia
	.type getEndia, %function
	.align 2
getEndia: .fnstart
	 ldrb r3, [r7]
	 cmp r3, #1
	 adr r3, little
	 adrne r3, big
	 ldr r1, 51f
	 add r1, r1, pc
	 stmfd sp!, {r0, r2, lr}
     20:
	 bl  printf
	 ldmfd sp!, {r0, r2, lr}
	 mov r1, #1
	 bx  lr
51:
    .long ei_data-20b

  big:
	.asciz "2's Complement MSB"
	.align 1
little:
	.asciz "2's Complement LSB"
.size getEndia, .-getEndia
	 .fnend

	.globl getMtype
	.type getMtype, %function
	.align 2
getMtype: .fnstart
	 ldrb r3, [r7]
	 cmp r3, #1
	 adr r3, m32
	 adrne r3, m64
	 ldr r1, 51f
	 add r1, r1, pc
	 stmfd sp!, {r0, r2, lr}
    20: 
	 bl  printf
	 ldmfd sp!, {r0, r2, lr}
	 mov r1, #1
	 bx  lr
      	 .align 2
51:
    .long ei_class-20b
m32:
     .asciz "32-Bits Objects"
     .align 2
m64:
     .ascii "64-Bits Objects"
.size getMtype, .-getMtype
     .fnend


	.globl getElfV
	.type getElfV, %function
	.align 2
getElfV:.fnstart
	ldrb r3, [r7]
	cmp r3, #1
	adr r3, cv
	adrne r3, iv
	ldr r1, 51f
	add r1, r1, pc
	stmfd sp!, {r0, r2, lr}
    20:
	bl  printf
	ldmfd sp!, {r0, r2, lr}
	mov r1, #1
	bx    lr
   .align 2
51:
    .long ei_version-20b
cv:
	.asciz "EV_CURRENT"
	.align 2
iv:
	.asciz "EV_INVALID"
.size getElfV, .-getElfV
	.fnend

	.text 1
	.globl e_type32_HalfLSB
	.type  e_type32_HalfLSB, %function
	.align 2
e_type32_HalfLSB: .fnstart
	ldrh r2, [r0]
	adr r3, ET_PTR
	ldr r1, [r3, r2]
	add r1, r1, pc
	mov r0, #2
    1:	
	bx  lr

ET_PTR:
	.long ET_NONE-1b, ET_REL-1b, ET_EXEC-1b, ET_DYN-1b, ET_CORE-1b 
	.size ET_PTR, .-ET_PTR
		.fnend
/*
	.globl e_type32_HalfMSB
	.type e_type32_HalfMSB, %function
e_type32_HalfMSB: .fnstart
	      bx  lr
		.fnend

	.globl e_type64_HalfLSB
	.type e_type64_HalfLSB, %function
e_type64_HalfLSB: .fnstart
	      bx  lr
		.fnend


	.globl e_type64_HalfMSB
	.type e_type64_HalfMSB, %function
e_type64_HalfMSB: .fnstart
	      bx  lr
		.fnend


*/
	.globl e_machine32_HalfLSB
	.type e_machine32_HalfLSB, %function
	.align 2
e_machine32_HalfLSB: .fnstart
	ldrh r2, [r0]

		.fnend
	.text 0
 	.globl ET_REDIRECTOR
	.type  ET_REDIRECTOR, %function
	.align 2
ET_REDIRECTOR: .fnstart
	mov r2, r4, lsl #24
	lsr r2, r2, #24
	adr r1, ET_HAND
	ldr r1, [r1, r2]
     1:	
	add r1, r1, pc
	mov pc, r1

ET_HAND:
	.long e_type32_HalfLSB-(1b+8)/*, e_type32_HalfMSB-(1b+8), e_type64_HalfLSB-(1b+8), e_type64_HalfMSB-(1b+8)*/
	.size ET_HAND, .-ET_HAND
	   .fnend

