.globl getMagic
	.type getMagic, %function
getMagic: .fnstart
	ldr r1, [r0] 	
	lsr r1, r1, #8
	str r1, [r0]
	mov r1, r0
	mov r0, #4
	bx  lr
.size getMagic, .-getMagic
	  .fnend
	
	.globl getEndia
	.type getEndia, %function
	.align 2
getEndia: .fnstart
	 ldrb r2, [r0]
	 cmp r2, #1
	 adr r1, little
	 adrne r1, big
	 mov r0, #1
	 bx  lr
  big:
	.asciz "Big"
	.align 1
little:
	.asciz "Little"
.size getEndia, .-getEndia
	 .fnend

	.globl getMtype
	.type getMtype, %function
	.align 2
getMtype: .fnstart
	 ldrb r2, [r0]
	 cmp r2, #1
	 adr r1, m32
	 adrne r1, m64
	 mov r0, #1
	 bx  lr
      	 .align 2
m32:
     .asciz "32 Bits"
     .align 2
m64:
     .ascii "64 Bits"
.size getMtype, .-getMtype
     .fnend


	.globl getElfV
	.type getElfV, %function
	.align 2
getElfV:.fnstart
	ldrb r2, [r0]
	cmp r2, #1
	adr r1, cv
	adrne r1, iv
	mov r0, #1
	bx    lr
   .align 2
cv:
	.asciz "Current Version"
	.align 2
iv:
	.asciz "Invalid Version"
.size getElfV, .-getElfV
	.fnend

