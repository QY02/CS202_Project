.data 0x0000
.text 0x0000
    start:
    addi $s2, $zero, 1
    addi $s3, $zero, 3
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC70
    lw $s0, 0($t0)
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC60
    sw $s0, 0($t0)
    j start
    sw $s2, 1($t0)
    sw $s3, 2($t0)