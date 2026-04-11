.section .data
# Scroll frames: 11 frames x 8 bytes
# [dig7, dig6, dig5, dig4, dig3, dig2, dig1, dig0]
# 0x6D=S  0x76=H  0x79=E  0x00=blank
scroll_frames:
    .byte 0x00,0x00,0x00,0x00,0x00,0x79,0x76,0x6D  # _____EHS
    .byte 0x00,0x00,0x00,0x00,0x79,0x76,0x6D,0x00  # ____EHS_
    .byte 0x00,0x00,0x00,0x79,0x76,0x6D,0x00,0x00  # ___EHS__
    .byte 0x00,0x00,0x79,0x76,0x6D,0x00,0x00,0x00  # __EHS___
    .byte 0x00,0x79,0x76,0x6D,0x00,0x00,0x00,0x00  # _EHS____
    .byte 0x79,0x76,0x6D,0x00,0x00,0x00,0x00,0x00  # EHS_____
    .byte 0x00,0x79,0x76,0x6D,0x00,0x00,0x00,0x00  # _EHS____
    .byte 0x00,0x00,0x79,0x76,0x6D,0x00,0x00,0x00  # __EHS___
    .byte 0x00,0x00,0x00,0x79,0x76,0x6D,0x00,0x00  # ___EHS__
    .byte 0x00,0x00,0x00,0x00,0x79,0x76,0x6D,0x00  # ____EHS_
    .byte 0x00,0x00,0x00,0x00,0x00,0x79,0x76,0x6D  # _____EHS

.section .text
.global _start
_start:
    # Control word 0x80 = 1000 0000
    # Bit 7=1: mode set command (always 1)
    mov $0x80, %al
    mov $0x643, %dx             # control register address
    out %al, %dx                # program the 8255

main_loop:
    mov $scroll_frames, %rsi    # ESI -> start of frame table
    mov $11, %rcx               # 11 frames per cycle

frame_loop:
    push %rcx                   # save outer frame counter
    push %rsi                   # save frame pointer

    mov $8, %rcx                # 8 digit positions per frame
    mov $0x01, %bl              # BL = digit select, start at dig0 (bit 0)

digit_loop:
    # Calculate index into current frame
    mov $8, %eax
    sub %rcx, %eax              # EAX = 8 - ECX = digit index (0=dig7 .. 7=dig0)
    movzbl (%rsi,%eax), %eax    # load segment byte for digit

    # Send segment pattern to Port B
    mov $0x641, %dx             # Port B address
    out %al, %dx

    # Send digit select to Port A
    mov %bl, %al            # digit select bit
    mov $0x640, %dx         # Port A address
    out %al, %dx

    shl $1, %bl             # shift select left -> next digit position
    loop digit_loop         # repeat for all 8 digits

    pop %rsi                # restore saved frame pointer
    pop %rcx                # restore saved frame counter
    add $8, %rsi            # next frame
    loop frame_loop
    
    jmp main_loop           # bounce