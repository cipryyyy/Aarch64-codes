# Aarch64-codes
Designed for macOS Aarch64 architecture, for linux technically just switch the syscall register from `x16` to `x8` and remove the `movz x16, #0x200, LSL #16` command, it's just the mask for macOS calls (for some reason).

## HelloWorld.s
Yep, that's just an hello world in assembly

## numberPrinter.s
Converts the number contained in register x10 (line 18) from decimal to ASCII and print it via write syscall

## sum.s
Loads two number from the `.data` section, sums them and print the result in the terminal
