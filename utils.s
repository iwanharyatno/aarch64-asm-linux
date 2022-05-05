.text
    str2UInt:
        stp     x29, x30, [sp, #-16]!
        stp     x4, x5, [sp, #-16]!
        stp     x2, x3, [sp, #-16]!
        stp     x6, x1, [sp, #-16]!

        mov     x5, #10
        mov     x4, #1
        mov     x0, #0
    str2UInt_Count:
        sub     x2, x2, #1
        ldrb    w3, [x1, x2]
        sub     w3, w3, #48

        madd    x0, x3, x4, x0
        mul     x4, x4, x5

        cmp     x2, #0
        bne     str2UInt_Count

        ldp     x6, x1, [sp], #16
        ldp     x2, x3, [sp], #16
        ldp     x4, x5, [sp], #16
        ldp     x29, x30, [sp], #16
        ret

    toUpper:
        stp     x29, x30, [sp, #-16]!
        stp     x2, x3, [sp, #-16]!
        stp     x0, x1, [sp, #-16]!

    toUpper_Convert:
        ldrb    w3, [x0], #1
        cmp     x3, #'a'
        bge     _toUpper
        b       _store
    _toUpper:
        cmp     x3, #'z'
        bgt     _store
        sub     x3, x3, #32
    _store:
        strb    w3, [x1], #1

        subs    x2, x2, #1
        bne     toUpper_Convert

        ldp     x0, x1, [sp], #16
        ldp     x2, x3, [sp], #16
        ldp     x29, x30, [sp], #16
        ret

    strBin2UInt:
        stp     x29, x30, [sp, #-16]!
        stp     x5, x6, [sp, #-16]!
        stp     x3, x4, [sp, #-16]!
        stp     x1, x2, [sp, #-16]!

        mov     x4, #2
        mov     x3, #1
        mov     x0, #0
    strBin2UInt_Convert: 
        sub     x2, x2, #1
        ldrb    w5, [x1, x2]
        sub     w5, w5, #48

        madd    x0, x5, x3, x0
        mul     x3, x3, x4

        cmp     x2, #0
        bne     strBin2UInt_Convert

        ldp     x1, x2, [sp], #16
        ldp     x3, x4, [sp], #16
        ldp     x5, x6, [sp], #16
        ldp     x29, x30, [sp], #16
        ret
