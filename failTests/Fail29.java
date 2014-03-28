class Main {
    public static void main(String[] a){
        System.out.println(new Class().go());
    }
}

class Class {
    public int go() {
        B b;
        b = new A();
        return b.i;
    }
}

class A extends B {
    int i;
}

class B {
}
