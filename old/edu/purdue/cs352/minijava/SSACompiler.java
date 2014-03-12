package edu.purdue.cs352.minijava;

import java.util.*;

import edu.purdue.cs352.minijava.ast.*;
import edu.purdue.cs352.minijava.ssa.*;



public class SSACompiler extends ASTVisitor.SimpleASTVisitor {
    // The method body currently being compiled
    List<SSAStatement> body = new ArrayList<SSAStatement>();

    // Create a field for local variables (symbol table)
    // ...
    static Map<String,Object> table= new HashMap<String, Object>();
    int label = 0;
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
        List<Parameter> parameters = new ArrayList<Parameter>();
        List<VarDecl>   variables = new ArrayList<VarDecl>();
        List<Statement> statements = new ArrayList<Statement>();
        Map<String, Object> table = new HashMap<String, Object>();
        SSAStatement ret, left;
        Type type;

        // visit the parameters
        // ...
        int index = 0;
        for(Parameter param : method.getParameters()) {

            ret = new SSAStatement(param, SSAStatement.Op.Parameter, index++);
            compiler.getBody().add(ret);

            left = new SSAStatement(param, SSAStatement.Op.VarAssg, ret, null, param.getName());
            compiler.getBody().add(left);

            table.put(param.getName(), ret.getIndex());
        }
        // and the variable declarations
        // ...
        for(VarDecl var : method.getVarDecls()) {
            type = var.getType();
            ret = new SSAStatement(var, SSAStatement.Op.Null, type);
            compiler.getBody().add(ret);
            table.put(var.getName(), ret.getIndex());
        }

        for(Map.Entry entry : table.entrySet()) {
            System.out.println("{key:" + entry.getKey() + ", val:" + entry.getValue() + "}");
        }
        
        // then compile the body
        // ...
        // statement.accept(compiler);
        for(Statement stat : method.getBody()) {
            stat.accept(compiler);
        }

        // and the return
        compiler.compileReturn(method.getRetExp());

