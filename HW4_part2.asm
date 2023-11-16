.data
x:      .word 9, -1, 2, 13, 79, 4, -87, 3
data:   .word 1, 4, 5, -1
newline: .asciiz "\n"

.text
main:
    # Initialize registers
    li $s0, 1           # i = 1
    li $s1, 4           # j = 4
    li $s2, 0           # sum = 0

for_loop:
    # Check condition: i < 10
    bge $s0, 10, end_for

    # Calculate x[i]
    sll $t0, $s0, 2      # Multiply i by 4 to get the offset in bytes
    la $t1, x            # Load the base address of array x
    add $t1, $t1, $t0    # Calculate the address of x[i]
    lw $t2, 0($t1)       # Load x[i] into $t2

    # Check if x[i] > 10
    bgt $t2, 10, else_branch

    # If x[i] <= 10
    sub $s2, $s2, 2      # sum = sum - 2
    j end_for

else_branch:
    # If x[i] > 10
    div $s1, $s1, 2      # j = j / 2
    mflo $t3             # Move the result of the division from lo to $t3

    # Calculate the address of data[j]
    sll $t0, $t3, 2      # Multiply j by 4 to get the offset in bytes
    la $t1, data         # Load the base address of array data
    add $t1, $t1, $t0    # Calculate the address of data[j]

    # Store 0 in data[j]
    li $t2, 0            # Load 0 into $t2
    sw $t2, 0($t1)       # Store $t2 at data[j]

    # Increment j
    addi $s1, $s1, 1

    # Unconditional jump to the end of the loop
    j end_for

end_for:
    # Increment i *= 2
    sll $s0, $s0, 1

    # Increment j++
    addi $s1, $s1, 1

    # Display sum (optional)
    move $a0, $s2         # Load sum into $a0 for printing
    li $v0, 10            # System call to exit the program
    syscall
