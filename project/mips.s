main:
 jal mj_main
 li $v0, 10
 syscall

minijavaNew:
 move $t0, $a0
 mul $a0, $a1, 4
 li $v0, 9
 syscall
 sw $t0, ($v0)
 j $ra

minijavaNewArray:
 move $t0, $a0
 mul $a0, $a0, 4
 add $a0, $a0, 4
 li $v0, 9
 syscall
 sw $t0, ($v0)
 j $ra

.data
.align 4
minijavaNewline:
 .asciiz "\n"

.text
minijavaPrint:
 li $v0, 1
 syscall
 la $a0, minijavaNewline
 li $v0, 4
 syscall
 j $ra

mj_main:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -16
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a1: 0(1): NewObj *Fac :Fac
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 la $a0, mj__v_Fac
 li $a1, 1
 jal minijavaNew
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 # a0: 1(0): Int *10 :int
 li $a0, 10
 # a0: 2(0): Arg 1 *0 :int
 # a0: 3(0): Call 0 *ComputeFac(2) :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 0($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 # a0: 4(0): Print 3 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 .ret_mj_main:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
.data
.align 4
mj__v_Fac:
 .word mj__m_Fac_ComputeFac
.text
mj__m_Fac_ComputeFac:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -24
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 5(0): Parameter *0 :int
 # a2: 6(2): VarAssg 5 *num :int
 move $a2, $a0
 # a0: 7(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 8(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 9(0): Int *10 :int
 li $a0, 10
 # a0: 10(0): Mod 9 6 :int
 rem $a0, $a0, $a2
 # a3: 11(3): VarAssg 10 *x :int
 move $a3, $a0
 # a0: 12(0): Int *5 :int
 li $a0, 5
 # a0: 13(0): Mod 12 6 :int
 rem $a0, $a0, $a2
 # a1: 14(1): VarAssg 13 *y :int
 move $a1, $a0
 # a0: 15(0): Print 11 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 move $a0, $a3
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 # a0: 16(0): Print 14 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 move $a0, $a1
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 # a0: 17(0): Int *13 :int
 li $a0, 13
 # a0: 18(0): Mod 17 6 :int
 rem $a0, $a0, $a2
 # a0: 19(0): Print 18 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 # a0: 20(0): Int *100 :int
 li $a0, 100
 # a0: 21(0): Mod 20 6 :int
 rem $a0, $a0, $a2
 # a0: 22(0): Print 21 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 # a1: 23(1): Int *500213 :int
 li $a1, 500213
 # a0: 24(0): Int *57 :int
 li $a0, 57
 # a0: 25(0): Mod 23 24 :int
 rem $a0, $a1, $a0
 # a0: 26(0): Print 25 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 # a0: 27(0): Int *0 :int
 li $a0, 0
 # a0: 28(0): Return 27 :void
 move $v0, $a0
 j .ret_mj__m_Fac_ComputeFac
 .ret_mj__m_Fac_ComputeFac:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra

