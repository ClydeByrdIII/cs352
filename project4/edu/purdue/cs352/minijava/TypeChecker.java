package edu.purdue.cs352.minijava;

import java.util.*;

import edu.purdue.cs352.minijava.ast.*;
import edu.purdue.cs352.minijava.ssa.*;
import edu.purdue.cs352.minijava.types.*;
import static edu.purdue.cs352.minijava.types.PrimitiveType.*;
import static edu.purdue.cs352.minijava.ssa.SSAStatement.*;

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
                addType(ssa, "Main");
            }
    }

    public void handleStats(List<SSAMethod> methods, String cless) {
        for(SSAMethod method : methods) {
           for(SSAStatement ssa : method.getBody()) {
                addType(ssa, cless);
            }
        }
    }

    public void addType(SSAStatement ssa, String cless) {
        Op oper = ssa.getOp();
        StaticType type = null;
        SSAStatement left, right;
        Type t;
        switch(oper) {
            case Int:
                type = types.get("int");
                break;
            case Print:
                type = types.get("void");
                break;
            case Unify:
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
                SSAMethod meth = thisClass.getMethod(prog, call.getMethod());
                System.out.println("class is " + obj.toString() + " Method is " + call.getMethod() + " Prim:" + meth.getRetType());
                type = meth.getRetType();
                break;
            case Return:
                type = types.get("void");
                break;
            case Member:
                break;
            case Index:
                type = types.get("int");
                break;
            case VarAssg:
                break;
            case MemberAssg:
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
                //throw new Error("Operation: " + oper + "is not supported");

        }
        ssa.setType(type);

    } 

    public ObjectType defaultSuper() {
        return (ObjectType)types.get("Object");
    }
}
