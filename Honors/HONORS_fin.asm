#	Name:		Joshua Paytosh
#	Program:	Honors Project
#	Purpose:	To create a functioning linked list in MIPS assembly language using the MARS simulator.




.data
	head: .space 12
	tail: .space 12
	menu: .asciiz "\nWelcome to my Linked List, Dr. Thacker, please be nice\n\nPlease enter the corresponding number to the function you wish to perform\n(1)\tPush_Front\n(2)\tPush_Back\n(3)\tPop_Front\n(4)\tPop_Back\n(5)\tSize\n(6)\tPrint\n(7)\tClear\n(8)\tIterator Menu\n\(9)\tFront\n(10)\tBack\n(0)\tExit\n"
	Pu_Message: .asciiz "Please enter the number you wish to push\n"
	Size_Message: .asciiz "The list has this many items: "
	Print_Message: .asciiz "The list contains: "
	Iter_Message: .asciiz "\nWelcome to the iterator manipulation menu! Please select what you would like to do.\n\n(1)\tIncrement\n(2)\tDecrement\n(3)\tBegin\n(4)\tEnd\n(5)\tErase\n(6)\tDerefence and Print\n(0)\tExit\n"
	ItPrint_Message: .asciiz "\nThis iterator is currently pointing to: "
	Reference_Message: .asciiz "\nThe function has returned a reference that contains the data: "

.text


	# 0($tx) = tx's Previous
	# 4($tx) = tx's Data
	# 8($tx) = tx's Next
	# $s0 = head
	# $s1 = tail
	# $s2 = size


	# To Push:
	# li $a0, x
	# jal Push_Front
	# OR
	# li $a0, x
	# jal Push_Back

	# To Pop:
	# jal Pop_Front
	# OR
	# jal Pop_Back



	jal Initialize



Menu_Loop:
	la $a0, menu

	li $v0 4
	syscall

	li $v0 5
	syscall

	li $t0, 1
	li $t1, 2
	li $t2, 3
	li $t3, 4
	li $t4, 5
	li $t5, 6
	li $t6, 7
	li $t7, 8
	li $t8, 9
	li $t9, 10			# Initialize variables for the menu loop


	bltz $v0, Menu_Loop
	bgt $v0, $t9, Menu_Loop		# If input is not within range or 0-8
	beqz $v0, Exit
	beq $t0, $v0 PuF_Call
	beq $t1, $v0 PuB_Call
	beq $t2, $v0 PoF_Call
	beq $t3, $v0 PoB_Call
	beq $t4, $v0 Size_Call
	beq $t5, $v0 Print_Call
	beq $t6, $v0 Clear_Call
	beq $t7, $v0 Iter_Loop
	beq $t8, $v0 Front_Call
	beq $t9, $v0 Back_Call




Front_Call:

	la $a0, Reference_Message
	li $v0 4
	syscall

	jal Front		# Return an address to the first item in the list
	lw $a0, 4($v0)

	li $v0 1
	syscall

	b Menu_Loop


Back_Call:
	la $a0, Reference_Message
	li $v0 4
	syscall

	jal Back		# Return an address to the last item in the list
	lw $a0, 4($v0)

	li $v0 1
	syscall

	b Menu_Loop



Clear_Call:
#	sw $ra, 0($sp)
#	addi $sp, $sp, -4


	li $s0, 0
	li $s1, 0
	li $s2, 0		# Set all s registers to 0

	jal Initialize		# Call initialize function

	b Menu_Loop

#	addi $sp, $sp 4
#	lw $ra, 0($sp)
#	jr $ra

# Push Front
PuF_Call:
	la $a0, Pu_Message
	li $v0 4
	syscall

	li $v0 5
	syscall		# Ask for input

	move $a0, $v0
	jal Push_Front	# Call push

	b Menu_Loop

