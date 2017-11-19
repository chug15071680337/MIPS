.data 
text_succ:	
	.asciiz "Success! Location:" 
text_fail:	
	.asciiz "Fail!\n"
text_input:
	.space 64
text_output:
	.space 10
.text
	.macro print_succ (%pos)
	move $t0,%pos
	la $a0, text_succ
	li $v0, 4
	syscall
	
	div $t1,$t0,10		# to gain the tens
	sub $t2,$t0,$t1		# to gain the units
	la $t3,text_output
	beq $t1,0,over
	add $t1,$t1,'0'		# change it to ASCII
	sb $t1,($t3)
	add $t3,$t3,1
over:
	add $t2,$t2,'0'		# change it to ASCII
	sb $t2,($t3)
	add $t3,$t3,1
	li $t1,'\n'
	sb $t1,($t3)		# store the line feed
	la $a0, text_output
	li $v0, 4
	syscall	
	.end_macro
		
	.macro print_fail ()
	la $a0, text_fail
	li $v0, 4
	syscall
	.end_macro
	
main:
	la $a0, text_input
	li $a1, 64
	li $v0, 8
	syscall			# Input the string
loop1:	
	li $v0, 12	
	syscall	
	beq $v0,'?',exit	# if $v0 is equal to '?',exit
	li $t0,0
	la $t1,text_input
loop0:
	add $t2,$t1,$t0
	lb $t3,($t2)
	beq $t3,0,fail		# if current character is null, it fails
	beq $t3,$v0,succ
	add $t0,$t0,1
	j loop0
succ:
	add $a0,$t0,1
	print_succ($a0)
	j loop1

fail:
	print_fail()
	j loop1
exit:
	li $v0, 10
	syscall
