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
 # a2: 6(2): VarAssg 5 *sz :int
 move $a2, $a0
 # a0: 7(0): Null *Type(int) :int
 move $a0, $zero
 # a1: 8(1): This :BBS
 move $a1, $v0
 # a0: 9(0): Arg 6 *0 :int
 move $a0, $a2
 # a0: 10(0): Call 8 *Init(9) :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 sw $a2, -16($fp)
 move $v0, $a1
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
 # a2: 25(2): Null *Type(int) :int
 move $a2, $zero
 # a0: 26(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 27(0): Null *Type(int) :int
 move $a0, $zero
 # t4: 28(8): Null *Type(int) :int
 move $t4, $zero
 # t6: 29(10): Null *Type(int) :int
 move $t6, $zero
 # a3: 30(3): Null *Type(int) :int
 move $a3, $zero
 # t3: 31(7): Null *Type(int) :int
 move $t3, $zero
 # a1: 32(1): Null *Type(int) :int
 move $a1, $zero
 # t2: 33(6): Null *Type(int) :int
 move $t2, $zero
 # a0: 34(0): This :BBS
 move $a0, $v0
 # t0: 35(4): Member 34 *size :int
 lw $t0, 8($a0)
 # a0: 36(0): Int *1 :int
 li $a0, 1
 # a0: 37(0): Minus 35 36 :int
 sub $a0, $t0, $a0
 # t0: 38(4): VarAssg 37 *i :int
 move $t0, $a0
 # t1: 39(5): Int *0 :int
 li $t1, 0
 # a0: 40(0): Int *1 :int
 li $a0, 1
 # a0: 41(0): Minus 39 40 :int
 sub $a0, $t1, $a0
 # t1: 42(5): VarAssg 41 *aux02 :int
 move $t1, $a0
 # a0: 43(0): Label *lwhile_753751532_start :void
 .lwhile_753751532_start:
 # a0: 44(0): Lt 42 38 :boolean
 slt $a0, $t1, $t0 # a0: 45(0): NBranch 44 *lwhile_753751532_end :void
 beq $a0, $zero, .lwhile_753751532_end
 # a0: 46(0): Int *1 :int
 li $a0, 1
 # a1: 47(1): VarAssg 46 *j :int
 move $a1, $a0
 # a0: 48(0): Label *lwhile_295964671_start :void
 .lwhile_295964671_start:
 # a0: 49(0): Int *1 :int
 li $a0, 1
 # a0: 50(0): Plus 38 49 :int
 add $a0, $t0, $a0
 # a0: 51(0): Lt 47 50 :boolean
 slt $a0, $a1, $a0 # a0: 52(0): NBranch 51 *lwhile_295964671_end :void
 beq $a0, $zero, .lwhile_295964671_end
 # a0: 53(0): Int *1 :int
 li $a0, 1
 # a0: 54(0): Minus 47 53 :int
 sub $a0, $a1, $a0
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
 mul $v1, $a1, 4
 add $v1, $v1, 4
 add $v1, $v1, $a0
 lw $a0, ($v1)
 # t6: 63(10): VarAssg 62 *aux05 :int
 move $t6, $a0
 # a0: 64(0): Lt 63 59 :boolean
 slt $a0, $t6, $t4 # a0: 65(0): NBranch 64 *lif_706099045_else :void
 beq $a0, $zero, .lif_706099045_else
 # a0: 66(0): Int *1 :int
 li $a0, 1
 # a0: 67(0): Minus 47 66 :int
 sub $a0, $a1, $a0
 # a3: 68(3): VarAssg 67 *aux06 :int
 move $a3, $a0
 # a0: 69(0): This :BBS
 move $a0, $v0
 # a0: 70(0): Member 69 *number :int[]
 lw $a0, 4($a0)
 # a0: 71(0): Index 70 68 :int
 mul $v1, $a3, 4
 add $v1, $v1, 4
 add $v1, $v1, $a0
 lw $a0, ($v1)
 # t2: 72(6): VarAssg 71 *t :int
 move $t2, $a0
 # a0: 73(0): This :BBS
 move $a0, $v0
 # a0: 74(0): Member 73 *number :int[]
 lw $a0, 4($a0)
 # t5: 75(9): This :BBS
 move $t5, $v0
 # t5: 76(9): Member 75 *number :int[]
 lw $t5, 4($t5)
 # t5: 77(9): Index 76 47 :int
 mul $v1, $a1, 4
 add $v1, $v1, 4
 add $v1, $v1, $t5
 lw $t5, ($v1)
 # a0: 78(0): IndexAssg 74 77 *68(3): VarAssg 67 *aux06 :int :int
 mul $v1, $a3, 4
 add $v1, $v1, 4
 add $v1, $v1, $a0
 sw $t5, ($v1)
 move $a0, $t5
 # a0: 79(0): Goto *lif_706099045_done :void
 j .lif_706099045_done
 # a0: 80(0): Label *lif_706099045_else :void
 .lif_706099045_else:
 # a0: 81(0): Int *0 :int
 li $a0, 0
 # a2: 82(2): VarAssg 81 *nt :int
 move $a2, $a0
 # a0: 83(0): Label *lif_706099045_done :void
 .lif_706099045_done:
 # a2: 84(2): Unify 25 82 :int
 # t2: 85(6): Unify 72 33 :int
 # a3: 86(3): Unify 68 30 :int
 # a0: 87(0): Int *1 :int
 li $a0, 1
 # a0: 88(0): Plus 47 87 :int
 add $a0, $a1, $a0
 # a1: 89(1): VarAssg 88 *j :int
 move $a1, $a0
 # a0: 90(0): Goto *lwhile_295964671_start :void
 j .lwhile_295964671_start
 # a0: 91(0): Label *lwhile_295964671_end :void
 .lwhile_295964671_end:
 # a2: 92(2): Unify 25 84 :int
 # t2: 93(6): Unify 33 85 :int
 # t3: 94(7): Unify 31 55 :int
 # a3: 95(3): Unify 30 86 :int
 # t6: 96(10): Unify 29 63 :int
 # t4: 97(8): Unify 28 59 :int
 # a1: 98(1): Unify 47 89 :int
 # a0: 99(0): Int *1 :int
 li $a0, 1
 # a0: 100(0): Minus 38 99 :int
 sub $a0, $t0, $a0
 # t0: 101(4): VarAssg 100 *i :int
 move $t0, $a0
 # a0: 102(0): Goto *lwhile_753751532_start :void
 j .lwhile_753751532_start
 # a0: 103(0): Label *lwhile_753751532_end :void
 .lwhile_753751532_end:
 # a2: 104(2): Unify 25 92 :int
 # t2: 105(6): Unify 33 93 :int
 # t3: 106(7): Unify 31 94 :int
 # a3: 107(3): Unify 30 95 :int
 # t6: 108(10): Unify 29 96 :int
 # t4: 109(8): Unify 28 97 :int
 # a1: 110(1): Unify 32 98 :int
 # t0: 111(4): Unify 38 101 :int
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
 # a0: 117(0): Label *lwhile_1265516423_start :void
 .lwhile_1265516423_start:
 # a0: 118(0): This :BBS
 move $a0, $v0
 # a0: 119(0): Member 118 *size :int
 lw $a0, 8($a0)
 # a0: 120(0): Lt 116 119 :boolean
 slt $a0, $a1, $a0 # a0: 121(0): NBranch 120 *lwhile_1265516423_end :void
 beq $a0, $zero, .lwhile_1265516423_end
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
 # a0: 129(0): Goto *lwhile_1265516423_start :void
 j .lwhile_1265516423_start
 # a0: 130(0): Label *lwhile_1265516423_end :void
 .lwhile_1265516423_end:
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
 # a2: 147(2): Member 146 *number :int[]
 lw $a2, 4($a0)
 # a1: 148(1): Int *1 :int
 li $a1, 1
 # a0: 149(0): Int *7 :int
 li $a0, 7
 # a0: 150(0): IndexAssg 147 149 *148(1): Int *1 :int :int
 mul $v1, $a1, 4
 add $v1, $v1, 4
 add $v1, $v1, $a2
 sw $a0, ($v1)
 # a0: 151(0): This :BBS
 move $a0, $v0
 # a1: 152(1): Member 151 *number :int[]
 lw $a1, 4($a0)
 # a0: 153(0): Int *2 :int
 li $a0, 2
 # a2: 154(2): Int *12 :int
 li $a2, 12
 # a0: 155(0): IndexAssg 152 154 *153(0): Int *2 :int :int
 mul $v1, $a0, 4
 add $v1, $v1, 4
 add $v1, $v1, $a1
 sw $a2, ($v1)
 move $a0, $a2
 # a0: 156(0): This :BBS
 move $a0, $v0
 # a0: 157(0): Member 156 *number :int[]
 lw $a0, 4($a0)
 # a1: 158(1): Int *3 :int
 li $a1, 3
 # a2: 159(2): Int *18 :int
 li $a2, 18
 # a0: 160(0): IndexAssg 157 159 *158(1): Int *3 :int :int
 mul $v1, $a1, 4
 add $v1, $v1, 4
 add $v1, $v1, $a0
 sw $a2, ($v1)
 move $a0, $a2
 # a0: 161(0): This :BBS
 move $a0, $v0
 # a2: 162(2): Member 161 *number :int[]
 lw $a2, 4($a0)
 # a0: 163(0): Int *4 :int
 li $a0, 4
 # a1: 164(1): Int *2 :int
 li $a1, 2
 # a0: 165(0): IndexAssg 162 164 *163(0): Int *4 :int :int
 mul $v1, $a0, 4
 add $v1, $v1, 4
 add $v1, $v1, $a2
 sw $a1, ($v1)
 move $a0, $a1
 # a0: 166(0): This :BBS
 move $a0, $v0
 # a1: 167(1): Member 166 *number :int[]
 lw $a1, 4($a0)
 # a2: 168(2): Int *5 :int
 li $a2, 5
 # a0: 169(0): Int *11 :int
 li $a0, 11
 # a0: 170(0): IndexAssg 167 169 *168(2): Int *5 :int :int
 mul $v1, $a2, 4
 add $v1, $v1, 4
 add $v1, $v1, $a1
 sw $a0, ($v1)
 # a0: 171(0): This :BBS
 move $a0, $v0
 # a2: 172(2): Member 171 *number :int[]
 lw $a2, 4($a0)
 # a1: 173(1): Int *6 :int
 li $a1, 6
 # a0: 174(0): Int *6 :int
 li $a0, 6
 # a0: 175(0): IndexAssg 172 174 *173(1): Int *6 :int :int
 mul $v1, $a1, 4
 add $v1, $v1, 4
 add $v1, $v1, $a2
 sw $a0, ($v1)
 # a0: 176(0): This :BBS
 move $a0, $v0
 # a1: 177(1): Member 176 *number :int[]
 lw $a1, 4($a0)
 # a0: 178(0): Int *7 :int
 li $a0, 7
 # a2: 179(2): Int *9 :int
 li $a2, 9
 # a0: 180(0): IndexAssg 177 179 *178(0): Int *7 :int :int
 mul $v1, $a0, 4
 add $v1, $v1, 4
 add $v1, $v1, $a1
 sw $a2, ($v1)
 move $a0, $a2
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
 # a1: 187(1): Member 186 *number :int[]
 lw $a1, 4($a0)
 # a2: 188(2): Int *9 :int
 li $a2, 9
 # a0: 189(0): Int *5 :int
 li $a0, 5
 # a0: 190(0): IndexAssg 187 189 *188(2): Int *9 :int :int
 mul $v1, $a2, 4
 add $v1, $v1, 4
 add $v1, $v1, $a1
 sw $a0, ($v1)
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