# Push Back
PuB_Call:
	la $a0, Pu_Message
	li $v0 4
	syscall

	li $v0 5
	syscall		# Ask for input

	move $a0, $v0
	jal Push_Back	# Call push

	b Menu_Loop

# Pop Front
PoF_Call:
	jal Pop_Front
	b Menu_Loop

# Pop Back
PoB_Call:
	jal Pop_Back
	b Menu_Loop

# Returns size
Size_Call:
	la $a0 Size_Message
	li $v0 4
	syscall

	move $a0, $s2
	li $v0, 1
	syscall

	b Menu_Loop

# Calls Print
Print_Call:
	la $a0 Print_Message
	li $v0 4
	syscall

	jal Print

	b Menu_Loop



Exit:

	li $v0, 10
	syscall


# Sets up head & tail nodes
Initialize:
	sw $ra, 0($sp)
	addi $sp, $sp, -4

	la $s0, head
	la $s1, tail
	li $s2, 0 # Size



	#	0($tx) = tx's Previous
	#	4($tx) = tx's Data
	#	8($tx) = tx's Next



	sw $s1, 8($s0) # Head's next == Tail
	sw $s0, 0($s0) # Head's prev == Head


	sw $s0, 0($s1) # Tail's prev == Head
	sw $s1, 8($s1) # Tail's next == Tail

	lw $s3, 0($s0)	# Iterator

	addi $sp, $sp 4
	lw $ra, 0($sp)
	jr $ra

Push_Front:

	sw $ra, 0($sp)
	addi $sp, $sp, -4

	# Push_Front
	# Create a new node
	# Set Data in new node
	# Set new nodes next to head's next
	# Set Head's next's prev to the new node
	# Set head's next to the new node
	# Set new node's prev to head


	move $t0, $a0

	# Create a new node
	li $a0, 12		# of bytes to allocate
	li $v0, 9
	syscall

	move $t1, $v0		# $t1 now holds the address of the new allocated memory

	# Set Data in new node
	sw $t0, 4($t1)

	# Set new nodes next to head's next

	lw $t3, 8($s0)		# t3 holds head's next

	sw $t3, 8($t1)		# new node's next == head's next

	# Set head's next's previous to the new node
	lw $t3, 8($s0)		# t3 holds head's next
	sw $t1, 0($t3)		# set t3's prev to new node


	# Set head's next equal to the new node
	sw $t1, 8($s0)


	# Set new node's prev to head
	sw $s0, 0($t1)

	addi $s2, $s2, 1

	addi $sp, $sp 4
	lw $ra, 0($sp)

	jr $ra

Push_Back:

	sw $ra, 0($sp)
	addi $sp, $sp, -4
	# Push_Back
	# Create a new node
	# Set Data in new node
	# Set new node's prev to tail's prev
	# Set Tail's prev's next to new node
	# Set Tail's prev to new node
	# Set New Node's Next to tail


	move $t0, $a0	# $t0 holds argument to store

	# Create a new node
	li $a0, 12	# of bytes to allocate
	li $v0, 9
	syscall

	move $t1, $v0		# $t1 now holds the address of the new allocated memory


	# Set Data in new node
	sw $t0, 4($t1)

	# Set new node's prev to tail's prev

	lw $t2, 0($s1)		#t2 = tails prev
	sw $t2, 0($t1)

	# Set Tail's prev's next to new node


	lw $t2, 0($s1)	# $t2 = tails prev
	sw $t1, 8($t2)  # $

	# Set Tail's prev to new node
	sw $t1, 0($s1)

	# Set New Node's Next to tail
	sw $s1, 8($t1)

	addi $s2, $s2, 1


	addi $sp, $sp 4
	lw $ra, 0($sp)
	jr $ra

