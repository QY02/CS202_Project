.data 
	a: .space 8
.text
	la $a0,a
	li $v0,5
	syscall
	sw $v0,($a0)
	
	addi $t0,$t0,1 #var 1
	lw $t1,a
	
	beq $t1,1,isExp
	beq $t1,0,isExp
loop:
	sll $t0,$t0,1
	bgt $t1,$t0,loop
	beq $t1,$t0,isExp
	li $a0,0
	li $v0,1
	syscall
	
	li $v0,10
	syscall
	
isExp:
	li $a0,1
	li $v0,1
	syscall
		