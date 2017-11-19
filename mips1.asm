.data 
text_letter:
	.asciiz "lpha\n\0\0\0"	
	.asciiz "ravo\n\0\0\0"	
	.asciiz "hina\n\0\0\0"	
	.asciiz "elta\n\0\0\0"	
	.asciiz "cho\n\0\0\0\0"	
	.asciiz "oxtrot\n\0"	
	.asciiz "olf\n\0\0\0\0"	
	.asciiz "otel\n\0\0\0"	
	.asciiz "ndia\n\0\0\0"	
	.asciiz "uliet\n\0\0"	
	.asciiz "ilo\n\0\0\0\0"	
	.asciiz "ima\n\0\0\0\0"	
	.asciiz "ary\n\0\0\0\0"	
	.asciiz "ovember\n"	
	.asciiz "scar\n\0\0\0"	
	.asciiz "aper\n\0\0\0"	
	.asciiz "uebec\n\0\0"	
	.asciiz "esearch\n"	
	.asciiz "ierra\n\0\0"	
	.asciiz "ango\n\0\0\0"	
	.asciiz "niform\n\0"	
	.asciiz "ictor\n\0\0"	
	.asciiz "hisky\n\0\0"	
	.asciiz "-ray\n\0\0\0"	
	.asciiz "ankee\n\0\0"	
	.asciiz "ulu\n\0\0\0\0"
text_digit:	
	.asciiz "zero\n\0\0\0"	
	.asciiz "First\n\0\0"	
	.asciiz "Second\n\0"	
	.asciiz "Third\n\0\0"	
	.asciiz "Fourth\n\0"	
	.asciiz "Fifth\n\0\0"	
	.asciiz "Sixth\n\0\0"	
	.asciiz "Seventh\n"	
	.asciiz "Eighth\n\0"	
	.asciiz "Ninth\n\0\0"
text_asterisk:	
	.asciiz "*\n"
		
.text
	.macro print_upper (%letter)	
	subi $t0,%letter,'A'	
	mul $t0,$t0,9	
	la $a0, text_letter	
	add $a0,$a0,$t0	
	li $v0, 4	
	syscall	
	.end_macro
		
	.macro print_lower (%letter)	
	subi $t0,%letter,'a'	
	mul $t0,$t0,9	
	la $a0, text_letter	
	add $a0,$a0,$t0	
	li $v0, 4	
	syscall	
	.end_macro	
	
	.macro print_digit (%letter)	
	subi $t0,%letter,'0'	
	mul $t0,$t0,9	
	la $a0, text_digit	
	add $a0,$a0,$t0	
	li $v0, 4	
	syscall	
	.end_macro
		
	.macro print_asterisk ()	
	la $a0, text_asterisk	
	li $v0, 4	
	syscall	
	.end_macro
		
main:	
	li $v0, 12	
	syscall	
	blt $v0,'0',asterisk	# if $v0 is less than '0'	
	ble $v0,'9',digit	# if $v0 is between '0' and '9'	
	blt $v0,'?',asterisk	# if $v0 is greater than '9' but less than '?'	
	beq $v0,'?',exit	# if $v0 is equal to '?',exit	
	blt $v0,'A',asterisk	# if $v0 is greater than '?' but less than 'A'	
	ble $v0,'Z',upper	# if $v0 is between 'A' and 'Z'	
	blt $v0,'a',asterisk	# if $v0 is greater than 'Z' but less than 'a'	
	ble $v0,'z',lower	# if $v0 is between 'a' and 'z'	
	j asterisk	# if $v0 is greater than 'z'
upper:	
	move $a0,$v0	
	print_upper($a0)	
	j main
lower:	
	move $a0,$v0	
	print_lower($a0)	
	j main
digit:	
	move $a0,$v0	
	print_digit($a0)	
	j main
asterisk:	
	print_asterisk()	
	j main
exit:	
	li $v0, 10	
	syscall
