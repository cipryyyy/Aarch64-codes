.global _main

.text
_main:

  //scan via read syscall

    mov x0, #0
    adrp x1, buffer@PAGE
    add x1, x1, buffer@PAGEOFF
    mov x2, #80
    movz x16, #0x200, LSL #16
    movk x16, #3
    svc #0

  // echo the input
    mov x0, #0
    adrp x1, buffer@PAGE
    add x1, x1, buffer@PAGEOFF
    mov x2, #80
    movz x16, #0x200, LSL #16
    movk x16, #4
    svc #0

  //exit
    mov x0, #0
    movz x16, #0x200, LSL #16
    movk x16, #1
    svc #0

.bss
    buffer: .zero 80
