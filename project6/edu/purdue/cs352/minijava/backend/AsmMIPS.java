package edu.purdue.cs352.minijava.backend;

import java.util.*;

import edu.purdue.cs352.minijava.ssa.*;
import edu.purdue.cs352.minijava.types.*;
import static edu.purdue.cs352.minijava.backend.ClassLayout.*;
import static edu.purdue.cs352.minijava.ssa.SSAStatement.*;

public class AsmMIPS {
    StringBuilder sb;

    int wordSize = 4;

    // registers for MIPS:
    private static final String[] registers = {
        "zero",
        "at",
        "v0", "v1",
        "a0", "a1", "a2", "a3",
        "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7",
        "s0", "s1", "s2", "s3", "s4", "s5", "s6", "s7",
        "t8", "t9",
        "k0", "k1",
        "gp", "sp", "fp", "ra"
    };

    // registers free for normal use
    private static final int[] freeRegisters = {
        4, 5, 6, 7, // a*
        8, 9, 10, 11, 12, 13, 14, 15, // t*
        16, 17, 18, 19, 20, 21, 22, 23, // s*
        24, 25 // t*
    };

    // pinned registers for arguments:
    private static final int[] argRegisters = {
        4, 5, 6, 7
    };

    // mapping of arg register indexes to free register indexes
    private static final int[] argFreeRegisters = {
        0, 1, 2, 3
    };

    // callee-saved registers, excluding stack/base
    private static final int[] calleeSavedRegisters = {
        16, 17, 18, 19, 20, 21, 22, 23, // s*
        28, // gp
        31, // ra
    };

    // caller-saved registers, excluding stack/base
    private static final int[] callerSavedRegisters = {
        2, 3, // v*
        4, 5, 6, 7, // a*
        8, 9, 10, 11, 12, 13, 14, 15, 24, 25 // t*
    };

    private AsmMIPS(StringBuilder sb) {
        this.sb = sb;
    }

    public static String compile(SSAProgram prog) {
        AsmMIPS compiler = new AsmMIPS(new StringBuilder());

        // SPIM stuff
        compiler.sb.append(
            "main:\n" +
            " jal mj_main\n" +
            " li $v0, 10\n" +
            " syscall\n\n" +

            "minijavaNew:\n" +
            " move $t0, $a0\n" +
            " mul $a0, $a1, 4\n" +
            " li $v0, 9\n" +
            " syscall\n" +
            " sw $t0, ($v0)\n" +
            " j $ra\n\n" +

            "minijavaNewArray:\n" +
            " move $t0, $a0\n" +
            " mul $a0, $a0, 4\n" +
            " add $a0, $a0, 4\n" +
            " li $v0, 9\n" +
            " syscall\n" +
            " sw $t0, ($v0)\n" +
            " j $ra\n\n" +

            ".data\n" +
            ".align 4\n" +
            "minijavaNewline:\n" +
            " .asciiz \"\\n\"\n\n" +

            ".text\n" +
            "minijavaPrint:\n" +
            " li $v0, 1\n" +
            " syscall\n" +
            " la $a0, minijavaNewline\n" +
            " li $v0, 4\n" +
            " syscall\n" +
            " j $ra\n\n"
        ); 

        // first compile main
        compiler.compile(prog, prog.getMain(), "mj_main");

        // then compile all the classes
        for (SSAClass cl : prog.getClassesOrdered()) {
            compiler.compile(prog, cl);
        }

        return compiler.toString();
    }

    // compile this class
    private void compile(SSAProgram prog, SSAClass cl) {
        // first make the vtable for this class
        sb.append(".data\n.align ");
        sb.append(wordSize);
        sb.append("\n");
        sb.append("mj__v_" + cl.getASTNode().getName() + ":\n");
        // FILLIN

        Vtable table = ClassLayout.getVtable(prog, cl);
        for(String method : table.methods) {
            sb.append(" .word mj__m_" + cl.getASTNode().getName() + "_" + method + "\n");
        }
        // now compile the actual methods
        sb.append(".text\n");
        for (SSAMethod m : cl.getMethodsOrdered()) {
            String name = "mj__m_" + cl.getASTNode().getName() + "_" + m.getMethod().getName();
            compile(prog, m, name);
        }
    }

