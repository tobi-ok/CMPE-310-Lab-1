.section .bss
.globl ram
.lcomm ram, 256     # Reserve 256 bytes of RAM (uninitialized memory)

.section .text
.globl fill_ram    # Make function visible to C program

fill_ram:

    

    ret             # Return control back to C program

.section .note.GNU-stack,"",@progbits