#	Joshua Paytosh
#	1/25/2018
#	Pay Rate Program
#	This program is used to calculate pay rate, including pay for overtime, this program in particular
#	uses a while loop to accomplish this


.data
	prompt: .asciiz "Input the weekly pay rate (In whole dollars): "
	prompt2: .asciiz "\nYou will recieve: "
	InputDays: .asciiz "\nInput the hours worked: "
	prompt3: .asciiz "Hours worked: "
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
	li $t3, 40 		# t3 holds the number 40
	
Loop:
	li $v0, 4
	la $a0, InputDays
	syscall
	
	li $t5, 0		# Initialize the pay amount to 0
	
	li $v0, 5
	syscall
	bltz $v0, End		# If input is -1, skip to end
	
	add $t4, $v0, $t4	#t4 holds accumulated hours
		
	bgt $t4, $t3, Overtime	# if Accumulated hours is greater than 40, skip to overtime
	
	#If not overtime, then
	mul $t5, $t4, $t0
	b Output		# skip to output

Overtime: 
	sub $t6, $t4, $t3	# Accumulated hours - 40
	mul $t6, $t6, $t1	# 2(rate) * difference of hours
	mul $t5, $t3, $t0	# rate * 40
	add $t5, $t6, $t5	# add overtime to regular rate
	

Output:	# Outputting	
	
	li $v0, 4
	la $a0, prompt3
	syscall
	
	
	li $v0, 1
	move $a0, $t4
	syscall
	
	
	li $v0, 4
	la $a0, prompt2
	syscall
	
	
	li $v0, 1
	move $a0, $t5		# move t5 to a0 to prep for output
	syscall
	
	b Loop			# loop back to beginning b/c -1 was never read
	
End:
	li $v0 10
	syscall			# exit
