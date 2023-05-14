.data 0x0000
.text 0x0000
    start:
    addi $s2, $zero, 3
    start1:
    addi $s2, $zero, 1
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC70
    lw $s0, 0($t0)
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC60
    sw $s0, 0($t0)
    j start1
    sw $s2, 1($t0)