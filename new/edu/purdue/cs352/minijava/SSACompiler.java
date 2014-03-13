package edu.purdue.cs352.minijava;

import java.util.*;

import edu.purdue.cs352.minijava.ast.*;
import edu.purdue.cs352.minijava.ssa.*;

public class SSACompiler extends ASTVisitor.SimpleASTVisitor {
    // The method body currently being compiled
    List<SSAStatement> body = new ArrayList<SSAStatement>();

    // Create a field for local variables (symbol table)
    // ...
    Map<String, SSAStatement> scope = new HashMap<String, SSAStatement>();
    static long id = 0;

    public static SSAProgram compile(Program prog) {
        SSAMethod main = compile(prog.getMain());
        List<SSAClass> classes = new ArrayList<SSAClass>();

        for (ClassDecl cl : prog.getClasses())
            classes.add(compile(cl));

        return new SSAProgram(main, classes);
    }

    public static SSAClass compile(ClassDecl cl) {
        List<SSAMethod> methods = new ArrayList<SSAMethod>();
        for (MethodDecl md : cl.getMethods())
            methods.add(compile(md));
        return new SSAClass(cl, methods);
    }

    public static SSAMethod compile(Main main) {
        SSACompiler compiler = new SSACompiler();

        // there's only a body
        main.getBody().accept(compiler);

        return new SSAMethod(main, compiler.getBody());
    }

    public static SSAMethod compile(MethodDecl method) {
        SSACompiler compiler = new SSACompiler();
        List<SSAStatement> body = compiler.getBody();
        Map<String, SSAStatement> table = compiler.getScope();
        SSAStatement ssaParam, ssaValue;
        Type type;
        int index = 0;
        // visit the parameters
        // ...

        // compute parameters and add to symbol table
        for(Parameter param : method.getParameters()) {
            System.out.println("Parameter:" + param.getName());
            ssaParam = new SSAStatement(param, SSAStatement.Op.Parameter, index++);
            body.add(ssaParam);
            table.put(param.getName(), ssaParam);
        }

        // Assign the paramters to vars
        for(Parameter param : method.getParameters()) {
            System.out.println("VarAssg Parameters:" + param.getName());
            SSAStatement left = table.get(param.getName());
            ssaValue = new SSAStatement(param, SSAStatement.Op.VarAssg, left, null, param.getName());
            body.add(ssaValue);
            table.put(param.getName(), ssaValue);
        }
        // and the variable declarations
        // ...

        for(VarDecl var : method.getVarDecls()) {
            System.out.println("Type Assignment:" + var.getName() +" type:" + var.getType().getName());
            type = var.getType();
            ssaValue = new SSAStatement(var, SSAStatement.Op.Null, type);
            body.add(ssaValue);
            table.put(var.getName(), ssaValue); 
        }

        for (Map.Entry<String, SSAStatement> entry : table.entrySet()){
            System.out.println("Key:" + entry.getKey() + ", Value:" + ((SSAStatement)entry.getValue()).getIndex());
        }
        // then compile the body
        // ...
        // statement.accept(compiler);
        for(Statement stat : method.getBody()) {
            System.out.println("Statement for " + method.getName());
            stat.accept(compiler);
        }


        // and the return
        compiler.compileReturn(method.getRetExp());

        return new SSAMethod(method, compiler.getBody());
    }

    @Override public Object defaultVisit(ASTNode node) {
        throw new Error("Unsupported visitor in SSACompiler: " + node.getClass().getSimpleName());
    }

    // ...

