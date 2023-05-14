.data 0x0000
.text 0x0000

start:
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC70
    lw $t1, 2($t0)
    srl $t1, $t1, 5
    beq $t1, $zero, case000
    add $zero, $zero, $zero
    addi $t2, $zero, 1
    beq $t1, $t2, case001
    add $zero, $zero, $zero
    j start
    add $zero, $zero, $zero

case000:
    addi $t3, $zero, 1
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC70
    lw $s0, 0($t0)

    sll $s0, $s0, 24
    srl $s0, $s0, 24

    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC60
    sw $s0, 0($t0)
	
	addi $t1, $zero, 1 #var 1

	beq $s0, $t3, isExp
	add $zero, $zero, $zero
	beq $s0, $zero, loop000
	add $zero, $zero, $zero
	
loop000:
	sll $t1, $t1, 1
	beq $s0, $t1, isExp
	add $zero, $zero, $zero
	slt $t2, $t1, $s0
	beq $t2, $t3, loop000
	add $zero, $zero, $zero

	sw $zero, 1($t0)
	j start
	add $zero, $zero, $zero
	
isExp:
	sw $t3, 1($t0)
	j start
	add $zero, $zero, $zero

case001:
    addi $t3, $zero, 1
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC70
    lw $s0, 0($t0)

    sll $s0, $s0, 24
    srl $s0, $s0, 24

    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC60
    sw $s0, 0($t0)

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