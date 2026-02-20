.section .bss
.globl ram
.lcomm ram, 256     # Reserve 256 bytes of RAM (uninitialized memory)

.section .text
.globl loop_start    # Make function visible to C program

loop_start:
    movq $10, %rcx       # Define counter
    movq $0, %rax        # Define sum

loop1:
    addq %rcx, %rax  # Add counter to sum

    decq %rcx        # Decrement counter
    cmpq $0, %rcx    # Compare counter to 0 to see if loop is finished
    jnz loop1        # jump to loop1 if line above is true

    movq %rax, ram+0x50 # move results to ram

    ret             # Return control back to C program

.section .note.GNU-stack,"",@progbits