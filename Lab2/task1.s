# use c to get string input

.section .text
.globl start_task

start_task:
    movl $str1, %esi        # Point to string 1
    movl $str2, %edi        # Point to string 2
    movl $0, %edx            # Hamming Distance counter

compare_loop:
    movb (%esi), %al
    movb (%edi), %bl

    cmp $0, %al         # Check if string 1 is done
    je results          # Jump to results if equal to 0
    cmp $0, %bl         # Check if string 2 is done
    je results          # Jump to results if equal to 0

    # Both strings still have text
    
    xorb %bl, %al

    # 0000 0000
    # Test each bit to the xor results
    # testb $bit, xor results

    testb $1, %al
    jz b2
    inc %edx

b2:
    testb $2, %al
    jz b3
    inc %edx

b3:
    testb $4, %al
    jz b4
    inc %edx

b4:
    testb $8, %al
    jz b5
    inc %edx
    
b5:
    testb $16, %al
    jz b6
    inc %edx

b6:
    testb $32, %al
    jz b7
    inc %edx

b7:
    testb $64, %al
    jz b8
    inc %edx
    
b8:
    testb $128, %al
    jz next_char
    inc %edx

next_char:
    inc %esi
    inc %edi
    jmp compare_loop

results:
    mov %edx, result        # Put results in result variable in c
    ret

.section .note.GNU-stack,"",@progbits