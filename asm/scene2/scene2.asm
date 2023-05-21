.data 0x0000
.text 0x0000

initialization:
    add $s1, $zero, $zero
    add $s2, $zero, $zero
	addi $s7, $zero, 1
	ori $sp, $zero, 0xFFFC

start:
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC70
    lw $t1, 2($t0)

	sll $t3, $t1, 27
	srl $t3, $t3, 31

    srl $t1, $t1, 5
    beq $t1, $zero, case000
    add $zero, $zero, $zero
    addi $t2, $zero, 1
    beq $t1, $t2, case001
    add $zero, $zero, $zero
    
    addi $t2, $zero, 2
    beq $t1, $t2, case010
    add $zero, $zero, $zero

    addi $t2, $zero, 3
    beq $t1, $t2, case011
    add $zero, $zero, $zero
    
    beq $t3, $s7, inputNum
    add $0,$0,$0 #input the number A and B,stored in $s1,$s2

    addi $t2, $zero, 4
    beq $t1, $t2, case100
    add $zero, $zero, $zero

    addi $t2, $zero, 5
    beq $t1, $t2, case101
    add $zero, $zero, $zero

    addi $t2, $zero, 6
    beq $t1, $t2, case110
    add $zero, $zero, $zero
    
    addi $t2, $zero, 7
    beq $t1, $t2, case111
    add $zero, $zero, $zero

    j start
    add $zero, $zero, $zero

case000:
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC70
    lw $s0, 0($t0)

    sll $s0, $s0, 24
    srl $s0, $s0, 24
    
	beq $s0, $zero, zero
    add $zero, $zero, $zero

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
	jal stall
	add $zero,$zero,$zero
	lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC60
    sw $zero, 0($t0)
	jal stall
	add $zero,$zero,$zero
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
	lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC90
    sw $s1, 0($t0)
		lui $t0, 0xFFFF
    	ori $t0, $t0, 0xFC60

	j start
	add $zero,$zero,$zero
zero:
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC60
    sw $zero, 0($t0)
	lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC90
    sw $zero, 0($t0)
		lui $t0, 0xFFFF
    	ori $t0, $t0, 0xFC60
	j start
	add $zero,$zero,$zero

case001:
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC70
    lw $s0, 0($t0)

    sll $s0, $s0, 24
    srl $s0, $s0, 24

    addi $a0, $s0, 0
	addi $v0, $zero, 0
	addi $v1, $zero, 0

	jal calculate001
	add $zero, $zero, $zero

	lui $t0, 0xFFFF
	ori $t0, $t0, 0xFC60
	sw $v1, 0($t0)
	lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC90
    sw $v1, 0($t0)
		lui $t0, 0xFFFF
    	ori $t0, $t0, 0xFC60

	j start
	add $zero, $zero, $zero
    
calculate001:
	slti $t1, $a0, 1
	beq $t1, $s7, return001
	add $zero, $zero, $zero

    addi $sp,$sp,-8
	sw $ra, 4($sp)
	sw $a0, 0($sp)
	addi $v1, $v1, 2
	addi $a0, $a0, -1

	jal calculate001
	add $zero, $zero, $zero
	lw $a0, 0($sp)
	lw $ra, 4($sp)
	addi $sp,$sp,8
	addi $v1, $v1, 2
	add $v0, $v0, $a0
return001:
	jr $ra
	add $zero, $zero, $zero

# stackin001:
# 	addi $sp,$sp,-8
# 	addi $t6,$t6,-8 #record the change of $sp
# 	sw $ra, 4($sp)
#  	sw $s0, 0($sp)
#  	addi $t3,$t3,1 #when stack get in or out,count
#  	slti $t4,$s0,1
#  	beq $t4,$0,stackout001
#  	add $0,$0,$0
#  	jr $ra
# stackout001:
# 	addi $s0,$s0,-1
# 	jal stackin001
# 	add $0,$0,$0
# 	lw $t5,0($sp)
# 	add $s1,$s1,$t5 #s1 is used to store the total sum
# 	lw $ra,4($sp)
# 	addi $sp,$sp,8
# 	addi $t6,$t6,8
# 	addi $t3,$t3,1 # t3 is used to calculate the cnt of stack operation
# 	beq  $t6,$zero,end001 #$t6 is used to record when $sp point back, then jump out of the loop
# 	add $0,$0,$0
# 	jr $ra 	 	
# 	add $0,$0,$0
# end001:
# 	lui $t0, 0xFFFF
#     	ori $t0, $t0, 0xFC60
# 		sw $s1, 0($t0)
#     	sw $s2, 2($t0)
# 	j start
# 	add $zero,$zero,$zero

