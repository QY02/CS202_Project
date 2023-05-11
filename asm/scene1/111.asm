.data 
	a: .space 8
	n: .ascii "\n"
	.align 2
	b: .space 8
.text
	la $a0,a
	li $v0,5
	syscall
	sw $v0,($a0)
	
	la $a0,b
	li $v0,5
	syscall
	sw $v0,($a0)
	
	lw $a0,a
	li $v0,1
	syscall
	
	la $a0,n
	li $v0,4
	syscall
	
	lw $a0,b
	li $v0,1
	syscall