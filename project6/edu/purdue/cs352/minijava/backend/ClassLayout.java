package edu.purdue.cs352.minijava.backend;

import java.util.*;

import edu.purdue.cs352.minijava.ssa.*;

public class ClassLayout {

    public static List<SSAClass> getSuperClasses(SSAProgram prog, SSAClass cl) {
        List<SSAClass> supers = new ArrayList<SSAClass>();
        for(SSAClass sup = cl.superclass(prog); sup != null; sup = sup.superclass(prog)) 
            supers.add(sup);
        Collections.reverse(supers);
        return supers;
    }

    public static SSAClass getOwner(SSAProgram prog, SSAClass cl, String field) {
        for(SSAClass sup = cl; sup != null; sup = sup.superclass(prog)) 
            if(sup.getField(field) != null) 
                return sup;
        return null;
    }

    // get the number of fields in an instance of this object
    public static int objectFields(SSAProgram prog, SSAClass cl) {
        // FILLIN
        int fields = 0;
        List<SSAClass> supers = getSuperClasses(prog, cl);
        fields += cl.getFieldsOrdered().size();
        for(SSAClass sc : supers) {
            fields+= sc.getFieldsOrdered().size();
        }
        //System.out.printf("SSAClass:%s Number of Fields:%d%n", cl.getASTNode().getName(), fields);
        return fields;
    }

    // get the size of an object (its number of fields plus one for the vtable)
    public static int objectSize(SSAProgram prog, SSAClass cl) {
        // FILLIN
        //System.out.printf("SSAClass:%s Size:%d%n", cl.getASTNode().getName(), objectFields(prog, cl) + 1);
        return objectFields(prog, cl) + 1;
    }

    // get the offset of a field within an object
    public static int fieldOffset(SSAProgram prog, SSAClass cl, String field) {
        // FILLIN
        int fieldOffset = 0;
        List<SSAClass> supers = getSuperClasses(prog, cl);
        SSAClass owner = getOwner(prog, cl, field);
        Collections.reverse(supers);
  
            for(SSAClass sc : supers) {
                if(sc == owner) {
                    fieldOffset += (sc.getField(field).getIndex() + 1);
                    break;
                }
                fieldOffset += sc.getFieldsOrdered().size();
            }
            if(cl == owner)
                fieldOffset += (cl.getField(field).getIndex() + 1);


        //System.out.printf("SSAClass:%s Field:%s offset:%d owner: %s%n", cl.getASTNode().getName(), field, fieldOffset, owner.getASTNode().getName());
        return fieldOffset;
    }

    static Map<SSAClass, Vtable> vtables = new HashMap<SSAClass, Vtable>(); 
    // a vtable
    public static class Vtable {
        public final List<String> methods;
        public final Map<String, Integer> methodOffsets;

        public Vtable(List<String> methods) {
            this.methods = methods;

            methodOffsets = new HashMap<String, Integer>();
            int off = 0;
            for (String m : methods)
                methodOffsets.put(m, off++);
        }
    }

    // get the complete vtable layout for this class
    public static Vtable getVtable(SSAProgram prog, SSAClass cl) {
        // FILLIN
        if(vtables.containsKey(cl)) 
            return vtables.get(cl);

        List<SSAClass> supers = getSuperClasses(prog, cl);
        List<String> methods = new ArrayList<String>();
        for(SSAClass sup : supers) {
            for(SSAMethod method : sup.getMethodsOrdered()) {
                methods.add(method.getMethod().getName());
            }
        }

        for(SSAMethod method : cl.getMethodsOrdered()) {
            methods.add(method.getMethod().getName());
        }

        Vtable table = new Vtable(methods);
        vtables.put(cl, table);
        return table;
    }

    // get the size of the vtable for a class
    public static int vtableSize(SSAProgram prog, SSAClass cl) {
        // FILLIN
        return getVtable(prog,cl).methods.size();
    }

    // for a given method, get the implementing class
    public static SSAClass getImplementor(SSAProgram prog, SSAClass cl, String method) {
        // FILLIN
        return cl.getMethodProvider(prog, method);
    }
}
