.data

#ASCII string

val: .asciiz "+123"

.text

main:

#method for conversion

jal conv

move $a1, $v0

li $v0,1

syscall

li $v0,10

syscall

#loop for conversion

conv:

la $a0, val

li $t5, 0x2B

li $t6, 0x30

# '9' in $t7

li $t7, 0x39

add $t0, $0, $a0

lbu $t1, 0($t0)

add $t3, $t1, $0

addiu $t0, $t0, 1

lbu $t1, 0($t0)

li $v0, 0

#loop for repeated conversion

REP_CONV:

slt $t4, $t1, $t6

bne $t4, $0, ExitLoop

slt $t4, $t1, $t7

beq $t4, $0, ExitLoop

subu $t1, $t1, $t6

mul $v0, $v0, 10

add $v0, $v0, $t1

addiu $t0, $t0, 1

lbu $t1, 0($t0)

bne $t1, $0, REP_CONV

bne $t3, $t5, NP

jr $ra

#loop for not positivr

NP:

sub $v0, $0, $v0

jr $ra

#exit loop

ExitLoop:

li $v0, -1

jr $ra