.data
    binPrefix:  .ascii  "0b"
    hexPrefix:  .ascii  "0x"
    hexArray:   .ascii  "0123456789ABCDEF"
    newline:    .ascii  "\n"
    char:       .byte   0

.text
    print:
        stp     x29, x30, [sp, #-16]!       // x29, x30: Frame pointer and Stack pointer
        stp     x2, x8, [sp, #-16]!         // x2: Buffer length, x8: Interruption code
        stp     x0, x1, [sp, #-16]!         // x0: File descriptor, x1: Buffer pointer

        mov     x0, #1
        mov     x8, #64
        svc     #0

        ldp     x0, x1, [sp], #16
        ldp     x2, x8, [sp], #16
        ldp     x29, x30, [sp], #16
        ret

    println:
        stp     x29, x30, [sp, #-16]!       // x29, x30: Frame pointer and Stack pointer
        stp     x2, x8, [sp, #-16]!         // x2: Buffer length, x8: Interruption code
        stp     x0, x1, [sp, #-16]!         // x0: File descriptor, x1: Buffer pointer

        mov     x0, #1
        mov     x8, #64
        svc     #0

        ldr     x1, =newline
        mov     x2, #1
        bl      print

        ldp     x0, x1, [sp], #16
        ldp     x2, x8, [sp], #16
        ldp     x29, x30, [sp], #16
        ret

    printReverse:
        stp     x29, x30, [sp, #-16]!       // x29, x30: Frame pointer and Stack pointer
        str     x2, [sp, #-16]!             // x2: Buffer length
        stp     x0, x1, [sp, #-16]!         // x0: Initial Buffer pointer (-1), x1: Buffer pointer + x2

        mov     x0, x1
        sub     x0, x0, #1
        add     x1, x1, x2
        mov     x2, #1
    printReverse_loop:
        bl      print

        subs    x1, x1, #1

        cmp     x1, x0
        bne     printReverse_loop

        ldp     x0, x1, [sp], #16
        ldr     x2, [sp], #16
        ldp     x29, x30, [sp], #16
        ret

    printInt:
        stp     x29, x30, [sp, #-16]!       // x29, x30: Frame pointer and Stack pointer
        stp     x5, x7, [sp, #-16]!         // x5: Number Stack offset, x7: The divisor (10)
        stp     x2, x3, [sp, #-16]!         // x2: Char length (always 1) and division result register, x3: Modulo register
        stp     x0, x1, [sp, #-16]!         // x0: Input number, x1: Decimal Char pointer
        str     x4, [sp, #-16]!

        mov     x7, #10
        mov     x5, #0
        sub     sp, sp, #128

        and     x4, x0, #0x8000000000000000
        cmp     x4, #0
        beq     printInt_Count

        mov     x4, #'-'
        ldr     x1, =char
        strb    w4, [x1]
        mov     x2, #1
        bl      print

        neg     x0, x0
    printInt_Count:
        udiv    x2, x0, x7
        msub    x3, x2, x7, x0
        add     x5, x5, #1
        strb    w3, [sp, x5]
        mov     x0, x2

        cmp     x0, #0
        bne     printInt_Count
    printInt_Print:
        ldr     x1, =char
        ldrb    w3, [sp, x5]
        add     w3, w3, #48
        strb    w3, [x1]
        mov     x2, #1
        bl      print

        subs    x5, x5, #1
        bne     printInt_Print

        ldr     x1, =newline
        mov     x2, #1
        bl      print

        add     sp, sp, #128

        ldr     x4, [sp], #16
        ldp     x0, x1, [sp], #16
        ldp     x2, x3, [sp], #16
        ldp     x5, x7, [sp], #16
        ldp     x29, x30, [sp], #16
        ret

    printHex:
        stp     x29, x30, [sp, #-16]!       // x29, x30: Frame pointer and Stack pointer
        stp     x4, x5, [sp, #-16]!         // x4: Non-zero value flag, x5: Nibble counter
        stp     x2, x3, [sp, #-16]!         // x2: Buffer length (1), x3: Nibble register
        stp     x0, x1, [sp, #-16]!         // x0: Input number, x1: Buffer pointer

        ldr     x1, =hexPrefix
        mov     x2, #2
        bl      print

        mov     w5, #0
        mov     w4, #0
    printHex_Mask:
        and     x3, x0, #0xf000000000000000
        lsr     x3, x3, #60
        lsl     x0, x0, #4

        add     w5, w5, #1

        cmp     w5, #16
        beq     printHex_Print

        cmp     w4, #1
        beq     printHex_Print

        cmp     x3, #0
        beq     printHex_Mask
        mov     w4, #1
    printHex_Print:
        ldr     x1, =hexArray
        ldrb    w3, [x1, x3]

        ldr     x1, =char
        strb    w3, [x1]
        mov     x2, #1
        bl      print

        cmp     w5, #16
        bne     printHex_Mask

        mov     x1, #0
        bl      println

        ldp     x0, x1, [sp], #16
        ldp     x2, x3, [sp], #16
        ldp     x4, x5, [sp], #16
        ldp     x29, x30, [sp], #16
        ret

    printBin:
        stp     x29, x30, [sp, #-16]!       // x29, x30: Frame pointer and Stack pointer
        stp     x4, x5, [sp, #-16]!         // x4: Non-zero value flag, x5: Bit counter
        stp     x2, x3, [sp, #-16]!         // x2: Buffer length (1), x3: Bit register
        stp     x0, x1, [sp, #-16]!         // x0: Input number, x1: Buffer pointer

        ldr     x1, =binPrefix
        mov     x2, #2
        bl      print

        mov     w5, #0
        mov     w4, #0
    printBin_Mask:
        and     x3, x0, #0x8000000000000000
        lsr     x3, x3, #63
        lsl     x0, x0, #1

        add     w5, w5, #1

        cmp     w5, #64
        beq     printBin_Print

        cmp     w4, #1
        beq     printBin_Print

        cmp     w3, #0
        beq     printBin_Mask
        mov     w4, #1
    printBin_Print:
        ldr     x1, =char
        add     x3, x3, #48
        strb    w3, [x1]
        mov     x2, #1
        bl      print

        cmp     w5, #64
        bne     printBin_Mask

        mov     x1, #0
        bl      println

        ldp     x0, x1, [sp], #16
        ldp     x2, x3, [sp], #16
        ldp     x4, x5, [sp], #16
        ldp     x29, x30, [sp], #16
        ret

    inputSTDIN:                
        stp     x29, x30, [sp, #-16]!       // x29, x30: Frame register and Stack pointer
        stp     x2, x8, [sp, #-16]!         // x2: Newline char pointer, x8: Interrupt code

        mov     x0, #0                      // x0: As a file descriptor register
        mov     x8, #63
        svc     #0

        sub     x0, x0, #1                  // x0: As a input buffer length
        ldrb    w2, [x1, x0]                // x1: Input buffer pointer
        cmp     w2, #'\n'
        beq     inputSTDIN_Exit
        add     x0, x0, #1
    inputSTDIN_Exit:
        ldp     x2, x8, [sp], #16
        ldp     x29, x30, [sp], #16
        ret

    exit:
        mov     x8, #93
        svc     #0
        ret
