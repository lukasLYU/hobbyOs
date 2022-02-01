.set MAGICNUMBER, 0x1badb002
.set FLAGS, (1<<0 | 1<<1)
.set CHECKS, -(MAGICNUMBER + FLAGS)

.section .multiboot
    .long MAGICNUMBER
    .long FLAGS
    .long CHECKS

.section .text
.extern kernelMain
.global loader

loader:
    mov $kernel_stack, %esp
    push %eax
    push %ebx
    
    call kernelMain
_stop:
    cli
    hlt
    jmp _stop

.section .bss

.space 2*1024*1024

kernel_stack:
