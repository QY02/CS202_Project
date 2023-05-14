.data 0x0000
.text 0x0000
    start:
    addi $s2, $zero, 3
    addi $s3, $zero, 2
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC70
    lw $s0, 0($t0)
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC60
    sw $s0, 0($t0)
    beq $s0, $s3, start
    sw $s2, 1($t0)
    sw $s3, 2($t0)