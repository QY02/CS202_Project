.data 0x0000
.text 0x0000
initialization:
    addi $s1, $zero, 0x001F
    addi $s2, $zero, 0
    addi $s3, $zero, 0x001F
    addi $s5, $zero, 0x000F
    addi $s6, $zero, 1

start:
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC80
    lw $s0, 0($t0)

    bne $s0, $s3, check1
    addi $s1, $zero, 0x001F
    j display

check1:
    bne $s0, $s1, select
    j display

select:
    addi $s1, $s0, 0
    beq $s0, $s5, deleteValue
    slti $t1, $s0, 10
    beq $t1, $s6, check2
    j display

check2:
    lui $t2, 0x0098
    ori $t2, $t2, 0x9680
    slt $t1, $s2, $t2
    beq $t1, $s6, addValue
    j display

addValue:
    add $s4, $s2, $s2
    sll $s2, $s2, 3
    add $s2, $s2, $s4
    add $s2, $s2, $s0
    j display

deleteValue:
    addi $t2, $zero, 0

divideLoopBig:
    slti $t1, $s2, 0x2710
    beq $t1, $s6, divideLoop
    addi $t3, $zero, 0x2710
    sub $s2, $s2, $t3
    addi $t2, $t2, 1000
    j divideLoopBig


divideLoop:
    slti $t1, $s2, 10
    beq $t1, $s6, divideFinish
    addi $t3, $zero, 10
    sub $s2, $s2, $t3
    addi $t2, $t2, 1
    j divideLoop

divideFinish:
    addi $s2, $t2, 0
    j display

display:
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC90
	sw $s2, 0($t0)

	j start