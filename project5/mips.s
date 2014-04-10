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
 # a1: 6(1): VarAssg 5 *sz :int
 move $a1, $a0
 # a2: 7(2): Null *Type(int) :int
 move $a2, $zero
 # a2: 8(2): This :BBS
 move $a2, $v0
 # a0: 9(0): Arg 6 *0 :int
 move $a0, $a1
 # a1: 10(1): Call 8 *Init(9) :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 move $v0, $a2
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
 # a1: 25(1): Null *Type(int) :int
 move $a1, $zero
 # a0: 26(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 27(0): Null *Type(int) :int
 move $a0, $zero
 # t4: 28(8): Null *Type(int) :int
 move $t4, $zero
 # t5: 29(9): Null *Type(int) :int
 move $t5, $zero
 # t2: 30(6): Null *Type(int) :int
 move $t2, $zero
 # t3: 31(7): Null *Type(int) :int
 move $t3, $zero
 # t1: 32(5): Null *Type(int) :int
 move $t1, $zero
 # a3: 33(3): Null *Type(int) :int
 move $a3, $zero
 # a0: 34(0): This :BBS
 move $a0, $v0
 # a0: 35(0): Member 34 *size :int
 lw $a0, 8($a0)
 # a2: 36(2): Int *1 :int
 li $a2, 1
 # a0: 37(0): Minus 35 36 :int
 sub $a0, $a0, $a2
 # t0: 38(4): VarAssg 37 *i :int
 move $t0, $a0
 # a0: 39(0): Int *0 :int
 li $a0, 0
 # a2: 40(2): Int *1 :int
 li $a2, 1
 # a0: 41(0): Minus 39 40 :int
 sub $a0, $a0, $a2
 # a2: 42(2): VarAssg 41 *aux02 :int
 move $a2, $a0
 # a0: 43(0): Label *lwhile_295964671_start :void
 .lwhile_295964671_start:
 # a0: 44(0): Lt 42 38 :boolean
 slt $a0, $a2, $t0 # a0: 45(0): NBranch 44 *lwhile_295964671_end :void
 beq $a0, $zero, .lwhile_295964671_end
 # a0: 46(0): Int *1 :int
 li $a0, 1
 # t1: 47(5): VarAssg 46 *j :int
 move $t1, $a0
 # a0: 48(0): Label *lwhile_706099045_start :void
 .lwhile_706099045_start:
 # a0: 49(0): Int *1 :int
 li $a0, 1
 # a0: 50(0): Plus 38 49 :int
 add $a0, $t0, $a0
 # a0: 51(0): Lt 47 50 :boolean
 slt $a0, $t1, $a0 # a0: 52(0): NBranch 51 *lwhile_706099045_end :void
 beq $a0, $zero, .lwhile_706099045_end
 # a0: 53(0): Int *1 :int
 li $a0, 1
 # a0: 54(0): Minus 47 53 :int
 sub $a0, $t1, $a0
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
 mul $v1, $t1, 4
 add $v1, $v1, 4
 add $v1, $v1, $a0
 lw $a0, ($v1)
 # t5: 63(9): VarAssg 62 *aux05 :int
 move $t5, $a0
 # a0: 64(0): Lt 63 59 :boolean
 slt $a0, $t5, $t4 # a0: 65(0): NBranch 64 *lif_412015993_else :void
 beq $a0, $zero, .lif_412015993_else
 # a0: 66(0): Int *1 :int
 li $a0, 1
 # a0: 67(0): Minus 47 66 :int
 sub $a0, $t1, $a0
 # t2: 68(6): VarAssg 67 *aux06 :int
 move $t2, $a0
 # a0: 69(0): This :BBS
 move $a0, $v0
 # a0: 70(0): Member 69 *number :int[]
 lw $a0, 4($a0)
 # a0: 71(0): Index 70 68 :int
 mul $v1, $t2, 4
 add $v1, $v1, 4
 add $v1, $v1, $a0
 lw $a0, ($v1)
 # a3: 72(3): VarAssg 71 *t :int
 move $a3, $a0
 # a0: 73(0): This :BBS
 move $a0, $v0
 # a2: 74(2): Member 73 *number :int[]
 lw $a2, 4($a0)
 # a0: 75(0): This :BBS
 move $a0, $v0
 # a0: 76(0): Member 75 *number :int[]
 lw $a0, 4($a0)
 # a0: 77(0): Index 76 47 :int
 mul $v1, $t1, 4
 add $v1, $v1, 4
 add $v1, $v1, $a0
 lw $a0, ($v1)
 # a0: 78(0): IndexAssg 74 77 *68(6): VarAssg 67 *aux06 :int :int
 mul $v1, $t2, 4
 add $v1, $v1, 4
 add $v1, $v1, $a2
 sw $a0, ($v1)
 # a0: 79(0): This :BBS
 move $a0, $v0
 # a0: 80(0): Member 79 *number :int[]
 lw $a0, 4($a0)
 # a0: 81(0): IndexAssg 80 72 *47(5): VarAssg 46 *j :int :int
 mul $v1, $t1, 4
 add $v1, $v1, 4
 add $v1, $v1, $a0
 sw $a3, ($v1)
 move $a0, $a3
 # a0: 82(0): Goto *lif_412015993_done :void
 j .lif_412015993_done
 # a0: 83(0): Label *lif_412015993_else :void
 .lif_412015993_else:
 # a0: 84(0): Int *0 :int
 li $a0, 0
 # a1: 85(1): VarAssg 84 *nt :int
 move $a1, $a0
 # a0: 86(0): Label *lif_412015993_done :void
 .lif_412015993_done:
 # a1: 87(1): Unify 25 85 :int
 # a3: 88(3): Unify 72 33 :int
 # t2: 89(6): Unify 68 30 :int
 # a0: 90(0): Int *1 :int
 li $a0, 1
 # a0: 91(0): Plus 47 90 :int
 add $a0, $t1, $a0
 # t1: 92(5): VarAssg 91 *j :int
 move $t1, $a0
 # a0: 93(0): Goto *lwhile_706099045_start :void
 j .lwhile_706099045_start
 # a0: 94(0): Label *lwhile_706099045_end :void
 .lwhile_706099045_end:
 # a1: 95(1): Unify 25 87 :int
 # a3: 96(3): Unify 33 88 :int
 # t3: 97(7): Unify 31 55 :int
 # t2: 98(6): Unify 30 89 :int
 # t5: 99(9): Unify 29 63 :int
 # t4: 100(8): Unify 28 59 :int
 # t1: 101(5): Unify 47 92 :int
 # a0: 102(0): Int *1 :int
 li $a0, 1
 # a0: 103(0): Minus 38 102 :int
 sub $a0, $t0, $a0
 # t0: 104(4): VarAssg 103 *i :int
 move $t0, $a0
 # a0: 105(0): Goto *lwhile_295964671_start :void
 j .lwhile_295964671_start
 # a0: 106(0): Label *lwhile_295964671_end :void
 .lwhile_295964671_end:
 # a1: 107(1): Unify 25 95 :int
 # a3: 108(3): Unify 33 96 :int
 # t3: 109(7): Unify 31 97 :int
 # t2: 110(6): Unify 30 98 :int
 # t5: 111(9): Unify 29 99 :int
 # t4: 112(8): Unify 28 100 :int
 # t1: 113(5): Unify 32 101 :int
 # t0: 114(4): Unify 38 104 :int
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
 # a0: 119(0): VarAssg 118 *j :int
 # a1: 120(1): Label *lwhile_856481473_start :void
 .lwhile_856481473_start:
 # a1: 121(1): This :BBS
 move $a1, $v0
 # a1: 122(1): Member 121 *size :int
 lw $a1, 8($a1)
 # a1: 123(1): Lt 119 122 :boolean
 slt $a1, $a0, $a1 # a1: 124(1): NBranch 123 *lwhile_856481473_end :void
 beq $a1, $zero, .lwhile_856481473_end
 # a1: 125(1): This :BBS
 move $a1, $v0
 # a1: 126(1): Member 125 *number :int[]
 lw $a1, 4($a1)
 # a1: 127(1): Index 126 119 :int
 mul $v1, $a0, 4
 add $v1, $v1, 4
 add $v1, $v1, $a1
 lw $a1, ($v1)
 # a1: 128(1): Print 127 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 move $a0, $a1
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 # a1: 129(1): Int *1 :int
 li $a1, 1
 # a0: 130(0): Plus 119 129 :int
 add $a0, $a0, $a1
 # a0: 131(0): VarAssg 130 *j :int
 # a1: 132(1): Goto *lwhile_856481473_start :void
 j .lwhile_856481473_start
 # a1: 133(1): Label *lwhile_856481473_end :void
 .lwhile_856481473_end:
 # a0: 134(0): Unify 119 131 :int
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
 # a3: 138(3): VarAssg 137 *sz :int
 move $a3, $a0
 # a1: 139(1): This :BBS
 move $a1, $v0
 # a1: 140(1): MemberAssg 139 138 *size :int
 sw $a3, 8($a1)
 move $a1, $a3
 # a2: 141(2): This :BBS
 move $a2, $v0
 # a1: 142(1): NewIntArray 138 :int[]
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 move $a0, $a3
 jal minijavaNewArray
 move $a1, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 # a1: 143(1): MemberAssg 141 142 *number :int[]
 sw $a1, 4($a2)
 # a1: 144(1): This :BBS
 move $a1, $v0
 # a2: 145(2): Member 144 *number :int[]
 lw $a2, 4($a1)
 # a3: 146(3): Int *0 :int
 li $a3, 0
 # a1: 147(1): Int *20 :int
 li $a1, 20
 # a1: 148(1): IndexAssg 145 147 *146(3): Int *0 :int :int
 mul $v1, $a3, 4
 add $v1, $v1, 4
 add $v1, $v1, $a2
 sw $a1, ($v1)
 # a1: 149(1): This :BBS
 move $a1, $v0
 # a3: 150(3): Member 149 *number :int[]
 lw $a3, 4($a1)
 # a2: 151(2): Int *1 :int
 li $a2, 1
 # a1: 152(1): Int *7 :int
 li $a1, 7
 # a1: 153(1): IndexAssg 150 152 *151(2): Int *1 :int :int
 mul $v1, $a2, 4
 add $v1, $v1, 4
 add $v1, $v1, $a3
 sw $a1, ($v1)
 # a1: 154(1): This :BBS
 move $a1, $v0
 # a3: 155(3): Member 154 *number :int[]
 lw $a3, 4($a1)
 # a1: 156(1): Int *2 :int
 li $a1, 2
 # a2: 157(2): Int *12 :int
 li $a2, 12
 # a1: 158(1): IndexAssg 155 157 *156(1): Int *2 :int :int
 mul $v1, $a1, 4
 add $v1, $v1, 4
 add $v1, $v1, $a3
 sw $a2, ($v1)
 move $a1, $a2
 # a1: 159(1): This :BBS
 move $a1, $v0
 # a1: 160(1): Member 159 *number :int[]
 lw $a1, 4($a1)
 # a2: 161(2): Int *3 :int
 li $a2, 3
 # a3: 162(3): Int *18 :int
 li $a3, 18
 # a1: 163(1): IndexAssg 160 162 *161(2): Int *3 :int :int
 mul $v1, $a2, 4
 add $v1, $v1, 4
 add $v1, $v1, $a1
 sw $a3, ($v1)
 move $a1, $a3
 # a1: 164(1): This :BBS
 move $a1, $v0
 # a1: 165(1): Member 164 *number :int[]
 lw $a1, 4($a1)
 # a3: 166(3): Int *4 :int
 li $a3, 4
 # a2: 167(2): Int *2 :int
 li $a2, 2
 # a1: 168(1): IndexAssg 165 167 *166(3): Int *4 :int :int
 mul $v1, $a3, 4
 add $v1, $v1, 4
 add $v1, $v1, $a1
 sw $a2, ($v1)
 move $a1, $a2
 # a1: 169(1): This :BBS
 move $a1, $v0
 # a1: 170(1): Member 169 *number :int[]
 lw $a1, 4($a1)
 # a3: 171(3): Int *5 :int
 li $a3, 5
 # a2: 172(2): Int *11 :int
 li $a2, 11
 # a1: 173(1): IndexAssg 170 172 *171(3): Int *5 :int :int
 mul $v1, $a3, 4
 add $v1, $v1, 4
 add $v1, $v1, $a1
 sw $a2, ($v1)
 move $a1, $a2
 # a1: 174(1): This :BBS
 move $a1, $v0
 # a3: 175(3): Member 174 *number :int[]
 lw $a3, 4($a1)
 # a1: 176(1): Int *6 :int
 li $a1, 6
 # a2: 177(2): Int *6 :int
 li $a2, 6
 # a1: 178(1): IndexAssg 175 177 *176(1): Int *6 :int :int
 mul $v1, $a1, 4
 add $v1, $v1, 4
 add $v1, $v1, $a3
 sw $a2, ($v1)
 move $a1, $a2
 # a1: 179(1): This :BBS
 move $a1, $v0
 # a3: 180(3): Member 179 *number :int[]
 lw $a3, 4($a1)
 # a1: 181(1): Int *7 :int
 li $a1, 7
 # a2: 182(2): Int *9 :int
 li $a2, 9
 # a1: 183(1): IndexAssg 180 182 *181(1): Int *7 :int :int
 mul $v1, $a1, 4
 add $v1, $v1, 4
 add $v1, $v1, $a3
 sw $a2, ($v1)
 move $a1, $a2
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
 # a3: 190(3): Member 189 *number :int[]
 lw $a3, 4($a1)
 # a1: 191(1): Int *9 :int
 li $a1, 9
 # a2: 192(2): Int *5 :int
 li $a2, 5
 # a1: 193(1): IndexAssg 190 192 *191(1): Int *9 :int :int
 mul $v1, $a1, 4
 add $v1, $v1, 4
 add $v1, $v1, $a3
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

