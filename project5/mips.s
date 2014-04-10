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
 # a0: 0(0): NewObj *TV :TV
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 la $a0, mj__v_TV
 li $a1, 1
 jal minijavaNew
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 # a0: 1(0): Call 0 *Start() :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 move $v0, $a0
 lw $v1, ($v0)
 lw $v1, 0($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 # a0: 2(0): Print 1 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 .ret_mj_main:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
.data
.align 4
mj__v_TV:
 .word mj__m_TV_Start
.text
mj__m_TV_Start:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -24
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a1: 3(1): Null *Type(Tree) :Tree
 move $a1, $zero
 # a1: 4(1): Null *Type(boolean) :boolean
 move $a1, $zero
 # a1: 5(1): Null *Type(int) :int
 move $a1, $zero
 # a1: 6(1): Null *Type(MyVisitor) :MyVisitor
 move $a1, $zero
 # a1: 7(1): NewObj *Tree :Tree
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 la $a0, mj__v_Tree
 li $a1, 7
 jal minijavaNew
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a2: 8(2): VarAssg 7 *root :Tree
 move $a2, $a1
 # a1: 9(1): Int *16 :int
 li $a1, 16
 # a0: 10(0): Arg 9 *0 :int
 move $a0, $a1
 # a1: 11(1): Call 8 *Init(10) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 0($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 12(1): VarAssg 11 *ntb :boolean
 # a1: 13(1): Call 8 *Print() :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 72($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 14(1): VarAssg 13 *ntb :boolean
 # a1: 15(1): Int *100000000 :int
 li $a1, 100000000
 # a1: 16(1): Print 15 :void
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
 # a1: 17(1): Int *8 :int
 li $a1, 8
 # a0: 18(0): Arg 17 *0 :int
 move $a0, $a1
 # a1: 19(1): Call 8 *Insert(18) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 48($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 20(1): VarAssg 19 *ntb :boolean
 # a1: 21(1): Int *24 :int
 li $a1, 24
 # a0: 22(0): Arg 21 *0 :int
 move $a0, $a1
 # a1: 23(1): Call 8 *Insert(22) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 48($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 24(1): VarAssg 23 *ntb :boolean
 # a1: 25(1): Int *4 :int
 li $a1, 4
 # a0: 26(0): Arg 25 *0 :int
 move $a0, $a1
 # a1: 27(1): Call 8 *Insert(26) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 48($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 28(1): VarAssg 27 *ntb :boolean
 # a1: 29(1): Int *12 :int
 li $a1, 12
 # a0: 30(0): Arg 29 *0 :int
 move $a0, $a1
 # a1: 31(1): Call 8 *Insert(30) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 48($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 32(1): VarAssg 31 *ntb :boolean
 # a1: 33(1): Int *20 :int
 li $a1, 20
 # a0: 34(0): Arg 33 *0 :int
 move $a0, $a1
 # a1: 35(1): Call 8 *Insert(34) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 48($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 36(1): VarAssg 35 *ntb :boolean
 # a1: 37(1): Int *28 :int
 li $a1, 28
 # a0: 38(0): Arg 37 *0 :int
 move $a0, $a1
 # a1: 39(1): Call 8 *Insert(38) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 48($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 40(1): VarAssg 39 *ntb :boolean
 # a1: 41(1): Int *14 :int
 li $a1, 14
 # a0: 42(0): Arg 41 *0 :int
 move $a0, $a1
 # a1: 43(1): Call 8 *Insert(42) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 48($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 44(1): VarAssg 43 *ntb :boolean
 # a1: 45(1): Call 8 *Print() :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 72($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 46(1): VarAssg 45 *ntb :boolean
 # a1: 47(1): Int *100000000 :int
 li $a1, 100000000
 # a1: 48(1): Print 47 :void
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
 # a1: 49(1): NewObj *MyVisitor :MyVisitor
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 la $a0, mj__v_MyVisitor
 li $a1, 3
 jal minijavaNew
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a3: 50(3): VarAssg 49 *v :MyVisitor
 move $a3, $a1
 # a1: 51(1): Int *50000000 :int
 li $a1, 50000000
 # a1: 52(1): Print 51 :void
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
 # a0: 53(0): Arg 50 *0 :MyVisitor
 move $a0, $a3
 # a1: 54(1): Call 8 *accept(53) :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 80($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 55(1): VarAssg 54 *nti :int
 # a1: 56(1): Int *100000000 :int
 li $a1, 100000000
 # a1: 57(1): Print 56 :void
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
 # a1: 58(1): Int *24 :int
 li $a1, 24
 # a0: 59(0): Arg 58 *0 :int
 move $a0, $a1
 # a1: 60(1): Call 8 *Search(59) :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 68($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 61(1): Print 60 :void
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
 # a1: 62(1): Int *12 :int
 li $a1, 12
 # a0: 63(0): Arg 62 *0 :int
 move $a0, $a1
 # a1: 64(1): Call 8 *Search(63) :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 68($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 65(1): Print 64 :void
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
 # a1: 66(1): Int *16 :int
 li $a1, 16
 # a0: 67(0): Arg 66 *0 :int
 move $a0, $a1
 # a1: 68(1): Call 8 *Search(67) :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 68($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 69(1): Print 68 :void
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
 # a1: 70(1): Int *50 :int
 li $a1, 50
 # a0: 71(0): Arg 70 *0 :int
 move $a0, $a1
 # a1: 72(1): Call 8 *Search(71) :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 68($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 73(1): Print 72 :void
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
 # a1: 74(1): Int *12 :int
 li $a1, 12
 # a0: 75(0): Arg 74 *0 :int
 move $a0, $a1
 # a1: 76(1): Call 8 *Search(75) :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 68($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 77(1): Print 76 :void
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
 # a1: 78(1): Int *12 :int
 li $a1, 12
 # a0: 79(0): Arg 78 *0 :int
 move $a0, $a1
 # a1: 80(1): Call 8 *Delete(79) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 52($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 81(1): VarAssg 80 *ntb :boolean
 # a1: 82(1): Call 8 *Print() :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 72($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 83(1): VarAssg 82 *ntb :boolean
 # a1: 84(1): Int *12 :int
 li $a1, 12
 # a0: 85(0): Arg 84 *0 :int
 move $a0, $a1
 # a1: 86(1): Call 8 *Search(85) :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 68($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 87(1): Print 86 :void
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
 # a1: 88(1): Int *0 :int
 li $a1, 0
 # a1: 89(1): Return 88 :void
 move $v0, $a1
 j .ret_mj__m_TV_Start
 .ret_mj__m_TV_Start:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
.data
.align 4
mj__v_Tree:
 .word mj__m_Tree_Init
 .word mj__m_Tree_SetRight
 .word mj__m_Tree_SetLeft
 .word mj__m_Tree_GetRight
 .word mj__m_Tree_GetLeft
 .word mj__m_Tree_GetKey
 .word mj__m_Tree_SetKey
 .word mj__m_Tree_GetHas_Right
 .word mj__m_Tree_GetHas_Left
 .word mj__m_Tree_SetHas_Left
 .word mj__m_Tree_SetHas_Right
 .word mj__m_Tree_Compare
 .word mj__m_Tree_Insert
 .word mj__m_Tree_Delete
 .word mj__m_Tree_Remove
 .word mj__m_Tree_RemoveRight
 .word mj__m_Tree_RemoveLeft
 .word mj__m_Tree_Search
 .word mj__m_Tree_Print
 .word mj__m_Tree_RecPrint
 .word mj__m_Tree_accept
.text
mj__m_Tree_Init:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -20
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 90(0): Parameter *0 :int
 # a2: 91(2): VarAssg 90 *v_key :int
 move $a2, $a0
 # a1: 92(1): This :Tree
 move $a1, $v0
 # a1: 93(1): MemberAssg 92 91 *key :int
 sw $a2, 12($a1)
 move $a1, $a2
 # a2: 94(2): This :Tree
 move $a2, $v0
 # a1: 95(1): Boolean *false :boolean
 move $a1, $zero
 # a1: 96(1): MemberAssg 94 95 *has_left :boolean
 sw $a1, 16($a2)
 # a2: 97(2): This :Tree
 move $a2, $v0
 # a1: 98(1): Boolean *false :boolean
 move $a1, $zero
 # a1: 99(1): MemberAssg 97 98 *has_right :boolean
 sw $a1, 20($a2)
 # a1: 100(1): Boolean *true :boolean
 li $a1, 1
 # a1: 101(1): Return 100 :void
 move $v0, $a1
 j .ret_mj__m_Tree_Init
 .ret_mj__m_Tree_Init:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
mj__m_Tree_SetRight:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -20
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 102(0): Parameter *0 :Tree
 # a2: 103(2): VarAssg 102 *rn :Tree
 move $a2, $a0
 # a1: 104(1): This :Tree
 move $a1, $v0
 # a1: 105(1): MemberAssg 104 103 *right :Tree
 sw $a2, 8($a1)
 move $a1, $a2
 # a1: 106(1): Boolean *true :boolean
 li $a1, 1
 # a1: 107(1): Return 106 :void
 move $v0, $a1
 j .ret_mj__m_Tree_SetRight
 .ret_mj__m_Tree_SetRight:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
mj__m_Tree_SetLeft:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -20
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 108(0): Parameter *0 :Tree
 # a2: 109(2): VarAssg 108 *ln :Tree
 move $a2, $a0
 # a1: 110(1): This :Tree
 move $a1, $v0
 # a1: 111(1): MemberAssg 110 109 *left :Tree
 sw $a2, 4($a1)
 move $a1, $a2
 # a1: 112(1): Boolean *true :boolean
 li $a1, 1
 # a1: 113(1): Return 112 :void
 move $v0, $a1
 j .ret_mj__m_Tree_SetLeft
 .ret_mj__m_Tree_SetLeft:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
mj__m_Tree_GetRight:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -12
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 114(0): This :Tree
 move $a0, $v0
 # a0: 115(0): Member 114 *right :Tree
 lw $a0, 8($a0)
 # a0: 116(0): Return 115 :void
 move $v0, $a0
 j .ret_mj__m_Tree_GetRight
 .ret_mj__m_Tree_GetRight:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
mj__m_Tree_GetLeft:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -12
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 117(0): This :Tree
 move $a0, $v0
 # a0: 118(0): Member 117 *left :Tree
 lw $a0, 4($a0)
 # a0: 119(0): Return 118 :void
 move $v0, $a0
 j .ret_mj__m_Tree_GetLeft
 .ret_mj__m_Tree_GetLeft:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
mj__m_Tree_GetKey:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -12
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 120(0): This :Tree
 move $a0, $v0
 # a0: 121(0): Member 120 *key :int
 lw $a0, 12($a0)
 # a0: 122(0): Return 121 :void
 move $v0, $a0
 j .ret_mj__m_Tree_GetKey
 .ret_mj__m_Tree_GetKey:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
mj__m_Tree_SetKey:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -20
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 123(0): Parameter *0 :int
 # a2: 124(2): VarAssg 123 *v_key :int
 move $a2, $a0
 # a1: 125(1): This :Tree
 move $a1, $v0
 # a1: 126(1): MemberAssg 125 124 *key :int
 sw $a2, 12($a1)
 move $a1, $a2
 # a1: 127(1): Boolean *true :boolean
 li $a1, 1
 # a1: 128(1): Return 127 :void
 move $v0, $a1
 j .ret_mj__m_Tree_SetKey
 .ret_mj__m_Tree_SetKey:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
mj__m_Tree_GetHas_Right:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -12
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 129(0): This :Tree
 move $a0, $v0
 # a0: 130(0): Member 129 *has_right :boolean
 lw $a0, 20($a0)
 # a0: 131(0): Return 130 :void
 move $v0, $a0
 j .ret_mj__m_Tree_GetHas_Right
 .ret_mj__m_Tree_GetHas_Right:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
mj__m_Tree_GetHas_Left:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -12
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 132(0): This :Tree
 move $a0, $v0
 # a0: 133(0): Member 132 *has_left :boolean
 lw $a0, 16($a0)
 # a0: 134(0): Return 133 :void
 move $v0, $a0
 j .ret_mj__m_Tree_GetHas_Left
 .ret_mj__m_Tree_GetHas_Left:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
mj__m_Tree_SetHas_Left:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -20
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 135(0): Parameter *0 :boolean
 # a2: 136(2): VarAssg 135 *val :boolean
 move $a2, $a0
 # a1: 137(1): This :Tree
 move $a1, $v0
 # a1: 138(1): MemberAssg 137 136 *has_left :boolean
 sw $a2, 16($a1)
 move $a1, $a2
 # a1: 139(1): Boolean *true :boolean
 li $a1, 1
 # a1: 140(1): Return 139 :void
 move $v0, $a1
 j .ret_mj__m_Tree_SetHas_Left
 .ret_mj__m_Tree_SetHas_Left:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
mj__m_Tree_SetHas_Right:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -20
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 141(0): Parameter *0 :boolean
 # a2: 142(2): VarAssg 141 *val :boolean
 move $a2, $a0
 # a1: 143(1): This :Tree
 move $a1, $v0
 # a1: 144(1): MemberAssg 143 142 *has_right :boolean
 sw $a2, 20($a1)
 move $a1, $a2
 # a1: 145(1): Boolean *true :boolean
 li $a1, 1
 # a1: 146(1): Return 145 :void
 move $v0, $a1
 j .ret_mj__m_Tree_SetHas_Right
 .ret_mj__m_Tree_SetHas_Right:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
mj__m_Tree_Compare:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -32
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 147(0): Parameter *0 :int
 # a1: 148(1): Parameter *1 :int
 # t1: 149(5): VarAssg 147 *num1 :int
 move $t1, $a0
 # t0: 150(4): VarAssg 148 *num2 :int
 move $t0, $a1
 # a2: 151(2): Null *Type(boolean) :boolean
 move $a2, $zero
 # a2: 152(2): Null *Type(int) :int
 move $a2, $zero
 # a2: 153(2): Boolean *false :boolean
 move $a2, $zero
 # a2: 154(2): VarAssg 153 *ntb :boolean
 # a2: 155(2): Int *1 :int
 li $a2, 1
 # a2: 156(2): Plus 150 155 :int
 add $a2, $t0, $a2
 # a3: 157(3): VarAssg 156 *nti :int
 move $a3, $a2
 # a2: 158(2): Lt 149 150 :boolean
 slt $a2, $t1, $t0 # a2: 159(2): NBranch 158 *lif_641502649_else :void
 beq $a2, $zero, .lif_641502649_else
 # a2: 160(2): Boolean *false :boolean
 move $a2, $zero
 # a2: 161(2): VarAssg 160 *ntb :boolean
 # a3: 162(3): Goto *lif_641502649_done :void
 j .lif_641502649_done
 # a2: 163(2): Label *lif_641502649_else :void
 .lif_641502649_else:
 # a2: 164(2): Lt 149 157 :boolean
 slt $a2, $t1, $a3 # a2: 165(2): Not 164 :boolean
 seq $a2, $zero, $a2
 # a2: 166(2): NBranch 165 *lif_1367113803_else :void
 beq $a2, $zero, .lif_1367113803_else
 # a2: 167(2): Boolean *false :boolean
 move $a2, $zero
 # a2: 168(2): VarAssg 167 *ntb :boolean
 # a3: 169(3): Goto *lif_1367113803_done :void
 j .lif_1367113803_done
 # a2: 170(2): Label *lif_1367113803_else :void
 .lif_1367113803_else:
 # a2: 171(2): Boolean *true :boolean
 li $a2, 1
 # a2: 172(2): VarAssg 171 *ntb :boolean
 # a3: 173(3): Label *lif_1367113803_done :void
 .lif_1367113803_done:
 # a2: 174(2): Unify 168 172 :boolean
 # a3: 175(3): Label *lif_641502649_done :void
 .lif_641502649_done:
 # a2: 176(2): Unify 161 174 :boolean
 # a2: 177(2): Return 176 :void
 move $v0, $a2
 j .ret_mj__m_Tree_Compare
 .ret_mj__m_Tree_Compare:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
mj__m_Tree_Insert:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -40
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 178(0): Parameter *0 :int
 # t3: 179(7): VarAssg 178 *v_key :int
 move $t3, $a0
 # a1: 180(1): Null *Type(Tree) :Tree
 move $a1, $zero
 # a1: 181(1): Null *Type(boolean) :boolean
 move $a1, $zero
 # a1: 182(1): Null *Type(Tree) :Tree
 move $a1, $zero
 # a1: 183(1): Null *Type(boolean) :boolean
 move $a1, $zero
 # a3: 184(3): Null *Type(int) :int
 move $a3, $zero
 # a1: 185(1): NewObj *Tree :Tree
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 sw $t2, -32($fp)
 sw $t3, -36($fp)
 la $a0, mj__v_Tree
 li $a1, 7
 jal minijavaNew
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 lw $t2, -32($fp)
 lw $t3, -36($fp)
 # t2: 186(6): VarAssg 185 *new_node :Tree
 move $t2, $a1
 # a0: 187(0): Arg 179 *0 :int
 move $a0, $t3
 # a1: 188(1): Call 186 *Init(187) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 sw $t2, -32($fp)
 sw $t3, -36($fp)
 move $v0, $t2
 lw $v1, ($v0)
 lw $v1, 0($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 lw $t2, -32($fp)
 lw $t3, -36($fp)
 # t0: 189(4): VarAssg 188 *ntb :boolean
 move $t0, $a1
 # a1: 190(1): This :Tree
 move $a1, $v0
 # a1: 191(1): VarAssg 190 *current_node :Tree
 # a2: 192(2): Boolean *true :boolean
 li $a2, 1
 # a2: 193(2): VarAssg 192 *cont :boolean
 # t1: 194(5): Label *lwhile_1689237072_start :void
 .lwhile_1689237072_start:
 # t1: 195(5): NBranch 193 *lwhile_1689237072_end :void
 beq $a2, $zero, .lwhile_1689237072_end
 # a3: 196(3): Call 191 *GetKey() :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 sw $t2, -32($fp)
 sw $t3, -36($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 20($v1)
 jal $v1
 move $a3, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 lw $t2, -32($fp)
 lw $t3, -36($fp)
 # a3: 197(3): VarAssg 196 *key_aux :int
 # t1: 198(5): Lt 179 197 :boolean
 slt $t1, $t3, $a3 # t1: 199(5): NBranch 198 *lif_1273655764_else :void
 beq $t1, $zero, .lif_1273655764_else
 # t1: 200(5): Call 191 *GetHas_Left() :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t0, -28($fp)
 sw $t2, -32($fp)
 sw $t3, -36($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 32($v1)
 jal $v1
 move $t1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t0, -28($fp)
 lw $t2, -32($fp)
 lw $t3, -36($fp)
 # t1: 201(5): NBranch 200 *lif_215432252_else :void
 beq $t1, $zero, .lif_215432252_else
 # a1: 202(1): Call 191 *GetLeft() :Tree
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 sw $t2, -32($fp)
 sw $t3, -36($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 16($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 lw $t2, -32($fp)
 lw $t3, -36($fp)
 # a1: 203(1): VarAssg 202 *current_node :Tree
 # t1: 204(5): Goto *lif_215432252_done :void
 j .lif_215432252_done
 # a2: 205(2): Label *lif_215432252_else :void
 .lif_215432252_else:
 # a2: 206(2): Boolean *false :boolean
 move $a2, $zero
 # a2: 207(2): VarAssg 206 *cont :boolean
 # t0: 208(4): Boolean *true :boolean
 li $t0, 1
 # a0: 209(0): Arg 208 *0 :boolean
 move $a0, $t0
 # t0: 210(4): Call 191 *SetHas_Left(209) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t1, -28($fp)
 sw $t2, -32($fp)
 sw $t3, -36($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 36($v1)
 jal $v1
 move $t0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t1, -28($fp)
 lw $t2, -32($fp)
 lw $t3, -36($fp)
 # t0: 211(4): VarAssg 210 *ntb :boolean
 # a0: 212(0): Arg 186 *0 :Tree
 move $a0, $t2
 # t0: 213(4): Call 191 *SetLeft(212) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t1, -28($fp)
 sw $t2, -32($fp)
 sw $t3, -36($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 8($v1)
 jal $v1
 move $t0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t1, -28($fp)
 lw $t2, -32($fp)
 lw $t3, -36($fp)
 # t0: 214(4): VarAssg 213 *ntb :boolean
 # t1: 215(5): Label *lif_215432252_done :void
 .lif_215432252_done:
 # t0: 216(4): Unify 189 214 :boolean
 # a2: 217(2): Unify 193 207 :boolean
 # a1: 218(1): Unify 203 191 :Tree
 # t1: 219(5): Goto *lif_1273655764_done :void
 j .lif_1273655764_done
 # t1: 220(5): Label *lif_1273655764_else :void
 .lif_1273655764_else:
 # t1: 221(5): Call 191 *GetHas_Right() :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t0, -28($fp)
 sw $t2, -32($fp)
 sw $t3, -36($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 28($v1)
 jal $v1
 move $t1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t0, -28($fp)
 lw $t2, -32($fp)
 lw $t3, -36($fp)
 # t1: 222(5): NBranch 221 *lif_112430522_else :void
 beq $t1, $zero, .lif_112430522_else
 # a1: 223(1): Call 191 *GetRight() :Tree
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 sw $t2, -32($fp)
 sw $t3, -36($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 12($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 lw $t2, -32($fp)
 lw $t3, -36($fp)
 # a1: 224(1): VarAssg 223 *current_node :Tree
 # t1: 225(5): Goto *lif_112430522_done :void
 j .lif_112430522_done
 # a2: 226(2): Label *lif_112430522_else :void
 .lif_112430522_else:
 # a2: 227(2): Boolean *false :boolean
 move $a2, $zero
 # a2: 228(2): VarAssg 227 *cont :boolean
 # t0: 229(4): Boolean *true :boolean
 li $t0, 1
 # a0: 230(0): Arg 229 *0 :boolean
 move $a0, $t0
 # t0: 231(4): Call 191 *SetHas_Right(230) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t1, -28($fp)
 sw $t2, -32($fp)
 sw $t3, -36($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 40($v1)
 jal $v1
 move $t0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t1, -28($fp)
 lw $t2, -32($fp)
 lw $t3, -36($fp)
 # t0: 232(4): VarAssg 231 *ntb :boolean
 # a0: 233(0): Arg 186 *0 :Tree
 move $a0, $t2
 # t0: 234(4): Call 191 *SetRight(233) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t1, -28($fp)
 sw $t2, -32($fp)
 sw $t3, -36($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 4($v1)
 jal $v1
 move $t0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t1, -28($fp)
 lw $t2, -32($fp)
 lw $t3, -36($fp)
 # t0: 235(4): VarAssg 234 *ntb :boolean
 # t1: 236(5): Label *lif_112430522_done :void
 .lif_112430522_done:
 # t0: 237(4): Unify 189 235 :boolean
 # a2: 238(2): Unify 193 228 :boolean
 # a1: 239(1): Unify 224 191 :Tree
 # t1: 240(5): Label *lif_1273655764_done :void
 .lif_1273655764_done:
 # a2: 241(2): Unify 217 238 :boolean
 # t0: 242(4): Unify 216 237 :boolean
 # a1: 243(1): Unify 218 239 :Tree
 # t1: 244(5): Goto *lwhile_1689237072_start :void
 j .lwhile_1689237072_start
 # t1: 245(5): Label *lwhile_1689237072_end :void
 .lwhile_1689237072_end:
 # t0: 246(4): Unify 189 242 :boolean
 # a3: 247(3): Unify 184 197 :int
 # a2: 248(2): Unify 193 241 :boolean
 # a1: 249(1): Unify 191 243 :Tree
 # a1: 250(1): Boolean *true :boolean
 li $a1, 1
 # a1: 251(1): Return 250 :void
 move $v0, $a1
 j .ret_mj__m_Tree_Insert
 .ret_mj__m_Tree_Insert:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
mj__m_Tree_Delete:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -52
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 252(0): Parameter *0 :int
 # t6: 253(10): VarAssg 252 *v_key :int
 move $t6, $a0
 # a2: 254(2): Null *Type(Tree) :Tree
 move $a2, $zero
 # a2: 255(2): Null *Type(Tree) :Tree
 move $a2, $zero
 # a2: 256(2): Null *Type(boolean) :boolean
 move $a2, $zero
 # a2: 257(2): Null *Type(boolean) :boolean
 move $a2, $zero
 # t2: 258(6): Null *Type(boolean) :boolean
 move $t2, $zero
 # a2: 259(2): Null *Type(boolean) :boolean
 move $a2, $zero
 # t1: 260(5): Null *Type(int) :int
 move $t1, $zero
 # a2: 261(2): This :Tree
 move $a2, $v0
 # a2: 262(2): VarAssg 261 *current_node :Tree
 # a3: 263(3): This :Tree
 move $a3, $v0
 # t3: 264(7): VarAssg 263 *parent_node :Tree
 move $t3, $a3
 # a3: 265(3): Boolean *true :boolean
 li $a3, 1
 # t0: 266(4): VarAssg 265 *cont :boolean
 move $t0, $a3
 # a3: 267(3): Boolean *false :boolean
 move $a3, $zero
 # a3: 268(3): VarAssg 267 *found :boolean
 # t4: 269(8): Boolean *true :boolean
 li $t4, 1
 # t4: 270(8): VarAssg 269 *is_root :boolean
 # t5: 271(9): Label *lwhile_1981657541_start :void
 .lwhile_1981657541_start:
 # t5: 272(9): NBranch 266 *lwhile_1981657541_end :void
 beq $t0, $zero, .lwhile_1981657541_end
 # t1: 273(5): Call 262 *GetKey() :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t0, -28($fp)
 sw $t2, -32($fp)
 sw $t3, -36($fp)
 sw $t4, -40($fp)
 sw $t5, -44($fp)
 sw $t6, -48($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 20($v1)
 jal $v1
 move $t1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t0, -28($fp)
 lw $t2, -32($fp)
 lw $t3, -36($fp)
 lw $t4, -40($fp)
 lw $t5, -44($fp)
 lw $t6, -48($fp)
 # t1: 274(5): VarAssg 273 *key_aux :int
 # t5: 275(9): Lt 253 274 :boolean
 slt $t5, $t6, $t1 # t5: 276(9): NBranch 275 *lif_394410264_else :void
 beq $t5, $zero, .lif_394410264_else
 # t4: 277(8): Call 262 *GetHas_Left() :boolean
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
 sw $t5, -44($fp)
 sw $t6, -48($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 32($v1)
 jal $v1
 move $t4, $v0
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
 lw $t5, -44($fp)
 lw $t6, -48($fp)
 # t4: 278(8): NBranch 277 *lif_1718772406_else :void
 beq $t4, $zero, .lif_1718772406_else
 # t3: 279(7): VarAssg 262 *parent_node :Tree
 move $t3, $a2
 # a2: 280(2): Call 262 *GetLeft() :Tree
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a3, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 sw $t2, -32($fp)
 sw $t3, -36($fp)
 sw $t4, -40($fp)
 sw $t5, -44($fp)
 sw $t6, -48($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 16($v1)
 jal $v1
 move $a2, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a3, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 lw $t2, -32($fp)
 lw $t3, -36($fp)
 lw $t4, -40($fp)
 lw $t5, -44($fp)
 lw $t6, -48($fp)
 # a2: 281(2): VarAssg 280 *current_node :Tree
 # t4: 282(8): Goto *lif_1718772406_done :void
 j .lif_1718772406_done
 # t0: 283(4): Label *lif_1718772406_else :void
 .lif_1718772406_else:
 # t0: 284(4): Boolean *false :boolean
 move $t0, $zero
 # t0: 285(4): VarAssg 284 *cont :boolean
 # t4: 286(8): Label *lif_1718772406_done :void
 .lif_1718772406_done:
 # t3: 287(7): Unify 279 264 :Tree
 # t0: 288(4): Unify 266 285 :boolean
 # a2: 289(2): Unify 281 262 :Tree
 # t4: 290(8): Goto *lif_394410264_done :void
 j .lif_394410264_done
 # t5: 291(9): Label *lif_394410264_else :void
 .lif_394410264_else:
 # t5: 292(9): Lt 274 253 :boolean
 slt $t5, $t1, $t6 # t5: 293(9): NBranch 292 *lif_1605291845_else :void
 beq $t5, $zero, .lif_1605291845_else
 # t4: 294(8): Call 262 *GetHas_Right() :boolean
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
 sw $t5, -44($fp)
 sw $t6, -48($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 28($v1)
 jal $v1
 move $t4, $v0
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
 lw $t5, -44($fp)
 lw $t6, -48($fp)
 # t4: 295(8): NBranch 294 *lif_1302981654_else :void
 beq $t4, $zero, .lif_1302981654_else
 # t3: 296(7): VarAssg 262 *parent_node :Tree
 move $t3, $a2
 # a2: 297(2): Call 262 *GetRight() :Tree
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a3, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 sw $t2, -32($fp)
 sw $t3, -36($fp)
 sw $t4, -40($fp)
 sw $t5, -44($fp)
 sw $t6, -48($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 12($v1)
 jal $v1
 move $a2, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a3, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 lw $t2, -32($fp)
 lw $t3, -36($fp)
 lw $t4, -40($fp)
 lw $t5, -44($fp)
 lw $t6, -48($fp)
 # a2: 298(2): VarAssg 297 *current_node :Tree
 # t4: 299(8): Goto *lif_1302981654_done :void
 j .lif_1302981654_done
 # t0: 300(4): Label *lif_1302981654_else :void
 .lif_1302981654_else:
 # t0: 301(4): Boolean *false :boolean
 move $t0, $zero
 # t0: 302(4): VarAssg 301 *cont :boolean
 # t4: 303(8): Label *lif_1302981654_done :void
 .lif_1302981654_done:
 # t3: 304(7): Unify 296 264 :Tree
 # t0: 305(4): Unify 266 302 :boolean
 # a2: 306(2): Unify 298 262 :Tree
 # t4: 307(8): Goto *lif_1605291845_done :void
 j .lif_1605291845_done
 # a3: 308(3): Label *lif_1605291845_else :void
 .lif_1605291845_else:
 # a3: 309(3): NBranch 270 *lif_1321910319_else :void
 beq $t4, $zero, .lif_1321910319_else
 # a3: 310(3): Call 262 *GetHas_Right() :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 sw $t2, -32($fp)
 sw $t3, -36($fp)
 sw $t4, -40($fp)
 sw $t5, -44($fp)
 sw $t6, -48($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 28($v1)
 jal $v1
 move $a3, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 lw $t2, -32($fp)
 lw $t3, -36($fp)
 lw $t4, -40($fp)
 lw $t5, -44($fp)
 lw $t6, -48($fp)
 # t0: 311(4): Not 310 :boolean
 seq $t0, $zero, $a3
 # a3: 312(3): Call 262 *GetHas_Left() :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 sw $t2, -32($fp)
 sw $t3, -36($fp)
 sw $t4, -40($fp)
 sw $t5, -44($fp)
 sw $t6, -48($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 32($v1)
 jal $v1
 move $a3, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 lw $t2, -32($fp)
 lw $t3, -36($fp)
 lw $t4, -40($fp)
 lw $t5, -44($fp)
 lw $t6, -48($fp)
 # a3: 313(3): Not 312 :boolean
 seq $a3, $zero, $a3
 # a3: 314(3): And 311 313 :boolean
 add $a3, $t0, $a3
 seq $a3, $a3, 2
 # a3: 315(3): NBranch 314 *lif_1628403218_else :void
 beq $a3, $zero, .lif_1628403218_else
 # a3: 316(3): Boolean *true :boolean
 li $a3, 1
 # t2: 317(6): VarAssg 316 *ntb :boolean
 move $t2, $a3
 # a3: 318(3): Goto *lif_1628403218_done :void
 j .lif_1628403218_done
 # a3: 319(3): Label *lif_1628403218_else :void
 .lif_1628403218_else:
 # a3: 320(3): This :Tree
 move $a3, $v0
 # a0: 321(0): Arg 264 *0 :Tree
 move $a0, $t3
 # a1: 322(1): Arg 262 *1 :Tree
 move $a1, $a2
 # a3: 323(3): Call 320 *Remove(321, 322) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 sw $t2, -32($fp)
 sw $t3, -36($fp)
 sw $t4, -40($fp)
 sw $t5, -44($fp)
 sw $t6, -48($fp)
 move $v0, $a3
 lw $v1, ($v0)
 lw $v1, 56($v1)
 jal $v1
 move $a3, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 lw $t2, -32($fp)
 lw $t3, -36($fp)
 lw $t4, -40($fp)
 lw $t5, -44($fp)
 lw $t6, -48($fp)
 # t2: 324(6): VarAssg 323 *ntb :boolean
 move $t2, $a3
 # a3: 325(3): Label *lif_1628403218_done :void
 .lif_1628403218_done:
 # t2: 326(6): Unify 317 324 :boolean
 # a3: 327(3): Goto *lif_1321910319_done :void
 j .lif_1321910319_done
 # a3: 328(3): Label *lif_1321910319_else :void
 .lif_1321910319_else:
 # a3: 329(3): This :Tree
 move $a3, $v0
 # a0: 330(0): Arg 264 *0 :Tree
 move $a0, $t3
 # a1: 331(1): Arg 262 *1 :Tree
 move $a1, $a2
 # a3: 332(3): Call 329 *Remove(330, 331) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 sw $t2, -32($fp)
 sw $t3, -36($fp)
 sw $t4, -40($fp)
 sw $t5, -44($fp)
 sw $t6, -48($fp)
 move $v0, $a3
 lw $v1, ($v0)
 lw $v1, 56($v1)
 jal $v1
 move $a3, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 lw $t2, -32($fp)
 lw $t3, -36($fp)
 lw $t4, -40($fp)
 lw $t5, -44($fp)
 lw $t6, -48($fp)
 # t2: 333(6): VarAssg 332 *ntb :boolean
 move $t2, $a3
 # a3: 334(3): Label *lif_1321910319_done :void
 .lif_1321910319_done:
 # t2: 335(6): Unify 326 333 :boolean
 # a3: 336(3): Boolean *true :boolean
 li $a3, 1
 # a3: 337(3): VarAssg 336 *found :boolean
 # t0: 338(4): Boolean *false :boolean
 move $t0, $zero
 # t0: 339(4): VarAssg 338 *cont :boolean
 # t4: 340(8): Label *lif_1605291845_done :void
 .lif_1605291845_done:
 # t3: 341(7): Unify 304 264 :Tree
 # t2: 342(6): Unify 258 335 :boolean
 # t0: 343(4): Unify 305 339 :boolean
 # a3: 344(3): Unify 268 337 :boolean
 # a2: 345(2): Unify 306 262 :Tree
 # t4: 346(8): Label *lif_394410264_done :void
 .lif_394410264_done:
 # t3: 347(7): Unify 287 341 :Tree
 # t2: 348(6): Unify 258 342 :boolean
 # t0: 349(4): Unify 288 343 :boolean
 # a2: 350(2): Unify 289 345 :Tree
 # a3: 351(3): Unify 268 344 :boolean
 # t4: 352(8): Boolean *false :boolean
 move $t4, $zero
 # t4: 353(8): VarAssg 352 *is_root :boolean
 # t5: 354(9): Goto *lwhile_1981657541_start :void
 j .lwhile_1981657541_start
 # t5: 355(9): Label *lwhile_1981657541_end :void
 .lwhile_1981657541_end:
 # t4: 356(8): Unify 270 353 :boolean
 # t3: 357(7): Unify 264 347 :Tree
 # t2: 358(6): Unify 258 348 :boolean
 # t1: 359(5): Unify 260 274 :int
 # t0: 360(4): Unify 266 349 :boolean
 # a3: 361(3): Unify 268 351 :boolean
 # a2: 362(2): Unify 262 350 :Tree
 # a2: 363(2): Return 361 :void
 move $v0, $a3
 j .ret_mj__m_Tree_Delete
 .ret_mj__m_Tree_Delete:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
mj__m_Tree_Remove:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -36
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 364(0): Parameter *0 :Tree
 # a1: 365(1): Parameter *1 :Tree
 # t1: 366(5): VarAssg 364 *p_node :Tree
 move $t1, $a0
 # t2: 367(6): VarAssg 365 *c_node :Tree
 move $t2, $a1
 # a2: 368(2): Null *Type(boolean) :boolean
 move $a2, $zero
 # a3: 369(3): Null *Type(int) :int
 move $a3, $zero
 # a2: 370(2): Null *Type(int) :int
 move $a2, $zero
 # t0: 371(4): Call 367 *GetHas_Left() :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t1, -28($fp)
 sw $t2, -32($fp)
 move $v0, $t2
 lw $v1, ($v0)
 lw $v1, 32($v1)
 jal $v1
 move $t0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t1, -28($fp)
 lw $t2, -32($fp)
 # t0: 372(4): NBranch 371 *lif_1041287558_else :void
 beq $t0, $zero, .lif_1041287558_else
 # t0: 373(4): This :Tree
 move $t0, $v0
 # a0: 374(0): Arg 366 *0 :Tree
 move $a0, $t1
 # a1: 375(1): Arg 367 *1 :Tree
 move $a1, $t2
 # t0: 376(4): Call 373 *RemoveLeft(374, 375) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t1, -28($fp)
 sw $t2, -32($fp)
 move $v0, $t0
 lw $v1, ($v0)
 lw $v1, 64($v1)
 jal $v1
 move $t0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t1, -28($fp)
 lw $t2, -32($fp)
 # t0: 377(4): VarAssg 376 *ntb :boolean
 # t1: 378(5): Goto *lif_1041287558_done :void
 j .lif_1041287558_done
 # t0: 379(4): Label *lif_1041287558_else :void
 .lif_1041287558_else:
 # t0: 380(4): Call 367 *GetHas_Right() :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t1, -28($fp)
 sw $t2, -32($fp)
 move $v0, $t2
 lw $v1, ($v0)
 lw $v1, 28($v1)
 jal $v1
 move $t0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t1, -28($fp)
 lw $t2, -32($fp)
 # t0: 381(4): NBranch 380 *lif_1075747903_else :void
 beq $t0, $zero, .lif_1075747903_else
 # t0: 382(4): This :Tree
 move $t0, $v0
 # a0: 383(0): Arg 366 *0 :Tree
 move $a0, $t1
 # a1: 384(1): Arg 367 *1 :Tree
 move $a1, $t2
 # t0: 385(4): Call 382 *RemoveRight(383, 384) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t1, -28($fp)
 sw $t2, -32($fp)
 move $v0, $t0
 lw $v1, ($v0)
 lw $v1, 60($v1)
 jal $v1
 move $t0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t1, -28($fp)
 lw $t2, -32($fp)
 # t0: 386(4): VarAssg 385 *ntb :boolean
 # t1: 387(5): Goto *lif_1075747903_done :void
 j .lif_1075747903_done
 # a2: 388(2): Label *lif_1075747903_else :void
 .lif_1075747903_else:
 # a2: 389(2): Call 367 *GetKey() :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a3, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 sw $t2, -32($fp)
 move $v0, $t2
 lw $v1, ($v0)
 lw $v1, 20($v1)
 jal $v1
 move $a2, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a3, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 lw $t2, -32($fp)
 # a3: 390(3): VarAssg 389 *auxkey1 :int
 move $a3, $a2
 # a2: 391(2): Call 366 *GetLeft() :Tree
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a3, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 sw $t2, -32($fp)
 move $v0, $t1
 lw $v1, ($v0)
 lw $v1, 16($v1)
 jal $v1
 move $a2, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a3, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 lw $t2, -32($fp)
 # a2: 392(2): Call 391 *GetKey() :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a3, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 sw $t2, -32($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 20($v1)
 jal $v1
 move $a2, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a3, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 lw $t2, -32($fp)
 # a2: 393(2): VarAssg 392 *auxkey2 :int
 # t0: 394(4): This :Tree
 move $t0, $v0
 # a0: 395(0): Arg 390 *0 :int
 move $a0, $a3
 # a1: 396(1): Arg 393 *1 :int
 move $a1, $a2
 # t0: 397(4): Call 394 *Compare(395, 396) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t1, -28($fp)
 sw $t2, -32($fp)
 move $v0, $t0
 lw $v1, ($v0)
 lw $v1, 44($v1)
 jal $v1
 move $t0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t1, -28($fp)
 lw $t2, -32($fp)
 # t0: 398(4): NBranch 397 *lif_430181628_else :void
 beq $t0, $zero, .lif_430181628_else
 # t0: 399(4): This :Tree
 move $t0, $v0
 # t0: 400(4): Member 399 *my_null :Tree
 lw $t0, 24($t0)
 # a0: 401(0): Arg 400 *0 :Tree
 move $a0, $t0
 # t0: 402(4): Call 366 *SetLeft(401) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t1, -28($fp)
 sw $t2, -32($fp)
 move $v0, $t1
 lw $v1, ($v0)
 lw $v1, 8($v1)
 jal $v1
 move $t0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t1, -28($fp)
 lw $t2, -32($fp)
 # t0: 403(4): VarAssg 402 *ntb :boolean
 # t0: 404(4): Boolean *false :boolean
 move $t0, $zero
 # a0: 405(0): Arg 404 *0 :boolean
 move $a0, $t0
 # t0: 406(4): Call 366 *SetHas_Left(405) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t1, -28($fp)
 sw $t2, -32($fp)
 move $v0, $t1
 lw $v1, ($v0)
 lw $v1, 36($v1)
 jal $v1
 move $t0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t1, -28($fp)
 lw $t2, -32($fp)
 # t0: 407(4): VarAssg 406 *ntb :boolean
 # t1: 408(5): Goto *lif_430181628_done :void
 j .lif_430181628_done
 # t0: 409(4): Label *lif_430181628_else :void
 .lif_430181628_else:
 # t0: 410(4): This :Tree
 move $t0, $v0
 # t0: 411(4): Member 410 *my_null :Tree
 lw $t0, 24($t0)
 # a0: 412(0): Arg 411 *0 :Tree
 move $a0, $t0
 # t0: 413(4): Call 366 *SetRight(412) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t1, -28($fp)
 sw $t2, -32($fp)
 move $v0, $t1
 lw $v1, ($v0)
 lw $v1, 4($v1)
 jal $v1
 move $t0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t1, -28($fp)
 lw $t2, -32($fp)
 # t0: 414(4): VarAssg 413 *ntb :boolean
 # t0: 415(4): Boolean *false :boolean
 move $t0, $zero
 # a0: 416(0): Arg 415 *0 :boolean
 move $a0, $t0
 # t0: 417(4): Call 366 *SetHas_Right(416) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t1, -28($fp)
 sw $t2, -32($fp)
 move $v0, $t1
 lw $v1, ($v0)
 lw $v1, 40($v1)
 jal $v1
 move $t0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t1, -28($fp)
 lw $t2, -32($fp)
 # t0: 418(4): VarAssg 417 *ntb :boolean
 # t1: 419(5): Label *lif_430181628_done :void
 .lif_430181628_done:
 # t0: 420(4): Unify 407 418 :boolean
 # t1: 421(5): Label *lif_1075747903_done :void
 .lif_1075747903_done:
 # a3: 422(3): Unify 369 390 :int
 # a2: 423(2): Unify 370 393 :int
 # t0: 424(4): Unify 386 420 :boolean
 # t1: 425(5): Label *lif_1041287558_done :void
 .lif_1041287558_done:
 # t0: 426(4): Unify 377 424 :boolean
 # a3: 427(3): Unify 369 422 :int
 # a2: 428(2): Unify 370 423 :int
 # a2: 429(2): Boolean *true :boolean
 li $a2, 1
 # a2: 430(2): Return 429 :void
 move $v0, $a2
 j .ret_mj__m_Tree_Remove
 .ret_mj__m_Tree_Remove:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
mj__m_Tree_RemoveRight:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -32
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 431(0): Parameter *0 :Tree
 # a1: 432(1): Parameter *1 :Tree
 # a3: 433(3): VarAssg 431 *p_node :Tree
 move $a3, $a0
 # a2: 434(2): VarAssg 432 *c_node :Tree
 move $a2, $a1
 # t0: 435(4): Null *Type(boolean) :boolean
 move $t0, $zero
 # t1: 436(5): Label *lwhile_1632665994_start :void
 .lwhile_1632665994_start:
 # t1: 437(5): Call 434 *GetHas_Right() :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t0, -28($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 28($v1)
 jal $v1
 move $t1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t0, -28($fp)
 # t1: 438(5): NBranch 437 *lwhile_1632665994_end :void
 beq $t1, $zero, .lwhile_1632665994_end
 # a3: 439(3): Call 434 *GetRight() :Tree
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 12($v1)
 jal $v1
 move $a3, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 # a3: 440(3): Call 439 *GetKey() :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 move $v0, $a3
 lw $v1, ($v0)
 lw $v1, 20($v1)
 jal $v1
 move $a3, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 # a0: 441(0): Arg 440 *0 :int
 move $a0, $a3
 # a3: 442(3): Call 434 *SetKey(441) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 24($v1)
 jal $v1
 move $a3, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 # t0: 443(4): VarAssg 442 *ntb :boolean
 move $t0, $a3
 # a3: 444(3): VarAssg 434 *p_node :Tree
 move $a3, $a2
 # a2: 445(2): Call 434 *GetRight() :Tree
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a3, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 12($v1)
 jal $v1
 move $a2, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a3, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 # a2: 446(2): VarAssg 445 *c_node :Tree
 # t1: 447(5): Goto *lwhile_1632665994_start :void
 j .lwhile_1632665994_start
 # t1: 448(5): Label *lwhile_1632665994_end :void
 .lwhile_1632665994_end:
 # t0: 449(4): Unify 435 443 :boolean
 # a3: 450(3): Unify 433 444 :Tree
 # a2: 451(2): Unify 434 446 :Tree
 # a2: 452(2): This :Tree
 move $a2, $v0
 # a2: 453(2): Member 452 *my_null :Tree
 lw $a2, 24($a2)
 # a0: 454(0): Arg 453 *0 :Tree
 move $a0, $a2
 # a2: 455(2): Call 450 *SetRight(454) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a3, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 move $v0, $a3
 lw $v1, ($v0)
 lw $v1, 4($v1)
 jal $v1
 move $a2, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a3, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 # a2: 456(2): VarAssg 455 *ntb :boolean
 # a2: 457(2): Boolean *false :boolean
 move $a2, $zero
 # a0: 458(0): Arg 457 *0 :boolean
 move $a0, $a2
 # a2: 459(2): Call 450 *SetHas_Right(458) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a3, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 move $v0, $a3
 lw $v1, ($v0)
 lw $v1, 40($v1)
 jal $v1
 move $a2, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a3, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 # a2: 460(2): VarAssg 459 *ntb :boolean
 # a2: 461(2): Boolean *true :boolean
 li $a2, 1
 # a2: 462(2): Return 461 :void
 move $v0, $a2
 j .ret_mj__m_Tree_RemoveRight
 .ret_mj__m_Tree_RemoveRight:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
mj__m_Tree_RemoveLeft:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -32
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 463(0): Parameter *0 :Tree
 # a1: 464(1): Parameter *1 :Tree
 # a3: 465(3): VarAssg 463 *p_node :Tree
 move $a3, $a0
 # a2: 466(2): VarAssg 464 *c_node :Tree
 move $a2, $a1
 # t0: 467(4): Null *Type(boolean) :boolean
 move $t0, $zero
 # t1: 468(5): Label *lwhile_1818803439_start :void
 .lwhile_1818803439_start:
 # t1: 469(5): Call 466 *GetHas_Left() :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t0, -28($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 32($v1)
 jal $v1
 move $t1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t0, -28($fp)
 # t1: 470(5): NBranch 469 *lwhile_1818803439_end :void
 beq $t1, $zero, .lwhile_1818803439_end
 # a3: 471(3): Call 466 *GetLeft() :Tree
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 16($v1)
 jal $v1
 move $a3, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 # a3: 472(3): Call 471 *GetKey() :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 move $v0, $a3
 lw $v1, ($v0)
 lw $v1, 20($v1)
 jal $v1
 move $a3, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 # a0: 473(0): Arg 472 *0 :int
 move $a0, $a3
 # a3: 474(3): Call 466 *SetKey(473) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 24($v1)
 jal $v1
 move $a3, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 # t0: 475(4): VarAssg 474 *ntb :boolean
 move $t0, $a3
 # a3: 476(3): VarAssg 466 *p_node :Tree
 move $a3, $a2
 # a2: 477(2): Call 466 *GetLeft() :Tree
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a3, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 16($v1)
 jal $v1
 move $a2, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a3, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 # a2: 478(2): VarAssg 477 *c_node :Tree
 # t1: 479(5): Goto *lwhile_1818803439_start :void
 j .lwhile_1818803439_start
 # t1: 480(5): Label *lwhile_1818803439_end :void
 .lwhile_1818803439_end:
 # t0: 481(4): Unify 467 475 :boolean
 # a3: 482(3): Unify 465 476 :Tree
 # a2: 483(2): Unify 466 478 :Tree
 # a2: 484(2): This :Tree
 move $a2, $v0
 # a2: 485(2): Member 484 *my_null :Tree
 lw $a2, 24($a2)
 # a0: 486(0): Arg 485 *0 :Tree
 move $a0, $a2
 # a2: 487(2): Call 482 *SetLeft(486) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a3, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 move $v0, $a3
 lw $v1, ($v0)
 lw $v1, 8($v1)
 jal $v1
 move $a2, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a3, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 # a2: 488(2): VarAssg 487 *ntb :boolean
 # a2: 489(2): Boolean *false :boolean
 move $a2, $zero
 # a0: 490(0): Arg 489 *0 :boolean
 move $a0, $a2
 # a2: 491(2): Call 482 *SetHas_Left(490) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a3, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 move $v0, $a3
 lw $v1, ($v0)
 lw $v1, 36($v1)
 jal $v1
 move $a2, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a3, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 # a2: 492(2): VarAssg 491 *ntb :boolean
 # a2: 493(2): Boolean *true :boolean
 li $a2, 1
 # a2: 494(2): Return 493 :void
 move $v0, $a2
 j .ret_mj__m_Tree_RemoveLeft
 .ret_mj__m_Tree_RemoveLeft:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
mj__m_Tree_Search:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -36
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 495(0): Parameter *0 :int
 # t2: 496(6): VarAssg 495 *v_key :int
 move $t2, $a0
 # a1: 497(1): Null *Type(Tree) :Tree
 move $a1, $zero
 # a1: 498(1): Null *Type(int) :int
 move $a1, $zero
 # a1: 499(1): Null *Type(boolean) :boolean
 move $a1, $zero
 # a3: 500(3): Null *Type(int) :int
 move $a3, $zero
 # a1: 501(1): This :Tree
 move $a1, $v0
 # a1: 502(1): VarAssg 501 *current_node :Tree
 # a2: 503(2): Boolean *true :boolean
 li $a2, 1
 # a2: 504(2): VarAssg 503 *cont :boolean
 # t0: 505(4): Int *0 :int
 li $t0, 0
 # t0: 506(4): VarAssg 505 *ifound :int
 # t1: 507(5): Label *lwhile_1347167875_start :void
 .lwhile_1347167875_start:
 # t1: 508(5): NBranch 504 *lwhile_1347167875_end :void
 beq $a2, $zero, .lwhile_1347167875_end
 # a3: 509(3): Call 502 *GetKey() :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 sw $t2, -32($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 20($v1)
 jal $v1
 move $a3, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 lw $t2, -32($fp)
 # a3: 510(3): VarAssg 509 *key_aux :int
 # t1: 511(5): Lt 496 510 :boolean
 slt $t1, $t2, $a3 # t1: 512(5): NBranch 511 *lif_930384804_else :void
 beq $t1, $zero, .lif_930384804_else
 # t1: 513(5): Call 502 *GetHas_Left() :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t0, -28($fp)
 sw $t2, -32($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 32($v1)
 jal $v1
 move $t1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t0, -28($fp)
 lw $t2, -32($fp)
 # t1: 514(5): NBranch 513 *lif_1148967021_else :void
 beq $t1, $zero, .lif_1148967021_else
 # a1: 515(1): Call 502 *GetLeft() :Tree
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 sw $t2, -32($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 16($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 lw $t2, -32($fp)
 # a1: 516(1): VarAssg 515 *current_node :Tree
 # t1: 517(5): Goto *lif_1148967021_done :void
 j .lif_1148967021_done
 # a2: 518(2): Label *lif_1148967021_else :void
 .lif_1148967021_else:
 # a2: 519(2): Boolean *false :boolean
 move $a2, $zero
 # a2: 520(2): VarAssg 519 *cont :boolean
 # t1: 521(5): Label *lif_1148967021_done :void
 .lif_1148967021_done:
 # a2: 522(2): Unify 504 520 :boolean
 # a1: 523(1): Unify 516 502 :Tree
 # t1: 524(5): Goto *lif_930384804_done :void
 j .lif_930384804_done
 # t1: 525(5): Label *lif_930384804_else :void
 .lif_930384804_else:
 # t1: 526(5): Lt 510 496 :boolean
 slt $t1, $a3, $t2 # t1: 527(5): NBranch 526 *lif_515768123_else :void
 beq $t1, $zero, .lif_515768123_else
 # t1: 528(5): Call 502 *GetHas_Right() :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 sw $a3, -24($fp)
 sw $t0, -28($fp)
 sw $t2, -32($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 28($v1)
 jal $v1
 move $t1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 lw $a3, -24($fp)
 lw $t0, -28($fp)
 lw $t2, -32($fp)
 # t1: 529(5): NBranch 528 *lif_1270843969_else :void
 beq $t1, $zero, .lif_1270843969_else
 # a1: 530(1): Call 502 *GetRight() :Tree
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 sw $t2, -32($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 12($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 lw $t2, -32($fp)
 # a1: 531(1): VarAssg 530 *current_node :Tree
 # t1: 532(5): Goto *lif_1270843969_done :void
 j .lif_1270843969_done
 # a2: 533(2): Label *lif_1270843969_else :void
 .lif_1270843969_else:
 # a2: 534(2): Boolean *false :boolean
 move $a2, $zero
 # a2: 535(2): VarAssg 534 *cont :boolean
 # t1: 536(5): Label *lif_1270843969_done :void
 .lif_1270843969_done:
 # a2: 537(2): Unify 504 535 :boolean
 # a1: 538(1): Unify 531 502 :Tree
 # t1: 539(5): Goto *lif_515768123_done :void
 j .lif_515768123_done
 # a2: 540(2): Label *lif_515768123_else :void
 .lif_515768123_else:
 # a2: 541(2): Int *1 :int
 li $a2, 1
 # t0: 542(4): VarAssg 541 *ifound :int
 move $t0, $a2
 # a2: 543(2): Boolean *false :boolean
 move $a2, $zero
 # a2: 544(2): VarAssg 543 *cont :boolean
 # t1: 545(5): Label *lif_515768123_done :void
 .lif_515768123_done:
 # a2: 546(2): Unify 537 544 :boolean
 # t0: 547(4): Unify 506 542 :int
 # a1: 548(1): Unify 538 502 :Tree
 # t1: 549(5): Label *lif_930384804_done :void
 .lif_930384804_done:
 # a2: 550(2): Unify 522 546 :boolean
 # t0: 551(4): Unify 506 547 :int
 # a1: 552(1): Unify 523 548 :Tree
 # t1: 553(5): Goto *lwhile_1347167875_start :void
 j .lwhile_1347167875_start
 # t1: 554(5): Label *lwhile_1347167875_end :void
 .lwhile_1347167875_end:
 # t0: 555(4): Unify 506 551 :int
 # a3: 556(3): Unify 500 510 :int
 # a2: 557(2): Unify 504 550 :boolean
 # a1: 558(1): Unify 502 552 :Tree
 # a1: 559(1): Return 555 :void
 move $v0, $t0
 j .ret_mj__m_Tree_Search
 .ret_mj__m_Tree_Search:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
mj__m_Tree_Print:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -20
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a1: 560(1): Null *Type(boolean) :boolean
 move $a1, $zero
 # a1: 561(1): Null *Type(Tree) :Tree
 move $a1, $zero
 # a1: 562(1): This :Tree
 move $a1, $v0
 # a2: 563(2): VarAssg 562 *current_node :Tree
 move $a2, $a1
 # a1: 564(1): This :Tree
 move $a1, $v0
 # a0: 565(0): Arg 563 *0 :Tree
 move $a0, $a2
 # a1: 566(1): Call 564 *RecPrint(565) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 76($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 # a1: 567(1): VarAssg 566 *ntb :boolean
 # a1: 568(1): Boolean *true :boolean
 li $a1, 1
 # a1: 569(1): Return 568 :void
 move $v0, $a1
 j .ret_mj__m_Tree_Print
 .ret_mj__m_Tree_Print:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
mj__m_Tree_RecPrint:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -24
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 570(0): Parameter *0 :Tree
 # a3: 571(3): VarAssg 570 *node :Tree
 move $a3, $a0
 # a1: 572(1): Null *Type(boolean) :boolean
 move $a1, $zero
 # a1: 573(1): Call 571 *GetHas_Left() :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a3
 lw $v1, ($v0)
 lw $v1, 32($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 574(1): NBranch 573 *lif_202233921_else :void
 beq $a1, $zero, .lif_202233921_else
 # a2: 575(2): This :Tree
 move $a2, $v0
 # a1: 576(1): Call 571 *GetLeft() :Tree
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a3
 lw $v1, ($v0)
 lw $v1, 16($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a0: 577(0): Arg 576 *0 :Tree
 move $a0, $a1
 # a1: 578(1): Call 575 *RecPrint(577) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 76($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 579(1): VarAssg 578 *ntb :boolean
 # a2: 580(2): Goto *lif_202233921_done :void
 j .lif_202233921_done
 # a1: 581(1): Label *lif_202233921_else :void
 .lif_202233921_else:
 # a1: 582(1): Boolean *true :boolean
 li $a1, 1
 # a1: 583(1): VarAssg 582 *ntb :boolean
 # a2: 584(2): Label *lif_202233921_done :void
 .lif_202233921_done:
 # a1: 585(1): Unify 579 583 :boolean
 # a1: 586(1): Call 571 *GetKey() :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a3
 lw $v1, ($v0)
 lw $v1, 20($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 587(1): Print 586 :void
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
 # a1: 588(1): Call 571 *GetHas_Right() :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a3
 lw $v1, ($v0)
 lw $v1, 28($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 589(1): NBranch 588 *lif_1626380693_else :void
 beq $a1, $zero, .lif_1626380693_else
 # a2: 590(2): This :Tree
 move $a2, $v0
 # a1: 591(1): Call 571 *GetRight() :Tree
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a3
 lw $v1, ($v0)
 lw $v1, 12($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a0: 592(0): Arg 591 *0 :Tree
 move $a0, $a1
 # a1: 593(1): Call 590 *RecPrint(592) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 76($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 594(1): VarAssg 593 *ntb :boolean
 # a2: 595(2): Goto *lif_1626380693_done :void
 j .lif_1626380693_done
 # a1: 596(1): Label *lif_1626380693_else :void
 .lif_1626380693_else:
 # a1: 597(1): Boolean *true :boolean
 li $a1, 1
 # a1: 598(1): VarAssg 597 *ntb :boolean
 # a2: 599(2): Label *lif_1626380693_done :void
 .lif_1626380693_done:
 # a1: 600(1): Unify 594 598 :boolean
 # a1: 601(1): Boolean *true :boolean
 li $a1, 1
 # a1: 602(1): Return 601 :void
 move $v0, $a1
 j .ret_mj__m_Tree_RecPrint
 .ret_mj__m_Tree_RecPrint:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
mj__m_Tree_accept:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -20
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 603(0): Parameter *0 :Visitor
 # a2: 604(2): VarAssg 603 *v :Visitor
 move $a2, $a0
 # a1: 605(1): Null *Type(int) :int
 move $a1, $zero
 # a1: 606(1): Int *333 :int
 li $a1, 333
 # a1: 607(1): Print 606 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 move $a0, $a1
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 # a1: 608(1): This :Tree
 move $a1, $v0
 # a0: 609(0): Arg 608 *0 :Tree
 move $a0, $a1
 # a1: 610(1): Call 604 *visit(609) :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 0($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 # a1: 611(1): VarAssg 610 *nti :int
 # a1: 612(1): Int *0 :int
 li $a1, 0
 # a1: 613(1): Return 612 :void
 move $v0, $a1
 j .ret_mj__m_Tree_accept
 .ret_mj__m_Tree_accept:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
.data
.align 4
mj__v_Visitor:
 .word mj__m_Visitor_visit
.text
mj__m_Visitor_visit:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -24
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 614(0): Parameter *0 :Tree
 # a3: 615(3): VarAssg 614 *n :Tree
 move $a3, $a0
 # a1: 616(1): Null *Type(int) :int
 move $a1, $zero
 # a1: 617(1): Call 615 *GetHas_Right() :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a3
 lw $v1, ($v0)
 lw $v1, 28($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 618(1): NBranch 617 *lif_863719801_else :void
 beq $a1, $zero, .lif_863719801_else
 # a2: 619(2): This :Visitor
 move $a2, $v0
 # a1: 620(1): Call 615 *GetRight() :Tree
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a3
 lw $v1, ($v0)
 lw $v1, 12($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 621(1): MemberAssg 619 620 *r :Tree
 sw $a1, 8($a2)
 # a1: 622(1): This :Visitor
 move $a1, $v0
 # a2: 623(2): Member 622 *r :Tree
 lw $a2, 8($a1)
 # a1: 624(1): This :Visitor
 move $a1, $v0
 # a0: 625(0): Arg 624 *0 :Visitor
 move $a0, $a1
 # a1: 626(1): Call 623 *accept(625) :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 80($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 627(1): VarAssg 626 *nti :int
 # a2: 628(2): Goto *lif_863719801_done :void
 j .lif_863719801_done
 # a1: 629(1): Label *lif_863719801_else :void
 .lif_863719801_else:
 # a1: 630(1): Int *0 :int
 li $a1, 0
 # a1: 631(1): VarAssg 630 *nti :int
 # a2: 632(2): Label *lif_863719801_done :void
 .lif_863719801_done:
 # a1: 633(1): Unify 627 631 :int
 # a1: 634(1): Call 615 *GetHas_Left() :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a3
 lw $v1, ($v0)
 lw $v1, 32($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 635(1): NBranch 634 *lif_1696725334_else :void
 beq $a1, $zero, .lif_1696725334_else
 # a2: 636(2): This :Visitor
 move $a2, $v0
 # a1: 637(1): Call 615 *GetLeft() :Tree
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a3
 lw $v1, ($v0)
 lw $v1, 16($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 638(1): MemberAssg 636 637 *l :Tree
 sw $a1, 4($a2)
 # a1: 639(1): This :Visitor
 move $a1, $v0
 # a2: 640(2): Member 639 *l :Tree
 lw $a2, 4($a1)
 # a1: 641(1): This :Visitor
 move $a1, $v0
 # a0: 642(0): Arg 641 *0 :Visitor
 move $a0, $a1
 # a1: 643(1): Call 640 *accept(642) :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 80($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 644(1): VarAssg 643 *nti :int
 # a2: 645(2): Goto *lif_1696725334_done :void
 j .lif_1696725334_done
 # a1: 646(1): Label *lif_1696725334_else :void
 .lif_1696725334_else:
 # a1: 647(1): Int *0 :int
 li $a1, 0
 # a1: 648(1): VarAssg 647 *nti :int
 # a2: 649(2): Label *lif_1696725334_done :void
 .lif_1696725334_done:
 # a1: 650(1): Unify 644 648 :int
 # a1: 651(1): Int *0 :int
 li $a1, 0
 # a1: 652(1): Return 651 :void
 move $v0, $a1
 j .ret_mj__m_Visitor_visit
 .ret_mj__m_Visitor_visit:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
.data
.align 4
mj__v_MyVisitor:
 .word mj__m_MyVisitor_visit
.text
mj__m_MyVisitor_visit:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -24
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 653(0): Parameter *0 :Tree
 # a3: 654(3): VarAssg 653 *n :Tree
 move $a3, $a0
 # a1: 655(1): Null *Type(int) :int
 move $a1, $zero
 # a1: 656(1): Call 654 *GetHas_Right() :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a3
 lw $v1, ($v0)
 lw $v1, 28($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 657(1): NBranch 656 *lif_427340025_else :void
 beq $a1, $zero, .lif_427340025_else
 # a2: 658(2): This :MyVisitor
 move $a2, $v0
 # a1: 659(1): Call 654 *GetRight() :Tree
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a3
 lw $v1, ($v0)
 lw $v1, 12($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 660(1): MemberAssg 658 659 *r :Tree
 sw $a1, 8($a2)
 # a1: 661(1): This :MyVisitor
 move $a1, $v0
 # a2: 662(2): Member 661 *r :Tree
 lw $a2, 8($a1)
 # a1: 663(1): This :MyVisitor
 move $a1, $v0
 # a0: 664(0): Arg 663 *0 :MyVisitor
 move $a0, $a1
 # a1: 665(1): Call 662 *accept(664) :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 80($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 666(1): VarAssg 665 *nti :int
 # a2: 667(2): Goto *lif_427340025_done :void
 j .lif_427340025_done
 # a1: 668(1): Label *lif_427340025_else :void
 .lif_427340025_else:
 # a1: 669(1): Int *0 :int
 li $a1, 0
 # a1: 670(1): VarAssg 669 *nti :int
 # a2: 671(2): Label *lif_427340025_done :void
 .lif_427340025_done:
 # a1: 672(1): Unify 666 670 :int
 # a1: 673(1): Call 654 *GetKey() :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a3
 lw $v1, ($v0)
 lw $v1, 20($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 674(1): Print 673 :void
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
 # a1: 675(1): Call 654 *GetHas_Left() :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a3
 lw $v1, ($v0)
 lw $v1, 32($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 676(1): NBranch 675 *lif_1118484607_else :void
 beq $a1, $zero, .lif_1118484607_else
 # a2: 677(2): This :MyVisitor
 move $a2, $v0
 # a1: 678(1): Call 654 *GetLeft() :Tree
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a3
 lw $v1, ($v0)
 lw $v1, 16($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 679(1): MemberAssg 677 678 *l :Tree
 sw $a1, 4($a2)
 # a1: 680(1): This :MyVisitor
 move $a1, $v0
 # a2: 681(2): Member 680 *l :Tree
 lw $a2, 4($a1)
 # a1: 682(1): This :MyVisitor
 move $a1, $v0
 # a0: 683(0): Arg 682 *0 :MyVisitor
 move $a0, $a1
 # a1: 684(1): Call 681 *accept(683) :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 80($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 685(1): VarAssg 684 *nti :int
 # a2: 686(2): Goto *lif_1118484607_done :void
 j .lif_1118484607_done
 # a1: 687(1): Label *lif_1118484607_else :void
 .lif_1118484607_else:
 # a1: 688(1): Int *0 :int
 li $a1, 0
 # a1: 689(1): VarAssg 688 *nti :int
 # a2: 690(2): Label *lif_1118484607_done :void
 .lif_1118484607_done:
 # a1: 691(1): Unify 685 689 :int
 # a1: 692(1): Int *0 :int
 li $a1, 0
 # a1: 693(1): Return 692 :void
 move $v0, $a1
 j .ret_mj__m_MyVisitor_visit
 .ret_mj__m_MyVisitor_visit:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra

