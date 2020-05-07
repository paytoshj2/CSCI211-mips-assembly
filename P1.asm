# Joshua Paytosh
# Program: Program_1
# Purpose: To get used to using variables, taking input, and basic arithmetic in MIPS Assembly
.data
	a: .word 5
	b: .word 6
	c: .word 15
	message1: .asciiz "Your result is "
	
.text

	li $v0, 4 # Prime system to output a string
	la $a0, message1 # Load the desired string into $a0, which is where syscall grabs it from
	
	syscall
	
	li $v0, 1 # primer to tell sys to print an integer
	lw $t0, a # a = 5
	lw $t1, b # b = 6
	lw $t2, c # c = 15
	
	sub  $t3, $t0, $t2 #t3 is recieving the value from subtracting a and c
	
	add $a0, $t3, $t1 # a0 is recieving the result of the addition of b and (a-c) in order to output
	
	
	syscall
	
	#Exit
	li $v0, 10
	syscall
	
