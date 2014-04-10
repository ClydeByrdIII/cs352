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
            StringBuilder string = new StringBuilder("Variable Master SSA:" + master);
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
        HashSet<Variable> def, in, out, use;
        HashSet<CFNode> pred, succ;
        Variable master;
        SSAStatement ssa;

        public CFNode(SSAStatement ssa) {
            this.ssa = ssa;
            master = findVariable(ssa);
            pred = new HashSet<CFNode>();
            succ = new HashSet<CFNode>();
            def = new HashSet<Variable>();
            use = new HashSet<Variable>();
            in = new HashSet<Variable>();
            out = new HashSet<Variable>();
        }

        public SSAStatement getSSA() {
            return ssa;
        }

        public Variable getVariable() {
            return master;
        }

        public Set<Variable> getSet(String set) {
            if(set.equals("use")) {
                return use;
            } else if(set.equals("def")) {
                return def;
            } else if(set.equals("in")) {
                return in;    
            } else if(set.equals("out")) {
                return out;
            } 
            
            return null;
        }

        public Set<CFNode> getPredSucc(String set) {
            if(set.equals("pred")) {
                return pred; 
            } else if(set.equals("succ")) {
                return succ; 
            }
            return null;
        }

        public boolean contains(SSAStatement ssa) {
            return contains(ssa.getIndex());
        }

        public boolean contains(int index){
            return (ssa.getIndex() == index);
        }

        public String toString() {
            StringBuilder string = new StringBuilder("CFNode Master SSA:" + ssa);
            string.append('\n');
            string.append("CFNode Variable:" + master);
            string.append('\n');

            string.append("Pred:");
            string.append('\n');
            for(CFNode node: pred){
                string.append(node.getSSA());
                string.append('\n');
            }
            string.append("Succ:");
            string.append('\n');
            for(CFNode node: succ){
                string.append(node.getSSA());
                string.append('\n');
            } 

            string.append("Use:");
            string.append('\n');
            for(Variable var: use){
                if(var == master) continue;
                string.append(var.getSSA());
                string.append('\n');
            }
            string.append("Def:");
            string.append('\n');
            for(Variable var: def){
                string.append(var.getSSA());
                string.append('\n');
            }

            string.append("Out:");
            string.append('\n');
            for(Variable var: out){
                string.append(var.getSSA());
                string.append('\n');
            }

            string.append("In:");
            string.append('\n');
            for(Variable var: in){
                string.append(var.getSSA());
                string.append('\n');
            }
            
            return string.toString();
        }

    }

    // a node in the interference graph (a temporary)
    class TempNode {
        // FILLIN...
        Set<TempNode> live;
        Variable master;
        int color;
        boolean removed;

        public TempNode(Variable var) {
            master = var;
            live = new HashSet<TempNode>();
        }

        public void addSetToLive(TempNode temp) {
                live.add(temp);
        }

        public Set<TempNode> getAdjList() {
            return live;
        }

        public Variable getVariable() {
            return master;
        }

        public boolean contains(SSAStatement ssa) {
            return master.contains(ssa);
        }

        public boolean isLive(TempNode temp) {
            return live.contains(temp);
        }

        public void setColor(int color) {
            this.color = color;
        }

        public int getColor() {
            return color;
        }

        public void setRemoved(boolean isRemoved) {
            removed = isRemoved;
        }

        public boolean isRemoved() {
            return removed;
        }

        public String toString() {
            StringBuilder string = new StringBuilder("TempNode");
            string.append('\n');
            string.append("Var:" + master.toString());
            string.append("LiveSet");
            string.append('\n');
            for(TempNode temp: live) {
                string.append(temp.getVariable().toString());
                string.append('\n');
            }

            return string.toString();
        }
    }

    class Graph {
        Map<TempNode, Set<TempNode>> adj;
        int size;
        public Graph() {
            adj = new HashMap<TempNode, Set<TempNode>>();
            size = 0;
        }

        public void addVertex(TempNode temp) {
            Set<TempNode> set;
            if(!adj.containsKey(temp)) {
                set = new HashSet<TempNode>();
            } else {
                set = adj.get(temp);
            }
            adj.put(temp, temp.getAdjList());
            size++;
        }
        public Set<TempNode> getNeighbors(TempNode node) {
            Set<TempNode> neighbors = new HashSet<TempNode>();
            for(Set<TempNode> set : adj.values()) {
                if(set.contains(node)){
                    for(TempNode n : set) {
                        if(n == node) continue;
                        neighbors.add(n);
                    }
                }
            }
            return neighbors;
        }

        public TempNode findDegreeLessNode(int k) {
            TempNode greater = null;
            for(TempNode i : adj.keySet()){
                if(i.isRemoved()) continue;
                if(this.getDegree(i) < k) {
                    return i;
                } else {
                    greater = i;
                }
            }
            return greater;
        }
        public void color() {
            for(TempNode i : adj.keySet()){
                for(SSAStatement s : i.getVariable().getUnifedSSA()) {
                    s.setRegister(i.getColor());
                }
            }  
        }

        public TempNode leastUsedNode() {
            return null;
        }

        public int getDegree(TempNode temp) {
            int degree = 0;
            if(adj.containsKey(temp)) {
                for(TempNode node : adj.get(temp)){
                    if(!node.isRemoved())
                        degree++;
                }
            } else {
                degree = -1;
            } 
            return degree;
        }

        public void remove(TempNode temp) {
            if(adj.containsKey(temp)) {
                temp.setRemoved(true);
                temp.setColor(-1);
                size--;
            }
        }  
        public int findColor(TempNode temp , int registers) {
            Set<TempNode> set = this.getNeighbors(temp);
            List<Integer> colors = new ArrayList<Integer>();
            //System.out.println("Computing color for: " + temp + " color is " + temp.getColor());
            for(TempNode node : set) {
                //System.out.println("Neighbor:");
                //System.out.println(node.getVariable().getSSA() + " color is " + node.getColor());
                if(node.isRemoved()) continue;
                int neighborColor = node.getColor();

                colors.add(neighborColor);
            }

            
           // for(Integer i : colors) {
             //   System.out.println(i);
           // }
            for(int i = 0; i < registers; i++) {
                if(!colors.contains(i)){
                    //System.out.println("Color is now " + i);
                    return i;
                }
            }
            //System.out.println("Bad Color is now " + -1);
            return -1;
        }

        public int size() {
            return size;
        }
        public boolean isEmpty() {
            if(size > 0) return false;
            return true;
        }

        public void clear() {
            size = 0;
            adj.clear();
        }
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
    Graph interference;
    Deque<TempNode> stack;
    int numOfSpills;

    private RegisterAllocator() {
        variables = new ArrayList<Variable>();
        cfnodes = new ArrayList<CFNode>();
        tempnodes = new ArrayList<TempNode>();
        stack = new ArrayDeque<TempNode>();
        interference = new Graph();

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
        //System.out.println("New Method");
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

break;
/*
            // OK, rewrite to perform the spills
            ra.performSpills(actualSpills);*/
        }

        // FILLIN: now, using the information from the interference graph, assign the register for each SSA statement
            ra.color();
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
            if((op == Op.Unify || op == Op.Alias) && !toRemove.contains(var)) {
                findUnify(var.master, toRemove);
            }
        } 

        // delete unified variables individual objects
        for(Variable var : toRemove) {
            // remove the variable from the list
            variables.remove(var);
        }

       /* for(Variable var : variables) {
            System.out.println(var);
        } */
    }

    public void initCFNodes() {
        for(SSAStatement s : block) {
            CFNode newNode = new CFNode(s);
            cfnodes.add(newNode);
            //System.out.println(newNode);
        }
    }

     public void addUses() {
        for(CFNode node : cfnodes) {
            fillUses(node);
            //System.out.println(node);
        }
    }

     public void cfPredSucc() {
        for(CFNode node : cfnodes) {
            fillPredSucc(node);
            //System.out.println(node);
            //System.out.println("end");
        }
    }
    public void liveness() {
        CFNode node;
        Set<Variable> out, in, def, use, succIn;
        Set<CFNode> succ;
        int size, index;
        Variable var;
        SSAStatement ssa;
        Set<Integer> done;
        HashMap<Integer, Set<Integer>> todo;

        todo = new HashMap<Integer, Set<Integer>>();
        done = new HashSet<Integer>();
        size = block.size();

        for(int i =  size - 1; i > -1; i--) {
            // For each ssastatement find it's cfnode, then get it's out and int 

            ssa = block.get(i);

            node = findCFNode(ssa);
            index = ssa.getIndex();
            out = node.getSet("out");
            in = node.getSet("in");
            def = node.getSet("def");
            use = node.getSet("use");
            succ = node.getPredSucc("succ");

            //System.out.println("Statement " + ssa.getIndex() + " analysis: " + ssa);

            for(Variable v : def)
                out.add(v);
            
            
            // if it's not the first node being analyzed
            if(succ != null) { 
                for(CFNode n : succ) {
                    int succSSA = n.getSSA().getIndex();
                    // if the successor isn't done yet, put it in the todo
                    if(!done.contains(succSSA)) {
                        Set<Integer> todoSet;
                        if(!todo.containsKey(succSSA)) {
                            todoSet = new HashSet<Integer>();
                            todoSet.add(i);

                        } else {
                            todoSet = todo.get(succSSA);
                            todoSet.add(i);
                        }
                      //  System.out.println("Added " + i + " waiting for " + succSSA);
                        todo.put(succSSA, todoSet);
                        continue;
                    }
               
                    //System.out.println("Succ:" + succSSA);
                    //System.out.println(findCFNode(succSSA));
                
                    succIn = findCFNode(succSSA).getSet("in");
                    for(Variable v : succIn) {
                        out.add(v);
                    }
                }
            }
            
            for(Variable v : out) {
                if(!def.contains(v)) 
                    in.add(v);
            }

            for(Variable v : use) {
                in.add(v);
            }

            done.add(index);

            if(todo.containsKey(index)) {
             //   System.out.println("Finally Finished " + index);
                int max = i;
                for(Integer predInt : todo.get(index)) { 
                //System.out.println("Pred Int is " + predInt);   
                    if(predInt > max) 
                        max = predInt;
                }
                todo.remove(index);
                // max + 1 because the loop will do a i--
                i = max + 1;
                //System.out.println("Going back to " + i);
            }

             
          /*  System.out.println("Out");
            for(Variable v : out) {
                System.out.println("    "+v.master);
            }
            System.out.println("In");
            for(Variable v : in) {
                System.out.println("    "+v.master);
            }
           
            System.out.println("end"); 
            System.out.println("");  */
            
        }


    }

    public void initTempNodes() {
        for(Variable var : variables) {
            TempNode temp = new TempNode(var);
            tempnodes.add(temp);
            //System.out.println(temp);
        }
    }

    public void buildInterference() {
        for(TempNode temp : tempnodes) {
            for(SSAStatement s : temp.getVariable().getUnifedSSA()) {
                CFNode cfnode = findCFNode(s);
                for(Variable var : cfnode.getSet("in")){
                    temp.addSetToLive(findTempNode(var));
                }
            }
            interference.addVertex(temp);
           // System.out.println("Degree of " + temp);
           // System.out.println(interference.getDegree(temp));
        }
        //System.out.println("Size of Graph is " + interference.size() + " Number of Variables " + variables.size() + " Number of temps: " + tempnodes.size());
    }

    public void simplify(int freeRegisters) {
        /*  while graph is not empty find the min degree */
        int degree;
        while(!interference.isEmpty()) {
            TempNode min = interference.findDegreeLessNode(freeRegisters);
            degree = interference.getDegree(min);
           
            if(degree >= freeRegisters) {

                //min = interference.leastUsedNode();
                // fix this!!
                stack.addLast(min);
            } else {
                stack.push(min);
            }

            interference.remove(min);
           // System.out.println("Graph size is now :" + interference.size());
        } 
       // for(TempNode node : tempnodes)
        //    System.out.println(node.isRemoved());

    }

    public Set<TempNode> select(int freeRegisters){
        Set<TempNode> spills = new HashSet<TempNode>();
        
        /*Create new graph While stack has nodes, color 
           if color is invalid, spill */
        TempNode node;
        int color;
        while(!stack.isEmpty()) {
            node = stack.pop();
            node.setRemoved(false);
            color = interference.findColor(node, freeRegisters);
            if(color == -1) {
            //System.out.println("Fuck");
                spills.add(node);
                break;
            }
            node.setColor(color);
        }

        while(!stack.isEmpty()) {
            spills.add(stack.pop());
        }
   
    
       return spills;
    }

    public void color() {
        interference.color();
    }

    /**** Helper functions *****/

    // Finders
        public void findUnify(SSAStatement stat, List<Variable> toRemove) {

        SSAStatement left = stat.getLeft();
        SSAStatement right = stat.getRight();

        if(left.getOp() == Op.Unify || left.getOp() == Op.Alias)
            findUnify(left, toRemove);

        if(right.getOp() == Op.Unify || right.getOp() == Op.Alias)
            findUnify(right, toRemove);
        
        Variable main = findVariable(stat);
        
        if(main == null) throw new Error("Couldn't find variable");

        Variable l = findVariable(left);

        Variable r = findVariable(right);

        for(SSAStatement s : l.getUnifedSSA()){
            main.getUnifedSSA().add(s);
        }

        if(r != null) {
            for(SSAStatement s : r.getUnifedSSA()){
                main.getUnifedSSA().add(s);
            }
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

    public Variable findVariable(int index) {
        for(Variable var: variables) {
            if(var.contains(index))
                return var;
        }
        return null;
    } 

    public CFNode findCFNode(Variable var) {
        return findCFNode(var.getSSA());
    }

    public CFNode findCFNode(SSAStatement ssa) {
        return findCFNode(ssa.getIndex());
    }

    public CFNode findCFNode(int index) {
        for(CFNode node : cfnodes){
            if(node.contains(index)){
                return node;
            }
        }
        return null;
    }

    public TempNode findTempNode(Variable var) {
        return findTempNode(var.getSSA().getIndex());
    }

    public TempNode findTempNode(int index) {
        for(TempNode node : tempnodes) {
            if(node.getVariable().getSSA().getIndex() == index)
                return node;
        }
        return null;
    }

    public void findLabelSucc(String label, Set<CFNode> set) {
        Op oper;
        for(CFNode node : cfnodes){
            Variable var = node.getVariable();
            for(SSAStatement s : var.getUnifedSSA()) {
                oper = s.getOp();
                if((oper == Op.NBranch) || (oper == Op.Branch) || (oper == Op.Goto)) {
                    String jumpsTo = (String)s.getSpecial();
                    if(jumpsTo.equals(label))
                        set.add(node);
                }
            }
        }
    }

    public void findLabel(String label, Set<CFNode> set) {
        Op oper;
        for(CFNode node : cfnodes){
            Variable var = node.getVariable();
            for(SSAStatement s : var.getUnifedSSA()) {
                oper = s.getOp();
                if(oper == Op.Label) {
                    String jumpsTo = (String)s.getSpecial();
                    if(jumpsTo.equals(label))
                        set.add(node);
                }
            }
        }
    }


    //Fillers
    public void addUse(SSAStatement ssa, Set<Variable> set) {

        SSAStatement left, right;
        left = null;
        right = null;
        Op oper = ssa.getOp();

        switch(oper) {
            case MemberAssg:
            case Index:
            case Unify:
            case Eq:             
            case Ne:
            case Lt:
            case Le:         
            case Gt:
            case Ge:
            case And:
            case Or:
            case Plus:           
            case Minus:          
            case Mul:            
            case Div:            
            case Mod:
                left = ssa.getLeft();
                right = ssa.getRight();
                break;
            case IndexAssg:
                left = ssa.getLeft();
                right = ssa.getRight();
                set.add(findVariable((SSAStatement)ssa.getSpecial()));
                break;
            case Call:
                left = ssa.getLeft();
                SSACall call = (SSACall)ssa.getSpecial();
                for(SSAStatement s: call.getArgs()) {
                    set.add(findVariable(s));
                }
                break;
            case Member:
            case Not:
            case Arg:
            case NewIntArray:
            case Return:
            case Alias:
            case Store:
            case Load:
            case VarAssg:         
            case Print:
            case Branch:
            case NBranch:
                left = ssa.getLeft();              
                break;
            default:
                break;

        }

        if(left != null) 
            set.add(findVariable(left));
        if(right != null)
            set.add(findVariable(right));
    }

    public void fillUses(CFNode node) {
        SSAStatement ssa = node.getSSA();
        Set<Variable> useDef;

        useDef = node.getSet("use");
        addUse(ssa, useDef);
        // define set
        useDef = node.getSet("def");
        // it defines itself
        useDef.add(node.getVariable()); 
    } 

       public void fillPredSucc(CFNode node) {
        Set<CFNode> set;
        CFNode succPred;
        SSAStatement ssa;
        int prevSSA, nextSSA;

        ssa = node.getSSA();

        prevSSA = ssa.getIndex() - 1;
        nextSSA = prevSSA + 2;
        
        succPred = findCFNode(prevSSA);
        if( succPred != null) {
            set = node.getPredSucc("pred");
            addPred(ssa, set, succPred, prevSSA);
        }

        succPred = findCFNode(nextSSA);
        if(succPred != null) {
            set = node.getPredSucc("succ");
            addSucc(ssa, set, succPred); 
        }
    }

    public void addPred(SSAStatement ssa, Set<CFNode> set, CFNode pred, int prevIndex) {

        Op oper = ssa.getOp();
        if(oper == Op.Label) {
            // find Branchs and Gotos that refer to this label.
            String label = (String)ssa.getSpecial();
            findLabelSucc(label, set);
        }

        if(!isGotoPred(pred, prevIndex))
            set.add(pred);
        
        return;
    }

    public void addSucc(SSAStatement ssa, Set<CFNode> set, CFNode succ) {

        SSAStatement left;
        Op oper = ssa.getOp();

        if((oper == Op.NBranch) || (oper == Op.Branch) || (oper == Op.Goto)) {
            // find labels that these jump to.
            String label = (String)ssa.getSpecial();
            findLabel(label, set);
        }
        
        // Gotos don't have a successor at goto's index + 1;
        if(oper != Op.Goto)
            set.add(succ);
        
        return;
    }

    // isX functions
    public boolean isGotoPred(CFNode pred, int index) {
        for(SSAStatement s : pred.getVariable().getUnifedSSA()) {
            if(s.getIndex() == index && s.getOp() == Op.Goto)
                return true; 
        }
        return false;
    }

}