    @Override public Object visit(AssignExp exp) {
        // what sort of statement we make, if any, depends on the LHS
        System.out.println("AssignExp");
        Exp target = exp.getTarget();
        Exp value = exp.getValue();
        SSAStatement ret, left;

        if (target instanceof VarExp) {
            // ...
            System.out.println("AssignExp, VarExp:" + ((VarExp)target).getName());
            String name = ((VarExp)target).getName();
            
            if(scope.get(name) == null) {
                // then it's a global object, do memberAssg
                ThisExp thiz = new ThisExp(null);
                MemberExp mem = new MemberExp(null, thiz, name);
                AssignExp next = new AssignExp(null, mem, value);
                return (SSAStatement)visit(next);
                //ret = new SSAStatement(exp, SSAStatement.Op.MemberAssg, (SSAStatement)visit(target), left, name);
            } else {
                left = (SSAStatement)visit(value);
                ret = new SSAStatement(exp, SSAStatement.Op.VarAssg, left, null, name);
                scope.put(name, ret);
                System.out.println("AssignExp, VarExp Assigned:" + name);
            }
        } else if (target instanceof MemberExp) {
            // ...
            System.out.println("AssignExp, MemberExp:" + ((MemberExp)target).getMember());
            String member = ((MemberExp)target).getMember();
            left = (SSAStatement)visit(((MemberExp)target).getSub());
            SSAStatement right = (SSAStatement)visit(value);
            ret = new SSAStatement(exp, SSAStatement.Op.MemberAssg, left, right, member);
            scope.put(member, ret);
        } else if (target instanceof IndexExp) {
            // ...
            System.out.println("AssignExp, IndexExp");
            SSAStatement index, right;
            left = (SSAStatement)visit(((IndexExp)target).getTarget());
            right = (SSAStatement)visit(value);
            index = (SSAStatement)visit(((IndexExp)target).getIndex());
            ret = new SSAStatement(exp, SSAStatement.Op.IndexAssg, left, right, index);
        } else {
            throw new Error("Invalid LHS: " + target.getClass().getSimpleName());
        }
        body.add(ret);
        return ret;
    }

    @Override public Object visit(BinaryExp node) {
        System.out.println("BinaryExp");
        SSAStatement target = (SSAStatement)visit(node.getLeft());
        SSAStatement operands = (SSAStatement)visit(node.getRight());
        String op = node.getOp().toString();
        SSAStatement ret;

        if(op.equals("<")){
            ret = new SSAStatement(node, SSAStatement.Op.Lt, target, operands); 
        } else if(op.equals("<=")) {
            ret = new SSAStatement(node, SSAStatement.Op.Le, target, operands); 
        } else if(op.equals("==")) {
            ret = new SSAStatement(node, SSAStatement.Op.Eq, target, operands);
        } else if(op.equals("!=")) {
            ret = new SSAStatement(node, SSAStatement.Op.Ne, target, operands);
        } else if(op.equals(">")) {
            ret = new SSAStatement(node, SSAStatement.Op.Gt, target, operands);
        } else if(op.equals(">=")) {
            ret = new SSAStatement(node, SSAStatement.Op.Ge, target, operands);
        } else if(op.equals("&&")) {
            ret = new SSAStatement(node, SSAStatement.Op.And, target, operands);
        } else if(op.equals("||")) {
            ret = new SSAStatement(node, SSAStatement.Op.Or, target, operands);
        } else if(op.equals("+")) {
            ret = new SSAStatement(node, SSAStatement.Op.Plus, target, operands);
        } else if(op.equals("-")) {
            ret = new SSAStatement(node, SSAStatement.Op.Minus, target, operands);
        } else if(op.equals("*")) {
            ret = new SSAStatement(node, SSAStatement.Op.Mul, target, operands);
        } else if(op.equals("/")) {
            ret = new SSAStatement(node, SSAStatement.Op.Div, target, operands);
        } else if(op.equals("%")) {
            ret = new SSAStatement(node, SSAStatement.Op.Mod, target, operands);
        } else {
            throw new Error("Invalid Operator:" + op);
        }
        body.add(ret);
        return ret; 
    }
    @Override public Object visit(BlockStatement node) {
        System.out.println("BlockStatement");
        List<Statement> stats = node.getBody();
        SSAStatement ret = null;

        for(Statement stat : node.getBody()) {
            ret = (SSAStatement)visit(stat);
        }

        return ret; 
    }
    @Override public Object visit(BooleanLiteralExp node) {
        System.out.println("BooleanLiteralExp:" + node.getValue());
        SSAStatement ret;
        boolean value = node.getValue();

        ret = new SSAStatement(node, SSAStatement.Op.Boolean, value);
        body.add(ret);
        return ret; 
    }
    @Override public Object visit(CallExp node) {
        System.out.println("CallExp:" + node.getMethod());
        SSAStatement ret, left, arg;
        SSACall methsArgs;
        Exp target = node.getTarget();
        List<SSAStatement> args = new ArrayList<SSAStatement>();
        String method = node.getMethod();

        // Evaluate left side
        left = (SSAStatement)visit(target);
        /* evaluate arguments */
        Integer pos = new Integer(0);
        for(Exp e : node.getArguments()) {
            System.out.println("CallExp Args");
            SSAStatement argLeft = (SSAStatement)visit(e);
            arg = new SSAStatement(e, SSAStatement.Op.Arg, argLeft, null, pos++);
            args.add(arg);
            body.add(arg);
        }
        methsArgs = new SSACall(method, args);
        // final call
        ret = new SSAStatement(node, SSAStatement.Op.Call, left, null, methsArgs);
        body.add(ret);
        return ret; 
    }

