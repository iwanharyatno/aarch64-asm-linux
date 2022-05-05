.text
    ladd:
	    stp     x29, x30, [sp, #-16]!
        stp     x4, x5, [sp, #-16]!
        stp     x2, x3, [sp, #-16]!
	    stp     x0, x1, [sp, #-16]!

        mov     x5, #3
	
        ldrb    w4, [x0], #1
        cmp     x4, #0
        beq     ladd_store_setlen
    ladd_tail:
        subs    x1, x1, #1
        beq     ladd_exit

        ldrb    w4, [x0], #1

        cmp     x4, #0
        bne     ladd_tail
    ladd_store_setlen:
        sub     x0, x0, #1
        str     w3, [x0], #1
    ladd_store:
        ldrb    w4, [x2], #1
        strb    w4, [x0], #1
        sub     x3, x3, #1

        cmp     x3, #0
        bne     ladd_store
        strb    w5, [x0], #1
    ladd_exit:
	    ldp     x0, x1, [sp], #16
        ldp     x2, x3, [sp], #16
        ldp     x4, x5, [sp], #16
	    ldp     x29, x30, [sp], #16
	    ret

    lprint:
        stp     x29, x30, [sp, #-16]!
        stp     x2, x3, [sp, #-16]!
        stp     x0, x1, [sp, #-16]!

        mov     x3, #0
        mov     x2, #0
    lprint_printElem:
        ldrb    w2, [x0]
        add     x0, x0, #1
        mov     x1, x0
        bl      println

        add     x0, x0, x2

        ldrb    w3, [x0], #1
        cmp     w3, #3
        beq     lprint_printElem
        
        ldp     x0, x1, [sp], #16
        ldp     x2, x3, [sp], #16
        ldp     x29, x30, [sp], #16
        ret

    // x0: pointer list
    // x1: "indeks" elemen
    lget:
        stp     x29, x30, [sp, #-16]!
        stp     x0, x1, [sp, #-16]!

        mov     x2, #0
        mov     x3, #0
    lget_find:
        mov     x2, x0
        ldrb    w3, [x0], #2

        add     x0, x0, x3

        subs    x1, x1, #1
        bne     lget_find

        add     x2, x2, #1

        ldp     x0, x1, [sp], #16
        ldp     x29, x30, [sp], #16
        ret
