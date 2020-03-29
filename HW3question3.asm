
.data
	ADULT_CHOICE: .word 1
	CHILD_CHOICE: .word 2
	SENIOR_CHOICE: .word 3
	QUIT_CHOICE: .word 4
	ADULT: .word 250
	CHILD: .word 200
	SENIOR: .word 350 
	MenuStr: .asciiz "\n\t\tHealth Club Membership Menu\n\n1. Standard Adult Membership\n2. Child Membership\n3. Senior Citizen Membership\n4. Quit the Program\n\nEnter your choice: "	#menu prompt String 
	errorPrompt1: .asciiz "\nPlease enter a valid menu choice: "
	prompt1: .asciiz "\nFor how many Months?"
	prompt2: .asciiz "\nThe total charges are $"
.text 

main:
move $s3,$0 # charges = 0

do:
	li $v0,4       #out put the menu to the consol
	la $a0,MenuStr #^
	syscall # ^
	
	# Get users choice
         li $v0, 5
         syscall
         #store into $s0
         move $s0,$v0 #$s0 = choice 
whileOne:# first while loop that checks if user is entering a choice vale withen range

	

	slti $t0,$s0,1 # if choice < ADULT_CHOICE $t0 = 1 else $t0 = 0
	lw $t2,QUIT_CHOICE # $t2 = QUIT_CHOICE
	slt $t1,$t2,$s0 # if choice > QUIT_CHOICE $t1 =1 else $t1= 0 
 	or  $t3,$t0,$t1 # get the or value frome $t0 and $t1
 
	 bne $t3,1,exit1 # if !(choice < ADULT_CHOICE) OR !(choice > QUIT_CHOICE) branch to whileOne
         #Print error message errorPrompt1
	li $v0,4
	la $a0,errorPrompt1
	syscall
	#get the new value for choice and store it into $s0 from the user
	li $v0,5
	syscall
	move $s0,$v0
	j whileOne 
exit1:#exit whileOne loop
        
        beq $s0,4,exit2 # if choice = 	QUIT_CHOICE branch to exit 2
        #print out propmt 1
        li $v0,4
        la $a0,prompt1
        syscall
        
        
        li $v0, 5
         syscall
         move $s1,$v0 # Ss1 = months 
         
         beq $s0,1,case1 # if choice = ADULT_CHOICE branch to case1
         beq $s0,2,case2 # if choice = CHILD_CHOICE branch to case2
         beq $s0,3,case3 # if choice = SENIOR_CHOICE branch to case3
         
         

         
        
        
exit2:
         bne $s0,4,Long # jump to the long lable if $s0 != 4 
         
         #end program 
         li $v0, 10
         syscall
         
Long:
	j do #jump to the address of do 
	
back:  
 #print the contents of prompt2       
     li $v0,4
     la $a0,prompt2
     syscall    
     #print the conctents of charge
     li $v0,1
     move $a0,$s3
     syscall
 j exit2 # jumpToexit2
	
	
	
	

case1:
	move $t0,$0 #$t0 = 0
for1:
	slt $t1,$t0,$s1 # if i < mothhs $t1 = 1 else $t1 = 0
	beq $t1,$0,LoopExit
	lw $t5,ADULT #$t5 = ADULT
	add $s3,$s3,$t5 # charges = charges + ADULT
	addi $t0,$t0,1 # i = i +1 
j for1 # jumpback to for1


case2:
	move $t0,$0 #$t0 = 0
for2:
	slt $t1,$t0,$s1 # if i < mothhs $t1 = 1 else $t1 = 0
	beq $t1,$0,LoopExit
	lw $t5,CHILD #$t5 = CHILD
	add $s3,$s3,$t5 # charges = charges + CHILD
	addi $t0,$t0,1 # i = i +1 
j for2 # jumpback to for2


case3:
	move $t0,$0 #$t0 = 0
for3:
	slt $t1,$t0,$s1 # if i < mothhs $t1 = 1 else $t1 = 0
	beq $t1,$0,LoopExit
	lw $t5,SENIOR #$t5 = SENIOR
	add $s3,$s3,$t5 # charges = charges + SENIOR
	addi $t0,$t0,1 # i = i +1 
j for3 # jumpback to for3


LoopExit: # exit the loop from one of the above cases
j back



         
         
         