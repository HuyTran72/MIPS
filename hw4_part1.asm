# This MIPS assembly code calculates the value of the polynomial
# f(x) = 3*x^5 + 2*x^4 - 5*x^3 - x^2 + 7*x - 6

.data
prompt:     .asciiz "Enter the value of x: "
result_msg: .asciiz "Result of the polynomial: "

.text
main:
    # Prompt the user to enter the value of x
    li $v0, 4               # syscall code for print_str
    la $a0, prompt          # load address of the prompt string
    syscall

    # Read the value of x from the user
    li $v0, 5               # syscall code for read_int
    syscall
    move $s0, $v0           # store the value of x in $s0

    # Calculate the polynomial: f(x) = 3*x^5 + 2*x^4 - 5*x^3 - x^2 + 7*x - 6

    # Calculate x^2 and store in $s1
    mul $s1, $s0, $s0       # $s1 = x * x

    # Calculate x^3 and store in $s2
    mul $s2, $s1, $s0       # $s2 = x * x * x

    # Calculate x^4 and store in $s3
    mul $s3, $s1, $s1       # $s3 = x^2 * x^2

    # Calculate x^5 and store in $s4
    mul $s4, $s3, $s0       # $s4 = x^2 * x^2 * x

    # Calculate 3*x^5 and store in $t0
    li $t0, 3
    mul $t0, $t0, $s4       # $t0 = 3 * x^5

    # Calculate 2*x^4 and store in $t1
    li $t1, 2
    mul $t1, $t1, $s3       # $t1 = 2 * x^4

    # Calculate 5*x^3 and store in $t2
    li $t2, 5
    mul $t2, $t2, $s2       # $t2 = 5 * x^3

    # Calculate -x^2 and store in $t3
    li $t3, -1
    mul $t3, $t3, $s1       # $t3 = -1 * x^2

    # Calculate 7*x and store in $t4
    li $t4, 7
    mul $t4, $t4, $s0       # $t4 = 7 * x

    # Sum all terms
    add $t5, $t0, $t1       # $t5 = 3*x^5 + 2*x^4
    sub $t6, $t5, $t2       # $t6 = $t5 - 5*x^3
    add $t7, $t6, $t3       # $t7 = $t6 - x^2
    add $t8, $t7, $t4       # $t8 = $t7 + 7*x
    sub $t9, $t8, 6         # $t9 = $t8 - 6

    # Display the result
    li $v0, 4               # syscall code for print_str
    la $a0, result_msg      # load address of the result message
    syscall

    # Print the result stored in $t9
    li $v0, 1               # syscall code for print_int
    move $a0, $t9           # load the result into $a0
    syscall

    # Exit the program
    li $v0, 10              # syscall code for exit
    syscall