    List<Integer> crsaved = new ArrayList<Integer>();
    List<Integer> cesaved = new ArrayList<Integer>();
    StringBuilder cestores = new StringBuilder();
    StringBuilder celoads = new StringBuilder();
    StringBuilder crstores = new StringBuilder();
    StringBuilder crloads = new StringBuilder();
    // compile this method with this name
    private void compile(SSAProgram prog, SSAMethod m, String name) {
        // beginning of the prologue
        sb.append(name);
        sb.append(":\n");
        sb.append(" add $sp, $sp, -");
        sb.append(wordSize);
        sb.append("\n");
        sb.append(" sw $fp, ($sp)\n");
        sb.append(" move $fp, $sp\n");

        // pin registers
        for (SSAStatement s : m.getBody()) {
            if (s.getOp() == SSAStatement.Op.Parameter) {
                int paramNum = ((Integer) s.getSpecial()).intValue();
                if (paramNum < argRegisters.length)
                    s.pinRegister(argFreeRegisters[paramNum]);
            }

            if (s.getOp() == SSAStatement.Op.Arg) {
                int argNum = ((Integer) s.getSpecial()).intValue();
                if (argNum < argRegisters.length)
                    s.pinRegister(argFreeRegisters[argNum]);
                else
                    s.pinRegister(-1); // pin to -1 to do this at Call time
            }
        }

        // FILLIN: perform register allocation
        RegisterAllocator.alloc(m, freeRegisters.length);
        // FILLIN: figure out how much space we need to reserve for spills
        int spillSpace = 0;
        spillSpace += findMax(m.getBody());
        // FILLIN: and perhaps any other space we need to reserve (saved registers?)
        
        // Add space for v0 and v1 if not already
        crsaved.add(callerSavedRegisters[0]);
        crsaved.add(callerSavedRegisters[1]);
        
        for(SSAStatement s : m.getBody()) {
            if(!crsaved.contains(freeReg(s)) && (Arrays.binarySearch(callerSavedRegisters, freeReg(s)) > -1)){
                crsaved.add(freeReg(s));
            } else if (!cesaved.contains(freeReg(s)) && Arrays.binarySearch(calleeSavedRegisters, freeReg(s)) > -1){
               cesaved.add(freeReg(s)); 
            }
        }

        // FILLIN: reserve space
        spillSpace+= crsaved.size();

        sb.append(" add $sp, $sp, -");
        sb.append(wordSize*(spillSpace));
        sb.append("\n");
        // reserve $ra space
        sb.append(" add $sp, $sp, -");
        sb.append(wordSize);
        sb.append("\n");

        
        int offsetS = 0;
        for(Integer reg : cesaved) {
               cestores.append(" sw $");
               cestores.append(registers[reg]);
               cestores.append(", -" + (++offsetS)*wordSize + "($sp)\n");
               celoads.append(" lw $");
               celoads.append(registers[reg]);
               celoads.append(", -" + (offsetS)*wordSize + "($sp)\n");
        }

        int offsetR = 0;
        for(Integer reg : crsaved) {
               crstores.append(" sw $");
               crstores.append(registers[reg]);
               crstores.append(", -" + (++offsetR)*wordSize + "($fp)\n");
               crloads.append(" lw $");
               crloads.append(registers[reg]);
               crloads.append(", -" + (offsetR)*wordSize + "($fp)\n");
        }

        // FILLIN: save the callee-saved registers, anything else that needs to be callee-saved
        sb.append(" sw $");
        sb.append(registers[31]);
        sb.append(", ($sp)\n");
        sb.append(cestores);
        // now write the code
        for (SSAStatement s : m.getBody()) {
            compile(prog, name, s);
        }

        // the epilogue starts here
        sb.append(" .ret_");
        sb.append(name);
        sb.append(":\n");

        // FILLIN: restore the callee-saved registers (anything else?)
        sb.append(celoads);
        sb.append(" lw $");
        sb.append(registers[31]);
        sb.append(", ($sp)\n");
        sb.append(" add $sp, $sp, " + wordSize*(offsetS+1) + "\n");
        // and the rest of the epilogue
        sb.append(" move $sp, $fp\n");
        sb.append(" lw $fp, ($sp)\n");
        sb.append(" add $sp, $sp, ");
        sb.append(wordSize);
        sb.append("\n");
        sb.append(" j $ra\n");

        cesaved.clear();
        crsaved.clear();
        cestores.setLength(0);
        celoads.setLength(0);
        crstores.setLength(0);
        crloads.setLength(0);
    }