        return new SSAMethod(method, compiler.getBody());
    }

    @Override public Object defaultVisit(ASTNode node) {
        return this;//throw new Error("Unsupported visitor in SSACompiler: " + node.getClass().getSimpleName());
    }

    // ...

    @Override public Object visit(AssignExp exp) {
        // what sort of statement we make, if any, depends on the LHS
        Exp target = exp.getTarget();
        String name;
        SSAStatement left;
        SSAStatement right;
        SSAStatement ret;

        if (target instanceof VarExp) {
            // left=value, special name

            name = ((VarExp)target).getName();  
            System.out.println("AssignExp: VarExp:" + name);
            left = (SSAStatement)visit(exp.getValue());

            ret = new SSAStatement(exp, SSAStatement.Op.VarAssg, left, null, name);
        } else if (target instanceof MemberExp) {
            // left = object, right=value, special name
            name = ((MemberExp)target).getMember();
            System.out.println("AssignExp: MemberExp:" + name);
            left = (SSAStatement)visit(((MemberExp)target).getSub());

            right = (SSAStatement)visit(exp.getValue());

            ret = new SSAStatement(exp, SSAStatement.Op.MemberAssg, left, right, name);
        } else if (target instanceof IndexExp) {
            // left = array, right=value, special index
            System.out.println("AssignExp: IndexExp");
            left = (SSAStatement)visit(((IndexExp)target).getTarget());

            right = (SSAStatement)visit(exp.getValue());

            Exp index = ((IndexExp)target).getIndex();

            ret = new SSAStatement(exp, SSAStatement.Op.IndexAssg, left, right, index);
        } else {

            throw new Error("Invalid LHS: " + target.getClass().getSimpleName());

        }
        //body.add(ret);
        return ret;
    }

    @Override public Object visit(BinaryExp exp) {
        System.out.println("BinaryExp");
        SSAStatement target = (SSAStatement)visit(exp.getLeft());
        SSAStatement operands = (SSAStatement)visit(exp.getRight());
        String op = exp.getOp().toString();
        SSAStatement ret;

        if(op.equals("<")){
            ret = new SSAStatement(exp, SSAStatement.Op.Lt, target, operands); 
        } else if(op.equals("<=")) {
            ret = new SSAStatement(exp, SSAStatement.Op.Le, target, operands); 
        } else if(op.equals("==")) {
            ret = new SSAStatement(exp, SSAStatement.Op.Eq, target, operands);
        } else if(op.equals("!=")) {
            ret = new SSAStatement(exp, SSAStatement.Op.Ne, target, operands);
        } else if(op.equals(">")) {
            ret = new SSAStatement(exp, SSAStatement.Op.Gt, target, operands);
        } else if(op.equals(">=")) {
            ret = new SSAStatement(exp, SSAStatement.Op.Ge, target, operands);
        } else if(op.equals("&&")) {
            ret = new SSAStatement(exp, SSAStatement.Op.And, target, operands);
        } else if(op.equals("||")) {
            ret = new SSAStatement(exp, SSAStatement.Op.Or, target, operands);
        } else if(op.equals("+")) {
            ret = new SSAStatement(exp, SSAStatement.Op.Plus, target, operands);
        } else if(op.equals("-")) {
            ret = new SSAStatement(exp, SSAStatement.Op.Minus, target, operands);
        } else if(op.equals("*")) {
            ret = new SSAStatement(exp, SSAStatement.Op.Mul, target, operands);
        } else if(op.equals("/")) {
            ret = new SSAStatement(exp, SSAStatement.Op.Div, target, operands);
        } else if(op.equals("%")) {
            ret = new SSAStatement(exp, SSAStatement.Op.Mod, target, operands);
        } else {
            throw new Error("Invalid Operator:" + op);
        }
        body.add(ret);
        return ret; 
    }

    @Override public Object visit(BlockStatement node) { 
        SSAStatement ret;
        return defaultVisit(node); 
    }

    @Override public Object visit(BooleanLiteralExp node) { 
        SSAStatement ret;
        System.out.println("BooleanLiteralExp:"+node.getValue());
        Boolean value = node.getValue();
        ret = new SSAStatement(node, SSAStatement.Op.Boolean, value);
        body.add(ret);
        return ret; 
    }

    /* FIX ARG WITH INDEX */
    @Override public Object visit(CallExp node) {
        SSAStatement ret, arg;
        System.out.println("CallExp:"+node.getClass());
        List<SSAStatement> args = new ArrayList<SSAStatement>();

        SSAStatement left = (SSAStatement) visit(node.getTarget());

        for(Exp e : node.getArguments()) {
            arg = new SSAStatement(e, SSAStatement.Op.Arg,(SSAStatement)visit(e), null, new Integer(2));
            args.add(arg);
            body.add(arg);
        }

        SSACall methsArgs = new SSACall(node.getMethod(), args);
        
        ret = new SSAStatement(node, SSAStatement.Op.Call, left, null, methsArgs);
        body.add(ret);
        return ret; 
    }

    @Override public Object visit(ExpStatement node) { 
        SSAStatement ret;
        System.out.println("ExpStatement");
        ret = (SSAStatement)visit(node.getExp());
        return ret;
    }

    /* Fix later */
    @Override public Object visit(IfStatement node) {  
        SSAStatement ret = null, left;
        System.out.println("If");
        Exp condition = node.getCondition();
        Statement ifpart = node.getIfPart();
        Statement elsepart = node.getElsePart();
        String ifLabel, elseLabel, doneLabel;
        left = (SSAStatement)visit(condition);
        if(elsepart != null){
            // branch if false (Nbranch)
            ifLabel = "lif_" + (label++) + "_else";
            ret = new SSAStatement(node, SSAStatement.Op.NBranch, left, null, ifLabel);
            body.add(ret);
            // Add statements
            body.add((SSAStatement)visit(elsepart));
            // Go to end
            doneLabel = "Lif_" + (label-1) + "_done";
            ret = new SSAStatement(node, SSAStatement.Op.Goto, doneLabel);
            body.add(ret);

            // else it was true; execute if true  statement
            body.add((SSAStatement)visit(ifpart));
            ret = new SSAStatement(node, SSAStatement.Op.Label, doneLabel);
            body.add(ret);
        } 
        //ret = new SSAStatement(node, SSAStatement.Op.Unify,);
        return ret;
    }

    @Override public Object visit(IndexExp node) { 
       System.out.println("IndexExp");
       SSAStatement ret;
       SSAStatement left = (SSAStatement)visit(node.getTarget());
       SSAStatement right = (SSAStatement)visit(node.getIndex());
       ret = new SSAStatement(node, SSAStatement.Op.Index, left, right);
       body.add(ret);
       return ret; 
   }

   @Override public Object visit(IntLiteralExp node) { 
        SSAStatement ret;
        System.out.println("IntLiteralExp:"+node.getValue());
        Integer value = node.getValue();
        ret = new SSAStatement(node, SSAStatement.Op.Int, value);
        body.add(ret);
        return ret; 
    }

    @Override public Object visit(MemberExp node) { 
        SSAStatement ret;
        System.out.println("Member:"+node.getMember());
        SSAStatement left = (SSAStatement)visit(node.getSub());
        String member = node.getMember();
        ret = new SSAStatement(node, SSAStatement.Op.Member, left, null, member);
        body.add(ret);
        return ret; 
    }

    @Override public Object visit(NewIntArrayExp node) { 
        SSAStatement ret;
        System.out.println("NewIntArrayExp:"+node.getSize());
        SSAStatement left = (SSAStatement)visit(node.getSize());
        ret = new SSAStatement(node, SSAStatement.Op.NewIntArray, left,null);
        body.add(ret);
        return ret; 
    }
    @Override public Object visit(NewObjectExp node) { 
        SSAStatement ret;
        String type = node.getName();
        System.out.println("NewObj Name:" + type);
        ret = new SSAStatement(node, SSAStatement.Op.NewObj, type);
        body.add(ret);
        return ret; 

    }
    @Override public Object visit(NotExp node) {
        SSAStatement ret;
        System.out.println("Not");
        SSAStatement left = (SSAStatement)visit(node.getSub());
        ret = new SSAStatement(node, SSAStatement.Op.Not, left, null);

        return ret; 
    }
    /* FIX THIS ONE */
    @Override public Object visit(Parameter node) { 
        SSAStatement ret, left;
        System.out.println("Paramter:"+node.getName() + " " + (Integer)table.get(node.getName()));
        ret = new SSAStatement(node, SSAStatement.Op.Parameter, (Integer)table.get(node.getName()));
        left = new SSAStatement(node, SSAStatement.Op.VarAssg, ret, null, node.getName());
       
        body.add(ret);
        body.add(left);
        return left; 
    }

    @Override public Object visit(PrintStatement node) {
        System.out.println("PrintStatement");
        SSAStatement left = (SSAStatement)visit(node.getValue());
        SSAStatement stat = new SSAStatement(node, SSAStatement.Op.Print, left, null);
        body.add(stat);
        return stat;
    }

    @Override public Object visit(ThisExp node) { 
       System.out.println("This");
       SSAStatement ret;
       ret = new SSAStatement(node, SSAStatement.Op.This);
       body.add(ret);
       return ret; 
    }
    /* Never Called any Types */
    @Override public Object visit(TypeBoolean node) { return defaultVisit(node); }
    @Override public Object visit(TypeIntArray node) { return defaultVisit(node); }
    @Override public Object visit(TypeInt node) { return defaultVisit(node); }

    @Override public Object visit(Type node) { 
        SSAStatement ret;
        System.out.println("Type Fix\n\n");
        ret = new SSAStatement(node, SSAStatement.Op.Null);
        body.add(ret);
        return ret; 
    }
    /* No Idea */
    @Override public Object visit(VarExp node) { 
        SSAStatement ret;
        System.out.println("VarExp:"+node.getName());
        ret = new SSAStatement(node, SSAStatement.Op.VarAssg, null, null, node.getName());
        body.add(ret);
        return ret; 
    }
    /* TODO */
    @Override public Object visit(WhileStatement node) { 
       System.out.println("While");
       return defaultVisit(node); 
    }

    /* Make sure works */
    @Override public Object visit(Statement node) { 

        SSAStatement ret;
        System.out.println("Statement");
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

    @Override public Object visit(Exp node) { 
        SSAStatement ret;
        System.out.println("Exp");
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
    @Override public Object visit(VarDecl node) { 
        SSAStatement ret;
        System.out.println("VarDecl:"+node.getName());
        Type type = node.getType();
        ret = new SSAStatement(node, SSAStatement.Op.Null, type);
        body.add(ret);
        return ret; 
    }

    public void compileReturn(Exp retExp) {
            // ...
       System.out.println("Compile");
       SSAStatement left = (SSAStatement)visit(retExp);
       SSAStatement ret = new SSAStatement(retExp, SSAStatement.Op.Return, left, null);
       body.add(ret);
    }

    public List<SSAStatement> getBody() { return body; }
}