case010:
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC70
    lw $s0, 0($t0)

    sll $s0, $s0, 24
    srl $s0, $s0, 24

    addi $a0, $s0, 0
	addi $v0, $zero, 0
	addi $v1, $zero, 0

	jal calculate010
	add $zero, $zero, $zero

	# lui $t0, 0xFFFF
	# ori $t0, $t0, 0xFC60
	# sw $v1, 0($t0)

	j start
	add $zero, $zero, $zero
    
calculate010:
	slti $t1, $a0, 1
	beq $t1, $s7, return010
	add $zero, $zero, $zero

    addi $sp,$sp,-8
	sw $ra, 4($sp)
	sw $a0, 0($sp)

	lui $t0, 0xFFFF
	ori $t0, $t0, 0xFC60
	sw $a0, 0($t0)
	lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC90
    sw $a0, 0($t0)
		lui $t0, 0xFFFF
    	ori $t0, $t0, 0xFC60
	jal stall
	jal stall

	addi $v1, $v1, 2
	addi $a0, $a0, -1

	jal calculate010
	add $zero, $zero, $zero
	lw $a0, 0($sp)
	lw $ra, 4($sp)
	addi $sp,$sp,8
	addi $v1, $v1, 2
	add $v0, $v0, $a0
return010:
	jr $ra
	add $zero, $zero, $zero



# case010:
#     addi $t3, $zero, 0
#     lui $t0, 0xFFFF
#     ori $t0, $t0, 0xFC70
#     lw $s0, 0($t0)

#     sll $s0, $s0, 24
#     srl $s0, $s0, 24

#     addi $s1,$0,0
#     addi $t6,$0,0
# stackin010:
# 	addi $sp,$sp,-8
# 	addi $t6,$t6,-8
# 	sw $ra, 4($sp)
#  	sw $s0, 0($sp)
 	
#  	add $t7,$0,$ra #temp $ra
 	
#  	lui $t0, 0xFFFF
#     	ori $t0, $t0, 0xFC60
#     	sw $s0, 0($t0) #s0 is the num insert into the stack
#     	jal stall #stop for 1 sec
#     	add $0,$0,$0
#     	jal stall
#     	add $0,$0,$0
    	
#     	add $ra,$0,$t7 #change back
    	
#  	slti $t4,$s0,1
#  	beq $t4,$0,stackout010
#  	add $0,$0,$0
#  	jr $ra
# stackout010:
# 	addi $s0,$s0,-1
# 	jal stackin010
# 	add $0,$0,$0
# 	lw $t5,0($sp)
# 	add $s1,$s1,$t5 #s1 is used to store the total sum
# 	lw $ra,4($sp)
# 	addi $sp,$sp,8
# 	addi $t6,$t6,8
# 	beq  $t6,$zero,end010 #$t6 is used to record when $sp point back, then jump out of the loop
# 	add $0,$0,$0
# 	jr $ra 	 	
# 	add $0,$0,$0
# end010:
# 	j start
# 	add $zero,$zero,$zero

case011:
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC70
    lw $s0, 0($t0)

    sll $s0, $s0, 24
    srl $s0, $s0, 24

    addi $a0, $s0, 0
	addi $v0, $zero, 0
	addi $v1, $zero, 0

	jal calculate011
	add $zero, $zero, $zero

	# lui $t0, 0xFFFF
	# ori $t0, $t0, 0xFC60
	# sw $v1, 0($t0)

	j start
	add $zero, $zero, $zero
    
calculate011:
	slti $t1, $a0, 1
	beq $t1, $s7, return011
	add $zero, $zero, $zero

    addi $sp,$sp,-8
	sw $ra, 4($sp)
	sw $a0, 0($sp)

	addi $v1, $v1, 2
	addi $a0, $a0, -1

	jal calculate011
	add $zero, $zero, $zero
	lw $a0, 0($sp)

	lui $t0, 0xFFFF
	ori $t0, $t0, 0xFC60
	sw $a0, 0($t0)
	lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC90
    sw $a0, 0($t0)
		lui $t0, 0xFFFF
    	ori $t0, $t0, 0xFC60
	jal stall
	jal stall

	lw $ra, 4($sp)
	addi $sp,$sp,8
	addi $v1, $v1, 2
	add $v0, $v0, $a0
return011:
	jr $ra
	add $zero, $zero, $zero


# case011:
#     addi $t3, $zero, 0
#     lui $t0, 0xFFFF
#     ori $t0, $t0, 0xFC70
#     lw $s0, 0($t0)

