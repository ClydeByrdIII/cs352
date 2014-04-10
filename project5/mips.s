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
 add $sp, $sp, -20
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a1: 0(1): NewObj *BBS :BBS
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 la $a0, mj__v_BBS
 li $a1, 3
 jal minijavaNew
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 # a2: 1(2): Int *10 :int
 li $a2, 10
 # a0: 2(0): Arg 1 *0 :int
 move $a0, $a2
 # a1: 3(1): Call 0 *Start(2) :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 0($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 # a1: 4(1): Print 3 :void
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
 # a1: 7(1): Null *Type(int) :int
 move $a1, $zero
 # a1: 8(1): This :BBS
 move $a1, $v0
 # a0: 9(0): Arg 6 *0 :int
 move $a0, $a2
 # a1: 10(1): Call 8 *Init(9) :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 12($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 # a1: 11(1): VarAssg 10 *aux01 :int
 # a1: 12(1): This :BBS
 move $a1, $v0
 # a1: 13(1): Call 12 *Print() :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 8($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 # a1: 14(1): VarAssg 13 *aux01 :int
 # a1: 15(1): Int *99999 :int
 li $a1, 99999
 # a1: 16(1): Print 15 :void
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
 # a1: 17(1): This :BBS
 move $a1, $v0
 # a1: 18(1): Call 17 *Sort() :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 4($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 # a1: 19(1): VarAssg 18 *aux01 :int
 # a1: 20(1): This :BBS
 move $a1, $v0
 # a1: 21(1): Call 20 *Print() :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 8($v1)
 jal $v1
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 # a1: 22(1): VarAssg 21 *aux01 :int
 # a1: 23(1): Int *0 :int
 li $a1, 0
 # a1: 24(1): Return 23 :void
 move $v0, $a1
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
 add $sp, $sp, -48
 add $sp, $sp, -4
 sw $ra, ($sp)
 # t2: 25(6): Null *Type(int) :int
 move $t2, $zero
 # a0: 26(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 27(0): Null *Type(int) :int
 move $a0, $zero
 # t5: 28(9): Null *Type(int) :int
 move $t5, $zero
 # a2: 29(2): Null *Type(int) :int
 move $a2, $zero
 # a3: 30(3): Null *Type(int) :int
 move $a3, $zero
 # t0: 31(4): Null *Type(int) :int
 move $t0, $zero
 # t1: 32(5): Null *Type(int) :int
 move $t1, $zero
 # t4: 33(8): Null *Type(int) :int
 move $t4, $zero
 # a0: 34(0): This :BBS
 move $a0, $v0
 # a1: 35(1): Member 34 *size :int
 lw $a1, 8($a0)
 # a0: 36(0): Int *1 :int
 li $a0, 1
 # a0: 37(0): Minus 35 36 :int
 sub $a0, $a1, $a0
 # t3: 38(7): VarAssg 37 *i :int
 move $t3, $a0
 # a1: 39(1): Int *0 :int
 li $a1, 0
 # a0: 40(0): Int *1 :int
 li $a0, 1
 # a0: 41(0): Minus 39 40 :int
 sub $a0, $a1, $a0
 # a1: 42(1): VarAssg 41 *aux02 :int
 move $a1, $a0
 # a0: 43(0): Label *lwhile_753751532_start :void
 .lwhile_753751532_start:
 # a0: 44(0): Lt 42 38 :boolean
 slt $a0, $a1, $t3 # a0: 45(0): NBranch 44 *lwhile_753751532_end :void
 beq $a0, $zero, .lwhile_753751532_end
 # a0: 46(0): Int *1 :int
 li $a0, 1
 # t1: 47(5): VarAssg 46 *j :int
 move $t1, $a0
 # a0: 48(0): Label *lwhile_295964671_start :void
 .lwhile_295964671_start:
 # a0: 49(0): Int *1 :int
 li $a0, 1
 # a0: 50(0): Plus 38 49 :int
 add $a0, $t3, $a0
 # a0: 51(0): Lt 47 50 :boolean
 slt $a0, $t1, $a0 # a0: 52(0): NBranch 51 *lwhile_295964671_end :void
 beq $a0, $zero, .lwhile_295964671_end
 # a0: 53(0): Int *1 :int
 li $a0, 1
 # a0: 54(0): Minus 47 53 :int
 sub $a0, $t1, $a0
 # t0: 55(4): VarAssg 54 *aux07 :int
 move $t0, $a0
 # a0: 56(0): This :BBS
 move $a0, $v0
 # a0: 57(0): Member 56 *number :int[]
 lw $a0, 4($a0)
 # a0: 58(0): Index 57 55 :int
 mul $v1, $t0, 4
 add $v1, $v1, 4
 add $v1, $v1, $a0
 lw $a0, ($v1)
 # t5: 59(9): VarAssg 58 *aux04 :int
 move $t5, $a0
 # a0: 60(0): This :BBS
 move $a0, $v0
 # a0: 61(0): Member 60 *number :int[]
 lw $a0, 4($a0)
 # a0: 62(0): Index 61 47 :int
 mul $v1, $t1, 4
 add $v1, $v1, 4
 add $v1, $v1, $a0
 lw $a0, ($v1)
 # a2: 63(2): VarAssg 62 *aux05 :int
 move $a2, $a0
 # a0: 64(0): Lt 63 59 :boolean
 slt $a0, $a2, $t5 # a0: 65(0): NBranch 64 *lif_706099045_else :void
 beq $a0, $zero, .lif_706099045_else
 # a0: 66(0): Int *1 :int
 li $a0, 1
 # a0: 67(0): Minus 47 66 :int
 sub $a0, $t1, $a0
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
 # t4: 72(8): VarAssg 71 *t :int
 move $t4, $a0
 # a0: 73(0): This :BBS
 move $a0, $v0
 # a1: 74(1): Member 73 *number :int[]
 lw $a1, 4($a0)
 # a0: 75(0): This :BBS
 move $a0, $v0
 # a0: 76(0): Member 75 *number :int[]
 lw $a0, 4($a0)
 # a0: 77(0): Index 76 47 :int
 mul $v1, $t1, 4
 add $v1, $v1, 4
 add $v1, $v1, $a0
 lw $a0, ($v1)
 # a0: 78(0): IndexAssg 74 77 *68(3): VarAssg 67 *aux06 :int :int
 mul $v1, $a3, 4
 add $v1, $v1, 4
 add $v1, $v1, $a1
 sw $a0, ($v1)
 # a0: 79(0): This :BBS
 move $a0, $v0
 # a0: 80(0): Member 79 *number :int[]
 lw $a0, 4($a0)
 # a0: 81(0): IndexAssg 80 72 *47(5): VarAssg 46 *j :int :int
 mul $v1, $t1, 4
 add $v1, $v1, 4
 add $v1, $v1, $a0
 sw $t4, ($v1)
 move $a0, $t4
 # a0: 82(0): Goto *lif_706099045_done :void
 j .lif_706099045_done
 # a0: 83(0): Label *lif_706099045_else :void
 .lif_706099045_else:
 # a0: 84(0): Int *0 :int
 li $a0, 0
 # t2: 85(6): VarAssg 84 *nt :int
 move $t2, $a0
 # a0: 86(0): Label *lif_706099045_done :void
 .lif_706099045_done:
 # t2: 87(6): Unify 25 85 :int
 # t4: 88(8): Unify 72 33 :int
 # a3: 89(3): Unify 68 30 :int
 # a0: 90(0): Int *1 :int
 li $a0, 1
 # a0: 91(0): Plus 47 90 :int
 add $a0, $t1, $a0
 # t1: 92(5): VarAssg 91 *j :int
 move $t1, $a0
 # a0: 93(0): Goto *lwhile_295964671_start :void
 j .lwhile_295964671_start
 # a0: 94(0): Label *lwhile_295964671_end :void
 .lwhile_295964671_end:
 # t2: 95(6): Unify 25 87 :int
 # t4: 96(8): Unify 33 88 :int
 # t0: 97(4): Unify 31 55 :int
 # a3: 98(3): Unify 30 89 :int
 # a2: 99(2): Unify 29 63 :int
 # t5: 100(9): Unify 28 59 :int
 # t1: 101(5): Unify 47 92 :int
 # a0: 102(0): Int *1 :int
 li $a0, 1
 # a0: 103(0): Minus 38 102 :int
 sub $a0, $t3, $a0
 # t3: 104(7): VarAssg 103 *i :int
 move $t3, $a0
 # a0: 105(0): Goto *lwhile_753751532_start :void
 j .lwhile_753751532_start
 # a0: 106(0): Label *lwhile_753751532_end :void
 .lwhile_753751532_end:
 # t2: 107(6): Unify 25 95 :int
 # t4: 108(8): Unify 33 96 :int
 # t0: 109(4): Unify 31 97 :int
 # a3: 110(3): Unify 30 98 :int
 # a2: 111(2): Unify 29 99 :int
 # t5: 112(9): Unify 28 100 :int
 # t1: 113(5): Unify 32 101 :int
 # t3: 114(7): Unify 38 104 :int
 # a0: 115(0): Int *0 :int
 li $a0, 0
 # a0: 116(0): Return 115 :void
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
 # a0: 117(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 118(0): Int *0 :int
 li $a0, 0
 # a1: 119(1): VarAssg 118 *j :int
 move $a1, $a0
 # a0: 120(0): Label *lwhile_1265516423_start :void
 .lwhile_1265516423_start:
 # a0: 121(0): This :BBS
 move $a0, $v0
 # a0: 122(0): Member 121 *size :int
 lw $a0, 8($a0)
 # a0: 123(0): Lt 119 122 :boolean
 slt $a0, $a1, $a0 # a0: 124(0): NBranch 123 *lwhile_1265516423_end :void
 beq $a0, $zero, .lwhile_1265516423_end
 # a0: 125(0): This :BBS
 move $a0, $v0
 # a0: 126(0): Member 125 *number :int[]
 lw $a0, 4($a0)
 # a0: 127(0): Index 126 119 :int
 mul $v1, $a1, 4
 add $v1, $v1, 4
 add $v1, $v1, $a0
 lw $a0, ($v1)
 # a0: 128(0): Print 127 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 # a0: 129(0): Int *1 :int
 li $a0, 1
 # a0: 130(0): Plus 119 129 :int
 add $a0, $a1, $a0
 # a1: 131(1): VarAssg 130 *j :int
 move $a1, $a0
 # a0: 132(0): Goto *lwhile_1265516423_start :void
 j .lwhile_1265516423_start
 # a0: 133(0): Label *lwhile_1265516423_end :void
 .lwhile_1265516423_end:
 # a1: 134(1): Unify 119 131 :int
 # a0: 135(0): Int *0 :int
 li $a0, 0
 # a0: 136(0): Return 135 :void
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
 add $sp, $sp, -24
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 137(0): Parameter *0 :int
 # a2: 138(2): VarAssg 137 *sz :int
 move $a2, $a0
 # a1: 139(1): This :BBS
 move $a1, $v0
 # a1: 140(1): MemberAssg 139 138 *size :int
 sw $a2, 8($a1)
 move $a1, $a2
 # a3: 141(3): This :BBS
 move $a3, $v0
 # a1: 142(1): NewIntArray 138 :int[]
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $a0, $a2
 jal minijavaNewArray
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 143(1): MemberAssg 141 142 *number :int[]
 sw $a1, 4($a3)
 # a1: 144(1): This :BBS
 move $a1, $v0
 # a1: 145(1): Member 144 *number :int[]
 lw $a1, 4($a1)
 # a2: 146(2): Int *0 :int
 li $a2, 0
 # a3: 147(3): Int *20 :int
 li $a3, 20
 # a1: 148(1): IndexAssg 145 147 *146(2): Int *0 :int :int
 mul $v1, $a2, 4
 add $v1, $v1, 4
 add $v1, $v1, $a1
 sw $a3, ($v1)
 move $a1, $a3
 # a1: 149(1): This :BBS
 move $a1, $v0
 # a1: 150(1): Member 149 *number :int[]
 lw $a1, 4($a1)
 # a2: 151(2): Int *1 :int
 li $a2, 1
 # a3: 152(3): Int *7 :int
 li $a3, 7
 # a1: 153(1): IndexAssg 150 152 *151(2): Int *1 :int :int
 mul $v1, $a2, 4
 add $v1, $v1, 4
 add $v1, $v1, $a1
 sw $a3, ($v1)
 move $a1, $a3
 # a1: 154(1): This :BBS
 move $a1, $v0
 # a2: 155(2): Member 154 *number :int[]
 lw $a2, 4($a1)
 # a3: 156(3): Int *2 :int
 li $a3, 2
 # a1: 157(1): Int *12 :int
 li $a1, 12
 # a1: 158(1): IndexAssg 155 157 *156(3): Int *2 :int :int
 mul $v1, $a3, 4
 add $v1, $v1, 4
 add $v1, $v1, $a2
 sw $a1, ($v1)
 # a1: 159(1): This :BBS
 move $a1, $v0
 # a1: 160(1): Member 159 *number :int[]
 lw $a1, 4($a1)
 # a3: 161(3): Int *3 :int
 li $a3, 3
 # a2: 162(2): Int *18 :int
 li $a2, 18
 # a1: 163(1): IndexAssg 160 162 *161(3): Int *3 :int :int
 mul $v1, $a3, 4
 add $v1, $v1, 4
 add $v1, $v1, $a1
 sw $a2, ($v1)
 move $a1, $a2
 # a1: 164(1): This :BBS
 move $a1, $v0
 # a3: 165(3): Member 164 *number :int[]
 lw $a3, 4($a1)
 # a1: 166(1): Int *4 :int
 li $a1, 4
 # a2: 167(2): Int *2 :int
 li $a2, 2
 # a1: 168(1): IndexAssg 165 167 *166(1): Int *4 :int :int
 mul $v1, $a1, 4
 add $v1, $v1, 4
 add $v1, $v1, $a3
 sw $a2, ($v1)
 move $a1, $a2
 # a1: 169(1): This :BBS
 move $a1, $v0
 # a2: 170(2): Member 169 *number :int[]
 lw $a2, 4($a1)
 # a1: 171(1): Int *5 :int
 li $a1, 5
 # a3: 172(3): Int *11 :int
 li $a3, 11
 # a1: 173(1): IndexAssg 170 172 *171(1): Int *5 :int :int
 mul $v1, $a1, 4
 add $v1, $v1, 4
 add $v1, $v1, $a2
 sw $a3, ($v1)
 move $a1, $a3
 # a1: 174(1): This :BBS
 move $a1, $v0
 # a2: 175(2): Member 174 *number :int[]
 lw $a2, 4($a1)
 # a1: 176(1): Int *6 :int
 li $a1, 6
 # a3: 177(3): Int *6 :int
 li $a3, 6
 # a1: 178(1): IndexAssg 175 177 *176(1): Int *6 :int :int
 mul $v1, $a1, 4
 add $v1, $v1, 4
 add $v1, $v1, $a2
 sw $a3, ($v1)
 move $a1, $a3
 # a1: 179(1): This :BBS
 move $a1, $v0
 # a2: 180(2): Member 179 *number :int[]
 lw $a2, 4($a1)
 # a3: 181(3): Int *7 :int
 li $a3, 7
 # a1: 182(1): Int *9 :int
 li $a1, 9
 # a1: 183(1): IndexAssg 180 182 *181(3): Int *7 :int :int
 mul $v1, $a3, 4
 add $v1, $v1, 4
 add $v1, $v1, $a2
 sw $a1, ($v1)
 # a1: 184(1): This :BBS
 move $a1, $v0
 # a2: 185(2): Member 184 *number :int[]
 lw $a2, 4($a1)
 # a3: 186(3): Int *8 :int
 li $a3, 8
 # a1: 187(1): Int *19 :int
 li $a1, 19
 # a1: 188(1): IndexAssg 185 187 *186(3): Int *8 :int :int
 mul $v1, $a3, 4
 add $v1, $v1, 4
 add $v1, $v1, $a2
 sw $a1, ($v1)
 # a1: 189(1): This :BBS
 move $a1, $v0
 # a1: 190(1): Member 189 *number :int[]
 lw $a1, 4($a1)
 # a3: 191(3): Int *9 :int
 li $a3, 9
 # a2: 192(2): Int *5 :int
 li $a2, 5
 # a1: 193(1): IndexAssg 190 192 *191(3): Int *9 :int :int
 mul $v1, $a3, 4
 add $v1, $v1, 4
 add $v1, $v1, $a1
 sw $a2, ($v1)
 move $a1, $a2
 # a1: 194(1): Int *0 :int
 li $a1, 0
 # a1: 195(1): Return 194 :void
 move $v0, $a1
 j .ret_mj__m_BBS_Init
 .ret_mj__m_BBS_Init:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra

