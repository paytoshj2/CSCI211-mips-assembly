#	Joshua Paytosh
#	1/25/2018
#	Pay Rate Program
#	This program is used to calculate pay rate, including pay for overtime, this program in particular
#	uses a for loop to accomplish this

.data
	prompt: .asciiz "Input the weekly pay rate (In whole dollars): "
	prompt2: .asciiz "You will recieve: "
	InputDays: .asciiz "\nInput the hours worked: "
.text
	
	
	
	# Input the pay rate
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0		# $t0 holds the base rate
	li $t1, 2
	mul $t1, $t0, $t1 	# t1 holds double the rate
	
	
	#Loop to input the Hours
	li $t7, 0		#t7 holds 0
	li $t6, 5
Loop:
	addi $t7, $t7, 1	# add 1 to the counter for the loop
	li $v0, 4
	la $a0, InputDays
	syscall
	
	li $v0, 5
	syscall
	add $t3, $v0, $t3	# Add to the accumulated hours, $t3
	
	blt $t7, $t6, Loop	# If Counter is less than 5, go back to the beginning of Loop
	
	# Begin Arithmetic
	li $t7, 40		# Load 40 into t7 for pay calculation
	
	bgt $t3, $t7, Overtime	# if accumulated hours > 40, go to overtime
	
	# If not overtime, then
	mul $t0, $t3, $t0
	b Output		# skip to output

Overtime: 
	sub $t6, $t3, $t7	# Hours accumulated - 40
	mul $t6, $t6, $t1	# Difference * double pay rate
	mul $t0, $t7, $t0	# 40 * pay rate
	add $t0, $t6, $t0	# Add the overtime pay, and regular pay
	

Output:	# Outputting	
	li $v0, 4
	la $a0, prompt2
	syscall
	
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0 10
	syscall			# exit