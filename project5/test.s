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
 # a1: 0(1): NewObj *LS :LS
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 la $a0, mj__v_LS
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
mj__v_LS:
 .word mj__m_LS_Start
 .word mj__m_LS_Print
 .word mj__m_LS_Search
 .word mj__m_LS_Init
.text
mj__m_LS_Start:
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
 # a1: 9(1): This :LS
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
 lw $v1, 12($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 lw $a2, -16($fp)
 # a0: 12(0): VarAssg 11 *aux01 :int
 # a0: 13(0): This :LS
 move $a0, $v0
 # a0: 14(0): Call 13 *Print() :int
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
 # a0: 15(0): VarAssg 14 *aux02 :int
 # a0: 16(0): Int *9999 :int
 li $a0, 9999
 # a0: 17(0): Print 16 :void
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
 # a1: 18(1): This :LS
 move $a1, $v0
 # a0: 19(0): Int *8 :int
 li $a0, 8
 # a0: 20(0): Arg 19 *0 :int
 # a0: 21(0): Call 18 *Search(20) :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 sw $a2, -16($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 8($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 lw $a2, -16($fp)
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
 # a1: 23(1): This :LS
 move $a1, $v0
 # a0: 24(0): Int *12 :int
 li $a0, 12
 # a0: 25(0): Arg 24 *0 :int
 # a0: 26(0): Call 23 *Search(25) :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 sw $a2, -16($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 8($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 lw $a2, -16($fp)
 # a0: 27(0): Print 26 :void
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
 # a1: 28(1): This :LS
 move $a1, $v0
 # a0: 29(0): Int *17 :int
 li $a0, 17
 # a0: 30(0): Arg 29 *0 :int
 # a0: 31(0): Call 28 *Search(30) :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 sw $a2, -16($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 8($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 lw $a2, -16($fp)
 # a0: 32(0): Print 31 :void
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
 # a1: 33(1): This :LS
 move $a1, $v0
 # a0: 34(0): Int *50 :int
 li $a0, 50
 # a0: 35(0): Arg 34 *0 :int
 # a0: 36(0): Call 33 *Search(35) :int
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 sw $a2, -16($fp)
 move $v0, $a1
 lw $v1, ($v0)
 lw $v1, 8($v1)
 jal $v1
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 lw $a2, -16($fp)
 # a0: 37(0): Print 36 :void
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
 # a0: 38(0): Int *55 :int
 li $a0, 55
 # a0: 39(0): Return 38 :void
 move $v0, $a0
 j .ret_mj__m_LS_Start
 .ret_mj__m_LS_Start:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
mj__m_LS_Print:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -16
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 40(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 41(0): Int *1 :int
 li $a0, 1
 # a1: 42(1): VarAssg 41 *j :int
 move $a1, $a0
 # a0: 43(0): Label *lwhile_753751532_start :void
 .lwhile_753751532_start:
 # a0: 44(0): This :LS
 move $a0, $v0
 # a0: 45(0): Member 44 *size :int
 lw $a0, 8($a0)
 # a0: 46(0): Lt 42 45 :boolean
 slt $a0, $a1, $a0 # a0: 47(0): NBranch 46 *lwhile_753751532_end :void
 beq $a0, $zero, .lwhile_753751532_end
 # a0: 48(0): This :LS
 move $a0, $v0
 # a0: 49(0): Member 48 *number :int[]
 lw $a0, 4($a0)
 # a0: 50(0): Index 49 42 :int
 mul $v1, $a1, 4
 add $v1, $v1, 4
 add $v1, $v1, $a0
 lw $a0, ($v1)
 # a0: 51(0): Print 50 :void
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a0, -12($fp)
 sw $a1, -16($fp)
 jal minijavaPrint
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a0, -12($fp)
 lw $a1, -16($fp)
 # a0: 52(0): Int *1 :int
 li $a0, 1
 # a0: 53(0): Plus 42 52 :int
 add $a0, $a1, $a0
 # a1: 54(1): VarAssg 53 *j :int
 move $a1, $a0
 # a0: 55(0): Goto *lwhile_753751532_start :void
 j .lwhile_753751532_start
 # a0: 56(0): Label *lwhile_753751532_end :void
 .lwhile_753751532_end:
 # a1: 57(1): Unify 42 54 :int
 # a0: 58(0): Int *0 :int
 li $a0, 0
 # a0: 59(0): Return 58 :void
 move $v0, $a0
 j .ret_mj__m_LS_Print
 .ret_mj__m_LS_Print:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
mj__m_LS_Search:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -40
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 60(0): Parameter *0 :int
 # t1: 61(5): VarAssg 60 *num :int
 move $t1, $a0
 # a0: 62(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 63(0): Null *Type(boolean) :boolean
 move $a0, $zero
 # a0: 64(0): Null *Type(int) :int
 move $a0, $zero
 # a3: 65(3): Null *Type(int) :int
 move $a3, $zero
 # t2: 66(6): Null *Type(int) :int
 move $t2, $zero
 # a1: 67(1): Null *Type(int) :int
 move $a1, $zero
 # a0: 68(0): Int *1 :int
 li $a0, 1
 # t3: 69(7): VarAssg 68 *j :int
 move $t3, $a0
 # a0: 70(0): Boolean *false :boolean
 move $a0, $zero
 # a2: 71(2): VarAssg 70 *ls01 :boolean
 move $a2, $a0
 # a0: 72(0): Int *0 :int
 li $a0, 0
 # t0: 73(4): VarAssg 72 *ifound :int
 move $t0, $a0
 # a0: 74(0): Label *lwhile_706099045_start :void
 .lwhile_706099045_start:
 # a0: 75(0): This :LS
 move $a0, $v0
 # a0: 76(0): Member 75 *size :int
 lw $a0, 8($a0)
 # a0: 77(0): Lt 69 76 :boolean
 slt $a0, $t3, $a0 # a0: 78(0): NBranch 77 *lwhile_706099045_end :void
 beq $a0, $zero, .lwhile_706099045_end
 # a0: 79(0): This :LS
 move $a0, $v0
 # a0: 80(0): Member 79 *number :int[]
 lw $a0, 4($a0)
 # a0: 81(0): Index 80 69 :int
 mul $v1, $t3, 4
 add $v1, $v1, 4
 add $v1, $v1, $a0
 lw $a0, ($v1)
 # a3: 82(3): VarAssg 81 *aux01 :int
 move $a3, $a0
 # a0: 83(0): Int *1 :int
 li $a0, 1
 # a0: 84(0): Plus 61 83 :int
 add $a0, $t1, $a0
 # t2: 85(6): VarAssg 84 *aux02 :int
 move $t2, $a0
 # a0: 86(0): Lt 82 61 :boolean
 slt $a0, $a3, $t1 # a0: 87(0): NBranch 86 *lif_412015993_else :void
 beq $a0, $zero, .lif_412015993_else
 # a0: 88(0): Int *0 :int
 li $a0, 0
 # a1: 89(1): VarAssg 88 *nt :int
 move $a1, $a0
 # a0: 90(0): Goto *lif_412015993_done :void
 j .lif_412015993_done
 # a0: 91(0): Label *lif_412015993_else :void
 .lif_412015993_else:
 # a0: 92(0): Lt 82 85 :boolean
 slt $a0, $a3, $t2 # a0: 93(0): Not 92 :boolean
 seq $a0, $zero, $a0
 # a0: 94(0): NBranch 93 *lif_1265516423_else :void
 beq $a0, $zero, .lif_1265516423_else
 # a0: 95(0): Int *0 :int
 li $a0, 0
 # a1: 96(1): VarAssg 95 *nt :int
 move $a1, $a0
 # a0: 97(0): Goto *lif_1265516423_done :void
 j .lif_1265516423_done
 # a0: 98(0): Label *lif_1265516423_else :void
 .lif_1265516423_else:
 # a0: 99(0): Boolean *true :boolean
 li $a0, 1
 # a2: 100(2): VarAssg 99 *ls01 :boolean
 move $a2, $a0
 # a0: 101(0): Int *1 :int
 li $a0, 1
 # t0: 102(4): VarAssg 101 *ifound :int
 move $t0, $a0
 # a0: 103(0): This :LS
 move $a0, $v0
 # a0: 104(0): Member 103 *size :int
 lw $a0, 8($a0)
 # t3: 105(7): VarAssg 104 *j :int
 move $t3, $a0
 # a0: 106(0): Label *lif_1265516423_done :void
 .lif_1265516423_done:
 # a1: 107(1): Unify 96 67 :int
 # a2: 108(2): Unify 71 100 :boolean
 # t0: 109(4): Unify 73 102 :int
 # t3: 110(7): Unify 69 105 :int
 # a0: 111(0): Label *lif_412015993_done :void
 .lif_412015993_done:
 # a1: 112(1): Unify 89 107 :int
 # a2: 113(2): Unify 71 108 :boolean
 # t0: 114(4): Unify 73 109 :int
 # t3: 115(7): Unify 69 110 :int
 # a0: 116(0): Int *1 :int
 li $a0, 1
 # a0: 117(0): Plus 115 116 :int
 add $a0, $t3, $a0
 # t3: 118(7): VarAssg 117 *j :int
 move $t3, $a0
 # a0: 119(0): Goto *lwhile_706099045_start :void
 j .lwhile_706099045_start
 # a0: 120(0): Label *lwhile_706099045_end :void
 .lwhile_706099045_end:
 # a1: 121(1): Unify 67 112 :int
 # a2: 122(2): Unify 71 113 :boolean
 # t0: 123(4): Unify 73 114 :int
 # t2: 124(6): Unify 66 85 :int
 # a3: 125(3): Unify 65 82 :int
 # t3: 126(7): Unify 69 118 :int
 # a0: 127(0): Return 123 :void
 move $v0, $t0
 j .ret_mj__m_LS_Search
 .ret_mj__m_LS_Search:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra
mj__m_LS_Init:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -32
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 128(0): Parameter *0 :int
 # a3: 129(3): VarAssg 128 *sz :int
 move $a3, $a0
 # a0: 130(0): Null *Type(int) :int
 move $a0, $zero
 # a0: 131(0): Null *Type(int) :int
 move $a0, $zero
 # a1: 132(1): Null *Type(int) :int
 move $a1, $zero
 # a2: 133(2): Null *Type(int) :int
 move $a2, $zero
 # a0: 134(0): This :LS
 move $a0, $v0
 # a0: 135(0): MemberAssg 134 129 *size :int
 sw $a3, 8($a0)
 move $a0, $a3
 # t0: 136(4): This :LS
 move $t0, $v0
 # a0: 137(0): NewIntArray 129 :int[]
 sw $v0, -4($fp)
 sw $v1, -8($fp)
 sw $a1, -12($fp)
 sw $a2, -16($fp)
 sw $a3, -20($fp)
 sw $t0, -24($fp)
 sw $t1, -28($fp)
 move $a0, $a3
 jal minijavaNewArray
 move $a0, $v0
 lw $v0, -4($fp)
 lw $v1, -8($fp)
 lw $a1, -12($fp)
 lw $a2, -16($fp)
 lw $a3, -20($fp)
 lw $t0, -24($fp)
 lw $t1, -28($fp)
 # a0: 138(0): MemberAssg 136 137 *number :int[]
 sw $a0, 4($t0)
 # a0: 139(0): Int *1 :int
 li $a0, 1
 # a3: 140(3): VarAssg 139 *j :int
 move $a3, $a0
 # a0: 141(0): This :LS
 move $a0, $v0
 # a0: 142(0): Member 141 *size :int
 lw $a0, 8($a0)
 # t0: 143(4): Int *1 :int
 li $t0, 1
 # a0: 144(0): Plus 142 143 :int
 add $a0, $a0, $t0
 # t1: 145(5): VarAssg 144 *k :int
 move $t1, $a0
 # a0: 146(0): Label *lwhile_856481473_start :void
 .lwhile_856481473_start:
 # a0: 147(0): This :LS
 move $a0, $v0
 # a0: 148(0): Member 147 *size :int
 lw $a0, 8($a0)
 # a0: 149(0): Lt 140 148 :boolean
 slt $a0, $a3, $a0 # a0: 150(0): NBranch 149 *lwhile_856481473_end :void
 beq $a0, $zero, .lwhile_856481473_end
 # a0: 151(0): Int *2 :int
 li $a0, 2
 # a0: 152(0): Mul 151 140 :int
 mul $a0, $a0, $a3
 # a1: 153(1): VarAssg 152 *aux01 :int
 move $a1, $a0
 # a0: 154(0): Int *3 :int
 li $a0, 3
 # a0: 155(0): Minus 145 154 :int
 sub $a0, $t1, $a0
 # a2: 156(2): VarAssg 155 *aux02 :int
 move $a2, $a0
 # a0: 157(0): This :LS
 move $a0, $v0
 # t0: 158(4): Member 157 *number :int[]
 lw $t0, 4($a0)
 # a0: 159(0): Plus 153 156 :int
 add $a0, $a1, $a2
 # a0: 160(0): IndexAssg 158 159 *140(3): VarAssg 139 *j :int :int
 mul $v1, $a3, 4
 add $v1, $v1, 4
 add $v1, $v1, $t0
 sw $a0, ($v1)
 # a0: 161(0): Int *1 :int
 li $a0, 1
 # a0: 162(0): Plus 140 161 :int
 add $a0, $a3, $a0
 # a3: 163(3): VarAssg 162 *j :int
 move $a3, $a0
 # a0: 164(0): Int *1 :int
 li $a0, 1
 # a0: 165(0): Minus 145 164 :int
 sub $a0, $t1, $a0
 # t1: 166(5): VarAssg 165 *k :int
 move $t1, $a0
 # a0: 167(0): Goto *lwhile_856481473_start :void
 j .lwhile_856481473_start
 # a0: 168(0): Label *lwhile_856481473_end :void
 .lwhile_856481473_end:
 # a2: 169(2): Unify 133 156 :int
 # a1: 170(1): Unify 132 153 :int
 # a3: 171(3): Unify 140 163 :int
 # t1: 172(5): Unify 145 166 :int
 # a0: 173(0): Int *0 :int
 li $a0, 0
 # a0: 174(0): Return 173 :void
 move $v0, $a0
 j .ret_mj__m_LS_Init
 .ret_mj__m_LS_Init:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra

