.data
input_mess: .asciiz "Nhap vao so nguyen: "
khong : .asciiz "khong"
mot : .asciiz "mot"
hai : .asciiz "hai"
ba : .asciiz "ba"
bon : .asciiz "bon"
nam : .asciiz "nam"
sau : .asciiz "sau"
bay : .asciiz "bay"
tam : .asciiz "tam"
chin : .asciiz "chin"
muoi: .asciiz "muoi"
tram : .asciiz "tram"
nghin : .asciiz "nghin"
trieu : .asciiz "trieu"
linh : .asciiz "linh"
ko_tram: .asciiz "khong tram"

invalid: .asciiz "So khong hop le vui long nhap trong [0 - 999999999]: \n"

space: .asciiz " "



.text
input:
	li $v0,4		#in ra input message(mess)
	la $a0,input_mess
	syscall
	li $v0,5		#doc so nguyen
	syscall  
	move $s0,$v0	#gan vao $s0 = $v0 (input number)
	
	bltz $s0,not_valid
	li $s2,999999999
	bgt $s0,$s2,not_valid
	beq $s0, $zero, print0_andexit	
	



main:	#chia so nguyen cho 1 trieu de lay cac chu so hang trieu
	li $s1, 1000000			
 	div $s0, $s1
 	mfhi $s0
 	mflo $t1
hang_trieu:
	jal hang_tram			# Chuyen doi so hang trieu va in ra man hinh
	beq $t1, $zero, hang_nghin	# Neu khong co hang trieu thi chuyen sang hang nghin
	jal print_1000000	# In "trieu" ra man hinh	
	li $t6, 1			# Danh dau la so lon hon 1 trieu
hang_nghin:
	li $s1, 1000			# Lay cac chu so hang nghin
 	div $s0, $s1
 	mfhi $s0
 	mflo $t1
 	li $t4, 100			# check so hang nghin be hon 100 va lon hon 0
 	slt $t3, $t1, $t4
 	slt $s3, $zero, $t1
 	bne $t3, $s3, a1		# Neu khong thoa man dieu kien thi bo qua
 	bne $t3, $t6, a1
 	jal print_kotram		# Neu so hang tram bang 0 thi in khong tram ra man hinh
 	
a1:	jal hang_tram			# Chuyen doi so hang nghin va in ra man hinh
	beq $t1, $zero, hang_donvi	# Neu khong co  hang nghin thi chuyen sang hang don vi
	li $t7, 1			# Danh dau la so lon hon 1000
	li $t8, 1			# Danh dau de in "linh" ra man hinh
	jal print_1000			# In  "nghin" ra man hinh
	
hang_donvi:
	move $t1,$s0		# lay ra cac chu so hang don vi
	li $t4, 100			# kiem tra lon hon 0 va nho hon 100
 	slt $t3, $t1, $t4		
 	slt $s3, $zero, $t1
 	bne $t3, $s3, b1		# Neu khong thoa man bo qua
 	beq $t3, $t6, b2		# Neu so lon hon 1 trieu thi in "khong tram"
 	bne $t3, $t7, b1		# Neu so nho hon 1000 thi bo qua
b2: 	jal print_kotram		# In "khong tram" ra man hinh

b1:	jal hang_tram			# In cac chu so hang don vi
	j done				# ket thuc chuong trinh
		
hang_tram:
	add $t9, $ra, $zero		# Luu lai thanh ghi $ra vao $t9
	li $s1, 100
	div $t1, $s1
	mfhi $t2		
	mflo $t0			# Lay ra chu so hang tram
	beq $t0, $zero, hang_chuc	# neu chu so hang tram bang 0 thi nhay toi hang chuc
	jal print_num			# in chu so hang tram
	jal print_100			# in " tram " ra man hinh
	li $t8, 1			# danh de in "linh" ra man hinh
	
hang_chuc:
	li $s1, 10			# lay chu so hang chuc
	div $t2, $s1
	mfhi $t2
	mflo $t0
	beq $t0, 1, c1			# neu chu so hang chuc bang 1 thi in muoi
	beq $t0, $zero, donvi		# neu chu so hang chuc bang 0 thi bo qua
	jal print_num			# in so hang chuc ra man hinh
	
c1:	jal print_10			# in " muoi" ra man hinh
	li $t8, 0			# danh dau khong in "linh" ra man hinh