#     sll $s0, $s0, 24
#     srl $s0, $s0, 24

#     addi $s1,$0,0
#     addi $t6,$0,0
# stackin011:
# 	addi $sp,$sp,-8
# 	addi $t6,$t6,-8
# 	sw $ra, 4($sp)
#  	sw $s0, 0($sp)
# 	slti $t4,$s0,1
#  	beq $t4,$0,stackout011
#  	add $0,$0,$0
#  	jr $ra
# stackout011:
# 	addi $s0,$s0,-1
# 	jal stackin011
# 	add $0,$0,$0
# 	lw $t5,0($sp)
	
# 	add $t7,$0,$ra #temp $ra
	
# 	add $s1,$s1,$t5 #s1 is used to store the total sum
# 	lui $t0, 0xFFFF
#     	ori $t0, $t0, 0xFC60
#     	sw $t5, 0($t0) #s0 is the num out of the stack
#     	jal stall #stop for 1 sec
#     	add $0,$0,$0
#     	jal stall
#     	add $0,$0,$0
    	
# 	lw $ra,4($sp)
# 	addi $sp,$sp,8
# 	addi $t6,$t6,8
# 	beq  $t6,$0,end011 #$t6 is used to record when $sp point back, then jump out of the loop
# 	add $0,$0,$0
# 	jr $ra 	 	
# 	add $0,$0,$0
# end011:
# 	j start
# 	add $zero,$zero,$zero

case100:
    add $t1, $s1, $s2

    sll $t1, $t1, 24
	srl $t1, $t1, 24

    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC60
    sw $t1, 0($t0) #final answer

    # sw $s7, 0($t0)
	# sw $s2, 1($t0)

    srl $t3,$s1,7
    srl $t4,$s2,7
    srl $t1,$t1,7
    beq $t3,$t4,possiOverflow
    add $0,$0,$0
    j start
    add $zero, $zero, $zero
possiOverflow:
	bne $t3,$t1,overflow
	add $0,$0,$0
	j start
overflow:
	#addi $t2,$0,1
	sw $s7,1($t0) #output the overflow
	j start
	add $0,$0,$0



case101:
    sub $t1, $s1, $s2

    sll $t1, $t1, 24
	srl $t1, $t1, 24

    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC60
    sw $t1, 0($t0) #final answer
    srl $t3,$s1,7
    srl $t4,$s2,7
    srl $t1,$t1,7
    bne $t3,$t4,possiOverflow
    add $0,$0,$0
    j start
    add $zero, $zero, $zero

case110:
    srl $t1, $s1, 7
	srl $t2, $s2, 7
	beq $t1, $s7, negA
	addi $t3, $s1, 0
	j checkB110
checkB110:
    beq $t2, $s7, negB
	addi $t4, $s2, 0
	j multiply

negA:
    nor $t3, $s1, $zero
	addi $t3, $t3, 1
	j checkB110


negB:
	nor $t4, $s2, $zero
	addi $t4, $t4, 1
	j multiply

multiply:
    sll $t3, $t3, 24
	srl $t3, $t3, 24
	sll $t4, $t4, 24
	srl $t4, $t4, 24
    addi $s3, $zero, 0
	addi $t5, $zero, 0

multiplyLoop:
    beq $t5, $t4, multiplyFinish
	add $s3, $s3, $t3
	addi $t5, $t5, 1
	j multiplyLoop

multiplyFinish:
    xor $t1, $t1, $t2
	beq $t1, $s7, negAnswer
	j printAnswer

negAnswer:
    nor $s3, $s3, $zero
	addi $s3, $s3, 1
	j printAnswer

printAnswer:
    sll $s3, $s3, 16
	srl $s3, $s3, 16
	lui $t0, 0xFFFF
   	ori $t0, $t0, 0xFC60
	sw $s3,0($t0)
	j start


# case110:
#     srl $a1,$s1,7 #sign bit
#     srl $a2,$s2,7
#     xor $a1,$a1,$a2
#     sll $a1,$a1,15 #significant bit,1+15*0
    
#     sll $s1,$s1,25
#     srl $s1,$s1,25
#     sll $s2,$s2,25
#     srl $s2,$s2,25 #remove sign bit of s1,s2
    
#     addi $a3,$0,0 #cnt
#     addi $s3,$0,0 #answer
# multi:
# 	beq $a3,$s2,printout
# 	add $0,$0,$0
# 	addi $a3,$a3,1
# 	add $s3,$s1,$s3
# printout:
# 	or $s3,$s3,$a1 #add sign bit
# 	lui $t0, 0xFFFF
#    	ori $t0, $t0, 0xFC60
# 	sw $s3,0($t0)
# 	j start
# 	add $0,$0,$0

