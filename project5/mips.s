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
 # a0: 0(0): NewObj *BS :BS
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 la $a0, mj__v_BS
 li $a1, 3
 jal minijavaNew
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 # a1: 1(1): Int *20 :int
 li $a1, 20
 # a1: 2(1): Arg 1 *0 :int
 # a0: 3(0): Call 0 *Start(2) :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 move $v0, $a0
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
 add $sp, $sp, -16
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 5(0): Parameter *0 :int
 # a0: 6(0): VarAssg 5 *sz :int
 # a0: 7(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 8(0): Null *Type(int) :int
 move $a0, $zero
 # a1: 9(1): This :BS
 move $a1, $v0
 # a0: 10(0): Arg 6 *0 :int
 # a0: 11(0): Call 9 *Init(10) :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 20($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 # a0: 12(0): VarAssg 11 *aux01 :int
 # a0: 13(0): This :BS
 move $a0, $v0
 # a0: 14(0): Call 13 *Print() :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 move $v0, $a0
 lw $v1, ($v0)
 lw $v1, 16($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
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
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 4($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 # a0: 20(0): NBranch 19 *lif_753751532_else :void
 beq $a0, $zero, .lif_753751532_else
 # a0: 21(0): Int *1 :int
 li $a0, 1
 # a0: 22(0): Print 21 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 # a0: 23(0): Goto *lif_753751532_done :void
 j .lif_753751532_done
 # a0: 24(0): Label *lif_753751532_else :void
 .lif_753751532_else:
 # a0: 25(0): Int *0 :int
 li $a0, 0
 # a0: 26(0): Print 25 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 # a0: 27(0): Label *lif_753751532_done :void
 .lif_753751532_done:
 # a0: 28(0): This :BS
 move $a0, $v0
 # a1: 29(1): Int *19 :int
 li $a1, 19
 # a1: 30(1): Arg 29 *0 :int
 # a0: 31(0): Call 28 *Search(30) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 move $v0, $a0
 lw $v1, ($v0)
 lw $v1, 4($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 # a0: 32(0): NBranch 31 *lif_706099045_else :void
 beq $a0, $zero, .lif_706099045_else
 # a0: 33(0): Int *1 :int
 li $a0, 1
 # a0: 34(0): Print 33 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 # a0: 35(0): Goto *lif_706099045_done :void
 j .lif_706099045_done
 # a0: 36(0): Label *lif_706099045_else :void
 .lif_706099045_else:
 # a0: 37(0): Int *0 :int
 li $a0, 0
 # a0: 38(0): Print 37 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 # a0: 39(0): Label *lif_706099045_done :void
 .lif_706099045_done:
 # a1: 40(1): This :BS
 move $a1, $v0
 # a0: 41(0): Int *20 :int
 li $a0, 20
 # a0: 42(0): Arg 41 *0 :int
 # a0: 43(0): Call 40 *Search(42) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 4($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 # a0: 44(0): NBranch 43 *lif_412015993_else :void
 beq $a0, $zero, .lif_412015993_else
 # a0: 45(0): Int *1 :int
 li $a0, 1
 # a0: 46(0): Print 45 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 # a0: 47(0): Goto *lif_412015993_done :void
 j .lif_412015993_done
 # a0: 48(0): Label *lif_412015993_else :void
 .lif_412015993_else:
 # a0: 49(0): Int *0 :int
 li $a0, 0
 # a0: 50(0): Print 49 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 # a0: 51(0): Label *lif_412015993_done :void
 .lif_412015993_done:
 # a1: 52(1): This :BS
 move $a1, $v0
 # a0: 53(0): Int *21 :int
 li $a0, 21
 # a0: 54(0): Arg 53 *0 :int
 # a0: 55(0): Call 52 *Search(54) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 4($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 # a0: 56(0): NBranch 55 *lif_1265516423_else :void
 beq $a0, $zero, .lif_1265516423_else
 # a0: 57(0): Int *1 :int
 li $a0, 1
 # a0: 58(0): Print 57 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 # a0: 59(0): Goto *lif_1265516423_done :void
 j .lif_1265516423_done
 # a0: 60(0): Label *lif_1265516423_else :void
 .lif_1265516423_else:
 # a0: 61(0): Int *0 :int
 li $a0, 0
 # a0: 62(0): Print 61 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 # a0: 63(0): Label *lif_1265516423_done :void
 .lif_1265516423_done:
 # a1: 64(1): This :BS
 move $a1, $v0
 # a0: 65(0): Int *37 :int
 li $a0, 37
 # a0: 66(0): Arg 65 *0 :int
 # a0: 67(0): Call 64 *Search(66) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 4($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 # a0: 68(0): NBranch 67 *lif_856481473_else :void
 beq $a0, $zero, .lif_856481473_else
 # a0: 69(0): Int *1 :int
 li $a0, 1
 # a0: 70(0): Print 69 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 # a0: 71(0): Goto *lif_856481473_done :void
 j .lif_856481473_done
 # a0: 72(0): Label *lif_856481473_else :void
 .lif_856481473_else:
 # a0: 73(0): Int *0 :int
 li $a0, 0
 # a0: 74(0): Print 73 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 # a0: 75(0): Label *lif_856481473_done :void
 .lif_856481473_done:
 # a1: 76(1): This :BS
 move $a1, $v0
 # a0: 77(0): Int *38 :int
 li $a0, 38
 # a0: 78(0): Arg 77 *0 :int
 # a0: 79(0): Call 76 *Search(78) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 4($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 # a0: 80(0): NBranch 79 *lif_301230870_else :void
 beq $a0, $zero, .lif_301230870_else
 # a0: 81(0): Int *1 :int
 li $a0, 1
 # a0: 82(0): Print 81 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 # a0: 83(0): Goto *lif_301230870_done :void
 j .lif_301230870_done
 # a0: 84(0): Label *lif_301230870_else :void
 .lif_301230870_else:
 # a0: 85(0): Int *0 :int
 li $a0, 0
 # a0: 86(0): Print 85 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 # a0: 87(0): Label *lif_301230870_done :void
 .lif_301230870_done:
 # a0: 88(0): This :BS
 move $a0, $v0
 # a1: 89(1): Int *39 :int
 li $a1, 39
 # a1: 90(1): Arg 89 *0 :int
 # a0: 91(0): Call 88 *Search(90) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 move $v0, $a0
 lw $v1, ($v0)
 lw $v1, 4($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 # a0: 92(0): NBranch 91 *lif_1168276111_else :void
 beq $a0, $zero, .lif_1168276111_else
 # a0: 93(0): Int *1 :int
 li $a0, 1
 # a0: 94(0): Print 93 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 # a0: 95(0): Goto *lif_1168276111_done :void
 j .lif_1168276111_done
 # a0: 96(0): Label *lif_1168276111_else :void
 .lif_1168276111_else:
 # a0: 97(0): Int *0 :int
 li $a0, 0
 # a0: 98(0): Print 97 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 # a0: 99(0): Label *lif_1168276111_done :void
 .lif_1168276111_done:
 # a0: 100(0): This :BS
 move $a0, $v0
 # a1: 101(1): Int *50 :int
 li $a1, 50
 # a1: 102(1): Arg 101 *0 :int
 # a0: 103(0): Call 100 *Search(102) :boolean
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 move $v0, $a0
 lw $v1, ($v0)
 lw $v1, 4($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 # a0: 104(0): NBranch 103 *lif_773613056_else :void
 beq $a0, $zero, .lif_773613056_else
 # a0: 105(0): Int *1 :int
 li $a0, 1
 # a0: 106(0): Print 105 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 # a0: 107(0): Goto *lif_773613056_done :void
 j .lif_773613056_done
 # a0: 108(0): Label *lif_773613056_else :void
 .lif_773613056_else:
 # a0: 109(0): Int *0 :int
 li $a0, 0
 # a0: 110(0): Print 109 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 # a0: 111(0): Label *lif_773613056_done :void
 .lif_773613056_done:
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
 add $sp, $sp, -52
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 114(0): Parameter *0 :int
 # t1: 115(5): VarAssg 114 *num :int
 move $t1, $a0
 # a0: 116(0): Null *Type(boolean) :boolean
 move $a0, $zero
 # a0: 117(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 118(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 119(0): Null *Type(boolean) :boolean
 move $a0, $zero
 # a1: 120(1): Null *Type(int) :int
 move $a1, $zero
 # a0: 121(0): Null *Type(int) :int
 move $a0, $zero
 # t6: 122(10): Null *Type(int) :int
 move $t6, $zero
 # a0: 123(0): Int *0 :int
 li $a0, 0
 # t2: 124(6): VarAssg 123 *aux01 :int
 move $t2, $a0
 # a0: 125(0): Boolean *false :boolean
 move $a0, $zero
 # a0: 126(0): VarAssg 125 *bs01 :boolean
 # a0: 127(0): This :BS
 move $a0, $v0
 # a0: 128(0): Member 127 *number :int[]
 lw $a0, 4($a0)
 # a0: 129(0): Member 128 *length :int
 lw $a0, ($a0)
 # a0: 130(0): VarAssg 129 *right :int
 # a2: 131(2): Int *1 :int
 li $a2, 1
 # a2: 132(2): Minus 130 131 :int
 sub $a2, $a0, $a2
 # a3: 133(3): VarAssg 132 *right :int
 move $a3, $a2
 # a0: 134(0): Int *0 :int
 li $a0, 0
 # t5: 135(9): VarAssg 134 *left :int
 move $t5, $a0
 # t3: 136(7): Boolean *true :boolean
 li $t3, 1
 # t0: 137(4): VarAssg 136 *var_cont :boolean
 move $t0, $t3
 # a0: 138(0): Label *lwhile_1248633254_start :void
 .lwhile_1248633254_start:
 # a0: 139(0): NBranch 137 *lwhile_1248633254_end :void
 beq $t0, $zero, .lwhile_1248633254_end
 # a0: 140(0): Plus 135 133 :int
 add $a0, $t5, $a3
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
 sw $t5, -44($fp)
 sw $t6, -48($fp)
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
 lw $t5, -44($fp)
 lw $t6, -48($fp)
 # a1: 145(1): VarAssg 144 *medium :int
 move $a1, $a0
 # a0: 146(0): This :BS
 move $a0, $v0
 # a0: 147(0): Member 146 *number :int[]
 lw $a0, 4($a0)
 # a2: 148(2): Index 147 145 :int
 mul $v1, $a1, 4
 add $v1, $v1, 4
 add $v1, $v1, $a0
 lw $a2, ($v1)
 # t2: 149(6): VarAssg 148 *aux01 :int
 move $t2, $a2
 # a0: 150(0): Lt 115 149 :boolean
 slt $a0, $t1, $t2 # a0: 151(0): NBranch 150 *lif_568901494_else :void
 beq $a0, $zero, .lif_568901494_else
 # a0: 152(0): Int *1 :int
 li $a0, 1
 # a0: 153(0): Minus 145 152 :int
 sub $a0, $a1, $a0
 # a3: 154(3): VarAssg 153 *right :int
 move $a3, $a0
 # a0: 155(0): Goto *lif_568901494_done :void
 j .lif_568901494_done
 # a0: 156(0): Label *lif_568901494_else :void
 .lif_568901494_else:
 # a0: 157(0): Int *1 :int
 li $a0, 1
 # a2: 158(2): Plus 145 157 :int
 add $a2, $a1, $a0
 # t5: 159(9): VarAssg 158 *left :int
 move $t5, $a2
 # a0: 160(0): Label *lif_568901494_done :void
 .lif_568901494_done:
 # t5: 161(9): Unify 135 159 :int
 # a3: 162(3): Unify 154 133 :int
 # t0: 163(4): This :BS
 move $t0, $v0
 # a2: 164(2): Arg 149 *0 :int
 move $a2, $t2
 # a0: 165(0): Arg 115 *1 :int
 move $a0, $t1
 # a0: 166(0): Call 163 *Compare(164, 165) :boolean
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
 sw $t5, -44($fp)
 sw $t6, -48($fp)
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
 lw $t5, -44($fp)
 lw $t6, -48($fp)
 # a0: 167(0): NBranch 166 *lif_930213214_else :void
 beq $a0, $zero, .lif_930213214_else
 # t4: 168(8): Boolean *false :boolean
 move $t4, $zero
 # t0: 169(4): VarAssg 168 *var_cont :boolean
 move $t0, $t4
 # a0: 170(0): Goto *lif_930213214_done :void
 j .lif_930213214_done
 # a0: 171(0): Label *lif_930213214_else :void
 .lif_930213214_else:
 # a2: 172(2): Boolean *true :boolean
 li $a2, 1
 # t0: 173(4): VarAssg 172 *var_cont :boolean
 move $t0, $a2
 # a0: 174(0): Label *lif_930213214_done :void
 .lif_930213214_done:
 # t0: 175(4): Unify 169 173 :boolean
 # a0: 176(0): Lt 162 161 :boolean
 slt $a0, $a3, $t5 # a0: 177(0): NBranch 176 *lif_412537538_else :void
 beq $a0, $zero, .lif_412537538_else
 # a0: 178(0): Boolean *false :boolean
 move $a0, $zero
 # t0: 179(4): VarAssg 178 *var_cont :boolean
 move $t0, $a0
 # a0: 180(0): Goto *lif_412537538_done :void
 j .lif_412537538_done
 # a0: 181(0): Label *lif_412537538_else :void
 .lif_412537538_else:
 # a0: 182(0): Int *0 :int
 li $a0, 0
 # t6: 183(10): VarAssg 182 *nt :int
 move $t6, $a0
 # a0: 184(0): Label *lif_412537538_done :void
 .lif_412537538_done:
 # t6: 185(10): Unify 122 183 :int
 # t0: 186(4): Unify 179 175 :boolean
 # a0: 187(0): Goto *lwhile_1248633254_start :void
 j .lwhile_1248633254_start
 # a0: 188(0): Label *lwhile_1248633254_end :void
 .lwhile_1248633254_end:
 # t6: 189(10): Unify 122 185 :int
 # t0: 190(4): Unify 137 186 :boolean
 # t2: 191(6): Unify 124 149 :int
 # t5: 192(9): Unify 135 161 :int
 # a3: 193(3): Unify 133 162 :int
 # a1: 194(1): Unify 120 145 :int
 # a0: 195(0): This :BS
 move $a0, $v0
 # a2: 196(2): Arg 191 *0 :int
 move $a2, $t2
 # a1: 197(1): Arg 115 *1 :int
 move $a1, $t1
 # a0: 198(0): Call 195 *Compare(196, 197) :boolean
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
 sw $t5, -44($fp)
 sw $t6, -48($fp)
 move $v0, $a0
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
 lw $t5, -44($fp)
 lw $t6, -48($fp)
 # a0: 199(0): NBranch 198 *lif_1441188650_else :void
 beq $a0, $zero, .lif_1441188650_else
 # a0: 200(0): Boolean *true :boolean
 li $a0, 1
 # a2: 201(2): VarAssg 200 *bs01 :boolean
 move $a2, $a0
 # a0: 202(0): Goto *lif_1441188650_done :void
 j .lif_1441188650_done
 # a0: 203(0): Label *lif_1441188650_else :void
 .lif_1441188650_else:
 # a1: 204(1): Boolean *false :boolean
 move $a1, $zero
 # a2: 205(2): VarAssg 204 *bs01 :boolean
 move $a2, $a1
 # a0: 206(0): Label *lif_1441188650_done :void
 .lif_1441188650_done:
 # a2: 207(2): Unify 201 205 :boolean
 # a0: 208(0): Return 207 :void
 move $v0, $a2
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
 add $sp, $sp, -32
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 209(0): Parameter *0 :int
 # a0: 210(0): VarAssg 209 *num :int
 # a0: 211(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 212(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 213(0): Null *Type(int) :int
 move $a0, $zero
 # a2: 214(2): Int *0 :int
 li $a2, 0
 # t0: 215(4): VarAssg 214 *count01 :int
 move $t0, $a2
 # a2: 216(2): Int *0 :int
 li $a2, 0
 # a3: 217(3): VarAssg 216 *count02 :int
 move $a3, $a2
 # a1: 218(1): Int *1 :int
 li $a1, 1
 # a0: 219(0): Minus 210 218 :int
 sub $a0, $a0, $a1
 # t1: 220(5): VarAssg 219 *aux03 :int
 move $t1, $a0
 # a0: 221(0): Label *lwhile_589586037_start :void
 .lwhile_589586037_start:
 # a0: 222(0): Lt 217 220 :boolean
 slt $a0, $a3, $t1 # a0: 223(0): NBranch 222 *lwhile_589586037_end :void
 beq $a0, $zero, .lwhile_589586037_end
 # a0: 224(0): Int *1 :int
 li $a0, 1
 # a1: 225(1): Plus 215 224 :int
 add $a1, $t0, $a0
 # t0: 226(4): VarAssg 225 *count01 :int
 move $t0, $a1
 # a0: 227(0): Int *2 :int
 li $a0, 2
 # a1: 228(1): Plus 217 227 :int
 add $a1, $a3, $a0
 # a3: 229(3): VarAssg 228 *count02 :int
 move $a3, $a1
 # a0: 230(0): Goto *lwhile_589586037_start :void
 j .lwhile_589586037_start
 # a0: 231(0): Label *lwhile_589586037_end :void
 .lwhile_589586037_end:
 # a3: 232(3): Unify 217 229 :int
 # t0: 233(4): Unify 215 226 :int
 # a0: 234(0): Return 233 :void
 move $v0, $t0
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
 # a1: 235(1): Parameter *0 :int
 # a0: 236(0): Parameter *1 :int
 # a2: 237(2): VarAssg 235 *num1 :int
 move $a2, $a1
 # a1: 238(1): VarAssg 236 *num2 :int
 move $a1, $a0
 # a0: 239(0): Null *Type(boolean) :boolean
 move $a0, $zero
 # a0: 240(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 241(0): Boolean *false :boolean
 move $a0, $zero
 # a0: 242(0): VarAssg 241 *retval :boolean
 # a0: 243(0): Int *1 :int
 li $a0, 1
 # a0: 244(0): Plus 238 243 :int
 add $a0, $a1, $a0
 # a3: 245(3): VarAssg 244 *aux02 :int
 move $a3, $a0
 # a0: 246(0): Lt 237 238 :boolean
 slt $a0, $a2, $a1 # a0: 247(0): NBranch 246 *lif_682976601_else :void
 beq $a0, $zero, .lif_682976601_else
 # a1: 248(1): Boolean *false :boolean
 move $a1, $zero
 # a0: 249(0): VarAssg 248 *retval :boolean
 move $a0, $a1
 # a0: 250(0): Goto *lif_682976601_done :void
 j .lif_682976601_done
 # a0: 251(0): Label *lif_682976601_else :void
 .lif_682976601_else:
 # a0: 252(0): Lt 237 245 :boolean
 slt $a0, $a2, $a3 # a0: 253(0): Not 252 :boolean
 seq $a0, $zero, $a0
 # a0: 254(0): NBranch 253 *lif_487639792_else :void
 beq $a0, $zero, .lif_487639792_else
 # a2: 255(2): Boolean *false :boolean
 move $a2, $zero
 # a0: 256(0): VarAssg 255 *retval :boolean
 move $a0, $a2
 # a0: 257(0): Goto *lif_487639792_done :void
 j .lif_487639792_done
 # a0: 258(0): Label *lif_487639792_else :void
 .lif_487639792_else:
 # a3: 259(3): Boolean *true :boolean
 li $a3, 1
 # a0: 260(0): VarAssg 259 *retval :boolean
 move $a0, $a3
 # a0: 261(0): Label *lif_487639792_done :void
 .lif_487639792_done:
 # a0: 262(0): Unify 256 260 :boolean
 # a0: 263(0): Label *lif_682976601_done :void
 .lif_682976601_done:
 # a0: 264(0): Unify 249 262 :boolean
 # a0: 265(0): Return 264 :void
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
 add $sp, $sp, -20
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 266(0): Null *Type(int) :int
 move $a0, $zero
 # a1: 267(1): Int *1 :int
 li $a1, 1
 # a2: 268(2): VarAssg 267 *j :int
 move $a2, $a1
 # a0: 269(0): Label *lwhile_964387192_start :void
 .lwhile_964387192_start:
 # a0: 270(0): This :BS
 move $a0, $v0
 # a0: 271(0): Member 270 *size :int
 lw $a0, 8($a0)
 # a0: 272(0): Lt 268 271 :boolean
 slt $a0, $a2, $a0 # a0: 273(0): NBranch 272 *lwhile_964387192_end :void
 beq $a0, $zero, .lwhile_964387192_end
 # a0: 274(0): This :BS
 move $a0, $v0
 # a0: 275(0): Member 274 *number :int[]
 lw $a0, 4($a0)
 # a0: 276(0): Index 275 268 :int
 mul $v1, $a2, 4
 add $v1, $v1, 4
 add $v1, $v1, $a0
 lw $a0, ($v1)
 # a0: 277(0): Print 276 :void
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
 # a0: 278(0): Int *1 :int
 li $a0, 1
 # a0: 279(0): Plus 268 278 :int
 add $a0, $a2, $a0
 # a2: 280(2): VarAssg 279 *j :int
 move $a2, $a0
 # a0: 281(0): Goto *lwhile_964387192_start :void
 j .lwhile_964387192_start
 # a0: 282(0): Label *lwhile_964387192_end :void
 .lwhile_964387192_end:
 # a2: 283(2): Unify 268 280 :int
 # a0: 284(0): Int *99999 :int
 li $a0, 99999
 # a0: 285(0): Print 284 :void
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
 # a0: 286(0): Int *0 :int
 li $a0, 0
 # a0: 287(0): Return 286 :void
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
 # a0: 288(0): Parameter *0 :int
 # a2: 289(2): VarAssg 288 *sz :int
 move $a2, $a0
 # a0: 290(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 291(0): Null *Type(int) :int
 move $a0, $zero
 # t0: 292(4): Null *Type(int) :int
 move $t0, $zero
 # a3: 293(3): Null *Type(int) :int
 move $a3, $zero
 # a0: 294(0): This :BS
 move $a0, $v0
 # a0: 295(0): MemberAssg 294 289 *size :int
 sw $a2, 8($a0)
 move $a0, $a2
 # a0: 296(0): This :BS
 move $a0, $v0
 # a1: 297(1): NewIntArray 289 :int[]
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 move $a0, $a2
 jal minijavaNewArray
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 # a0: 298(0): MemberAssg 296 297 *number :int[]
 sw $a1, 4($a0)
 move $a0, $a1
 # a0: 299(0): Int *1 :int
 li $a0, 1
 # t1: 300(5): VarAssg 299 *j :int
 move $t1, $a0
 # a0: 301(0): This :BS
 move $a0, $v0
 # a1: 302(1): Member 301 *size :int
 lw $a1, 8($a0)
 # a0: 303(0): Int *1 :int
 li $a0, 1
 # a0: 304(0): Plus 302 303 :int
 add $a0, $a1, $a0
 # a1: 305(1): VarAssg 304 *k :int
 move $a1, $a0
 # a0: 306(0): Label *lwhile_1396452035_start :void
 .lwhile_1396452035_start:
 # a0: 307(0): This :BS
 move $a0, $v0
 # a0: 308(0): Member 307 *size :int
 lw $a0, 8($a0)
 # a0: 309(0): Lt 300 308 :boolean
 slt $a0, $t1, $a0 # a0: 310(0): NBranch 309 *lwhile_1396452035_end :void
 beq $a0, $zero, .lwhile_1396452035_end
 # a0: 311(0): Int *2 :int
 li $a0, 2
 # a0: 312(0): Mul 311 300 :int
 mul $a0, $a0, $t1
 # a3: 313(3): VarAssg 312 *aux01 :int
 move $a3, $a0
 # a0: 314(0): Int *3 :int
 li $a0, 3
 # a0: 315(0): Minus 305 314 :int
 sub $a0, $a1, $a0
 # t0: 316(4): VarAssg 315 *aux02 :int
 move $t0, $a0
 # a0: 317(0): This :BS
 move $a0, $v0
 # a0: 318(0): Member 317 *number :int[]
 lw $a0, 4($a0)
 # a2: 319(2): Plus 313 316 :int
 add $a2, $a3, $t0
 # a0: 320(0): IndexAssg 318 319 *300(5): VarAssg 299 *j :int :int
 mul $v1, $t1, 4
 add $v1, $v1, 4
 add $v1, $v1, $a0
 sw $a2, ($v1)
 move $a0, $a2
 # a0: 321(0): Int *1 :int
 li $a0, 1
 # a2: 322(2): Plus 300 321 :int
 add $a2, $t1, $a0
 # t1: 323(5): VarAssg 322 *j :int
 move $t1, $a2
 # a0: 324(0): Int *1 :int
 li $a0, 1
 # a2: 325(2): Minus 305 324 :int
 sub $a2, $a1, $a0
 # a1: 326(1): VarAssg 325 *k :int
 move $a1, $a2
 # a0: 327(0): Goto *lwhile_1396452035_start :void
 j .lwhile_1396452035_start
 # a0: 328(0): Label *lwhile_1396452035_end :void
 .lwhile_1396452035_end:
 # t0: 329(4): Unify 292 316 :int
 # a3: 330(3): Unify 293 313 :int
 # t1: 331(5): Unify 300 323 :int
 # a1: 332(1): Unify 305 326 :int
 # a0: 333(0): Int *0 :int
 li $a0, 0
 # a0: 334(0): Return 333 :void
 move $v0, $a0
 j .ret_mj__m_BS_Init
 .ret_mj__m_BS_Init:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra

