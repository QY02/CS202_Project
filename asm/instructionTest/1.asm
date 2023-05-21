.data 0x0000
.text 0x0000

start:
    addi $s0, $zero, 0xFFFF
    addi $s1, $zero, 0xFFFE
    xori $s0, $s0, 0xFFFF

    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC60
	sw $s0, 0($t0)