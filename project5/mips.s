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
 # a1: 0(1): NewObj *BBS :BBS
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 la $a0, mj__v_BBS
 li $a1, 3
 jal minijavaNew
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 # a0: 1(0): Int *10 :int
 li $a0, 10
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
mj__v_BBS:
 .word mj__m_BBS_Start
 .word mj__m_BBS_Sort
 .word mj__m_BBS_Print
 .word mj__m_BBS_Init
.text
mj__m_BBS_Start:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -20
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 5(0): Parameter *0 :int
 # a1: 6(1): VarAssg 5 *sz :int
 move $a1, $a0
 # a0: 7(0): Null *Type(int) :int
 move $a0, $zero
 # a2: 8(2): This :BBS
 move $a2, $v0
 # a0: 9(0): Arg 6 *0 :int
 move $a0, $a1
 # a0: 10(0): Call 8 *Init(9) :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 sw $a2, -16($fp)
 move $v0, $a2
 lw $v1, ($v0)
 lw $v1, 12($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 lw $a2, -16($fp)
 # a0: 11(0): VarAssg 10 *aux01 :int
 # a0: 12(0): This :BBS
 move $a0, $v0
 # a0: 13(0): Call 12 *Print() :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 sw $a2, -16($fp)
 move $v0, $a0
 lw $v1, ($v0)
 lw $v1, 8($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 lw $a2, -16($fp)
 # a0: 14(0): VarAssg 13 *aux01 :int
 # a0: 15(0): Int *99999 :int
 li $a0, 99999
 # a0: 16(0): Print 15 :void
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
 # a0: 17(0): This :BBS
 move $a0, $v0
 # a0: 18(0): Call 17 *Sort() :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 sw $a2, -16($fp)
 move $v0, $a0
 lw $v1, ($v0)
 lw $v1, 4($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 lw $a2, -16($fp)
 # a0: 19(0): VarAssg 18 *aux01 :int
 # a0: 20(0): This :BBS
 move $a0, $v0
 # a0: 21(0): Call 20 *Print() :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 sw $a2, -16($fp)
 move $v0, $a0
 lw $v1, ($v0)
 lw $v1, 8($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 lw $a2, -16($fp)
 # a0: 22(0): VarAssg 21 *aux01 :int
 # a0: 23(0): Int *0 :int
 li $a0, 0
 # a0: 24(0): Return 23 :void
 move $v0, $a0
 j .ret_mj__m_BBS_Start
 .ret_mj__m_BBS_Start:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
mj__m_BBS_Sort:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -52
 add $sp, $sp, -4
 sw $ra, ($sp)
 # t2: 25(6): Null *Type(int) :int
 move $t2, $zero
 # a0: 26(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 27(0): Null *Type(int) :int
 move $a0, $zero
 # t4: 28(8): Null *Type(int) :int
 move $t4, $zero
 # t5: 29(9): Null *Type(int) :int
 move $t5, $zero
 # t1: 30(5): Null *Type(int) :int
 move $t1, $zero
 # t3: 31(7): Null *Type(int) :int
 move $t3, $zero
 # a3: 32(3): Null *Type(int) :int
 move $a3, $zero
 # a2: 33(2): Null *Type(int) :int
 move $a2, $zero
 # a0: 34(0): This :BBS
 move $a0, $v0
 # a1: 35(1): Member 34 *size :int
 lw $a1, 8($a0)
 # a0: 36(0): Int *1 :int
 li $a0, 1
 # a0: 37(0): Minus 35 36 :int
 sub $a0, $a1, $a0
 # a1: 38(1): VarAssg 37 *i :int
 move $a1, $a0
 # a0: 39(0): Int *0 :int
 li $a0, 0
 # t0: 40(4): Int *1 :int
 li $t0, 1
 # a0: 41(0): Minus 39 40 :int
 sub $a0, $a0, $t0
 # t0: 42(4): VarAssg 41 *aux02 :int
 move $t0, $a0
 # a0: 43(0): Label *lwhile_682976601_start :void
 .lwhile_682976601_start:
 # a0: 44(0): Lt 42 38 :boolean
 slt $a0, $t0, $a1 # a0: 45(0): NBranch 44 *lwhile_682976601_end :void
 beq $a0, $zero, .lwhile_682976601_end
 # a0: 46(0): Int *1 :int
 li $a0, 1
 # a3: 47(3): VarAssg 46 *j :int
 move $a3, $a0
 # a0: 48(0): Label *lwhile_487639792_start :void
 .lwhile_487639792_start:
 # a0: 49(0): Int *1 :int
 li $a0, 1
 # a0: 50(0): Plus 38 49 :int
 add $a0, $a1, $a0
 # a0: 51(0): Lt 47 50 :boolean
 slt $a0, $a3, $a0 # a0: 52(0): NBranch 51 *lwhile_487639792_end :void
 beq $a0, $zero, .lwhile_487639792_end
 # a0: 53(0): Int *1 :int
 li $a0, 1
 # a0: 54(0): Minus 47 53 :int
 sub $a0, $a3, $a0
 # t3: 55(7): VarAssg 54 *aux07 :int
 move $t3, $a0
 # a0: 56(0): This :BBS
 move $a0, $v0
 # a0: 57(0): Member 56 *number :int[]
 lw $a0, 4($a0)
 # a0: 58(0): Index 57 55 :int
 mul $v1, $t3, 4
 add $v1, $v1, 4
 add $v1, $v1, $a0
 lw $a0, ($v1)
 # t4: 59(8): VarAssg 58 *aux04 :int
 move $t4, $a0
 # a0: 60(0): This :BBS
 move $a0, $v0
 # a0: 61(0): Member 60 *number :int[]
 lw $a0, 4($a0)
 # a0: 62(0): Index 61 47 :int
 mul $v1, $a3, 4
 add $v1, $v1, 4
 add $v1, $v1, $a0
 lw $a0, ($v1)
 # t5: 63(9): VarAssg 62 *aux05 :int
 move $t5, $a0
 # a0: 64(0): Lt 63 59 :boolean
 slt $a0, $t5, $t4 # a0: 65(0): NBranch 64 *lif_964387192_else :void
 beq $a0, $zero, .lif_964387192_else
 # a0: 66(0): Int *1 :int
 li $a0, 1
 # a0: 67(0): Minus 47 66 :int
 sub $a0, $a3, $a0
 # t1: 68(5): VarAssg 67 *aux06 :int
 move $t1, $a0
 # a0: 69(0): This :BBS
 move $a0, $v0
 # a0: 70(0): Member 69 *number :int[]
 lw $a0, 4($a0)
 # a0: 71(0): Index 70 68 :int
 mul $v1, $t1, 4
 add $v1, $v1, 4
 add $v1, $v1, $a0
 lw $a0, ($v1)
 # a2: 72(2): VarAssg 71 *t :int
 move $a2, $a0
 # a0: 73(0): This :BBS
 move $a0, $v0
 # a0: 74(0): Member 73 *number :int[]
 lw $a0, 4($a0)
 # t6: 75(10): This :BBS
 move $t6, $v0
 # t6: 76(10): Member 75 *number :int[]
 lw $t6, 4($t6)
 # t6: 77(10): Index 76 47 :int
 mul $v1, $a3, 4
 add $v1, $v1, 4
 add $v1, $v1, $t6
 lw $t6, ($v1)
 # a0: 78(0): IndexAssg 74 77 *68(5): VarAssg 67 *aux06 :int :int
 mul $v1, $t1, 4
 add $v1, $v1, 4
 add $v1, $v1, $a0
 sw $t6, ($v1)
 move $a0, $t6
 # a0: 79(0): Goto *lif_964387192_done :void
 j .lif_964387192_done
 # a0: 80(0): Label *lif_964387192_else :void
 .lif_964387192_else:
 # a0: 81(0): Int *0 :int
 li $a0, 0
 # t2: 82(6): VarAssg 81 *nt :int
 move $t2, $a0
 # a0: 83(0): Label *lif_964387192_done :void
 .lif_964387192_done:
 # t2: 84(6): Unify 25 82 :int
 # a2: 85(2): Unify 72 33 :int
 # t1: 86(5): Unify 68 30 :int
 # a0: 87(0): Int *1 :int
 li $a0, 1
 # a0: 88(0): Plus 47 87 :int
 add $a0, $a3, $a0
 # a3: 89(3): VarAssg 88 *j :int
 move $a3, $a0
 # a0: 90(0): Goto *lwhile_487639792_start :void
 j .lwhile_487639792_start
 # a0: 91(0): Label *lwhile_487639792_end :void
 .lwhile_487639792_end:
 # t2: 92(6): Unify 25 84 :int
 # a2: 93(2): Unify 33 85 :int
 # t3: 94(7): Unify 31 55 :int
 # t1: 95(5): Unify 30 86 :int
 # t5: 96(9): Unify 29 63 :int
 # t4: 97(8): Unify 28 59 :int
 # a3: 98(3): Unify 47 89 :int
 # a0: 99(0): Int *1 :int
 li $a0, 1
 # a0: 100(0): Minus 38 99 :int
 sub $a0, $a1, $a0
 # a1: 101(1): VarAssg 100 *i :int
 move $a1, $a0
 # a0: 102(0): Goto *lwhile_682976601_start :void
 j .lwhile_682976601_start
 # a0: 103(0): Label *lwhile_682976601_end :void
 .lwhile_682976601_end:
 # t2: 104(6): Unify 25 92 :int
 # a2: 105(2): Unify 33 93 :int
 # t3: 106(7): Unify 31 94 :int
 # t1: 107(5): Unify 30 95 :int
 # t5: 108(9): Unify 29 96 :int
 # t4: 109(8): Unify 28 97 :int
 # a3: 110(3): Unify 32 98 :int
 # a1: 111(1): Unify 38 101 :int
 # a0: 112(0): Int *0 :int
 li $a0, 0
 # a0: 113(0): Return 112 :void
 move $v0, $a0
 j .ret_mj__m_BBS_Sort
 .ret_mj__m_BBS_Sort:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
mj__m_BBS_Print:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -16
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 114(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 115(0): Int *0 :int
 li $a0, 0
 # a1: 116(1): VarAssg 115 *j :int
 move $a1, $a0
 # a0: 117(0): Label *lwhile_320574182_start :void
 .lwhile_320574182_start:
 # a0: 118(0): This :BBS
 move $a0, $v0
 # a0: 119(0): Member 118 *size :int
 lw $a0, 8($a0)
 # a0: 120(0): Lt 116 119 :boolean
 slt $a0, $a1, $a0 # a0: 121(0): NBranch 120 *lwhile_320574182_end :void
 beq $a0, $zero, .lwhile_320574182_end
 # a0: 122(0): This :BBS
 move $a0, $v0
 # a0: 123(0): Member 122 *number :int[]
 lw $a0, 4($a0)
 # a0: 124(0): Index 123 116 :int
 mul $v1, $a1, 4
 add $v1, $v1, 4
 add $v1, $v1, $a0
 lw $a0, ($v1)
 # a0: 125(0): Print 124 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 # a0: 126(0): Int *1 :int
 li $a0, 1
 # a0: 127(0): Plus 116 126 :int
 add $a0, $a1, $a0
 # a1: 128(1): VarAssg 127 *j :int
 move $a1, $a0
 # a0: 129(0): Goto *lwhile_320574182_start :void
 j .lwhile_320574182_start
 # a0: 130(0): Label *lwhile_320574182_end :void
 .lwhile_320574182_end:
 # a1: 131(1): Unify 116 128 :int
 # a0: 132(0): Int *0 :int
 li $a0, 0
 # a0: 133(0): Return 132 :void
 move $v0, $a0
 j .ret_mj__m_BBS_Print
 .ret_mj__m_BBS_Print:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
mj__m_BBS_Init:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -20
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 134(0): Parameter *0 :int
 # a0: 135(0): VarAssg 134 *sz :int
 # a1: 136(1): This :BBS
 move $a1, $v0
 # a1: 137(1): MemberAssg 136 135 *size :int
 sw $a0, 8($a1)
 move $a1, $a0
 # a1: 138(1): This :BBS
 move $a1, $v0
 # a0: 139(0): NewIntArray 135 :int[]
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 sw $a2, -16($fp)
 jal minijavaNewArray
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 lw $a2, -16($fp)
 # a0: 140(0): MemberAssg 138 139 *number :int[]
 sw $a0, 4($a1)
 # a0: 141(0): This :BBS
 move $a0, $v0
 # a0: 142(0): Member 141 *number :int[]
 lw $a0, 4($a0)
 # a2: 143(2): Int *0 :int
 li $a2, 0
 # a1: 144(1): Int *20 :int
 li $a1, 20
 # a0: 145(0): IndexAssg 142 144 *143(2): Int *0 :int :int
 mul $v1, $a2, 4
 add $v1, $v1, 4
 add $v1, $v1, $a0
 sw $a1, ($v1)
 move $a0, $a1
 # a0: 146(0): This :BBS
 move $a0, $v0
 # a0: 147(0): Member 146 *number :int[]
 lw $a0, 4($a0)
 # a2: 148(2): Int *1 :int
 li $a2, 1
 # a1: 149(1): Int *7 :int
 li $a1, 7
 # a0: 150(0): IndexAssg 147 149 *148(2): Int *1 :int :int
 mul $v1, $a2, 4
 add $v1, $v1, 4
 add $v1, $v1, $a0
 sw $a1, ($v1)
 move $a0, $a1
 # a0: 151(0): This :BBS
 move $a0, $v0
 # a2: 152(2): Member 151 *number :int[]
 lw $a2, 4($a0)
 # a0: 153(0): Int *2 :int
 li $a0, 2
 # a1: 154(1): Int *12 :int
 li $a1, 12
 # a0: 155(0): IndexAssg 152 154 *153(0): Int *2 :int :int
 mul $v1, $a0, 4
 add $v1, $v1, 4
 add $v1, $v1, $a2
 sw $a1, ($v1)
 move $a0, $a1
 # a0: 156(0): This :BBS
 move $a0, $v0
 # a2: 157(2): Member 156 *number :int[]
 lw $a2, 4($a0)
 # a0: 158(0): Int *3 :int
 li $a0, 3
 # a1: 159(1): Int *18 :int
 li $a1, 18
 # a0: 160(0): IndexAssg 157 159 *158(0): Int *3 :int :int
 mul $v1, $a0, 4
 add $v1, $v1, 4
 add $v1, $v1, $a2
 sw $a1, ($v1)
 move $a0, $a1
 # a0: 161(0): This :BBS
 move $a0, $v0
 # a1: 162(1): Member 161 *number :int[]
 lw $a1, 4($a0)
 # a2: 163(2): Int *4 :int
 li $a2, 4
 # a0: 164(0): Int *2 :int
 li $a0, 2
 # a0: 165(0): IndexAssg 162 164 *163(2): Int *4 :int :int
 mul $v1, $a2, 4
 add $v1, $v1, 4
 add $v1, $v1, $a1
 sw $a0, ($v1)
 # a0: 166(0): This :BBS
 move $a0, $v0
 # a2: 167(2): Member 166 *number :int[]
 lw $a2, 4($a0)
 # a0: 168(0): Int *5 :int
 li $a0, 5
 # a1: 169(1): Int *11 :int
 li $a1, 11
 # a0: 170(0): IndexAssg 167 169 *168(0): Int *5 :int :int
 mul $v1, $a0, 4
 add $v1, $v1, 4
 add $v1, $v1, $a2
 sw $a1, ($v1)
 move $a0, $a1
 # a0: 171(0): This :BBS
 move $a0, $v0
 # a2: 172(2): Member 171 *number :int[]
 lw $a2, 4($a0)
 # a0: 173(0): Int *6 :int
 li $a0, 6
 # a1: 174(1): Int *6 :int
 li $a1, 6
 # a0: 175(0): IndexAssg 172 174 *173(0): Int *6 :int :int
 mul $v1, $a0, 4
 add $v1, $v1, 4
 add $v1, $v1, $a2
 sw $a1, ($v1)
 move $a0, $a1
 # a0: 176(0): This :BBS
 move $a0, $v0
 # a1: 177(1): Member 176 *number :int[]
 lw $a1, 4($a0)
 # a2: 178(2): Int *7 :int
 li $a2, 7
 # a0: 179(0): Int *9 :int
 li $a0, 9
 # a0: 180(0): IndexAssg 177 179 *178(2): Int *7 :int :int
 mul $v1, $a2, 4
 add $v1, $v1, 4
 add $v1, $v1, $a1
 sw $a0, ($v1)
 # a0: 181(0): This :BBS
 move $a0, $v0
 # a0: 182(0): Member 181 *number :int[]
 lw $a0, 4($a0)
 # a1: 183(1): Int *8 :int
 li $a1, 8
 # a2: 184(2): Int *19 :int
 li $a2, 19
 # a0: 185(0): IndexAssg 182 184 *183(1): Int *8 :int :int
 mul $v1, $a1, 4
 add $v1, $v1, 4
 add $v1, $v1, $a0
 sw $a2, ($v1)
 move $a0, $a2
 # a0: 186(0): This :BBS
 move $a0, $v0
 # a0: 187(0): Member 186 *number :int[]
 lw $a0, 4($a0)
 # a1: 188(1): Int *9 :int
 li $a1, 9
 # a2: 189(2): Int *5 :int
 li $a2, 5
 # a0: 190(0): IndexAssg 187 189 *188(1): Int *9 :int :int
 mul $v1, $a1, 4
 add $v1, $v1, 4
 add $v1, $v1, $a0
 sw $a2, ($v1)
 move $a0, $a2
 # a0: 191(0): Int *0 :int
 li $a0, 0
 # a0: 192(0): Return 191 :void
 move $v0, $a0
 j .ret_mj__m_BBS_Init
 .ret_mj__m_BBS_Init:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra

