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
 # a1: 0(1): NewObj *BS :BS
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 la $a0, mj__v_BS
 li $a1, 3
 jal minijavaNew
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 # a0: 1(0): Int *20 :int
 li $a0, 20
 # a0: 2(0): Arg 1 *0 :int
 # a0: 3(0): Call 0 *Start(2) :int
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
mj__v_BS:
 .word mj__m_BS_Start
 .word mj__m_BS_Search
 .word mj__m_BS_Div
 .word mj__m_BS_Compare
 .word mj__m_BS_Print
 .word mj__m_BS_Init
.text
mj__m_BS_Start:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -20
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 5(0): Parameter *0 :int
 # a2: 6(2): VarAssg 5 *sz :int
 move $a2, $a0
 # a0: 7(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 8(0): Null *Type(int) :int
 move $a0, $zero
 # a1: 9(1): This :BS
 move $a1, $v0
 # a0: 10(0): Arg 6 *0 :int
 move $a0, $a2
 # a0: 11(0): Call 9 *Init(10) :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 sw $a2, -16($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 20($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 lw $a2, -16($fp)
 # a0: 12(0): VarAssg 11 *aux01 :int
 # a0: 13(0): This :BS
 move $a0, $v0
 # a0: 14(0): Call 13 *Print() :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 sw $a2, -16($fp)
 move $v0, $a0
 lw $v1, ($v0)
 lw $v1, 16($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 lw $a2, -16($fp)
 # a0: 15(0): VarAssg 14 *aux02 :int
 # a1: 16(1): This :BS
 move $a1, $v0
 # a0: 17(0): Int *8 :int
 li $a0, 8
 # a0: 18(0): Arg 17 *0 :int
 # a0: 19(0): Call 16 *Search(18) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 sw $a2, -16($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 4($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 lw $a2, -16($fp)
 # a0: 20(0): NBranch 19 *lif_0_else :void
 beq $a0, $zero, .lif_0_else
 # a0: 21(0): Int *1 :int
 li $a0, 1
 # a0: 22(0): Print 21 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 # a0: 23(0): Goto *lif_0_done :void
 j .lif_0_done
 # a0: 24(0): Label *lif_0_else :void
 .lif_0_else:
 # a0: 25(0): Int *0 :int
 li $a0, 0
 # a0: 26(0): Print 25 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 # a0: 27(0): Label *lif_0_done :void
 .lif_0_done:
 # a1: 28(1): This :BS
 move $a1, $v0
 # a0: 29(0): Int *19 :int
 li $a0, 19
 # a0: 30(0): Arg 29 *0 :int
 # a0: 31(0): Call 28 *Search(30) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 sw $a2, -16($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 4($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 lw $a2, -16($fp)
 # a0: 32(0): NBranch 31 *lif_1_else :void
 beq $a0, $zero, .lif_1_else
 # a0: 33(0): Int *1 :int
 li $a0, 1
 # a0: 34(0): Print 33 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 # a0: 35(0): Goto *lif_1_done :void
 j .lif_1_done
 # a0: 36(0): Label *lif_1_else :void
 .lif_1_else:
 # a0: 37(0): Int *0 :int
 li $a0, 0
 # a0: 38(0): Print 37 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 # a0: 39(0): Label *lif_1_done :void
 .lif_1_done:
 # a1: 40(1): This :BS
 move $a1, $v0
 # a0: 41(0): Int *20 :int
 li $a0, 20
 # a0: 42(0): Arg 41 *0 :int
 # a0: 43(0): Call 40 *Search(42) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 sw $a2, -16($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 4($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 lw $a2, -16($fp)
 # a0: 44(0): NBranch 43 *lif_2_else :void
 beq $a0, $zero, .lif_2_else
 # a0: 45(0): Int *1 :int
 li $a0, 1
 # a0: 46(0): Print 45 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 # a0: 47(0): Goto *lif_2_done :void
 j .lif_2_done
 # a0: 48(0): Label *lif_2_else :void
 .lif_2_else:
 # a0: 49(0): Int *0 :int
 li $a0, 0
 # a0: 50(0): Print 49 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 # a0: 51(0): Label *lif_2_done :void
 .lif_2_done:
 # a1: 52(1): This :BS
 move $a1, $v0
 # a0: 53(0): Int *21 :int
 li $a0, 21
 # a0: 54(0): Arg 53 *0 :int
 # a0: 55(0): Call 52 *Search(54) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 sw $a2, -16($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 4($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 lw $a2, -16($fp)
 # a0: 56(0): NBranch 55 *lif_3_else :void
 beq $a0, $zero, .lif_3_else
 # a0: 57(0): Int *1 :int
 li $a0, 1
 # a0: 58(0): Print 57 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 # a0: 59(0): Goto *lif_3_done :void
 j .lif_3_done
 # a0: 60(0): Label *lif_3_else :void
 .lif_3_else:
 # a0: 61(0): Int *0 :int
 li $a0, 0
 # a0: 62(0): Print 61 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 # a0: 63(0): Label *lif_3_done :void
 .lif_3_done:
 # a1: 64(1): This :BS
 move $a1, $v0
 # a0: 65(0): Int *37 :int
 li $a0, 37
 # a0: 66(0): Arg 65 *0 :int
 # a0: 67(0): Call 64 *Search(66) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 sw $a2, -16($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 4($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 lw $a2, -16($fp)
 # a0: 68(0): NBranch 67 *lif_4_else :void
 beq $a0, $zero, .lif_4_else
 # a0: 69(0): Int *1 :int
 li $a0, 1
 # a0: 70(0): Print 69 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 # a0: 71(0): Goto *lif_4_done :void
 j .lif_4_done
 # a0: 72(0): Label *lif_4_else :void
 .lif_4_else:
 # a0: 73(0): Int *0 :int
 li $a0, 0
 # a0: 74(0): Print 73 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 # a0: 75(0): Label *lif_4_done :void
 .lif_4_done:
 # a1: 76(1): This :BS
 move $a1, $v0
 # a0: 77(0): Int *38 :int
 li $a0, 38
 # a0: 78(0): Arg 77 *0 :int
 # a0: 79(0): Call 76 *Search(78) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 sw $a2, -16($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 4($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 lw $a2, -16($fp)
 # a0: 80(0): NBranch 79 *lif_5_else :void
 beq $a0, $zero, .lif_5_else
 # a0: 81(0): Int *1 :int
 li $a0, 1
 # a0: 82(0): Print 81 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 # a0: 83(0): Goto *lif_5_done :void
 j .lif_5_done
 # a0: 84(0): Label *lif_5_else :void
 .lif_5_else:
 # a0: 85(0): Int *0 :int
 li $a0, 0
 # a0: 86(0): Print 85 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 # a0: 87(0): Label *lif_5_done :void
 .lif_5_done:
 # a1: 88(1): This :BS
 move $a1, $v0
 # a0: 89(0): Int *39 :int
 li $a0, 39
 # a0: 90(0): Arg 89 *0 :int
 # a0: 91(0): Call 88 *Search(90) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 sw $a2, -16($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 4($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 lw $a2, -16($fp)
 # a0: 92(0): NBranch 91 *lif_6_else :void
 beq $a0, $zero, .lif_6_else
 # a0: 93(0): Int *1 :int
 li $a0, 1
 # a0: 94(0): Print 93 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 # a0: 95(0): Goto *lif_6_done :void
 j .lif_6_done
 # a0: 96(0): Label *lif_6_else :void
 .lif_6_else:
 # a0: 97(0): Int *0 :int
 li $a0, 0
 # a0: 98(0): Print 97 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 # a0: 99(0): Label *lif_6_done :void
 .lif_6_done:
 # a1: 100(1): This :BS
 move $a1, $v0
 # a0: 101(0): Int *50 :int
 li $a0, 50
 # a0: 102(0): Arg 101 *0 :int
 # a0: 103(0): Call 100 *Search(102) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 sw $a2, -16($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 4($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 lw $a2, -16($fp)
 # a0: 104(0): NBranch 103 *lif_7_else :void
 beq $a0, $zero, .lif_7_else
 # a0: 105(0): Int *1 :int
 li $a0, 1
 # a0: 106(0): Print 105 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 # a0: 107(0): Goto *lif_7_done :void
 j .lif_7_done
 # a0: 108(0): Label *lif_7_else :void
 .lif_7_else:
 # a0: 109(0): Int *0 :int
 li $a0, 0
 # a0: 110(0): Print 109 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 sw $a2, -20($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 lw $a2, -20($fp)
 # a0: 111(0): Label *lif_7_done :void
 .lif_7_done:
 # a0: 112(0): Int *999 :int
 li $a0, 999
 # a0: 113(0): Return 112 :void
 move $v0, $a0
 j .ret_mj__m_BS_Start
 .ret_mj__m_BS_Start:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
mj__m_BS_Search:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -44
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 114(0): Parameter *0 :int
 # a3: 115(3): VarAssg 114 *num :int
 move $a3, $a0
 # a0: 116(0): Null *Type(boolean) :boolean
 move $a0, $zero
 # a0: 117(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 118(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 119(0): Null *Type(boolean) :boolean
 move $a0, $zero
 # t2: 120(6): Null *Type(int) :int
 move $t2, $zero
 # a0: 121(0): Null *Type(int) :int
 move $a0, $zero
 # t1: 122(5): Null *Type(int) :int
 move $t1, $zero
 # a0: 123(0): Int *0 :int
 li $a0, 0
 # a2: 124(2): VarAssg 123 *aux01 :int
 move $a2, $a0
 # a0: 125(0): Boolean *false :boolean
 move $a0, $zero
 # a1: 126(1): VarAssg 125 *bs01 :boolean
 move $a1, $a0
 # a0: 127(0): This :BS
 move $a0, $v0
 # a0: 128(0): Member 127 *number :int[]
 lw $a0, 4($a0)
 # a0: 129(0): Member 128 *length :int
 lw $a0, ($a0)
 # a0: 130(0): VarAssg 129 *right :int
 # a1: 131(1): Int *1 :int
 li $a1, 1
 # a0: 132(0): Minus 130 131 :int
 sub $a0, $a0, $a1
 # t3: 133(7): VarAssg 132 *right :int
 move $t3, $a0
 # a0: 134(0): Int *0 :int
 li $a0, 0
 # t0: 135(4): VarAssg 134 *left :int
 move $t0, $a0
 # a0: 136(0): Boolean *true :boolean
 li $a0, 1
 # a1: 137(1): VarAssg 136 *var_cont :boolean
 move $a1, $a0
 # a0: 138(0): Label *lwhile_8_start :void
 .lwhile_8_start:
 # a0: 139(0): NBranch 137 *lwhile_8_done :void
 beq $a1, $zero, .lwhile_8_done
 # a0: 140(0): Plus 135 133 :int
 add $a0, $t0, $t3
 # a0: 141(0): VarAssg 140 *medium :int
 # a1: 142(1): This :BS
 move $a1, $v0
 # a0: 143(0): Arg 141 *0 :int
 # a0: 144(0): Call 142 *Div(143) :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 sw $t2, -32($fp)
 sw $t3, -36($fp)
 sw $t4, -40($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 8($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 lw $t2, -32($fp)
 lw $t3, -36($fp)
 lw $t4, -40($fp)
 # t2: 145(6): VarAssg 144 *medium :int
 move $t2, $a0
 # a0: 146(0): This :BS
 move $a0, $v0
 # a0: 147(0): Member 146 *number :int[]
 lw $a0, 4($a0)
 # a0: 148(0): Index 147 145 :int
 mul $v1, $t2, 4
 add $v1, $v1, 4
 add $v1, $v1, $a0
 lw $a0, ($v1)
 # a2: 149(2): VarAssg 148 *aux01 :int
 move $a2, $a0
 # a0: 150(0): Lt 115 149 :boolean
 slt $a0, $a3, $a2 # a0: 151(0): NBranch 150 *lif_9_else :void
 beq $a0, $zero, .lif_9_else
 # a0: 152(0): Int *1 :int
 li $a0, 1
 # a0: 153(0): Minus 145 152 :int
 sub $a0, $t2, $a0
 # t3: 154(7): VarAssg 153 *right :int
 move $t3, $a0
 # a0: 155(0): Goto *lif_9_done :void
 j .lif_9_done
 # a0: 156(0): Label *lif_9_else :void
 .lif_9_else:
 # a0: 157(0): Int *1 :int
 li $a0, 1
 # a0: 158(0): Plus 145 157 :int
 add $a0, $t2, $a0
 # t0: 159(4): VarAssg 158 *left :int
 move $t0, $a0
 # a0: 160(0): Label *lif_9_done :void
 .lif_9_done:
 # t0: 161(4): Unify 135 159 :int
 # t0: 162(4): Unify 161 135 :int
 # t3: 163(7): Unify 154 133 :int
 # t4: 164(8): This :BS
 move $t4, $v0
 # a0: 165(0): Arg 149 *0 :int
 move $a0, $a2
 # a1: 166(1): Arg 115 *1 :int
 move $a1, $a3
 # a0: 167(0): Call 164 *Compare(165, 166) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 sw $t2, -32($fp)
 sw $t3, -36($fp)
 sw $t4, -40($fp)
 move $v0, $t4
 lw $v1, ($v0)
 lw $v1, 12($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 lw $t2, -32($fp)
 lw $t3, -36($fp)
 lw $t4, -40($fp)
 # a0: 168(0): NBranch 167 *lif_10_else :void
 beq $a0, $zero, .lif_10_else
 # a0: 169(0): Boolean *false :boolean
 move $a0, $zero
 # a1: 170(1): VarAssg 169 *var_cont :boolean
 move $a1, $a0
 # a0: 171(0): Goto *lif_10_done :void
 j .lif_10_done
 # a0: 172(0): Label *lif_10_else :void
 .lif_10_else:
 # a0: 173(0): Boolean *true :boolean
 li $a0, 1
 # a1: 174(1): VarAssg 173 *var_cont :boolean
 move $a1, $a0
 # a0: 175(0): Label *lif_10_done :void
 .lif_10_done:
 # a1: 176(1): Unify 170 174 :boolean
 # a1: 177(1): Unify 176 137 :boolean
 # a0: 178(0): Lt 163 162 :boolean
 slt $a0, $t3, $t0 # a0: 179(0): NBranch 178 *lif_11_else :void
 beq $a0, $zero, .lif_11_else
 # a0: 180(0): Boolean *false :boolean
 move $a0, $zero
 # a1: 181(1): VarAssg 180 *var_cont :boolean
 move $a1, $a0
 # a0: 182(0): Goto *lif_11_done :void
 j .lif_11_done
 # a0: 183(0): Label *lif_11_else :void
 .lif_11_else:
 # a0: 184(0): Int *0 :int
 li $a0, 0
 # t1: 185(5): VarAssg 184 *nt :int
 move $t1, $a0
 # a0: 186(0): Label *lif_11_done :void
 .lif_11_done:
 # t1: 187(5): Unify 122 185 :int
 # t1: 188(5): Unify 187 122 :int
 # a1: 189(1): Unify 181 177 :boolean
 # a0: 190(0): Goto *lwhile_8_start :void
 j .lwhile_8_start
 # a0: 191(0): Label *lwhile_8_done :void
 .lwhile_8_done:
 # t1: 192(5): Unify 122 188 :int
 # a1: 193(1): Unify 137 189 :boolean
 # t0: 194(4): Unify 135 162 :int
 # a2: 195(2): Unify 124 149 :int
 # t3: 196(7): Unify 133 163 :int
 # t2: 197(6): Unify 120 145 :int
 # t1: 198(5): Unify 122 192 :int
 # a1: 199(1): Unify 137 193 :boolean
 # a2: 200(2): Unify 124 195 :int
 # t0: 201(4): Unify 135 194 :int
 # t3: 202(7): Unify 133 196 :int
 # t2: 203(6): Unify 120 197 :int
 # t0: 204(4): This :BS
 move $t0, $v0
 # a0: 205(0): Arg 200 *0 :int
 move $a0, $a2
 # a1: 206(1): Arg 115 *1 :int
 move $a1, $a3
 # a0: 207(0): Call 204 *Compare(205, 206) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 sw $t2, -32($fp)
 sw $t3, -36($fp)
 sw $t4, -40($fp)
 move $v0, $t0
 lw $v1, ($v0)
 lw $v1, 12($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 lw $t2, -32($fp)
 lw $t3, -36($fp)
 lw $t4, -40($fp)
 # a0: 208(0): NBranch 207 *lif_12_else :void
 beq $a0, $zero, .lif_12_else
 # a0: 209(0): Boolean *true :boolean
 li $a0, 1
 # a1: 210(1): VarAssg 209 *bs01 :boolean
 move $a1, $a0
 # a0: 211(0): Goto *lif_12_done :void
 j .lif_12_done
 # a0: 212(0): Label *lif_12_else :void
 .lif_12_else:
 # a0: 213(0): Boolean *false :boolean
 move $a0, $zero
 # a1: 214(1): VarAssg 213 *bs01 :boolean
 move $a1, $a0
 # a0: 215(0): Label *lif_12_done :void
 .lif_12_done:
 # a1: 216(1): Unify 210 214 :boolean
 # a1: 217(1): Unify 216 126 :boolean
 # a0: 218(0): Return 217 :void
 move $v0, $a1
 j .ret_mj__m_BS_Search
 .ret_mj__m_BS_Search:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
mj__m_BS_Div:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -24
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 219(0): Parameter *0 :int
 # a0: 220(0): VarAssg 219 *num :int
 # a1: 221(1): Null *Type(int) :int
 move $a1, $zero
 # a1: 222(1): Null *Type(int) :int
 move $a1, $zero
 # a1: 223(1): Null *Type(int) :int
 move $a1, $zero
 # a1: 224(1): Int *0 :int
 li $a1, 0
 # a2: 225(2): VarAssg 224 *count01 :int
 move $a2, $a1
 # a1: 226(1): Int *0 :int
 li $a1, 0
 # a3: 227(3): VarAssg 226 *count02 :int
 move $a3, $a1
 # a1: 228(1): Int *1 :int
 li $a1, 1
 # a0: 229(0): Minus 220 228 :int
 sub $a0, $a0, $a1
 # a1: 230(1): VarAssg 229 *aux03 :int
 move $a1, $a0
 # a0: 231(0): Label *lwhile_13_start :void
 .lwhile_13_start:
 # a0: 232(0): Lt 227 230 :boolean
 slt $a0, $a3, $a1 # a0: 233(0): NBranch 232 *lwhile_13_done :void
 beq $a0, $zero, .lwhile_13_done
 # a0: 234(0): Int *1 :int
 li $a0, 1
 # a0: 235(0): Plus 225 234 :int
 add $a0, $a2, $a0
 # a2: 236(2): VarAssg 235 *count01 :int
 move $a2, $a0
 # a0: 237(0): Int *2 :int
 li $a0, 2
 # a0: 238(0): Plus 227 237 :int
 add $a0, $a3, $a0
 # a3: 239(3): VarAssg 238 *count02 :int
 move $a3, $a0
 # a0: 240(0): Goto *lwhile_13_start :void
 j .lwhile_13_start
 # a0: 241(0): Label *lwhile_13_done :void
 .lwhile_13_done:
 # a3: 242(3): Unify 227 239 :int
 # a2: 243(2): Unify 225 236 :int
 # a3: 244(3): Unify 227 242 :int
 # a2: 245(2): Unify 225 243 :int
 # a0: 246(0): Return 245 :void
 move $v0, $a2
 j .ret_mj__m_BS_Div
 .ret_mj__m_BS_Div:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
mj__m_BS_Compare:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -24
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 247(0): Parameter *0 :int
 # a1: 248(1): Parameter *1 :int
 # a2: 249(2): VarAssg 247 *num1 :int
 move $a2, $a0
 # a1: 250(1): VarAssg 248 *num2 :int
 # a0: 251(0): Null *Type(boolean) :boolean
 move $a0, $zero
 # a0: 252(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 253(0): Boolean *false :boolean
 move $a0, $zero
 # a0: 254(0): VarAssg 253 *retval :boolean
 # a0: 255(0): Int *1 :int
 li $a0, 1
 # a0: 256(0): Plus 250 255 :int
 add $a0, $a1, $a0
 # a3: 257(3): VarAssg 256 *aux02 :int
 move $a3, $a0
 # a0: 258(0): Lt 249 250 :boolean
 slt $a0, $a2, $a1 # a0: 259(0): NBranch 258 *lif_14_else :void
 beq $a0, $zero, .lif_14_else
 # a0: 260(0): Boolean *false :boolean
 move $a0, $zero
 # a0: 261(0): VarAssg 260 *retval :boolean
 # a1: 262(1): Goto *lif_14_done :void
 j .lif_14_done
 # a0: 263(0): Label *lif_14_else :void
 .lif_14_else:
 # a0: 264(0): Lt 249 257 :boolean
 slt $a0, $a2, $a3 # a0: 265(0): Not 264 :boolean
 seq $a0, $zero, $a0
 # a0: 266(0): NBranch 265 *lif_15_else :void
 beq $a0, $zero, .lif_15_else
 # a0: 267(0): Boolean *false :boolean
 move $a0, $zero
 # a0: 268(0): VarAssg 267 *retval :boolean
 # a1: 269(1): Goto *lif_15_done :void
 j .lif_15_done
 # a0: 270(0): Label *lif_15_else :void
 .lif_15_else:
 # a0: 271(0): Boolean *true :boolean
 li $a0, 1
 # a0: 272(0): VarAssg 271 *retval :boolean
 # a1: 273(1): Label *lif_15_done :void
 .lif_15_done:
 # a0: 274(0): Unify 268 272 :boolean
 # a0: 275(0): Unify 274 261 :boolean
 # a1: 276(1): Label *lif_14_done :void
 .lif_14_done:
 # a0: 277(0): Unify 261 275 :boolean
 # a0: 278(0): Unify 277 254 :boolean
 # a0: 279(0): Return 278 :void
 move $v0, $a0
 j .ret_mj__m_BS_Compare
 .ret_mj__m_BS_Compare:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
mj__m_BS_Print:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -16
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 280(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 281(0): Int *1 :int
 li $a0, 1
 # a1: 282(1): VarAssg 281 *j :int
 move $a1, $a0
 # a0: 283(0): Label *lwhile_16_start :void
 .lwhile_16_start:
 # a0: 284(0): This :BS
 move $a0, $v0
 # a0: 285(0): Member 284 *size :int
 lw $a0, 8($a0)
 # a0: 286(0): Lt 282 285 :boolean
 slt $a0, $a1, $a0 # a0: 287(0): NBranch 286 *lwhile_16_done :void
 beq $a0, $zero, .lwhile_16_done
 # a0: 288(0): This :BS
 move $a0, $v0
 # a0: 289(0): Member 288 *number :int[]
 lw $a0, 4($a0)
 # a0: 290(0): Index 289 282 :int
 mul $v1, $a1, 4
 add $v1, $v1, 4
 add $v1, $v1, $a0
 lw $a0, ($v1)
 # a0: 291(0): Print 290 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 # a0: 292(0): Int *1 :int
 li $a0, 1
 # a0: 293(0): Plus 282 292 :int
 add $a0, $a1, $a0
 # a1: 294(1): VarAssg 293 *j :int
 move $a1, $a0
 # a0: 295(0): Goto *lwhile_16_start :void
 j .lwhile_16_start
 # a0: 296(0): Label *lwhile_16_done :void
 .lwhile_16_done:
 # a1: 297(1): Unify 282 294 :int
 # a1: 298(1): Unify 282 297 :int
 # a0: 299(0): Int *99999 :int
 li $a0, 99999
 # a0: 300(0): Print 299 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 # a0: 301(0): Int *0 :int
 li $a0, 0
 # a0: 302(0): Return 301 :void
 move $v0, $a0
 j .ret_mj__m_BS_Print
 .ret_mj__m_BS_Print:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
mj__m_BS_Init:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -32
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 303(0): Parameter *0 :int
 # a0: 304(0): VarAssg 303 *sz :int
 # a1: 305(1): Null *Type(int) :int
 move $a1, $zero
 # a1: 306(1): Null *Type(int) :int
 move $a1, $zero
 # t0: 307(4): Null *Type(int) :int
 move $t0, $zero
 # a2: 308(2): Null *Type(int) :int
 move $a2, $zero
 # a1: 309(1): This :BS
 move $a1, $v0
 # a1: 310(1): MemberAssg 309 304 *size :int
 sw $a0, 8($a1)
 move $a1, $a0
 # a1: 311(1): This :BS
 move $a1, $v0
 # a0: 312(0): NewIntArray 304 :int[]
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 jal minijavaNewArray
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 # a0: 313(0): MemberAssg 311 312 *number :int[]
 sw $a0, 4($a1)
 # a0: 314(0): Int *1 :int
 li $a0, 1
 # t1: 315(5): VarAssg 314 *j :int
 move $t1, $a0
 # a0: 316(0): This :BS
 move $a0, $v0
 # a0: 317(0): Member 316 *size :int
 lw $a0, 8($a0)
 # a1: 318(1): Int *1 :int
 li $a1, 1
 # a0: 319(0): Plus 317 318 :int
 add $a0, $a0, $a1
 # a1: 320(1): VarAssg 319 *k :int
 move $a1, $a0
 # a0: 321(0): Label *lwhile_17_start :void
 .lwhile_17_start:
 # a0: 322(0): This :BS
 move $a0, $v0
 # a0: 323(0): Member 322 *size :int
 lw $a0, 8($a0)
 # a0: 324(0): Lt 315 323 :boolean
 slt $a0, $t1, $a0 # a0: 325(0): NBranch 324 *lwhile_17_done :void
 beq $a0, $zero, .lwhile_17_done
 # a0: 326(0): Int *2 :int
 li $a0, 2
 # a0: 327(0): Mul 326 315 :int
 mul $a0, $a0, $t1
 # a2: 328(2): VarAssg 327 *aux01 :int
 move $a2, $a0
 # a0: 329(0): Int *3 :int
 li $a0, 3
 # a0: 330(0): Minus 320 329 :int
 sub $a0, $a1, $a0
 # t0: 331(4): VarAssg 330 *aux02 :int
 move $t0, $a0
 # a0: 332(0): This :BS
 move $a0, $v0
 # a3: 333(3): Member 332 *number :int[]
 lw $a3, 4($a0)
 # a0: 334(0): Plus 328 331 :int
 add $a0, $a2, $t0
 # a0: 335(0): IndexAssg 333 334 *315(5): VarAssg 314 *j :int :int
 mul $v1, $t1, 4
 add $v1, $v1, 4
 add $v1, $v1, $a3
 sw $a0, ($v1)
 # a0: 336(0): Int *1 :int
 li $a0, 1
 # a0: 337(0): Plus 315 336 :int
 add $a0, $t1, $a0
 # t1: 338(5): VarAssg 337 *j :int
 move $t1, $a0
 # a0: 339(0): Int *1 :int
 li $a0, 1
 # a0: 340(0): Minus 320 339 :int
 sub $a0, $a1, $a0
 # a1: 341(1): VarAssg 340 *k :int
 move $a1, $a0
 # a0: 342(0): Goto *lwhile_17_start :void
 j .lwhile_17_start
 # a0: 343(0): Label *lwhile_17_done :void
 .lwhile_17_done:
 # t0: 344(4): Unify 307 331 :int
 # a2: 345(2): Unify 308 328 :int
 # t1: 346(5): Unify 315 338 :int
 # a1: 347(1): Unify 320 341 :int
 # t0: 348(4): Unify 307 344 :int
 # a2: 349(2): Unify 308 345 :int
 # t1: 350(5): Unify 315 346 :int
 # a1: 351(1): Unify 320 347 :int
 # a0: 352(0): Int *0 :int
 li $a0, 0
 # a0: 353(0): Return 352 :void
 move $v0, $a0
 j .ret_mj__m_BS_Init
 .ret_mj__m_BS_Init:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra

