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
.text
mj__m_BS_Start:
 add $sp, $sp, -4
 sw $fp, ($sp)
 move $fp, $sp
 add $sp, $sp, -20
 add $sp, $sp, -4
 sw $ra, ($sp)
 # a0: 5(0): Parameter *0 :int
 # a0: 6(0): VarAssg 5 *sz :int
 # a0: 7(0): Null *Type(int[]) :int[]
 move $a0, $zero
 # a0: 8(0): NewIntArray 6 :int[]
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
 # a1: 9(1): VarAssg 8 *aux01 :int[]
 move $a1, $a0
 # a0: 10(0): Int *0 :int
 li $a0, 0
 # a2: 11(2): Int *1 :int
 li $a2, 1
 # a0: 12(0): IndexAssg 9 11 *10(0): Int *0 :int :int
 mul $v1, $a0, 4
 add $v1, $v1, 4
 add $v1, $v1, $a1
 sw $a2, ($v1)
 move $a0, $a2
 # a0: 13(0): Int *999 :int
 li $a0, 999
 # a0: 14(0): Return 13 :void
 move $v0, $a0
 j .ret_mj__m_BS_Start
 .ret_mj__m_BS_Start:
 lw $ra, ($sp)
 add $sp, $sp, 4
 move $sp, $fp
 lw $fp, ($sp)
 add $sp, $sp, 4
 j $ra