    @Override public Object visit(Exp node) {
        System.out.println("Exp");
        SSAStatement ret;

        if(node instanceof AssignExp) {
            ret = (SSAStatement)visit((AssignExp)node);
        } else if(node instanceof BinaryExp) {
            ret = (SSAStatement)visit((BinaryExp)node);
        } else if(node instanceof CallExp) {
            ret = (SSAStatement)visit((CallExp)node);
        } else if(node instanceof IntLiteralExp) {
            ret = (SSAStatement)visit((IntLiteralExp)node);
        } else if(node instanceof BooleanLiteralExp) {
            ret = (SSAStatement)visit((BooleanLiteralExp)node);
        }  else if(node instanceof NewIntArrayExp) {
            ret = (SSAStatement)visit((NewIntArrayExp)node);
        } else if(node instanceof NewObjectExp) {
            ret = (SSAStatement)visit((NewObjectExp)node);
        } else if(node instanceof NotExp) {
            ret = (SSAStatement)visit((NotExp)node);
        } else if(node instanceof ThisExp) {
            ret = (SSAStatement)visit((ThisExp)node);
        } else if(node instanceof MemberExp) {
            ret = (SSAStatement)visit((MemberExp)node);
        } else if(node instanceof VarExp) {
            ret = (SSAStatement)visit((VarExp)node);
        } else if(node instanceof IndexExp) {
            ret = (SSAStatement)visit((IndexExp)node);
        } else {
            throw new Error("Unsupported Exp Class: " + node.getClass());
        }
        return ret; 
    }
    @Override public Object visit(ExpStatement node) {
        System.out.println("ExpStatement");
        SSAStatement ret;
        Exp exp = node.getExp();
        ret = (SSAStatement)visit(exp);
        return ret; 
    }

    @Override public Object visit(IfStatement node) {
        System.out.println("IfStatement");
        SSAStatement ret, left;
        String label, done;
        label = "lif_" + id + "_else";
        done = "lif_" + (id++) + "_done" ;
        left = (SSAStatement)visit(node.getCondition());
        System.out.println("Done visiting condition");
        Statement ifpart = node.getIfPart();
        Statement elsepart = node.getElsePart();
        
        Map<String, SSAStatement> original, ifHash, elseHash;

        original = new HashMap<String, SSAStatement>(scope);
        elseHash = null;

        

        if(elsepart == null) {
            // if null then no else;
            // Branch to done if false
            ret = new SSAStatement(node, SSAStatement.Op.NBranch, left, null, done);
            body.add(ret);
            // if true do evaluate the statements
            visit(ifpart);
            ifHash = new HashMap<String, SSAStatement>(scope);
            // now you fall in to done     
        } else {
            // is an else
            // branch to else if false
            ret = new SSAStatement(node, SSAStatement.Op.NBranch, left, null, label);
            body.add(ret);

            //if true evaluate the statements
            visit(ifpart);
            ifHash= new HashMap<String, SSAStatement>(scope);
            // goto to done
            ret = new SSAStatement(node, SSAStatement.Op.Goto, done);
            body.add(ret);
            //if false else label
            ret = new SSAStatement(node, SSAStatement.Op.Label, label);
            body.add(ret);
            // execute else part
            visit(elsepart);
            elseHash = new HashMap<String, SSAStatement>(scope);
            // fall in to done
        }
        
        // done label
        ret = new SSAStatement(node, SSAStatement.Op.Label, done);
        body.add(ret);

        /* check for unification */

        // then only check ifhash and else hash, because one must be executed
        if(elseHash != null) {

            for(Map.Entry<String, SSAStatement> entry : elseHash.entrySet()) {
                System.out.println("Key:" + entry.getKey() + ", Value:"+ ((SSAStatement)entry.getValue()).getIndex());

                if(ifHash.containsKey(entry.getKey())) {

                    SSAStatement iftrue = (SSAStatement)ifHash.get(entry.getKey());
                    SSAStatement iffalse = (SSAStatement)entry.getValue();

                    if(iftrue.getIndex() != iffalse.getIndex()) {
                        System.out.println("Unify if/else");
                        ret = new SSAStatement(node, SSAStatement.Op.Unify, iftrue, iffalse);
                        body.add(ret);
                        scope.put(entry.getKey(), ret);
                    }

                }

            }
        } else {
            for(Map.Entry<String, SSAStatement> entry : ifHash.entrySet()) {
                System.out.println("Key:" + entry.getKey() + ", Value:"+ ((SSAStatement)entry.getValue()).getIndex());

                if(original.containsKey(entry.getKey())) {

                    SSAStatement old = (SSAStatement)original.get(entry.getKey());
                    SSAStatement newer = (SSAStatement)entry.getValue();

                    if(newer.getIndex() != old.getIndex()) {
                        System.out.println("Unify if");
                        ret = new SSAStatement(node, SSAStatement.Op.Unify, old, newer);
                        body.add(ret);
                        scope.put(entry.getKey(), ret);
                    }

                }

            }
        }

        return left; 
    }

