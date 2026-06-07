.equ INPUT_SIZE, 30
.equ OUTPUT_SIZE, INPUT_SIZE + 1
.global _main

.text
_main:
    //Input first number
	mov x0, #1
	adrp x1, inp1@PAGE
	add x1, x1, inp1@PAGEOFF
	adrp x2, EOFinp1@PAGE
	add x2, x2, EOFinp1@PAGEOFF
	sub x2, x2, x1
	movz x16, #0x200, LSL #16
	movk x16, #4
	svc #0

    mov x0, #0
    adrp x1, number1@PAGE
    add x1, x1, number1@PAGEOFF
    mov x2, #30
    movz x16, #0x200, LSL #16
    movk x16, #3
    svc #0

    adrp x1, number1@PAGE
    add x1, x1, number1@PAGEOFF

    //Convert to number from ascii in register w20
    mov w20, #0     //output
    mov w2, #10   //Base

_loop_convert_1:
    ldrb w11, [x1], #1
    cmp w11, #10
    beq _number1converted
    cmp w11, #48
    blt _loop_convert_1
    
    sub w11, w11, #48
    
    mul w20, w20, w2      
    add w20, w20, w11     
    
    b _loop_convert_1

_number1converted:

    //Input second number
	mov x0, #1
	adrp x1, inp2@PAGE
	add x1, x1, inp2@PAGEOFF
	adrp x2, EOFinp2@PAGE
	add x2, x2, EOFinp2@PAGEOFF
	sub x2, x2, x1
	movz x16, #0x200, LSL #16
	movk x16, #4
	svc #0

    mov x0, #0
    adrp x1, number2@PAGE
    add x1, x1, number2@PAGEOFF
    mov x2, #30
    movz x16, #0x200, LSL #16
    movk x16, #3
    svc #0

    adrp x1, number2@PAGE
    add x1, x1, number2@PAGEOFF

    //Convert to number from ascii in register w1
    mov w21, #0     //output
    mov w2, #10   //Base

_loop_convert_2:
    ldrb w11, [x1], #1
    cmp w11, #10
    beq _number2converted
    cmp w11, #48
    blt _loop_convert_2
    
    sub w11, w11, #48
    
    mul w21, w21, w2      
    add w21, w21, w11     
    
    b _loop_convert_2

_number2converted:
    mov x10, #0
	add w10, w21, w20

    //ASCII conversion
	mov x11, #10			
	adrp x1, output@PAGE
	add x1, x1, output@PAGEOFF 	
	add x1, x1, #OUTPUT_SIZE
    sub x1, x1, #1
	mov x2, #0		 	

_loop3:
	udiv x13, x10, x11		
	msub x12, x13, x11, x10		
	mov x10, x13			

	add x12, x12, #48		
	strb w12, [x1]			
	
	sub x1, x1, #1			
	add x2, x2, #1			
	cmp x10, #0			
	bne _loop3		

    //Print output
	mov x0, #1
	add x1, x1, #1			
	movz x16, #0x200, LSL #16
	movk x16, #4
	svc #0

    //End of line
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
    number1: .zero INPUT_SIZE
    number2: .zero INPUT_SIZE
	output: .zero OUTPUT_SIZE

.align 2
.data
	inp1: .ascii "Insert first number:  "
	EOFinp1: .byte 0
	inp2: .ascii "Insert second number: "
	EOFinp2: .byte 0
	str: .ascii "Sum: "
	EOFstr: .byte 0
	endl: .ascii "\n"
	EOFendl: .byte 0
