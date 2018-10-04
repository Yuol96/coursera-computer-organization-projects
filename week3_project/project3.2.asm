	.data
buf:	.space	1024
succMsg:.asciiz	"Success! Location: "
failMsg:.asciiz	"Fail!\n"
endl:	.asciiz	"\n"
	.text
	la $a0, buf
	li $a1, 512
	li $v0, 8	# input string
	syscall
	
loop:	li $v0, 12	# input character
	syscall
	move $t3, $v0
	li $v0, 4	# print string
	la $a0, endl
	syscall
	move $v0, $t3
	beq $v0, '?', end
	la $t0, buf
	li $t1, 1
	
find:	lb $t2, ($t0)
	beq $t2, 0, fail
	beq $t2, $v0, succ
	add $t1, $t1, 1
	add $t0, $t0, 1
	b find
	
succ:	li $v0, 4
	la $a0, succMsg
	syscall
	li $v0, 1	# print integer
	move $a0, $t1
	syscall
	li $v0, 4
	la $a0, endl
	syscall
	b loop
	
fail:	li $v0, 4
	la $a0, failMsg
	syscall
	b loop
	
end:	li $v0, 10	# exit
	syscall