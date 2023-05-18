.data 0x0000
.text 0x0000

initialization:
    add $s1, $zero, $zero
    add $s2, $zero, $zero
	addi $s7, $zero, 1

start:
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC70
    lw $t1, 2($t0)
    srl $t1, $t1, 5
    beq $t1, $zero, case000
    add $zero, $zero, $zero
    j start
    add $zero, $zero, $zero

case000:
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC70
    lw $s0, 0($t0)

    sll $s0, $s0, 24
    srl $s0, $s0, 24
    
    addi $t4,$zero,0 #the adder each time
    addi $s1,$zero,0 #positive add up
    addi $s2,$zero,1 #negative add up
    
    srl $t3, $s0, 7#read the significant bit
    
    beq $t3,$s7,signExtend
    add $zero,$zero,$zero
    j positiveAdd
    add $zero,$zero,$zero
signExtend:
    lui $t5, 0xFFFF
	ori $t5, $t5, 0xFF00
	or $s0, $s0, $t5
	j negativeAdd
	add $zero,$zero,$zero
negativeAdd:
	addi $t4,$t4,-1
	add $s2,$s2,$t4
	bne $t4,$s0,negativeAdd
	add $zero,$zero,$zero
	lui $t0, 0xFFFF
    	ori $t0, $t0, 0xFC60
    	sw $s2, 0($t0)
	j start
	add $zero,$zero,$zero
positiveAdd:
	addi $t4,$t4,1
	add $s1,$s1,$t4
	bne $t4,$s0,positiveAdd
	add $zero,$zero,$zero
	lui $t0, 0xFFFF
    	ori $t0, $t0, 0xFC60
    	sw $s1, 0($t0)
	j start
	add $zero,$zero,$zero