.global _start
.align  8

.include "io.s"
.include "utils.s"

.data
    input_placeholder:      .ascii  "Masukkan angka: "
    input_placeholder_len=  . - input_placeholder
    result_text:            .ascii "Nilai angka tersebut dalam heksadesimal: "
    result_text_len=        . - result_text
    input_container:        .fill   20, 1, 0
    input_container_len=    . - input_container

.text
    _start:
        ldr     x1, =input_placeholder
        ldr     x2, =input_placeholder_len
        bl      print

        ldr     x1, =input_container
        ldr     x2, =input_container_len
        bl      inputSTDIN

        mov     x2, x0
        bl      str2Udec

        ldr     x1, =result_text
        ldr     x2, =result_text_len
        bl      print

        bl      printHex

        mov     x0, #0
        bl      exit
