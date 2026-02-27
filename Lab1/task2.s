.section .bss
.globl ram
.lcomm ram, 256     # Reserve 256 bytes of RAM (uninitialized memory)

.section .text
.globl fill_ram    # Make function visible to C program

fill_ram:
    # Load into ram0x50 then move to the next in table like indexing

    # (mov)e(b)yte memory, location

    movl $ram, %ebx          # Create pointer to ram
    addl $0x50, %ebx         # move pointer to ram+0x50

    movb $0xFF, (%ebx)      # Add data to pointer 0x50
    inc %ebx                # incremet

    movb $0xFF, (%ebx)      # Add data to pointer 0x51
    inc %ebx                # incremet

    movb $0xFF, (%ebx)      # Add data to pointer 0x52
    inc %ebx                # incremet

    movb $0xFF, (%ebx)      # Add data to pointer 0x53
    inc %ebx                # incremet

    movb $0xFF, (%ebx)      # Add data to pointer 0x54
    inc %ebx                # incremet

    movb $0xFF, (%ebx)      # Add data to pointer 0x55
    inc %ebx                # incremet

    movb $0xFF, (%ebx)      # Add data to pointer 0x56
    inc %ebx                # incremet

    movb $0xFF, (%ebx)      # Add data to pointer 0x57
    inc %ebx                # incremet

    movb $0xFF, (%ebx)      # Add data to pointer 0x58
    inc %ebx                # incremet

    ret             # Return control back to C program

.section .note.GNU-stack,"",@progbits