    @Override public Object visit(IndexExp node) {
        System.out.println("IndexExp");
        SSAStatement ret, left, right;
        left = (SSAStatement)visit(node.getTarget());
        right = (SSAStatement)visit(node.getIndex());

        ret = new SSAStatement(node, SSAStatement.Op.Index, left, right);
        body.add(ret);
        return ret; 
    }

    @Override public Object visit(IntLiteralExp node) {
        System.out.println("IntLiteralExp:" + node.getValue());
        SSAStatement ret;
        Integer value = node.getValue();
        ret = new SSAStatement(node, SSAStatement.Op.Int, value);
        body.add(ret);
        return ret; 
    }

    @Override public Object visit(MemberExp node) {
        System.out.println("MemberExp:" + node.getMember());
        SSAStatement ret, left;
        String member = node.getMember();
        left = (SSAStatement)visit(node.getSub());
        ret = new SSAStatement(node, SSAStatement.Op.Member, left, null, member);
        body.add(ret);
        return ret; 
    }

    @Override public Object visit(NewIntArrayExp node) {
        System.out.println("NewIntArrayExp");
        SSAStatement ret, left;
        left = (SSAStatement)visit(node.getSize());
        ret = new SSAStatement(node, SSAStatement.Op.NewIntArray, left, null);
        body.add(ret);
        return ret; 
    }

    @Override public Object visit(NewObjectExp node) {
        System.out.println("NewObjectExp:" + node.getName());
        String type = node.getName();
        SSAStatement ret;
        ret = new SSAStatement(node, SSAStatement.Op.NewObj, type);
        body.add(ret);
        return ret; 
    }
    @Override public Object visit(NotExp node) {
        System.out.println("NotExp");
        SSAStatement ret, left;
        left = (SSAStatement)visit(node.getSub());
        ret = new SSAStatement(node, SSAStatement.Op.Not, left, null);
        body.add(ret);
        return ret; 
    }

    @Override public Object visit(PrintStatement node) {
        System.out.println("PrintStatement");
        SSAStatement ret, left;
        left = (SSAStatement)visit(node.getValue());
        ret = new SSAStatement(node, SSAStatement.Op.Print, left, null);
        body.add(ret);
        return ret; 
    }

    @Override public Object visit(Statement node) {
        System.out.println("Statement");
        SSAStatement ret;
        if(node instanceof BlockStatement) {
            ret = (SSAStatement)visit((BlockStatement)node);
        } else  if(node instanceof ExpStatement) {
            ret = (SSAStatement)visit((ExpStatement)node);
        } else if(node instanceof IfStatement) {
            ret = (SSAStatement)visit((IfStatement)node);
        } else if(node instanceof PrintStatement) {
            ret = (SSAStatement)visit((PrintStatement)node);
        } else if(node instanceof WhileStatement) {
            ret = (SSAStatement)visit((WhileStatement)node);
        } else {
            throw new Error("Unsupported Statement");
        }

        return ret; 
    }
    @Override public Object visit(ThisExp node) {
        System.out.println("ThisExp");
        SSAStatement ret;
        ret = new SSAStatement(node, SSAStatement.Op.This);
        body.add(ret);
        return ret; 
    }