donvi:
	li $s1, 1			# Doc chu so hang don vi
	div $t2, $s1
	mfhi $t2
	mflo $t0
	beq $t0, $zero, d1		# neu bang 0 thi tro ve chuong trinh main
	bne $t8, 1, d2			# neu co danh dau khong in "linh" ra man hinh thi bo qua
	jal print_linh			# in "linh" ra man hinh
d2:	jal print_num			# in so hang don vi ra man hinh
	li $t8 , 1			# gan co khong in "linh"
d1:	jr $t9			

print_num:		
	beq $t0, 1, print_1		# in cac so ra man hinh($t0 = hang don vi)
	beq $t0, 2, print_2
	beq $t0, 3, print_3
	beq $t0, 4, print_4
	beq $t0, 5, print_5
	beq $t0, 6, print_6
	beq $t0, 7, print_7
	beq $t0, 8, print_8
	beq $t0, 9, print_9
	
print_0: 	#in "khong" ra man hinh
	li $v0,4
	la $a0,khong
	syscall
	li $v0,4		#in "space" ra man hinh
	la $a0,space
	syscall
	jr $ra
print_1:		#in "mot" ra man hinh
	
	li $v0,4
	la $a0,mot
	syscall
	li $v0,4			#in "space" ra man hinh
	la $a0,space
	syscall
	jr $ra
print_2:		#in "hai" ra man hinh
	li $v0,4
	la $a0,hai
	syscall
	li $v0,4			#in "space" ra man hinh
	la $a0,space
	syscall
	jr $ra
print_3:		#in "ba" ra man hinh
	li $v0,4
	la $a0,ba
	syscall
	li $v0,4			#in "space" ra man hinh
	la $a0,space
	syscall
	jr $ra
print_4:		#in "bon" ra man hinh
	li $v0,4
	la $a0,bon
	syscall
	li $v0,4			#in "space" ra man hinh
	la $a0,space
	syscall
	jr $ra
print_5:		#in "nam" ra man hinh
	li $v0,4
	la $a0,nam
	syscall
	li $v0,4			#in "space" ra man hinh
	la $a0,space
	syscall
	jr $ra
print_6:		#in "sau" ra man hinh
	li $v0,4
	la $a0,sau
	syscall
	li $v0,4			#in "space" ra man hinh
	la $a0,space
	syscall
	jr $ra
print_7:		#in "bay" ra man hinh
	li $v0,4
	la $a0,bay
	syscall
	li $v0,4			#in "space" ra man hinh
	la $a0,space
	syscall
	jr $ra
print_8:		#in "tam" ra man hinh
	li $v0,4
	la $a0,tam
	syscall
	li $v0,4			#in "space" ra man hinh
	la $a0,space
	syscall
	jr $ra
print_9:		#in "chin" ra man hinh
	li $v0,4
	la $a0,chin
	syscall
	li $v0,4			#in "space" ra man hinh
	la $a0,space
	syscall
	jr $ra
print_10:	#in "muoi" ra man hinh
	li $v0,4
	la $a0,muoi
	syscall
	li $v0,4			#in "space" ra man hinh
	la $a0,space
	syscall
	jr $ra
print_100:	#in "tram" ra man hinh
	li $v0,4
	la $a0,tram
	syscall
	li $v0,4			#in "space" ra man hinh
	la $a0,space
	syscall
	jr $ra
print_1000:	#in "nghin" ra man hinh
	li $v0,4
	la $a0,nghin
	syscall
	li $v0,4			#in "space" ra man hinh
	la $a0,space
	syscall
	jr $ra
print_1000000:	#in "trieu" ra man hinh
	li $v0,4
	la $a0,trieu
	syscall
	li $v0,4			#in "space" ra man hinh
	la $a0,space
	syscall
	jr $ra
print_linh:	#in "linh" ra man hinh
	li $v0,4
	la $a0,linh
	syscall
	li $v0,4			#in "space" ra man hinh
	la $a0,space
	syscall
	jr $ra
print_kotram:	#in "khong tram" ra man hinh
	li $v0,4
	la $a0,ko_tram
	syscall
	li $v0,4			#in "space" ra man hinh
	la $a0,space
	syscall
	jr $ra
	
not_valid:
	li $v0,4
	la $a0,invalid
	syscall
	j input
	
print0_andexit:	# Neu so nguyen bang 0 thi in ra man hinh roi ket thuc
	li $v0,4
	la $a0,khong
	syscall
	j done		
	

done:	#ket thuc chuong trinh
	li $v0,10
	syscall
