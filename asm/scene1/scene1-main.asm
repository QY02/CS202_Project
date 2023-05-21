.data 0x0000
.text 0x0000

initialization:
    add $s1, $zero, $zero
    add $s2, $zero, $zero

start:
    #程序启动，0xfffffc70存储输入
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC70
    lw $t1, 2($t0)
    srl $t1, $t1, 5
    beq $t1, $zero, case000
    
    addi $t2, $zero, 1
    beq $t1, $t2, case001
    
    addi $t2, $zero, 7
    beq $t1, $t2, case111
    

    addi $t2, $zero, 2
    beq $t1, $t2, case010
    

    addi $t2, $zero, 3
    beq $t1, $t2, case011
    

    addi $t2, $zero, 4
    beq $t1, $t2, case100
    

    addi $t2, $zero, 5
    beq $t1, $t2, case101
    

    addi $t2, $zero, 6
    beq $t1, $t2, case110
    

    j start
    

case000:
    #判断2的幂
    addi $t3, $zero, 1
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC70
    lw $s0, 0($t0)

    sll $s0, $s0, 24 #移除前24位
    srl $s0, $s0, 24

    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC60 
    sw $s0, 0($t0)
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC90 #数码显像管存址
    sw $s0, 0($t0)
	lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC60
	
	addi $t1, $zero, 1 #var 1

	beq $s0, $t3, isExp
	
	beq $s0, $zero, loop000
	
	
loop000:
	sll $t1, $t1, 1
	beq $s0, $t1, isExp
	
	slt $t2, $t1, $s0
	beq $t2, $t3, loop000
	

	sw $zero, 1($t0)
	j start
	
	
isExp:
	sw $t3, 1($t0)
	j start
	

case001:
    #判断奇数
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
    sw $s0, 0($t0)
	lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC60

	and $t1, $s0, $t3

	beq $t1, $t3, isOdd
	

	sw $zero, 1($t0)
	j start
	
	
isOdd:
    sw $t3, 1($t0)
	j start
	

case010:
    #按位或
    or $t1, $s1, $s2
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC60
    sw $s1, 0($t0)
    sw $s2, 1($t0)
    sw $t1, 2($t0)
    j start
    

case011:
    #按位或非
    nor $t1, $s1, $s2
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC60
    sw $s1, 0($t0)
    sw $s2, 1($t0)
    sw $t1, 2($t0)
    j start
    

case100:
    #异或
    xor $t1, $s1, $s2
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC60
    sw $s1, 0($t0)
    sw $s2, 1($t0)
    sw $t1, 2($t0)
    j start
    

case101:
    #有符号数比较
    sll $t2, $s1, 24
    sll $t3, $s2, 24
    slt $t1, $t2, $t3
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC60
    sw $s1, 0($t0)
    sw $s2, 1($t0)
    sw $t1, 2($t0)
    j start
    

case110:
    #无符号数比较
    sltu $t1, $s1, $s2
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC60
    sw $s1, 0($t0)
    sw $s2, 1($t0)
    sw $t1, 2($t0)
    j start
    

case111:
    #输入a,b
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
    

    addi $t2, $zero, 1
    beq $t1, $t2, inputB
    

inputA:
    add $s1, $zero, $s0
    j finishInput
    

inputB:
    add $s2, $zero, $s0
    j finishInput
    

finishInput:
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC60
    sw $s1, 0($t0)
    sw $s2, 1($t0)
    j start
    