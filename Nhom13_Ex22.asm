.data
	string: .asciiz "adjourned"
	mess1: .asciiz "true"
	mess2: .asciiz "false"	
.text
main:
	la 	$a0, string	# a0 -> &S[0]
	
	jal 	FUNC
	nop
	beq 	$v0, 0, false
	nop
true:
	li 	$v0, 4
	la 	$a0, mess1
	syscall
	nop
	j 	end_main
	nop
false:
	li 	$v0, 4
	la 	$a0, mess2
	syscall
	nop
	j 	end_main
	nop
end_main:
	li 	$v0, 10 	# exit
	syscall
	nop
# Chuong trinh con dau vao la a0 luu dia chi cua mang string
# Su dung hai con tro, $t1 tro vao dau, $t2 tro vao cuoi string.
# Dau ra cua chuong trinh luu trong thanh ghi v0
# v0 = 0, -> false
# v0 = 1, -> true	
FUNC:
	addi 	$a1, $a0, 0	# a1 --> &S[0]
	addi 	$a2, $a0, 0	# a2 --> $S[0]
	lb 	$t1, 0($a1)	# t1 = S[0]
	lb 	$t2, 0($a2)	# t2 = S[0]

while:				# Dich con tro $t2 ve cuoi string
	beq 	$t2, 0, end_while
	nop
	
	addi 	$a2, $a2, 1	# Dich con tro $t2 sang phai 1 ky tu
	lb 	$t2, 0($a2)	# t2 = S[j]
	j 	while
	nop
	
end_while:
	
	addi 	$a2, $a2, -1	# Dich con tro $t2 sang trai 1 ky tu 
	lb 	$t2, 0($a2)	# t2 <-- ky tu cuoi cung cua từ
	
loop: 
	slt 	$t0, $a1, $a2 	# if (a1 < a2)	-> continue
	beq 	$t0, $zero, end_loop
	nop
	
	slt 	$t0, $t2, $t1	# if (t1 >= t2) -> return false
	bne 	$t0, $zero, return_false
	nop
	
	addi 	$a1, $a1, 1 	# Dich con tro $t1 sang phai 1 ky tu 
	lb 	$t1, 0($a1)	# t1 = S[i]
	
	slt 	$t0, $t1, $t2	# if (t1 >= t2) -> return false
	bne 	$t0, $zero, return_false 
	nop
	
	addi 	$a2, $a2, -1	# Dich con tro $t2 sang trai 1 ky tu
	lb 	$t2, 0($a2)	# t2 = S[j]
	j 	loop
	nop
end_loop:
return_true:
	li 	$v0, 1
	jr 	$ra
	
	nop
return_false:
	li 	$v0, 0
	jr 	$ra
	
	nop
end_FUNC:
