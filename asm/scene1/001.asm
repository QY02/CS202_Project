.data 
	a: .space 8
	check: .word 1
.text
	la $a0,a
	li $v0,5
	syscall
	sw $v0,($a0)
	
	lw $t0,a
	lw $t1,check
	and $a0,$t0,$t1
	li $v0,1
	syscall