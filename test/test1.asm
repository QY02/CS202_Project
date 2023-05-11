.data 0x0000
.text 0x0000
    start:
    lw $s0, 0xFFFFFC70($zero)
    sw $s0, 0xFFFFFC60($zero)
    j start