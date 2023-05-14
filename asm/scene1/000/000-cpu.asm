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
	
	addi $t1, $zero, 1 #var 1
	
	#j isExp

    #sw $t3, 2($t0)

	beq $s0, $t3, isExp
	add $zero, $zero, $zero
	beq $s0, $zero, loop
	add $zero, $zero, $zero
	#j start
	#add $zero, $zero, $zero
loop:
	sll $t1, $t1, 1
	beq $s0, $t1, isExp
	add $zero, $zero, $zero
	slt $t2, $t1, $s0
	beq $t2, $t3, loop
	add $zero, $zero, $zero

	sw $zero, 1($t0)
	j start
	add $zero, $zero, $zero
	
isExp:
	sw $t3, 1($t0)
	j start
	add $zero, $zero, $zero