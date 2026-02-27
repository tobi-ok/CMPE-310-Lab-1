.section .data
prompt1: .asciz "Enter first string: "
prompt2: .asciz "Enter second string: "

.section .bss
.lcomm str1, 256        # Hold 256 bytes for string 1
.lcomm str2, 256        # Hold 256 bytes for string 2

.section .text
.globl start_task

start_task:
    movl $str1, %esi        # Point to string 1
    movl $str2, %edi        # Point to string 2
    movw $0, %dx            # Hamming Distance counter

compare_loop:
    cmp $0, %ecx         # Check if counter is 0
    je results          # Jump to results if equal to 0

    # Else

    movb (%esi), %al
    movb (%edi), %bl
    xorb %al, %bl

    # 0000 0000
    # Test each bit to the xor results
    # testb $bit, xor results

    testb $1, %al
    jz b2
    inc %dx

b2:
    testb $2, %al
    jz b3
    inc %dx

b3:
    testb $4, %al
    jz b4
    inc %dx

b4:
    testb $8, %al
    jz b5
    inc %dx
    
b5:
    testb $16, %al
    jz b6
    inc %dx

b6:
    testb $32, %al
    jz b7
    inc %dx

b7:
    testb $64, %al
    jz b8
    inc %dx
    
b8:
    testb $128, %al
    jz next_char
    inc %dx

next_char:
    inc %esi
    inc %edi
    dec %ecx
    jmp compare_loop

results:
    mov $1, %eax
    mov $0, %ebx

.section .note.GNU-stack,"",@progbits