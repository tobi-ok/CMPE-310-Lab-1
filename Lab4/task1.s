.section .text
.globl sum_array

sum_array:
    movl $0, %eax
    movq $0, %rcx

sum_loop:
    addl (%rdi, %rcx, 4), %eax

    incq %rcx

    cmpq %rsi, %rcx
    jne sum_loop

    ret

.section .note.GNU-stack,"",@progbits