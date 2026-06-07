.global _main

.text
_main:
	mov x0, #1
	adrp x1, str@PAGE
	add x1, x1, str@PAGEOFF
	adrp x2, EOFstr@PAGE
	add x2, x2, EOFstr@PAGEOFF
	sub x2, x2, x1
	movz x16, #0x200, LSL #16
	movk x16, #4
	svc #0

	adrp x0, number1@PAGE
	add x0, x0, number1@PAGEOFF
	ldr w0, [x0]
	adrp x1, number2@PAGE
	add x1, x1, number2@PAGEOFF
	ldr w1, [x1]
	add w10, w1, w0

	mov x11, #10			
	adrp x1, output@PAGE
	add x1, x1, output@PAGEOFF 	
	add x1, x1, #39			
	mov x2, #0		 	

_loop:
	udiv x13, x10, x11		
	msub x12, x13, x11, x10		
	mov x10, x13			

	add x12, x12, #48		
	strb w12, [x1]			
	
	sub x1, x1, #1			
	add x2, x2, #1			
	cmp x10, #0			
	bne _loop			

	mov x0, #1
	add x1, x1, #1			
	movz x16, #0x200, LSL #16
	movk x16, #4
	svc #0

	mov x0, #1
	adrp x1, endl@PAGE
	add x1, x1, endl@PAGEOFF
	adrp x2, EOFendl@PAGE
	add x2, x2, EOFendl@PAGEOFF
	sub x2, x2, x1
	movz x16, #0x200, LSL #16
	movk x16, #4
	svc #0

	mov x0, #0
	movz x16, #0x200, LSL #16
	movk x16, #1
	svc #0

.align 2
.bss
	output: .zero 40

.align 2
.data
	str: .ascii "Your number is: "
	EOFstr: .byte 0
	endl: .ascii "\n"
	EOFendl: .byte 0

	.align 2
	number1: .word 278459
	number2: .word 11
