.data 0x0000
.text 0x0000
start:
    addi $t3, $zero, 1
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC70
    lw $s0, 0($t0)

    sll $s0, $s0, 24
    srl $s0, $s0, 24

    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC60
    sw $s0, 0($t0)
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC90
    sw $a0, 0($t0)
	lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC60

	and $t1, $s0, $t3

	beq $t1, $t3, isOdd
	add $zero, $zero, $zero

	sw $zero, 1($t0)
	j start
	add $zero, $zero, $zero
	
isOdd:
    sw $t3, 1($t0)
	j start
	add $zero, $zero, $zero