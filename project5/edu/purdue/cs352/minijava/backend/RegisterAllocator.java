package edu.purdue.cs352.minijava.backend;

import java.util.*;

import edu.purdue.cs352.minijava.ssa.*;

import static edu.purdue.cs352.minijava.ssa.SSAStatement.*;


public class RegisterAllocator {
    /* a "variable" is just a set of SSA statements. We alias it (sort of) to
     * make this explicit. A Variable is thus equivalently a definition of
     * def(v). */
    static class Variable {
        public final SSAStatement master; // just for debugging
        public final Set<SSAStatement> v;
        public Variable(SSAStatement s) {
            master = s;
            v = new HashSet<SSAStatement>();
            v.add(s);
        }
        public SSAStatement getSSA() {
            return master;
        } 

        public SSAStatement getSSA(int index) {
            for(SSAStatement s : v) {
                if(s.getIndex() == index)
                    return s;
            }
            return null;
        } 

        public Set<SSAStatement> getUnifedSSA(){
            return v;
        }

        public boolean equals(SSAStatement ssa) {
            return (ssa.getIndex() == master.getIndex());
        }

        public boolean contains(SSAStatement ssa) {
            return v.contains(ssa);
        }

        public boolean contains(int index) {
            for(SSAStatement s : v) {
                if(s.getIndex() == index)
                    return true;
            }
            return false;
        }

        public String toString() {
            StringBuilder string = new StringBuilder("Master:" + master);
            string.append('\n');
            for(SSAStatement s: v){
                if(s == master) continue;
                string.append(s);
                string.append('\n');
            }
            return string.toString();
        }
    }

    /* you will additionally need classes for at least:
     * Nodes in the control flow graph
     * Nodes in the variable interference graph
     */

    // a node in the control flow graph
    class CFNode {
        // FILLIN...
        // will need at least pred, succ, def[n], use[n], in[n] and out[n]
    }

    // a node in the interference graph (a temporary)
    class TempNode {
        // FILLIN...
    }

    // the block we're performing allocation over
    List<SSAStatement> block;

    /* FILLIN: You may additionally need fields for, e.g.,
     * The number of spills you have performed (to fill the special field of Store and Load operations),
     * Your list of variables,
     * Your SSAStatement->variable binding (def(v)),
     * Your list of CFG nodes,
     * Your SSAProgram->CFG node binding,
     * use(v),
     * Your list of interference graph nodes,
     * Your binding of variables to nodes in the interference graph.
     */

    List<Variable> variables;
    List<CFNode> cfnodes;
    List<TempNode> tempnodes;
    //Graph interference, colorGraph;
    Deque<TempNode> stack;
    int numOfSpills;

    private RegisterAllocator() {
        variables = new ArrayList<Variable>();
        cfnodes = new ArrayList<CFNode>();
        tempnodes = new ArrayList<TempNode>();
        stack = new ArrayDeque<TempNode>();
        //interference = new Graph();
        //colorGraph = new Graph();
        numOfSpills = 0;

    }

    // perform all register allocations for this program
    public static void alloc(SSAProgram prog, int freeRegisters) {
        // first main
        SSAMethod main = prog.getMain();
        main.setBody(alloc(main.getBody(), freeRegisters));

        // then each class
        for (SSAClass cl : prog.getClassesOrdered())
            alloc(cl, freeRegisters);
    }

    // perform all register allocations for this class
    public static void alloc(SSAClass cl, int freeRegisters) {
        for (SSAMethod m : cl.getMethodsOrdered())
            alloc(m, freeRegisters);
    }

    // perform register allocation for this method
    public static void alloc(SSAMethod m, int freeRegisters) {
        m.setBody(alloc(m.getBody(), freeRegisters));
    }

    // the register allocator itself
    public static List<SSAStatement> alloc(List<SSAStatement> block, int freeRegisters) {
        Set<TempNode> actualSpills;

        RegisterAllocator ra = new RegisterAllocator();
        ra.block = block;

        while (true) {
            /* FILLIN: This body may work fine, in which case you will have to
             * write the relevant functions, or you may prefer to implement it
             * differently */

            // prefill the variables with single statements
            ra.initVariables();

            // unify
            ra.unifyVariables();
            break;
/*
            // now build the CF nodes
            ra.initCFNodes();

            // build the use[n] relationship from them
            ra.addUses();

            // build their successor/predecessor relationships
            ra.cfPredSucc();

            // liveness analysis
            ra.liveness();

            // build the temporaries
            ra.initTempNodes();

            // and figure out their interference
            ra.buildInterference();

            ra.simplify(freeRegisters);

            // do we need to spill?
            actualSpills = ra.select(freeRegisters);
            if (actualSpills.size() == 0) break;

            // OK, rewrite to perform the spills
            ra.performSpills(actualSpills);*/
        }

        // FILLIN: now, using the information from the interference graph, assign the register for each SSA statement

        return ra.block;
    }

    // FILLIN: Implement the methods used by alloc() above

    public void initVariables() {
        for(SSAStatement s : block) {
            Variable var = new Variable(s);
            variables.add(var);
            //System.out.println(var);
        }
    }

    public void unifyVariables() {
        List<Variable> toRemove = new ArrayList<Variable>();

        for(Variable var : variables) {
            Op op = var.master.getOp();
            if(op == Op.Unify && !toRemove.contains(var)) {
                findUnify(var.master, toRemove);
            }
        } 

        // delete unified variables individual objects
        for(Variable var : toRemove) {
            // remove the variable from the list
            variables.remove(var);
        }

        for(Variable var : variables) {
            System.out.println(var);
        }
    }

    /**** Helper functions *****/
        public void findUnify(SSAStatement stat, List<Variable> toRemove) {

        SSAStatement left = stat.getLeft();
        SSAStatement right = stat.getRight();

        if(left.getOp() == Op.Unify)
            findUnify(left, toRemove);

        if(right.getOp() == Op.Unify)
            findUnify(right, toRemove);
        
        Variable main = findVariable(stat);
        
        if(main == null) throw new Error("Couldn't find variable");

        Variable l = findVariable(left);
        Variable r = findVariable(right);

        for(SSAStatement s : l.v){
            main.getUnifedSSA().add(s);
        }

        for(SSAStatement s : r.v){
            main.getUnifedSSA().add(s);
        }

        toRemove.add(l);
        toRemove.add(r);

    }

    public Variable findVariable(SSAStatement stat) {
        for(Variable var : variables) {
            if(var.contains(stat)) return var;
        }
        return null;
    }
}