    // compile this statement (FILLIN: might need more registers, coming from above method)
    private void compile(SSAProgram prog, String methodName, SSAStatement s) {
        // recommended for debuggability:
        sb.append(" # ");
        if (s.getRegister() >= 0)
            sb.append(reg(s));
        sb.append(": ");
        sb.append(s.toString());
        sb.append("\n");

        SSAStatement left, right;
        String special;
        StringBuilder built = new StringBuilder();

        left = s.getLeft();
        right = s.getRight();

        switch (s.getOp()) {
            // FILLIN (this is the actual code generator!)
            case Unify:
            case Alias:
            case Parameter: 
                break; // Do nothing
            case Int:
                int intValue = (Integer)s.getSpecial();
                built.append(" li $" + reg(s) + ", " + intValue + "\n");
                break;
            case Print:
                built.append(crstores);
                built.append(" jal minijavaPrint\n");
                built.append(crloads);
                break;
            case Boolean:
                boolean boolValue = (Boolean)s.getSpecial();
                if(boolValue) {
                    built.append(" li $" + reg(s) + ", " + 1 + "\n");
                } else {
                    built.append(" move $" + reg(s) + ", $zero\n");
                }
                break;
            case This:
                built.append(" move $" + reg(s) + ", $v0\n");
                break;
            case Arg:
                int argPos = (Integer)s.getSpecial();
                if(argPos > 3) {
                    built.append("sw $" + reg(s) + (argPos-4)*wordSize + "($sp)\n");   
                }
                break;
            case Null:
                built.append(" move $" + reg(s) + ", $zero\n");
                break;
            case NewObj:
               
                break;
            case NewIntArray:
                built.append(crstores);
                if(!reg(left).equals("a0")) {
                    built.append(" move $a0, $" + reg(left));
                }
                built.append(" jal minijavaNewArray\n");
                built.append(" move $a0, $v0\n");
                built.append(crloads);
                break;
            case Label:
                special = (String)s.getSpecial();
                built.append("."+special + "\n");
                break;
            case Goto:
                special = (String)s.getSpecial();
                built.append("j ."+special + "\n");
                break;
            case Branch:
                special = (String)s.getSpecial();
                built.append(" bne $" + reg(s) + ", $zero ." + special +"\n");
                break;
            case NBranch:
            // could change to beqz
                special = (String)s.getSpecial();
                built.append(" beq $" + reg(s) + ", $zero, ." + special +"\n");
                break;
            case Call:
                
                
                break;
            case Return:
                built.append(" move $" + reg(s) + ", $" + reg(left) + "\n");
                break;
            case Member:
               
                break;
            case Index:
               
                break;
            case VarAssg:
                if(!reg(s).equals(reg(left))) {
                    built.append(" move $" + reg(s) + ", $" + reg(left)+ "\n");
                }
                break;
            case MemberAssg:
                
                break;
            case IndexAssg:
               
                break;
            case Not:
                 built.append(" seq $" + reg(s) + ", $zero , $" + reg(left) + "\n");
                break;
            case Eq:
                built.append(" seq $" + reg(s) + ", $" + reg(left) + ", $" + reg(right) + "\n");
                break;             
            case Ne:
                built.append(" sne $" + reg(s) + ", $" + reg(left) + ", $" + reg(right) + "\n");
                break;
            case Lt:
                built.append(" slt $" + reg(s) + ", $" + reg(left) + ", $" + reg(right) + "\n");
                break;
            case Le:
                built.append(" sle $" + reg(s) + ", $" + reg(left) + ", $" + reg(right) + "\n");
                break;       
            case Gt:
                built.append(" sgt $" + reg(s) + ", $" + reg(left) + ", $" + reg(right) + "\n");
                break;
            case Ge:
                built.append(" sge $" + reg(s) + ", $" + reg(left) + ", $" + reg(right) + "\n");
                break;
            case And:
                built.append(" add $" + reg(s) + ", $" + reg(left) + ", $" + reg(right) + "\n");
                built.append(" seq $" + reg(s) + ", $" + reg(s) + ", 2\n");
                break;
            case Or:
                built.append(" add $" + reg(s) + ", $" + reg(left) + ", $" + reg(right) + "\n");
                built.append(" sgt $" + reg(s) + ", $" + reg(s) + ", 0\n");
                break;
            case Plus:
                built.append(" add $" + reg(s) + ", $" + reg(left) + ", $" + reg(right) + "\n");
                break;           
            case Minus:
                built.append(" sub $" + reg(s) + ", $" + reg(left) + ", $" + reg(right) + "\n");
                break;          
            case Mul:
                built.append(" mul $" + reg(s) + ", $" + reg(left) + ", $" + reg(right) + "\n");
                break;            
            case Div: 
                // can change this to one liner after verifying it works
                built.append(" div $" + reg(left) + ", $" + reg(right) + "\n");
                built.append(" mflo $" + reg(s) + "\n");
                break;           
            case Mod:
                // can change to one liner
                built.append(" div $" + reg(left) + ", $" + reg(right) + "\n");
                built.append(" mfhi $" + reg(s) + "\n");
                break;
            default:
                throw new Error("Implement MIPS compiler for " + s.getOp() + "!");
        }

        sb.append(built);
    }
    // utility method to get the register name for a given statement
    private String reg(SSAStatement s) {
        return registers[freeRegisters[s.getRegister()]];
    }

    // utility method to get the register name for a given statement
    private int freeReg(SSAStatement s) {
        return freeRegisters[s.getRegister()];
    }


    public int findMax(List<SSAStatement> body) {
        int max = 0;
        for(SSAStatement s: body) {
            if(s.getOp() == Op.Store) {
                int offset = (Integer) s.getSpecial();
                if(offset > max) 
                    max = offset;
            }
        }
        return max;
    }
    // get the actual code generated
    public String toString() {
        return sb.toString();
    }
}
