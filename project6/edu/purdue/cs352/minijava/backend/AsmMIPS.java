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
            sb.append(" .word mj__m_" + getImplementor(prog, cl, method).getASTNode().getName() + "_" + method + "\n");
        }
        // now compile the actual methods
        sb.append(".text\n");
        for (SSAMethod m : cl.getMethodsOrdered()) {
            String name = "mj__m_" + cl.getASTNode().getName() + "_" + m.getMethod().getName();
            compile(prog, m, name);
        }
    }

    List<Integer> crsaved = new ArrayList<Integer>();
    StringBuilder crstores = new StringBuilder();
    StringBuilder crloads = new StringBuilder();
    int spills;
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
        int totalSpace = 0;
        // FILLIN: figure out how much space we need to reserve for spills
        int spillSpace = 0;
        spillSpace += findMax(m.getBody());
        spills = spillSpace;
        // FILLIN: and perhaps any other space we need to reserve (saved registers?)
        
        // Add space for v0 and v1 if not already
        List<Integer> cesaved = new ArrayList<Integer>();
        
        sortOnInsert(crsaved, callerSavedRegisters[0]);
        sortOnInsert(crsaved, callerSavedRegisters[1]);
        sortOnInsert(cesaved, calleeSavedRegisters[9]);
        
        int extraArgs = 0;
        for(SSAStatement s : m.getBody()) {
            if(s.getRegister() < 0) {
                extraArgs++;
                continue;
            }
            if(!crsaved.contains(freeReg(s)) && (Arrays.binarySearch(callerSavedRegisters, freeReg(s)) > -1)){
                sortOnInsert(crsaved, freeReg(s));
            } else if (!cesaved.contains(freeReg(s)) && Arrays.binarySearch(calleeSavedRegisters, freeReg(s)) > -1){
                sortOnInsert(cesaved, freeReg(s));
            }
        }
       
        // FILLIN: reserve space
        totalSpace+= crsaved.size() + spillSpace; 
        sb.append(" add $sp, $sp, -");
        sb.append(wordSize*(totalSpace));
        sb.append("\n");
        // reserve $ra space

        StringBuilder cestores = new StringBuilder();
        StringBuilder celoads = new StringBuilder();
        for(int i = 0; i < cesaved.size(); i++) {
            int reg = cesaved.get(i);
            cestores.append(" add $sp, $sp, -" + (wordSize) + "\n");
            cestores.append(" sw $");
            cestores.append(registers[reg]);
            cestores.append(", ($sp)\n");        
            reg = cesaved.get(((cesaved).size()-1) - i);
            celoads.append(" lw $");
            celoads.append(registers[reg]);
            celoads.append(", ($sp)\n");
            celoads.append(" add $sp, $sp, " + (wordSize) + "\n");
            
        }

        // FILLIN: save the callee-saved registers, anything else that needs to be callee-saved
        sb.append(cestores);
        if(extraArgs > 0) {
            sb.append(" add $sp, $sp, -");
            sb.append(wordSize*(extraArgs));
            sb.append("\n");
        }
        // now write the code
        for (SSAStatement s : m.getBody()) {
            compile(prog, name, s);
        }

        // the epilogue starts here
        sb.append(" .ret_");
        sb.append(name);
        sb.append(":\n");

        // FILLIN: restore the callee-saved registers (anything else?)
        if(extraArgs > 0) {
            sb.append(" add $sp, $sp, ");
            sb.append(wordSize*(extraArgs));
            sb.append("\n");
        }    
        sb.append(celoads);
        
        // and the rest of the epilogue
        sb.append(" move $sp, $fp\n");
        sb.append(" lw $fp, ($sp)\n");
        sb.append(" add $sp, $sp, ");
        sb.append(wordSize);
        sb.append("\n");
        sb.append(" j $ra\n");

        crsaved.clear();
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
                break; // Do nothing
            case Parameter:
                int paramPos = (Integer)s.getSpecial();
                if(paramPos > 3) {
                    built.append(" lw $" + reg(s) + ", " + (paramPos-3)*wordSize + "($fp)\n");   
                }
                break; 
            case Int:
                int intValue = (Integer)s.getSpecial();
                built.append(" li $" + reg(s) + ", " + intValue + "\n");
                break;
            case Print:
                callerSave(-1);
                built.append(crstores);
                built.append(moveRegister("a0", reg(left)));
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
                    built.append(" sw $" + reg(left) + ", " + (argPos-4)*wordSize + "($sp)\n");   
                } else {
                    built.append(moveRegister(reg(s) ,reg(left)));
                }
                break;
            case Null:
                built.append(" move $" + reg(s) + ", $zero\n");
                break;
            case NewObj:
                callerSave(freeReg(s));
                built.append(crstores);
                special = (String)s.getSpecial();
                built.append(" la $a0, mj__v_" + special + "\n");
                built.append(" li $a1, " + objectSize(prog, prog.getClass(special)) + "\n");
                built.append(" jal minijavaNew\n");
                built.append(" move $" + reg(s) + ", $v0\n");
                built.append(crloads);
                break;
            case NewIntArray:
                callerSave(freeReg(s));
                built.append(crstores);
                built.append(moveRegister("a0", reg(left)));
                built.append(" jal minijavaNewArray\n");
                built.append(" move $" + reg(s) + ", $v0\n");
                built.append(crloads);
                break;
            case Label:
                special = (String)s.getSpecial();
                built.append(" ." + special + ":\n");
                break;
            case Goto:
                special = (String)s.getSpecial();
                built.append(" j ." + special + "\n");
                break;
            case Branch:
                special = (String)s.getSpecial();
                built.append(" bne $" + reg(left) + ", $zero ." + special +"\n");
                break;
            case NBranch:
            // could change to beqz
                special = (String)s.getSpecial();
                built.append(" beq $" + reg(left) + ", $zero, ." + special +"\n");
                break;
            case Call:
                String clasName = left.getType().toString();
                SSACall call = (SSACall)s.getSpecial();
                String funcName = call.getMethod();
                Vtable vtab = getVtable(prog, prog.getClass(clasName));
                int methodOffset = vtab.methodOffsets.get(funcName);
                callerSave(freeReg(s));
                built.append(crstores);
                built.append(" move $v0, $" + reg(left) + "\n");
                built.append(" lw $v1, ($v0)\n");
                built.append(" lw $v1, " + (methodOffset*wordSize) + "($v1)\n");
                built.append(" jal $v1\n");
                built.append(" move $" + reg(s) + ", $v0\n");
                built.append(crloads);
                break;
            case Return:
                built.append(" move $v0, $" + reg(left) + "\n");
                built.append(" j .ret_" + methodName + "\n");
                break;
            case Member:
                special = (String)s.getSpecial();
                String clname = left.getType().toString();
                int memOffset;
                if(clname.equals("int[]")) {
                    memOffset = 0;
                } else {
                    memOffset = fieldOffset(prog, prog.getClass(clname), special);
                }
                if(memOffset == 0) {
                    built.append(" lw $" + reg(s) + ", ($" + reg(left) + ")\n");
                } else {
                    built.append(" lw $" + reg(s) + ", " + (wordSize*memOffset) + "($" + reg(left) + ")\n");
                }
                break;
            case Index:
                built.append(" mul $v1, $" + reg(right) + ", 4\n");
                built.append(" add $v1, $v1, 4\n");
                built.append(" add $v1, $v1, $" + reg(left) + "\n");
                built.append(" lw $" + reg(s) + ", ($v1)\n");
                break;
            case VarAssg:
                built.append(moveRegister(reg(s), reg(left)));
                break;
            case MemberAssg:
                special = (String)s.getSpecial();
                String className = left.getType().toString();
                int memSOffset = fieldOffset(prog, prog.getClass(className), special);
                built.append(" sw $" + reg(right) + ", " + (memSOffset*wordSize) + "($" + reg(left) + ")\n");
                built.append(moveRegister(reg(s), reg(right)));
                break;
            case IndexAssg:
                SSAStatement index = (SSAStatement)s.getSpecial();
                built.append(" mul $v1, $" + reg(index) + ", 4\n");
                built.append(" add $v1, $v1, 4\n");
                built.append(" add $v1, $v1, $" + reg(left) + "\n");
                built.append(" sw $" + reg(right) + ", ($v1)\n");
                built.append(moveRegister(reg(s), reg(right)));
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
                built.append(" div $" + reg(s) + ", $"+ reg(left) + ", $" + reg(right) + "\n");
                //built.append(" mflo $" + reg(s) + "\n");
                break;           
            case Mod:
                // can change to one liner
                //built.append(" div $" + reg(left) + ", $" + reg(right) + "\n");
                //built.append(" mfhi $" + reg(s) + "\n");
                built.append(" rem $" + reg(s) + ", $"+ reg(left) + ", $" + reg(right) + "\n");
                
                break;
            case Store:
                int storeVal = (Integer)s.getSpecial();
                built.append(" sw $" + reg(left) + ", -" + (storeVal+1)*wordSize + "($fp)\n");
                break;
            case Load:
                int loadVal = (Integer)s.getSpecial();
                built.append(" lw $" + reg(s) + ", -" + (loadVal+1)*wordSize + "($fp)\n");
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

    private StringBuilder moveRegister(String expected, String actual) {
        StringBuilder build = new StringBuilder();
        if(expected.equals(actual))
            return build;
        build.append(" move $" + expected + ", $" + actual + "\n");
        return build;
    }

    private int findMax(List<SSAStatement> body) {
        int max = -1;
        for(SSAStatement s: body) {
            if(s.getOp() == Op.Store) {
                int offset = (Integer) s.getSpecial();
                if(offset > max) 
                    max = offset;
            }
        }
        if(max == -1)
            return 0;
        return max+1;
    }

    private void sortOnInsert(List<Integer> array, int toAdd) {
        int i;
        for( i = 0; i < array.size(); i++) {
            if(array.get(i) > toAdd){
                break;        
            }
        }
        array.add(i, toAdd);  
    }

    public void callerSave(int ignore) {
        int offsetR = 0;
        crstores.setLength(0);
        crloads.setLength(0);
        for(Integer reg : crsaved) {
            if(reg == ignore) 
                continue;
            crstores.append(" sw $");
            crstores.append(registers[reg]);
            crstores.append(", -" + ((++offsetR + spills)*wordSize) + "($fp)\n");
            crloads.append(" lw $");
            crloads.append(registers[reg]);
            crloads.append(", -" + ((offsetR + spills)*wordSize) + "($fp)\n");
        }
    }

    // get the actual code generated
    public String toString() {
        return sb.toString();
    }
}
