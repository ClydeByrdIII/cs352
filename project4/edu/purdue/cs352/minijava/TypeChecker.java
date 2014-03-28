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


        // Deal with duplicate classes
        Map<String, String> dupList = new HashMap<String,String>();
        for(SSAClass cls : classes) {
            ClassDecl cd = (ClassDecl)cls.getASTNode();
            String name = cd.getName();
            if(dupList.containsKey(name)) 
                throw new Error("Duplicate class:" + name);
            dupList.put(name, name);
        }
        
        // Add classes to Type first to avoid null class types
        for(SSAClass cless: classes) {
            addClass(cless);
        }

        // handle the stats
        for(SSAClass cless: classes) {
            handleClass(cless);
        }

        for(SSAClass cless: classes) {
            ClassDecl cd = (ClassDecl)cless.getASTNode();
            String name = cd.getName();
            handleStats(cless.getMethodsOrdered(), name);
        }
        // Deal with Main
        handleStats(prog.getMain());
    
    }

    public void handleClass(SSAClass cless) {
        ClassDecl cd = (ClassDecl)cless.getASTNode();
        String name = cd.getName();

        Map<String, String> dupList = new HashMap<String,String>();
        for(SSAField field : cless.getFieldsOrdered()) {
            VarDecl vd = field.getField();
            if(dupList.containsKey(vd.getName())){
                throw new Error("Duplicate Member:" + vd.getName());
            }
            handleField(field);
            dupList.put(vd.getName(), vd.getName());
        }

        dupList.clear();
        for(SSAMethod method : cless.getMethodsOrdered()) {
            MethodDecl md = method.getMethod();
            if(dupList.containsKey(md.getName())){
                throw new Error("Duplicate Method:" + md.getName());
            }
            handleMethod(method, name);

            dupList.put(md.getName(), md.getName());
        }
    }

    public void addClass(SSAClass cless) {
        ClassDecl cd = (ClassDecl)cless.getASTNode();
        String name = cd.getName();
        String eggstends = cd.getExtends();
        SSAClass supper;

        if(types.containsKey(name)) {
            return;
        }

        if(eggstends != null) { 
            // fix this to handle if the class wasn't add yet 
            supper = prog.getClass(eggstends);
            if(supper == null) 
                throw new Error("Super Class " + eggstends + " does not exist!");
            // make sure it has been added first

            addClass(supper);

            String supName = ((ClassDecl)supper.getASTNode()).getName();
            ObjectType supType = (ObjectType)types.get(supName);
            types.put(name, new ObjectType(name, supType));

        } else {
            types.put(name, new ObjectType(name, defaultSuper())); 
        }

    }

    public void handleField(SSAField field) {
        VarDecl vd = field.getField();
        Type type = vd.getType();
        field.setType(types.get(type.getName()));
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
                ptypes.add(types.get(type.getName()));
            }
            method.setParamTypes(ptypes);

            type = meth.getType();
            method.setRetType(types.get(type.getName()));

        }

    }

    public void handleStats(SSAMethod method) {
        Map<String, String> dupList = new HashMap<String,String>();
        for(SSAStatement ssa : method.getBody()) {
            String name;
            if(ssa.getOp() == Op.Null) {
                 name = ((VarDecl)ssa.getASTNode()).getName();
                if(dupList.containsKey(name)) {
                    throw new Error("Class: Main Duplicate Variable name :" + name);
                }
                dupList.put(name, name);
            } else if(ssa.getOp() == Op.Parameter) {
                Parameter param = (Parameter)ssa.getASTNode();
                name = param.getName();
                if(dupList.containsKey(name)) {
                    throw new Error("Class: Main Duplicate Parameter name:" + name);
                }
                dupList.put(name, name);
            }
            
            if(ssa.getOp() == Op.This) throw new Error("No This allowed in Main in MiniJava");
            addType(ssa, "Main", "Main");
        }
    }

    public void handleStats(List<SSAMethod> methods, String cless) {
        for(SSAMethod method : methods) {
             Map<String, String> dupList = new HashMap<String,String>();
            for(SSAStatement ssa : method.getBody()) {
                String name;
            if(ssa.getOp() == Op.Null) {

                name = ((VarDecl)ssa.getASTNode()).getName();
                if(dupList.containsKey(name)) {
                    throw new Error("Class:" + cless + " Duplicate Variable name :" + name);
                }
                dupList.put(name, name);
            } else if(ssa.getOp() == Op.Parameter) {
                Parameter param = (Parameter)ssa.getASTNode();
                name = param.getName();
                if(dupList.containsKey(name)) {
                    throw new Error("Class:" + cless + " Duplicate Parameter name:" + name);
                }
                dupList.put(name, name);
            }
                
                addType(ssa, cless, method.getMethod().getName());
            }
        }
    }

    public void addType(SSAStatement ssa, String cless, String method) {
        SSAClass thisClass;
        SSAMethod meth;
        SSAField fd;
        SSAStatement left, right;
        Op oper = ssa.getOp();
        String name;
        Type t;
        StaticType type = null;
        StaticType req;
        StaticType found;

        switch(oper) {
            case Int:
                type = types.get("int");
                break;
            case Print:
                left = ssa.getLeft();
                req = types.get("int");
                found = left.getType();
                checkTypes(req, found, "Print Argument was not an Int");
                type = types.get("void");
                break;
            case Unify:
                left = ssa.getLeft();
                right = ssa.getRight();
                StaticType t1 = left.getType();
                StaticType t2 = right.getType();

                // add instanceofs for ObjectTypes
                if(t1 instanceof ObjectType && t2 instanceof ObjectType) {
                    ObjectType obj = (ObjectType)t1;
                    ObjectType obj2 = (ObjectType)t2;
                    type = obj.commonSupertype(obj2);
                } else {
                    type = t1.commonSupertype(t2); 
                }

                if (type == null) {
                    throw new Error("Type error in Unify");
                }
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
                name = t.getName();
                type = types.get(name);
                break;
            case NewObj:
                name = (String)ssa.getSpecial();
                type = types.get(name);
                break;
            case NewIntArray:
                left = ssa.getLeft();
                req = types.get("int");
                found = left.getType();
                checkTypes(req, found, "size was not an int");
                type = types.get("int[]");
                break;
            case Label:
            case Goto:
                type = types.get("void");
                break;
            case Branch:
            case NBranch:
                left = ssa.getLeft();
                req = types.get("boolean");
                found = left.getType();
                checkTypes(req, found, "If or While condition was not a boolean");
                type = types.get("void");
                break;
            case Call:
                
                SSACall call = (SSACall)ssa.getSpecial();
                left = ssa.getLeft();
                ObjectType obj = (ObjectType)left.getType();
                thisClass = prog.getClass(obj.toString());
    
                meth = thisClass.getMethod(prog, call.getMethod());
            
                List<SSAStatement> args = call.getArgs();
                for(SSAStatement arg : args) {
                    if(arg.getOp() != Op.Arg) throw new Error("An argument of " + call.getMethod() + " was not an Argument SSAStatement");
                    int index = (int)arg.getSpecial();
                    found = arg.getType();
                    req = meth.getParamType(index);
                    checkTypes(req, found, call.getMethod() + ":Argument type was wrong");
                } 

                type = meth.getRetType();
                break;
            case Return:
                left = ssa.getLeft();
                found = left.getType();
                thisClass = prog.getClass(cless);
                meth = thisClass.getMethod(prog, method);
                req = meth.getRetType();
                checkTypes(req, found, "Method " + method + "'s return's was wrong");
                type = types.get("void");
                break;
            case Member:
                left = ssa.getLeft();
                name = (String)ssa.getSpecial();

                if(name.equals("length")) {
                    req = types.get("int[]");
                    found = left.getType();
                    checkTypes(req, found, "Tried to access the length variable of a non-array variable");
                    type = types.get("int");
                } else {
                    ObjectType objType = (ObjectType) left.getType();
                    type = findType(ssa, objType.toString(), method);
                }

                break;
            case Index:
                // array
                left = ssa.getLeft();
                //index
                right = ssa.getRight();
                req = types.get("int[]");
                found = left.getType();
                checkTypes(req, found, "trying to access an index of a non array variable");
                req = types.get("int");
                found = right.getType();
                checkTypes(req, found, "index was not an int");
                type = req;
                break;
            case VarAssg:
                left = ssa.getLeft();
                req = findType(ssa, cless, method);
                found = left.getType();
                checkTypes(req, found, "Variable Assignement to the wrong type");
                type = req;
                break;
            case MemberAssg:
                right = ssa.getRight();

                req = findType(ssa, cless, method);
                found = right.getType();
                checkTypes(req, found, "Member Assignement to the wrong type");
                type = req;
                break;
            case IndexAssg:
                left = ssa.getLeft();
                right = ssa.getRight();
                SSAStatement index = (SSAStatement)ssa.getSpecial();
                // check array
                req = types.get("int[]");
                found = left.getType();
                checkTypes(req, found, "Index Assignement to a variable that's not an int array");
                // check value
                req = types.get("int");
                found = right.getType();
                checkTypes(req, found, "Index Assignement with a non-int value");
                // check index
                found = index.getType();
                checkTypes(req, found, "Index Assignement with a non-int index");
                type = types.get("int");
                break;
            case Not:
                left = ssa.getLeft();
                req = types.get("boolean");
                found = left.getType();
                checkTypes(req, found, "left value in Not Expression was not a boolean");
                type = types.get("boolean");
                break;
            case Eq:             
            case Ne:
                type = types.get("boolean");
                break;
            case Lt:
            case Le:         
            case Gt:
            case Ge:
                left = ssa.getLeft();
                right = ssa.getRight();
                req = types.get("int");
                found = left.getType();
                checkTypes(req, found, "left value in Comparison was not an int");
                found = right.getType();
                checkTypes(req, found, "right value in Comparison was not an int");
                type = types.get("boolean");
                break;
            case And:
            case Or:
                left = ssa.getLeft();
                right = ssa.getRight();
                req = types.get("boolean");
                found = left.getType();
                checkTypes(req, found, "left value in Conditional Expression was not a boolean");
                found = right.getType();
                checkTypes(req, found, "left value in Conditional Expression was not a boolean");
                type = req;
                break;
            case Plus:           
            case Minus:          
            case Mul:            
            case Div:            
            case Mod:
                left = ssa.getLeft();
                right = ssa.getRight();
                req = types.get("int");
                found = left.getType();
                checkTypes(req, found, "left value in Arithmetic Expression was not an int");
                found = right.getType();
                checkTypes(req, found, "Right value in Arithmetic Expression was not an int");
                type = req;
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
        SSAField fd = cl.getField(prog, name);

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

        } else { 
            type = fd.getType();
        }

        return type;
    }

    public ObjectType defaultSuper() {
        return (ObjectType)types.get("Object");
    }

    // checks if type is a subtype of paramType
    public void checkTypes(StaticType paramType, StaticType type, String errorMsg) {
        if(paramType instanceof ObjectType && type instanceof ObjectType) {
            ObjectType obj = (ObjectType)paramType;
            ObjectType obj2 = (ObjectType)type;
            if(obj2.subtypeOf(obj)) return;
        } else {
            if(paramType.commonSupertype(type) != null) return;
        }
        throw new Error(errorMsg);
    }
}
