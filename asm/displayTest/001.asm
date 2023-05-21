.data 0x0000
.text 0x0000
initialization:
    addi $s1, $zero, 0x001F
    addi $s2, $zero, 0
    addi $s3, $zero, 0x001F

start:
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC80
    lw $s0, 0($t0)

    bne $s0, $s3, check1
    addi $s1, $zero, 0x001F
    j display

check1:
    bne $s0, $s1, addValue
    j display

addValue:
    add $s2, $s2, $s0
    addi $s1, $s0, 0
    j display

display:
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC90
	sw $s2, 0($t0)

	j start
	