    @Override public Object visit(VarExp node) {
        System.out.println("VarExp:" + node.getName());
        SSAStatement ret;
        ret = (SSAStatement)scope.get(node.getName());
        if(ret == null){
            // member variable, call a this and add to the body

            ThisExp thiz = new ThisExp(node.getToken());
            MemberExp mem = new MemberExp(node.getToken(), thiz, node.getName());
            ret = (SSAStatement)visit(mem);

            //body.add(ret);

        }
        return ret; 
    }
    @Override public Object visit(WhileStatement node) {
        System.out.println("WhileStatement");
        SSAStatement ret, condition;
        Exp cond;
        Statement whileBody;
        Map<String, SSAStatement> original, postBody, postWhile, postConditon;
        String start, done;
        start = "lwhile_" + id + "_start";
        done = "lwhile_" + (id++) + "_done";
        cond = node.getCondition();
        whileBody = node.getBody();

        // make start label if true

        ret = new SSAStatement(node, SSAStatement.Op.Label, start);
        body.add(ret);
        // save original scope; pre while
        original = new HashMap<String, SSAStatement>(scope);

        // eval condition
        condition = (SSAStatement)visit(cond);
        // save scope post condition scope
        postConditon = new HashMap<String, SSAStatement>(scope);


        // Nbranch if false to done
        ret = new SSAStatement(node, SSAStatement.Op.NBranch, condition, null, done);
        body.add(ret);
        // else execute statments; Save scope after post Body
        ret = (SSAStatement)visit(whileBody);
        postBody= new HashMap<String, SSAStatement>(scope);

        // go back to start
        ret = new SSAStatement(node, SSAStatement.Op.Goto, start);
        body.add(ret);
        // make the done label
        ret = new SSAStatement(node, SSAStatement.Op.Label, done);
        body.add(ret);
        // check for unify between post body and post cond
        for(Map.Entry<String, SSAStatement> entry : postBody.entrySet()) {
            System.out.println("Key:" + entry.getKey() + ", Value:"+ ((SSAStatement)entry.getValue()).getIndex());

            if(postConditon.containsKey(entry.getKey())) {

                SSAStatement old = (SSAStatement)postConditon.get(entry.getKey());
                SSAStatement newer = (SSAStatement)entry.getValue();

                if(newer.getIndex() != old.getIndex()) {
                    System.out.println("Unify while post condition and body");
                    ret = new SSAStatement(node, SSAStatement.Op.Unify, old, newer);
                    body.add(ret);
                    scope.put(entry.getKey(), ret);
                }

            }

        }

        // then check unify between 
        for(Map.Entry<String, SSAStatement> entry : scope.entrySet()) {
            System.out.println("Key:" + entry.getKey() + ", Value:"+ ((SSAStatement)entry.getValue()).getIndex());

            if(original.containsKey(entry.getKey())) {

                SSAStatement old = (SSAStatement)original.get(entry.getKey());
                SSAStatement newer = (SSAStatement)entry.getValue();

                if(newer.getIndex() != old.getIndex()) {
                    System.out.println("Unify while original and above");
                    ret = new SSAStatement(node, SSAStatement.Op.Unify, old, newer);
                    body.add(ret);
                    scope.put(entry.getKey(), ret);
                }

            }

        }

        return ret; 
    }

    public void compileReturn(Exp retExp) {
        // ...
        System.out.println("Return");
        SSAStatement left = (SSAStatement)visit(retExp);
        /*if( retExp instanceof VarExp) {
            VarExp exp = (VarExp)retExp;
            System.out.println("name:" +exp.getName());
            if(!scope.containsKey(exp.getName()))
                body.add(new SSAStatement(retExp, SSAStatement.Op.Member, left, null, exp.getName()));
        }*/
        SSAStatement ret = new SSAStatement(retExp, SSAStatement.Op.Return, left, null);
        body.add(ret);
    }

    public List<SSAStatement> getBody() { return body; }
    public Map<String, SSAStatement> getScope() { return scope; }
}
