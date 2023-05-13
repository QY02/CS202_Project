.data 0x0000
.text 0x0000
    start:
    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC70
    lw $s0, 0($t0)
    
    sll $s0, $s0, 24
    srl $s0, $s0, 24

    lui $t0, 0xFFFF
    ori $t0, $t0, 0xFC60
    sw $s0, 0($t0)
    j start