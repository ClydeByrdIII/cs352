package edu.purdue.cs352.minijava;

import java.util.*;

import edu.purdue.cs352.minijava.ast.*;
import edu.purdue.cs352.minijava.ssa.*;
import edu.purdue.cs352.minijava.types.*;
import static edu.purdue.cs352.minijava.types.PrimitiveType.*;
import static edu.purdue.cs352.minijava.ssa.SSAStatement.*;
/* TODO Check for duplicate classes, parameters, variables, and fields and check types */
public class TypeChecker {
    SSAProgram prog;
    Map<String, StaticType> types;

    public TypeChecker(SSAProgram prog) {
        this.prog = prog;
        types = new HashMap<String, StaticType>();
        types.put("Object", new ObjectType("Object", null));
    }

    public void typeCheck() {
        // FILLIN
        // (Hint: Create types, then assign types to SSAFields/SSAMethods, then check types in SSAStatements)
        List<SSAStatement> body;
        List<SSAClass> classes;
        List<SSAMethod> methods;
        List<SSAField> fields;

        IntType intType = new IntType();
        BooleanType boolType = new BooleanType();
        VoidType voidType = new VoidType();
        // Set Common types
        types.put(intType.toString(), intType);
        types.put(boolType.toString(), boolType);
        types.put(voidType.toString(), voidType);
        types.put("int[]", new ObjectType("int[]", defaultSuper()));

        // Deal with Classes
        classes = prog.getClassesOrdered();

        for(SSAClass cless: classes) {
            handleClass(cless);
        }

        // Deal with Main
        handleStats(prog.getMain());

    }

    public void handleClass(SSAClass cless) {
        ClassDecl cd = (ClassDecl)cless.getASTNode();
        String name = cd.getName();
        String eggstends = cd.getExtends();
        SSAClass supper;

        if(eggstends != null) { 
                // fix this to handle if the class wasn't add yet 
            supper = prog.getClass(eggstends);
            if(supper == null) throw new Error("Super Class " + eggstends + " does not exist!");
            String supName = ((ClassDecl)supper.getASTNode()).getName();
            ObjectType supType = (ObjectType)types.get(supName);
            types.put(name, new ObjectType(name, supType));
        } else {
            types.put(name, new ObjectType(name, defaultSuper())); 
        }

        for(SSAField field : cless.getFieldsOrdered()) {
            handleField(field);
        }

        for(SSAMethod method : cless.getMethodsOrdered()) {
            handleMethod(method, name);
        }

            handleStats(cless.getMethodsOrdered(), name); // possibly bad place?

        }

        public void handleField(SSAField field) {
            VarDecl vd = field.getField();
            Type type = vd.getType();
            field.setType(types.get(type.getName()));
            System.out.println("name:" + vd.getName() + " "+type);
        }

        public void handleMethod(SSAMethod method, String cless) {
            if(method.getMain() == null) {
            //Parameters
                MethodDecl meth = method.getMethod();
                List<StaticType> ptypes = new ArrayList<StaticType>();
                List<Parameter> params = meth.getParameters();
                Type type;

                for(Parameter param : params) {
                    type = param.getType();
                    System.out.println("name:" + param.getName() + " " + param.getType());
                    ptypes.add(types.get(type.getName()));
                }
                method.setParamTypes(ptypes);
                System.out.println("name:" + meth.getName() + " " + meth.getType());
                type = meth.getType();
                method.setRetType(types.get(type.getName()));

            }

        }

        public void handleStats(SSAMethod method) {
            for(SSAStatement ssa : method.getBody()) {
                addType(ssa, "Main", "Main");
            }
        }

        public void handleStats(List<SSAMethod> methods, String cless) {
            for(SSAMethod method : methods) {
               for(SSAStatement ssa : method.getBody()) {
                addType(ssa, cless, method.getMethod().getName());
            }
        }
    }