Pop_Front:
	sw $ra, 0($sp)
	addi $sp, $sp, -4

	beqz $s2, PF_End

	# Pop Front
	# Set Head's Next to Head's Next's Next

	lw $t0, 8($s0)		# $t0 now holds head's next
	sw $0, 0($t0)		# Set head's next's prev to NULL
	lw $t1, 8($t0)		# Load $t1 into $t0's next
	sw $0, 8($t0)

	sw $t1, 8($s0)
	sw $s0, 0($t1)




	addi $s2, $s2, -1

PF_End:
	addi $sp, $sp 4
	lw $ra, 0($sp)
	jr $ra

Pop_Back:
	# Pop Back

	sw $ra, 0($sp)
	addi $sp, $sp, -4

	beqz $s2, PB_End


	lw $t0, 0($s1)		#t0 holds tails prev
	lw $t1, 0($t0)		#t1 holds $t0's prev

	sw $s1, 8($t1)		#t1's next == tail
	sw $t1, 0($s1) 		#s1's prev == $t1

	sw $0, 0($t0)
	sw $0, 8($t0)		#Set $t0 == NULL

	addi $s2, $s2, -1

PB_End:
	addi $sp, $sp 4
	lw $ra, 0($sp)
	jr $ra

Front:
	sw $ra, 0($sp)
	addi $sp, $sp, -4

	lw $v0 8($s0)


	addi $sp, $sp 4
	lw $ra, 0($sp)
	jr $ra

Back:
	sw $ra, 0($sp)
	addi $sp, $sp, -4

	lw $v0 0($s1)


	addi $sp, $sp 4
	lw $ra, 0($sp)
	jr $ra



# Function to Print List
Print:

	sw $ra, 0($sp)
	addi $sp, $sp, -4

	# Use size to print, since we can't have a flag in head/tail
	# Load size into temp register

	move $t0, $s2	# t0 is temp size


	lw $t1, 8($s0)	# t1 holds head's next

Print_Loop:

	beqz $t0, Pr_End	# While tempsize != 0

	lw $a0, 4($t1)		# Load item into a0

	li $v0 1
	syscall			# Print it


	lw $t1, 8($t1)
	addi $t0, $t0, -1	# Increment pointer & decrement temp size

	b Print_Loop


Pr_End:
	addi $sp, $sp 4
	lw $ra, 0($sp)
	jr $ra			# Return






Iter_Loop:
	li $v0, 4
	la $a0, Iter_Message
	syscall

	li $t0, 1
	li $t1, 2
	li $t2, 3
	li $t3, 4
	li $t4, 5
	li $t5, 6		# Initialize variables for iter loop

	li $v0, 5
	syscall



	bltz $v0, Iter_Loop
	bgt $v0, $t5, Iter_Loop
	beqz $v0, Menu_Loop
	beq $t0, $v0 Inc_Call
	beq $t1, $v0 Dec_Call
	beq $t2, $v0 Begin_Call
	beq $t3, $v0 End_Call
	beq $t4, $v0 Erase_Call
	beq $t5, $v0 DRef_Call

DRef_Call:
	li $v0, 4
	la $a0, ItPrint_Message
	syscall				# Display message

	li $v0, 1

	lw $a0, 4($s3)			# Get Item

	syscall				# Print it

	b Iter_Loop


Inc_Call:

	lw $s3, 8($s3)

	b Iter_Loop

Dec_Call:

	lw $s3, 0($s3)

	b Iter_Loop

Begin_Call:

	lw $s3, 8($s0)		# Set iter == head's next

	b Iter_Loop

End_Call:

	lw $s3, 0($s1)		# Set  iter == tail's prev

	b Iter_Loop

Erase_Call:

	lw $t1, 0($s3)		# t1 is iter's prev
	lw $t2, 8($s3)		# t2 is iter's next


	sw $0, 0($s3)
	sw $0, 8($s3)

	sw $t2 8($t1)
	sw $t1 0($t2)		# Fix what they point to

	lw $s3, 0($t2)

	addi $s2, $s2, -1	# Decrement size

	b Iter_Loop
