.data 0x0000
.text 0x0000
    start:
    lw $s0, 0x0000FC70($zero)
    sw $s0, 0x0000FC60($zero)
    j start