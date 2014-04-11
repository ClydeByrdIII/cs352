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
 add $sp, $sp, -12
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 0(0): NewObj *Spiller :Spiller
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 la $a0, mj__v_Spiller
 li $a1, 1
 jal minijavaNew
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 # a0: 1(0): Call 0 *spill() :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 move $v0, $a0
 lw $v1, ($v0)
 lw $v1, 0($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 .ret_mj_main:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
.data
.align 4
mj__v_Spiller:
 .word mj__m_Spiller_spill
.text
mj__m_Spiller_spill:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -60
 add $sp, $sp, -4
 sw $s0, ($sp)
 add $sp, $sp, -4
 sw $s1, ($sp)
 add $sp, $sp, -4
 sw $s2, ($sp)
 add $sp, $sp, -4
 sw $s3, ($sp)
 add $sp, $sp, -4
 sw $s4, ($sp)
 add $sp, $sp, -4
 sw $s5, ($sp)
 add $sp, $sp, -4
 sw $s6, ($sp)
 add $sp, $sp, -4
 sw $s7, ($sp)
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 2(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 3(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 4(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 5(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 6(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 7(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 8(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 9(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 10(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 11(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 12(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 13(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 14(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 15(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 16(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 17(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 18(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 19(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 20(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 21(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 22(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 23(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 24(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 25(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 26(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 27(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 28(0): Int *1 :int
 li $a0, 1
 # s7: 29(19): VarAssg 28 *a :int
 move $s7, $a0
 # a0: 30(0): Int *2 :int
 li $a0, 2
 # s1: 31(13): VarAssg 30 *b :int
 move $s1, $a0
 # a0: 32(0): Int *3 :int
 li $a0, 3
 # s3: 33(15): VarAssg 32 *c :int
 move $s3, $a0
 # a0: 34(0): Int *4 :int
 li $a0, 4
 # t2: 35(6): VarAssg 34 *d :int
 move $t2, $a0
 # a0: 36(0): Int *5 :int
 li $a0, 5
 # s4: 37(16): VarAssg 36 *e :int
 move $s4, $a0
 # a0: 38(0): Int *6 :int
 li $a0, 6
 # t1: 39(5): VarAssg 38 *f :int
 move $t1, $a0
 # a0: 40(0): Int *7 :int
 li $a0, 7
 # a0: 41(0): VarAssg 40 *g :int
 # a1: 42(1): Int *8 :int
 li $a1, 8
 # t6: 43(10): VarAssg 42 *h :int
 move $t6, $a1
 # a1: 44(1): Int *9 :int
 li $a1, 9
 # s6: 45(18): VarAssg 44 *i :int
 move $s6, $a1
 # a1: 46(1): Int *10 :int
 li $a1, 10
 # t5: 47(9): VarAssg 46 *j :int
 move $t5, $a1
 # a1: 48(1): Int *11 :int
 li $a1, 11
 # a2: 49(2): VarAssg 48 *k :int
 move $a2, $a1
 # a1: 50(1): Int *12 :int
 li $a1, 12
 # t7: 51(11): VarAssg 50 *l :int
 move $t7, $a1
 # a1: 52(1): Int *13 :int
 li $a1, 13
 # s0: 53(12): VarAssg 52 *m :int
 move $s0, $a1
 # a1: 54(1): Int *14 :int
 li $a1, 14
 # t3: 55(7): VarAssg 54 *n :int
 move $t3, $a1
 # a1: 56(1): Int *15 :int
 li $a1, 15
 # t4: 57(8): VarAssg 56 *o :int
 move $t4, $a1
 # a1: 58(1): Int *16 :int
 li $a1, 16
 # s2: 59(14): VarAssg 58 *p :int
 move $s2, $a1
 # a1: 60(1): Int *17 :int
 li $a1, 17
 # s5: 61(17): VarAssg 60 *q :int
 move $s5, $a1
 # a1: 62(1): Int *18 :int
 li $a1, 18
 # t0: 63(4): VarAssg 62 *r :int
 move $t0, $a1
 # a1: 64(1): Int *19 :int
 li $a1, 19
 # a3: 65(3): VarAssg 64 *s :int
 move $a3, $a1
 # a1: 66(1): Int *20 :int
 li $a1, 20
 # t8: 67(20): VarAssg 66 *t :int
 move $t8, $a1
 # a1: 68(1): Print 29 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t0, -28($fp)
 sw $t1, -32($fp)
 sw $t2, -36($fp)
 sw $t3, -40($fp)
 sw $t4, -44($fp)
 sw $t5, -48($fp)
 sw $t6, -52($fp)
 sw $t7, -56($fp)
 sw $t8, -60($fp)
 move $a0, $s7
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t0, -28($fp)
 lw $t1, -32($fp)
 lw $t2, -36($fp)
 lw $t3, -40($fp)
 lw $t4, -44($fp)
 lw $t5, -48($fp)
 lw $t6, -52($fp)
 lw $t7, -56($fp)
 lw $t8, -60($fp)
 # a1: 69(1): Print 31 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t0, -28($fp)
 sw $t1, -32($fp)
 sw $t2, -36($fp)
 sw $t3, -40($fp)
 sw $t4, -44($fp)
 sw $t5, -48($fp)
 sw $t6, -52($fp)
 sw $t7, -56($fp)
 sw $t8, -60($fp)
 move $a0, $s1
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t0, -28($fp)
 lw $t1, -32($fp)
 lw $t2, -36($fp)
 lw $t3, -40($fp)
 lw $t4, -44($fp)
 lw $t5, -48($fp)
 lw $t6, -52($fp)
 lw $t7, -56($fp)
 lw $t8, -60($fp)
 # a1: 70(1): Print 33 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t0, -28($fp)
 sw $t1, -32($fp)
 sw $t2, -36($fp)
 sw $t3, -40($fp)
 sw $t4, -44($fp)
 sw $t5, -48($fp)
 sw $t6, -52($fp)
 sw $t7, -56($fp)
 sw $t8, -60($fp)
 move $a0, $s3
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t0, -28($fp)
 lw $t1, -32($fp)
 lw $t2, -36($fp)
 lw $t3, -40($fp)
 lw $t4, -44($fp)
 lw $t5, -48($fp)
 lw $t6, -52($fp)
 lw $t7, -56($fp)
 lw $t8, -60($fp)
 # a1: 71(1): Print 35 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t0, -28($fp)
 sw $t1, -32($fp)
 sw $t2, -36($fp)
 sw $t3, -40($fp)
 sw $t4, -44($fp)
 sw $t5, -48($fp)
 sw $t6, -52($fp)
 sw $t7, -56($fp)
 sw $t8, -60($fp)
 move $a0, $t2
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t0, -28($fp)
 lw $t1, -32($fp)
 lw $t2, -36($fp)
 lw $t3, -40($fp)
 lw $t4, -44($fp)
 lw $t5, -48($fp)
 lw $t6, -52($fp)
 lw $t7, -56($fp)
 lw $t8, -60($fp)
 # a1: 72(1): Print 37 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t0, -28($fp)
 sw $t1, -32($fp)
 sw $t2, -36($fp)
 sw $t3, -40($fp)
 sw $t4, -44($fp)
 sw $t5, -48($fp)
 sw $t6, -52($fp)
 sw $t7, -56($fp)
 sw $t8, -60($fp)
 move $a0, $s4
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t0, -28($fp)
 lw $t1, -32($fp)
 lw $t2, -36($fp)
 lw $t3, -40($fp)
 lw $t4, -44($fp)
 lw $t5, -48($fp)
 lw $t6, -52($fp)
 lw $t7, -56($fp)
 lw $t8, -60($fp)
 # a1: 73(1): Print 39 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t0, -28($fp)
 sw $t1, -32($fp)
 sw $t2, -36($fp)
 sw $t3, -40($fp)
 sw $t4, -44($fp)
 sw $t5, -48($fp)
 sw $t6, -52($fp)
 sw $t7, -56($fp)
 sw $t8, -60($fp)
 move $a0, $t1
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t0, -28($fp)
 lw $t1, -32($fp)
 lw $t2, -36($fp)
 lw $t3, -40($fp)
 lw $t4, -44($fp)
 lw $t5, -48($fp)
 lw $t6, -52($fp)
 lw $t7, -56($fp)
 lw $t8, -60($fp)
 # a0: 74(0): Print 41 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t0, -28($fp)
 sw $t1, -32($fp)
 sw $t2, -36($fp)
 sw $t3, -40($fp)
 sw $t4, -44($fp)
 sw $t5, -48($fp)
 sw $t6, -52($fp)
 sw $t7, -56($fp)
 sw $t8, -60($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t0, -28($fp)
 lw $t1, -32($fp)
 lw $t2, -36($fp)
 lw $t3, -40($fp)
 lw $t4, -44($fp)
 lw $t5, -48($fp)
 lw $t6, -52($fp)
 lw $t7, -56($fp)
 lw $t8, -60($fp)
 # a0: 75(0): Print 43 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t0, -28($fp)
 sw $t1, -32($fp)
 sw $t2, -36($fp)
 sw $t3, -40($fp)
 sw $t4, -44($fp)
 sw $t5, -48($fp)
 sw $t6, -52($fp)
 sw $t7, -56($fp)
 sw $t8, -60($fp)
 move $a0, $t6
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t0, -28($fp)
 lw $t1, -32($fp)
 lw $t2, -36($fp)
 lw $t3, -40($fp)
 lw $t4, -44($fp)
 lw $t5, -48($fp)
 lw $t6, -52($fp)
 lw $t7, -56($fp)
 lw $t8, -60($fp)
 # a0: 76(0): Print 45 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t0, -28($fp)
 sw $t1, -32($fp)
 sw $t2, -36($fp)
 sw $t3, -40($fp)
 sw $t4, -44($fp)
 sw $t5, -48($fp)
 sw $t6, -52($fp)
 sw $t7, -56($fp)
 sw $t8, -60($fp)
 move $a0, $s6
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t0, -28($fp)
 lw $t1, -32($fp)
 lw $t2, -36($fp)
 lw $t3, -40($fp)
 lw $t4, -44($fp)
 lw $t5, -48($fp)
 lw $t6, -52($fp)
 lw $t7, -56($fp)
 lw $t8, -60($fp)
 # a0: 77(0): Print 47 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t0, -28($fp)
 sw $t1, -32($fp)
 sw $t2, -36($fp)
 sw $t3, -40($fp)
 sw $t4, -44($fp)
 sw $t5, -48($fp)
 sw $t6, -52($fp)
 sw $t7, -56($fp)
 sw $t8, -60($fp)
 move $a0, $t5
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t0, -28($fp)
 lw $t1, -32($fp)
 lw $t2, -36($fp)
 lw $t3, -40($fp)
 lw $t4, -44($fp)
 lw $t5, -48($fp)
 lw $t6, -52($fp)
 lw $t7, -56($fp)
 lw $t8, -60($fp)
 # a0: 78(0): Print 49 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t0, -28($fp)
 sw $t1, -32($fp)
 sw $t2, -36($fp)
 sw $t3, -40($fp)
 sw $t4, -44($fp)
 sw $t5, -48($fp)
 sw $t6, -52($fp)
 sw $t7, -56($fp)
 sw $t8, -60($fp)
 move $a0, $a2
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t0, -28($fp)
 lw $t1, -32($fp)
 lw $t2, -36($fp)
 lw $t3, -40($fp)
 lw $t4, -44($fp)
 lw $t5, -48($fp)
 lw $t6, -52($fp)
 lw $t7, -56($fp)
 lw $t8, -60($fp)
 # a0: 79(0): Print 51 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t0, -28($fp)
 sw $t1, -32($fp)
 sw $t2, -36($fp)
 sw $t3, -40($fp)
 sw $t4, -44($fp)
 sw $t5, -48($fp)
 sw $t6, -52($fp)
 sw $t7, -56($fp)
 sw $t8, -60($fp)
 move $a0, $t7
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t0, -28($fp)
 lw $t1, -32($fp)
 lw $t2, -36($fp)
 lw $t3, -40($fp)
 lw $t4, -44($fp)
 lw $t5, -48($fp)
 lw $t6, -52($fp)
 lw $t7, -56($fp)
 lw $t8, -60($fp)
 # a0: 80(0): Print 53 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t0, -28($fp)
 sw $t1, -32($fp)
 sw $t2, -36($fp)
 sw $t3, -40($fp)
 sw $t4, -44($fp)
 sw $t5, -48($fp)
 sw $t6, -52($fp)
 sw $t7, -56($fp)
 sw $t8, -60($fp)
 move $a0, $s0
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t0, -28($fp)
 lw $t1, -32($fp)
 lw $t2, -36($fp)
 lw $t3, -40($fp)
 lw $t4, -44($fp)
 lw $t5, -48($fp)
 lw $t6, -52($fp)
 lw $t7, -56($fp)
 lw $t8, -60($fp)
 # a0: 81(0): Print 55 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t0, -28($fp)
 sw $t1, -32($fp)
 sw $t2, -36($fp)
 sw $t3, -40($fp)
 sw $t4, -44($fp)
 sw $t5, -48($fp)
 sw $t6, -52($fp)
 sw $t7, -56($fp)
 sw $t8, -60($fp)
 move $a0, $t3
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t0, -28($fp)
 lw $t1, -32($fp)
 lw $t2, -36($fp)
 lw $t3, -40($fp)
 lw $t4, -44($fp)
 lw $t5, -48($fp)
 lw $t6, -52($fp)
 lw $t7, -56($fp)
 lw $t8, -60($fp)
 # a0: 82(0): Print 57 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t0, -28($fp)
 sw $t1, -32($fp)
 sw $t2, -36($fp)
 sw $t3, -40($fp)
 sw $t4, -44($fp)
 sw $t5, -48($fp)
 sw $t6, -52($fp)
 sw $t7, -56($fp)
 sw $t8, -60($fp)
 move $a0, $t4
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t0, -28($fp)
 lw $t1, -32($fp)
 lw $t2, -36($fp)
 lw $t3, -40($fp)
 lw $t4, -44($fp)
 lw $t5, -48($fp)
 lw $t6, -52($fp)
 lw $t7, -56($fp)
 lw $t8, -60($fp)
 # a0: 83(0): Print 59 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t0, -28($fp)
 sw $t1, -32($fp)
 sw $t2, -36($fp)
 sw $t3, -40($fp)
 sw $t4, -44($fp)
 sw $t5, -48($fp)
 sw $t6, -52($fp)
 sw $t7, -56($fp)
 sw $t8, -60($fp)
 move $a0, $s2
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t0, -28($fp)
 lw $t1, -32($fp)
 lw $t2, -36($fp)
 lw $t3, -40($fp)
 lw $t4, -44($fp)
 lw $t5, -48($fp)
 lw $t6, -52($fp)
 lw $t7, -56($fp)
 lw $t8, -60($fp)
 # a0: 84(0): Print 61 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t0, -28($fp)
 sw $t1, -32($fp)
 sw $t2, -36($fp)
 sw $t3, -40($fp)
 sw $t4, -44($fp)
 sw $t5, -48($fp)
 sw $t6, -52($fp)
 sw $t7, -56($fp)
 sw $t8, -60($fp)
 move $a0, $s5
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t0, -28($fp)
 lw $t1, -32($fp)
 lw $t2, -36($fp)
 lw $t3, -40($fp)
 lw $t4, -44($fp)
 lw $t5, -48($fp)
 lw $t6, -52($fp)
 lw $t7, -56($fp)
 lw $t8, -60($fp)
 # a0: 85(0): Print 63 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t0, -28($fp)
 sw $t1, -32($fp)
 sw $t2, -36($fp)
 sw $t3, -40($fp)
 sw $t4, -44($fp)
 sw $t5, -48($fp)
 sw $t6, -52($fp)
 sw $t7, -56($fp)
 sw $t8, -60($fp)
 move $a0, $t0
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t0, -28($fp)
 lw $t1, -32($fp)
 lw $t2, -36($fp)
 lw $t3, -40($fp)
 lw $t4, -44($fp)
 lw $t5, -48($fp)
 lw $t6, -52($fp)
 lw $t7, -56($fp)
 lw $t8, -60($fp)
 # a0: 86(0): Print 65 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t0, -28($fp)
 sw $t1, -32($fp)
 sw $t2, -36($fp)
 sw $t3, -40($fp)
 sw $t4, -44($fp)
 sw $t5, -48($fp)
 sw $t6, -52($fp)
 sw $t7, -56($fp)
 sw $t8, -60($fp)
 move $a0, $a3
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t0, -28($fp)
 lw $t1, -32($fp)
 lw $t2, -36($fp)
 lw $t3, -40($fp)
 lw $t4, -44($fp)
 lw $t5, -48($fp)
 lw $t6, -52($fp)
 lw $t7, -56($fp)
 lw $t8, -60($fp)
 # a0: 87(0): Print 67 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t0, -28($fp)
 sw $t1, -32($fp)
 sw $t2, -36($fp)
 sw $t3, -40($fp)
 sw $t4, -44($fp)
 sw $t5, -48($fp)
 sw $t6, -52($fp)
 sw $t7, -56($fp)
 sw $t8, -60($fp)
 move $a0, $t8
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t0, -28($fp)
 lw $t1, -32($fp)
 lw $t2, -36($fp)
 lw $t3, -40($fp)
 lw $t4, -44($fp)
 lw $t5, -48($fp)
 lw $t6, -52($fp)
 lw $t7, -56($fp)
 lw $t8, -60($fp)
 # a0: 88(0): Int *0 :int
 li $a0, 0
 # a0: 89(0): Return 88 :void
 move $v0, $a0
 j .ret_mj__m_Spiller_spill
 .ret_mj__m_Spiller_spill:
 lw $ra, ($sp)
 add $sp, $sp, 4
 lw $s7, ($sp)
 add $sp, $sp, 4
 lw $s6, ($sp)
 add $sp, $sp, 4
 lw $s5, ($sp)
 add $sp, $sp, 4
 lw $s4, ($sp)
 add $sp, $sp, 4
 lw $s3, ($sp)
 add $sp, $sp, 4
 lw $s2, ($sp)
 add $sp, $sp, 4
 lw $s1, ($sp)
 add $sp, $sp, 4
 lw $s0, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra

