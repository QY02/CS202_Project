.data 0x0000
.text 0x0000
test:
	addi $sp,$sp,-8
	addi $t6,$t6,-8
	sw $ra, 4($sp)
 	sw $s0, 0($sp)
 	
 	#slti $t4,$s0,1
 	beq $t4,$0,stackout011
 	add $0,$0,$0
 	jr $ra
stackout011:
    add $0,$0,$0