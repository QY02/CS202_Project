.data 0x0000
.text 0x0000

start:
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC70
    lw $t1, 0($t0)

    sll $t1, $t1, 16
    sra $t1, $t1, 16

    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC60
    sw $t1, 0($t0)

    # lui $t1, 0xFFFF
    # ori $t1, $t1, 0xFFFC


    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC90
    sw $t1, 0($t0)

    j start