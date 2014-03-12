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
        List<VarDecl> variables = new ArrayList<VarDecl>();
        List<SSAStatement> body = new ArrayList<SSAStatement>();
        List<Statement> statement = new ArrayList<Statement>();
        Map<String, SSAStatement> table = new HashMap<String, SSAStatement>();
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
        }
        // and the variable declarations
        // ...

        for(VarDecl var : method.getVarDecls()) {
            System.out.println("Type Assignment:" + var.getType().getName());
            type = var.getType();
            ssaValue = new SSAStatement(var, SSAStatement.Op.Null, type);
            body.add(ssaValue);
            table.put(var.getName(), ssaValue); 
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
        Exp target = exp.getTarget();
        Exp value = exp.getValue();
        SSAStatement ret, left;

        if (target instanceof VarExp) {
            // ...
            String name = ((VarExp)target).getName();
            left = (SSAStatement)visit(value);
            ret = new SSAStatement(exp, SSAStatement.Op.VarAssg, left, null, name);
        } else if (target instanceof MemberExp) {
            // ...
            String member = ((MemberExp)target).getMember();
            SSAStatement right = (SSAStatement)visit(value);
            left = (SSAStatement)visit(((MemberExp)target).getSub());

            ret = new SSAStatement(exp, SSAStatement.Op.MemberAssg, left, right, member);
        } else if (target instanceof IndexExp) {
            // ...
            SSAStatement index, right;
            right = (SSAStatement)visit(value);
            left = (SSAStatement)visit(((IndexExp)target).getTarget());
            index = (SSAStatement)visit(((IndexExp)target).getIndex());
            ret = new SSAStatement(exp, SSAStatement.Op.IndexAssg, left, right, index);
        } else {
            throw new Error("Invalid LHS: " + target.getClass().getSimpleName());

        }

        return ret;
    }

    @Override public Object visit(BinaryExp node) {
        System.out.println("");
        SSAStatement ret = null;

        return ret; 
    }
    @Override public Object visit(BlockStatement node) {
        System.out.println("");
        SSAStatement ret = null;

        return ret; 
    }
    @Override public Object visit(BooleanLiteralExp node) {
        System.out.println("BooleanLiteralExp:" + node.getValue());
        SSAStatement ret = null;
        Boolean value = node.getValue();
        ret = new SSAStatement(node, SSAStatement.Op.Boolean, value);
        body.add(ret);
        return ret; 
    }
    @Override public Object visit(CallExp node) {
        System.out.println("");
        SSAStatement ret = null;

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
        SSAStatement ret, left;
        Exp exp = node.getExp();
        left = (SSAStatement)visit(exp);
        ret = new SSAStatement(node, SSAStatement.Op.Print, left, null);
        return ret; 
    }
    @Override public Object visit(IfStatement node) {
        System.out.println("IfStatement");
        SSAStatement ret = null;

        return ret; 
    }
    @Override public Object visit(IndexExp node) {
        System.out.println("");
        SSAStatement ret = null;

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
        System.out.println("");
        SSAStatement ret = null;

        return ret; 
    }

    @Override public Object visit(NewIntArrayExp node) {
        System.out.println("");
        SSAStatement ret = null;

        return ret; 
    }
    @Override public Object visit(NewObjectExp node) {
        System.out.println("");
        SSAStatement ret = null;

        return ret; 
    }
    @Override public Object visit(NotExp node) {
        System.out.println("");
        SSAStatement ret = null;

        return ret; 
    }

    @Override public Object visit(PrintStatement node) {
        System.out.println("");
        SSAStatement ret = null;

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
        System.out.println("");
        SSAStatement ret = null;

        return ret; 
    }

    @Override public Object visit(VarDecl node) {
        System.out.println("");
        SSAStatement ret = null;

        return ret; 
    }
    @Override public Object visit(VarExp node) {
        System.out.println("");
        SSAStatement ret = null;

        return ret; 
    }
    @Override public Object visit(WhileStatement node) {
        System.out.println("");
        SSAStatement ret = null;

        return ret; 
    }
    public void compileReturn(Exp retExp) {
        // ...
        System.out.println("Return");
        SSAStatement left = (SSAStatement)visit(retExp);
        SSAStatement ret = new SSAStatement(retExp, SSAStatement.Op.Return, left, null);
        body.add(ret);
    }

    public List<SSAStatement> getBody() { return body; }
    public Map<String, SSAStatement> getScope() { return scope; }
}
