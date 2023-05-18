.data 0x0000
.text 0x0000
    start:
    addi $s1, $zero, 1
    addi $s2, $zero, 3
    addi $s3, $zero, 7

    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC70
    lw $s0, 0($t0)
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC60
    sw $s0, 0($t0)
    jal test
    sw $s1, 1($t0)
    sw $s2, 1($t0)
    sw $s3, 1($t0)
    j start
    
    
    test:
    add $s7, $zero, $zero
    add $t7, $zero, $zero
    sw $s1, 2($t0)
    jr $ra
    sw $s2, 2($t0)
    sw $s3, 2($t0)