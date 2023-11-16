
.data
prompt: .asciiz "Enter a positive integer: "
result_msg: .asciiz "The factorial of the given integer is "
newline: .asciiz "\n"

.text
.globl main

main:
    # Prompt the user for input
    li $v0, 4
    la $a0, prompt
    syscall
    
    # Read the input integer
    li $v0, 5
    syscall
    move $t0, $v0  # Save the input in $t0

    # Initialize $t1 to 1 (factorial result)
    li $t1, 1

    # Calculate factorial
    loop:
        beqz $t0, done  # If input is 0, we are done
        mul $t1, $t1, $t0  # $t1 = $t1 * $t0
        subi $t0, $t0, 1  # Decrement $t0
        j loop

    done:
        # Display the result
        li $v0, 4
        la $a0, result_msg
        syscall

        # Display the factorial result
        li $v0, 1
        move $a0, $t1
        syscall

        # Print a newline
        li $v0, 4
        la $a0, newline
        syscall

    # Exit the program
    li $v0, 10
    syscall