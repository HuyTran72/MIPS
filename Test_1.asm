.data
    numbers: .word 10, 5, 15, 8  # Example numbers
    max: .word 0  # Max value
    min: .word 0  # Min value
    second_max: .word 0  # Second max value
    second_min: .word 0  # Second min value

.text
.globl main

main:
    la $t0, numbers  # Load the address of the array
    lw $t1, ($t0)  # Load the first number into $t1
    lw $t2, 4($t0)  # Load the second number into $t2
    lw $t3, 8($t0)  # Load the third number into $t3
    lw $t4, 12($t0)  # Load the fourth number into $t4

    # Find max and min
    # Find max of $t1 and $t2
    slt $t5, $t1, $t2
    beq $t5, 1, set_max
    move $t6, $t1
    j max_of_t2_t6
set_max:
    move $t6, $t2
max_of_t2_t6:
    # Find max of $t6 and $t3
    slt $t5, $t6, $t3
    beq $t5, 1, set_max
    move $t6, $t3
    # Find max of $t6 and $t4
    slt $t5, $t6, $t4
    beq $t5, 1, set_max
    move $t6, $t4
    sw $t6, max  # Store the max value

    # Find min of $t1 and $t2
    slt $t5, $t1, $t2
    beq $t5, 1, set_min
    move $t7, $t2
    j min_of_t2_t7
set_min:
    move $t7, $t1
min_of_t2_t7:
    # Find min of $t7 and $t3
    slt $t5, $t7, $t3
    beq $t5, 1, set_min
    move $t7, $t3
    # Find min of $t7 and $t4
    slt $t5, $t7, $t4
    beq $t5, 1, set_min
    move $t7, $t4
    sw $t7, min  # Store the min value

    # Find second max
    li $t8, 0  # Initialize the second max to 0
    # Compare each number with max and update second max if needed
    bgt $t1, $t8, check_t1
    j check_t2
check_t1:
    blt $t1, $t6, check_t2
    move $t8, $t1
    j check_t2
check_t2:
    bgt $t2, $t8, check_t3
    j check_t3
    blt $t2, $t6, check_t3
    move $t8, $t2
    j check_t3
check_t3:
    bgt $t3, $t8, check_t4
    j check_t4
    blt $t3, $t6, check_t4
    move $t8, $t3
    j check_t4
check_t4:
    bgt $t4, $t8, set_second_max
    j set_second_max
    blt $t4, $t6, set_second_max
    move $t8, $t4
set_second_max:
    sw $t8, second_max  # Store the second max value

    # Find second min
    li $t9, 99999999  # Initialize the second min to a large number
    # Compare each number with min and update second min if needed
    blt $t1, $t9, check_t1_min
    j check_t2_min
check_t1_min:
    bgt $t1, $t7, check_t2_min
    move $t9, $t1
    j check_t2_min
check_t2_min:
    blt $t2, $t9, check_t3_min
    j check_t3_min
    bgt $t2, $t7, check_t3_min
    move $t9, $t2
    j check_t3_min
check_t3_min:
    blt $t3, $t9, check_t4_min
    j check_t4_min
    bgt $t3, $t7, check_t4_min
    move $t9, $t3
    j check_t4_min
check_t4_min:
    blt $t4, $t9, set_second_min
    j set_second_min
    bgt $t4, $t7, set_second_min
    move $t9, $t4
set_second_min:
    sw $t9, second_min  # Store the second min value

    li $v0, 10  # Exit system call
    syscall
