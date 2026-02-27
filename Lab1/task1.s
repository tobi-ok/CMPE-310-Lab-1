.section .bss
.globl ram
.lcomm ram, 256     # Reserve 256 bytes of RAM (uninitialized memory)

.section .text
.globl fill_ram    # Make function visible to C program

fill_ram:
    # Store FFh into RAM locations 50H - 58H using direct addressing

    # (mov)e(b)yte value, location
    # value = ($)constant(0x)hex(FF)data
    # location = ram+(0x)hex(##)position

    movb $0xFF, ram+0x50
    movb $0xFF, ram+0x51
    movb $0xFF, ram+0x52
    movb $0xFF, ram+0x53
    movb $0xFF, ram+0x54
    movb $0xFF, ram+0x55
    movb $0xFF, ram+0x56
    movb $0xFF, ram+0x57
    movb $0xFF, ram+0x58

    ret             # Return control back to C program

.section .note.GNU-stack,"",@progbits
