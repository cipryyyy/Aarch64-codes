# Aarch64-codes
Designed for macOS Aarch64 architecture, for linux technically just switch the syscall register from `x16` to `x8` and remove the `movz x16, #0x200, LSL #16` command, it's just the mask for macOS calls (for some reason).

## How to run them

To run them just type this:

```bash
clang path/to/file.s -o run && ./run && rm -rf run
```

## List of programs

### 00_HelloWorld.s
Yep, that's just an hello world in assembly

### 01_numberPrinter.s
Converts the number contained in register x10 (line 18) from decimal to ASCII and print it via write syscall

### 02_sumFromMemory.s
Loads two number from the `.data` section, sums them and print the result in the terminal

### 03_echo.s
Get user input, store it in memory and print it out (treated as string).

### 04_sumFromUser.s
User can input two numbers, the program will display the sum