case111:
    srl $t1, $s1, 7
	srl $t2, $s2, 7
	beq $t1, $s7, negA111
	addi $t3, $s1, 0
	j checkB111
checkB111:
    beq $t2, $s7, negB111
	addi $t4, $s2, 0
	j divde

negA111:
    nor $t3, $s1, $zero
	addi $t3, $t3, 1
	j checkB111


negB111:
	nor $t4, $s2, $zero
	addi $t4, $t4, 1
	j divde

divde:
    sll $t3, $t3, 24
	srl $t3, $t3, 24
	sll $t4, $t4, 24
	srl $t4, $t4, 24
    addi $s3, $zero, 0

divdeLoop:
    slt $t6, $t3, $t4
	beq $t6, $s7, divdeFinish
	sub $t3, $t3, $t4
	addi $s3, $s3, 1
	j divdeLoop

divdeFinish:
    xor $t2, $t1, $t2
	beq $t2, $s7, negQuotient
checkRemainder:
	beq $t1, $s7, negRemainder
	j printDivideAnswer

negQuotient:
    nor $s3, $s3, $zero
	addi $s3, $s3, 1
	j checkRemainder

negRemainder:
	nor $t3, $t3, $zero
	addi $t3, $t3, 1
	j printDivideAnswer

printDivideAnswer:
    sll $s3, $s3, 24
	srl $s3, $s3, 24
	sll $t3, $t3, 24
	srl $t3, $t3, 24

	lui $t0, 0xFFFF
   	ori $t0, $t0, 0xFC60
	sw $s3,0($t0)

	jal stall
	jal stall
	jal stall
	jal stall
	jal stall

	sw $t3,0($t0)

	jal stall
	jal stall
	jal stall
	jal stall
	jal stall

	j start

# case111:
# 	srl $a1,$s1,7 #sign bit of both
#     	srl $a2,$s2,7
#     	xor $a1,$a1,$a2
#     	sll $a1,$a1,7 #significant bit,1+7*0,for quotient
    	
#     	srl $t3,$s1,7
#     	sll $t3,$t3,7 #sign bit of remainder
#     	addi $a3,$0,0 #quotient
#     	#remainder is $s1
    	
#     	sll $s1,$s1,25
#     	srl $s1,$s1,25
#     	sll $s2,$s2,25
#     	srl $s2,$s2,25 #remove sign bit of s1,s2
# divd:
# 	slt $t1,$s1,$s2
# 	beq $t1,$s7,printoutDiv
# 	add $0,$0,$0
# 	sub $s1,$s1,$s2
# 	addi $a3,$a3,1 #add quotient
# 	j divd
# 	add $0,$0,$0
# printoutDiv:
# 	or $s1,$s1,$t3
# 	or $a3,$a3,$a1
# 	lui $t0, 0xFFFF
#     	ori $t0, $t0, 0xFC60	
# 	sw $a3,0($t0)
	
# 	jal stall
# 	add $0,$0,$0
# 	jal stall
# 	add $0,$0,$0
# 	jal stall
# 	add $0,$0,$0
# 	jal stall
# 	add $0,$0,$0
# 	jal stall
# 	add $0,$0,$0
	
# 	sw $s1,0($t0)
	
# 	jal stall
# 	add $0,$0,$0
# 	jal stall
# 	add $0,$0,$0
# 	jal stall
# 	add $0,$0,$0
# 	jal stall
# 	add $0,$0,$0
# 	jal stall
# 	add $0,$0,$0
	
# 	j start
# 	add $0,$0,$0
	
inputNum:
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC70
    lw $s0, 0($t0)

    sll $t1, $s0, 23
    srl $t1, $t1, 31

    sll $s0, $s0, 24
    srl $s0, $s0, 24

    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC60
    sw $s0, 0($t0)

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
    j start
    add $zero, $zero, $zero

inputB:
    add $s2, $zero, $s0
    j start
    add $zero, $zero, $zero

# finishInput:
#     lui $t0, 0xFFFF
#     ori $t0, $t0, 0xFC60
#     #sw $s1, 0($t0)
#     #sw $s2, 1($t0)
#     jr $ra
#     add $zero, $zero, $zero
stall:# for 1 sec
	addi $t9,$0,0 
	lui $t8, 0x0098
	ori $t8, $t8, 0x9680
sec1:
	addi $t9,$t9,1
	bne $t9,$t8,sec1
	add $0,$0,$0
	jr $ra
	add $0,$0,$0