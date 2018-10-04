	.data
upper:	.asciiz 
	"Alpha\r\n","Bravo\r\n","China\r\n","Delta\r\n","Echo\r\n",
    	"Foxtrot\r\n","Golf\r\n","Hotel\r\n","India\r\n","Juliet\r\n",
    	"Kilo\r\n","Lima\r\n","Mary\r\n","November\r\n","Oscar\r\n",
    	"Paper\r\n","Quebec\r\n","Reserach\r\n","Sierra\r\n","Tango\r\n",
    	"Uniform\r\n","Victor\r\n","Whisky\r\n","X-ray\r\n","Yankee\r\n",
    	"Zulu\r\n"
lower:	.asciiz
    "alpha\r\n","bravo\r\n","china\r\n","delta\r\n","echo\r\n",
    "foxtrot\r\n","golf\r\n","hotel\r\n","india\r\n","juliet\r\n",
    "kilo\r\n","lima\r\n","mary\r\n","november\r\n","oscar\r\n",
    "paper\r\n","quebec\r\n","reserach\r\n","sierra\r\n","tango\r\n",
    "uniform\r\n","victor\r\n","whisky\r\n","x-ray\r\n","yankee\r\n",
    "zulu\r\n"
numbers:.asciiz
    "zero\r\n","First\r\n","Second\r\n","Third\r\n","Fourth\r\n",
    "Fifth\r\n","Sixth\r\n","Seventh\r\n","Eighth\r\n","Ninth\r\n"
endl:	.asciiz	"\r\n"
letter_offset:	.word	0,8,16,24,32,39,49,56,64,72,81,88,95,102,113,121,129,138,149,158,166,176,185,194,202,211
num_offset:	.word	0,7,15,24,32,41,49,57,67,76
	.text
loop: 	li $v0, 12	#input
	syscall
	move $t0, $v0	
	
	la $a0, endl
	li $v0, 4	#print string service
	syscall
	move $v0, $t0
	
	sub $t0, $v0, '?'
	beqz $t0, End
	blt $v0, '0', isOthers
	ble $v0 '9', isNum
	blt $v0, 'A', isOthers
	ble $v0, 'Z', isUpper
	blt $v0, 'a', isOthers
	ble $v0, 'z', isLower
	b isOthers
	
isLower:
	sub $t0, $v0, 'a'
	sll $t0, $t0, 2
	la $t1, letter_offset
	add $t0, $t0, $t1
	lw $t0, ($t0) 	#load offset
	la $t1, lower
	add $a0, $t0, $t1
	li $v0, 4
	syscall
	b loop
	
isUpper:
	sub $t0, $v0, 'A'
	sll $t0, $t0, 2
	la $t1, letter_offset
	add $t0, $t0, $t1
	lw $t0, ($t0) 	#load offset
	la $t1, upper
	add $a0, $t0, $t1
	li $v0, 4
	syscall
	b loop
	
isNum:	sub $t0, $v0, '0'
	sll $t0, $t0, 2
	la $t1, num_offset
	add $t0, $t0, $t1
	lw $t0, ($t0)
	la $t1, numbers
	add $a0, $t0, $t1
	li $v0, 4
	syscall
	b loop
	
isOthers:
	li $a0, '*'
	li $v0, 11	#print the character
	syscall
	la $a0, endl
	li $v0, 4
	syscall
	b loop
	
	
End:	li $v0, 10	#exit
	syscall