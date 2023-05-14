.data 0x0000
.text 0x0000

initialization:
    add $s1, $zero, $zero
    add $s2, $zero, $zero

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
    addi $t2, $zero, 7
    beq $t1, $t2, case111
    add $zero, $zero, $zero

    addi $t2, $zero, 2
    beq $t1, $t2, case010
    add $zero, $zero, $zero

    #addi $t2, $zero, 3
    #beq $t1, $t2, case011
    #add $zero, $zero, $zero

    #addi $t2, $zero, 4
    #beq $t1, $t2, case100
    #add $zero, $zero, $zero

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

case010:
    or $t1, $s1, $s2
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC60
    sw $s1, 0($t0)
    sw $s2, 1($t0)
    sw $t1, 2($t0)
    j start
    add $zero, $zero, $zero

case011:
    or $t1, $s1, $s2
    not $t1, $t1
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC60
    sw $s1, 0($t0)
    sw $s2, 1($t0)
    sw $t1, 2($t0)
    j start
    add $zero, $zero, $zero

case100:
    xor $t1, $s1, $s2
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC60
    sw $s1, 0($t0)
    sw $s2, 1($t0)
    sw $t1, 2($t0)
    j start
    add $zero, $zero, $zero

case111:
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC70
    lw $s0, 0($t0)

    sll $t1, $s0, 23
    srl $t1, $t1, 31

    sll $s0, $s0, 24
    srl $s0, $s0, 24

    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC60
    sw $t1, 2($t0)

    beq $t1, $zero, inputA
    add $zero, $zero, $zero

    addi $t2, $zero, 1
    beq $t1, $t2, inputB
    add $zero, $zero, $zero

inputA:
    add $s1, $zero, $s0
    j finishInput
    add $zero, $zero, $zero

inputB:
    add $s2, $zero, $s0
    j finishInput
    add $zero, $zero, $zero

finishInput:
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC60
    sw $s1, 0($t0)
    sw $s2, 1($t0)
    j start
    add $zero, $zero, $zero