    public void addType(SSAStatement ssa, String cless, String method) {
        Op oper = ssa.getOp();
        StaticType type = null;
        SSAStatement left, right;
        SSAMethod meth;
        String name;
        Type t;
        switch(oper) {
            case Int:
            type = types.get("int");
            break;
            case Print:
            type = types.get("void");
            break;
            case Unify:
            left = ssa.getLeft();
            right = ssa.getRight();
            StaticType t1 = left.getType();
            StaticType t2 = right.getType();
            System.out.println("t1:" + t1 + " t2:"+t2);

            // add instanceofs for ObjectTypes
            type = t1.commonSupertype(t2);
            break;
            case Alias:
            left = ssa.getLeft();
            type = left.getType();
            break;
            case Boolean:
            type = types.get("boolean");
            break;
            case This:
            type = types.get(cless);
            break;
            case Parameter:
            Parameter param = (Parameter)ssa.getASTNode();
            t = param.getType();
            type = types.get(t.getName());
            break;
            case Arg:
            left = ssa.getLeft();
            type = left.getType();
            break;
            case Null:
            t = (Type)ssa.getSpecial();
            type = types.get(t.getName());
            break;
            case NewObj:
            type = types.get((String)ssa.getSpecial());
            break;
            case NewIntArray:
            type = types.get("int[]");
            break;
            case Label:
            case Goto:
            type = types.get("void");
            break;
            case Branch:
            case NBranch:
            type = types.get("void");
            break;
            case Call:
                // what if call doesn't exist?
                SSACall call = (SSACall)ssa.getSpecial();
                left = ssa.getLeft();
                ObjectType obj = (ObjectType)left.getType();
                SSAClass thisClass = prog.getClass(obj.toString());
                meth = thisClass.getMethod(prog, call.getMethod());
                System.out.println("class is " + obj.toString() + " Method is " + call.getMethod() + " Prim:" + meth.getRetType());
                type = meth.getRetType();
            break;
            case Return:
                type = types.get("void");
            break;
            case Member:
                left = ssa.getLeft();
                name = (String)ssa.getSpecial();

            if(name.equals("length")) {
                type = types.get("int");
            } else {
                // change to find Type
                SSAClass cl = prog.getClass(cless);
                SSAField fd = cl.getField(prog, name);
                if(fd == null) throw new Error(name + " does not exist in " + cless + " or it's super classes!");
                System.out.println("name is " + name + " class is " + cless);
                type = fd.getType();
            }

            break;
            case Index:
            type = types.get("int");
            break;
            case VarAssg:
            type = findType(ssa, cless, method);
            break;
            case MemberAssg:
                left = ssa.getLeft(); // class obj/ this
                name = (String)ssa.getSpecial(); // member
                System.out.println("left is " + left.getType() + " member:" + name);
                SSAClass cle = prog.getClass(cless);
                SSAField  fie = cle.getField(prog, name);
                if(fie == null) throw new Error("Member:" + name + " does not exist!");
                type = fie.getType();

            break;
            case IndexAssg:
            type = types.get("int");
            break;
            case Not:
            type = types.get("boolean");
            break;
            case Lt:
            case Le:
            type = types.get("boolean");
            break;
            case Eq:             
            case Ne: 
            type = types.get("boolean");
            break;            
            case Gt:
            case Ge:
            type = types.get("boolean");
            break;
            case And:
            case Or:
            type = types.get("boolean");
            break;
            case Plus:           
            case Minus:          
            case Mul:            
            case Div:            
            case Mod: 
            type = types.get("int");          
            break;
            default:
            throw new Error("Operation: " + oper + "is not supported");

        }
        ssa.setType(type);

    } 
    public StaticType findType(SSAStatement ssa, String cless, String method) {

        Op oper = ssa.getOp();
        StaticType type = null;
        SSAStatement left, right;
        SSAMethod meth;
        String name;
        Type t;
        // check 
        left = ssa.getLeft();
        name = (String)ssa.getSpecial();
        SSAClass cl = prog.getClass(cless);
        SSAField fd = cl.getField(name);

        if(fd == null) {
         meth = cl.getMethod(prog, method);
         MethodDecl md = meth.getMethod();
         List<Parameter> params = md.getParameters();
         List<VarDecl> vds = md.getVarDecls();
         int index = -1;
         int index2 = -1;
         for(Parameter para : params) {
            if(para.getName().equals(name)) {
                index = params.indexOf(para);
                type = meth.getParamType(index);
                break;
            }
        }

        for(VarDecl vd : vds) {
            if(vd.getName().equals(name)) {
                index2 = 0;
                type = types.get(vd.getType().getName());
            }
        }

        if(index == -1 && index2 == -1) throw new Error(name + " is undefined!");
        else if(index > -1 && index2 > -1) throw new Error(name + " is defined twice!");
        
    } else { 
        type = fd.getType();
    }
     System.out.println("name is " + name + " class is " + cless + " method is " + method);
    return type;
}

public ObjectType defaultSuper() {
    return (ObjectType)types.get("Object");
}
}
