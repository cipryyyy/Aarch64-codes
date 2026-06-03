// Print the number contained in register x10 (line 18)

.global _main

.text
_main:
	//Load initial text
	mov x0, #1
	adrp x1, str@PAGE
	add x1, x1, str@PAGEOFF
	adrp x2, EOFstr@PAGE
	add x2, x2, EOFstr@PAGEOFF
	sub x2, x2, x1
	movz x16, #0x200, LSL #16
	movk x16, #4
	svc #0

	ldr x10, =6942062		//Dividend
	mov x11, #10			//Divisor
	adrp x1, output@PAGE
	add x1, x1, output@PAGEOFF 	//ascii target
	add x1, x1, #39			//End of buffer (insert from the end backward)
	mov x2, #0		 	//Length

	//convert
_loop:
	udiv x13, x10, x11		//Quotient
	msub x12, x13, x11, x10		//Remainder
	mov x10, x13			//Update dividend

	add x12, x12, #48		//ASCII conversion
	strb w12, [x1]			//Store byte
	
	sub x1, x1, #1			//Move back the buffer
	add x2, x2, #1			//Increment length to print
	cmp x10, #0			//Check if its equal to 0
	bne _loop			//If no, loop

	//Print number
	mov x0, #1
	add x1, x1, #1			//output buffer + 1
	movz x16, #0x200, LSL #16
	movk x16, #4
	svc #0

	//Load newline
	mov x0, #1
	adrp x1, endl@PAGE
	add x1, x1, endl@PAGEOFF
	adrp x2, EOFendl@PAGE
	add x2, x2, EOFendl@PAGEOFF
	sub x2, x2, x1
	movz x16, #0x200, LSL #16
	movk x16, #4
	svc #0

	//Exit
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
