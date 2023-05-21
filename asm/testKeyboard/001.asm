.data 0x0000
.text 0x0000
start:
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC80
    lw $s0, 0($t0)

    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC60
	sw $s0, 0($t0)

	j start
	
