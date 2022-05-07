.text
    // x0: pointer list
    // x1: ukuran list
    // x2: pointer string untuk dimasukkan ke dalam list
    // x3: panjang string yang ditunjuk x2
    ladd:
	    stp     x29, x30, [sp, #-16]!
        stp     x4, x5, [sp, #-16]!
        stp     x2, x3, [sp, #-16]!
	    stp     x0, x1, [sp, #-16]!
	
        ldr     x4, [x0], #4
        cmp     x4, #0
        beq     ladd_store
    ladd_tail:
        subs    x1, x1, #1
        beq     ladd_exit

        ldr     x4, [x0], #4

        cmp     x4, #0
        bne     ladd_tail
    ladd_store:
        sub     x0, x0, #4
        str     x3, [x0], #4
        str     x2, [x0]
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
        ldr     w2, [x0], #4
        ldr     w1, [x0]
        bl      println

        add     x0, x0, #4

        ldr     x3, [x0]
        cmp     x3, #0
        bne     lprint_printElem
        
        ldp     x0, x1, [sp], #16
        ldp     x2, x3, [sp], #16
        ldp     x29, x30, [sp], #16
        ret

    // x0: pointer list
    // x1: "indeks" elemen
    // kembalian,
    // x2: pointer hasil elemen
    // x3: panjang dari string yang ditunjuk x2
    lget:
        stp     x29, x30, [sp, #-16]!
        stp     x0, x1, [sp, #-16]!
        str     x4, [sp, #-16]! 
        
        mov     x4, #8
        mul     x1, x1, x4

        ldr     w3, [x0, x1]
        add     x0, x0, x1
        ldr     w2, [x0, #4]

        ldr     x4, [sp], #16
        ldp     x0, x1, [sp], #16
        ldp     x29, x30, [sp], #16
        ret
