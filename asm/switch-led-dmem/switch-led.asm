.data 0x0000
.text 0x0000
    start:
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC70
    lw $s0, 0($t0)

    sw $s0, 0($zero)
    lw $s1, 0($zero)

    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC60
    sw $s1, 0($t0)
    beq $zero, $zero, start