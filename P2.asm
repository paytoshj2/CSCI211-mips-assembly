# Joshua Paytosh
# Program: Program_2
# Purpose: To get used to using variables, taking input, and basic arithmetic in MIPS Assembly


.data
	prompt: .asciiz "Enter the first integer "
	prompt2: .asciiz "Enter the second integer "
	Add: .asciiz "\n Result of the addition: "
	Sub: .asciiz "\n Result of the subtraction: "
	Mult: .asciiz "\n Result of the multiplication: "
	Div: .asciiz "\n Result of the division: "
	Rem: .asciiz "\n Result of the remainder: "
	
.text
	# Message 1
	li $v0, 4	# Prep sys for outputting strings
	la $a0, prompt	# Load the prompt into $a0
	syscall		# Output from $a0
	
	#Input 1
	li $v0, 5	# Prep sys for input int
	syscall		# Syscall to recieve input
	
	# Store input in $t0
	move $t0, $v0
	
	# Message 2
	li $v0, 4	# Prep sys for outputting strings
	la $a0, prompt2	# Load the prompt2 into $a0
	syscall		# Output from $a0
	
	# Input 2
	li $v0, 5	# Prep sys for integer input
	syscall		# Syscall to recieve input
	
	# Store input in $t1
	move $t1, $v0
	
	#Arithmetic
	
	# t2 is for additon
	# t3 is for subtraction
	# t4 is for multiplication
	# t5 is for division
	# t6 is for modulus
	
	#Addition
	add $t2, $t0, $t1
	
	
	li $v0, 4	#Prep sys to output a string
	la $a0, Add	#Load Add string into output register
	syscall 	#Output from $a0
	
	li $v0, 1	# Prep sys to output an int
	move $a0, $t2	# Move the result of $t0+$t1 to $a0
	syscall		# Output from $a0
	
	
	
	#Subtraction
	sub $t3, $t0, $t1
	
	li $v0, 4	#Prep sys to output a string
	la $a0, Sub	#Load Sub string into output register
	syscall		#Output from $a0
	
	li $v0, 1	#Prep sys to output a int
	move $a0, $t3	#Move the result of $t0-$t1 to $a0
	syscall		#Output from $a0
	
	#Multiplication
	mul $t4, $t0, $t1
	
	li $v0, 4	#Prep sys to output a string
	la $a0, Mult	#Load Mult string into output register
	syscall		#Output from $a0
	
	li $v0, 1	#Prep sys to output a int
	move $a0, $t4	#Move the result of $t0*t1 to $a0
	syscall
	
	#Division
	div $t5, $t0, $t1
	
	li $v0, 4	#Prep sys to output a string
	la $a0, Div	#Load Div into output register
	syscall		#Output from $a0
	
	li $v0, 1	#Prep sys to output an integer
	move $a0, $t5	#Move the result from $t0/$t1 to $a0
	syscall		#Output from $a0
	
	#Modulus
	rem $t6, $t0, $t1
	
	li $v0, 4	#Prep sys to output a string
	la $a0, Rem	#Load Rem into output register
	syscall		#Output from $a0
	
	li $v0, 1	#Prep sys to output an integer
	move $a0, $t6	#Move the result of $t0 % $t1 to $a0
	syscall		#Output from $a0
	
	#Exit
	li $v0, 10
	syscall
	
	
	#Explanation as to the 7 digit number arithmetic:
	# The reason the multiplication has such a strange result is because it exceeds the limit of 2^32
	# nothing else comes close because the operations are relatively small
