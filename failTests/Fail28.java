class Main {
    public static void main(String[] a){
        System.out.println(new Class().go());
    }
}

class Class {
    public int go() {
        Bar b;
        b = new Foo();
        return b.ii;
    }
}

class Foo extends Bar {
    int ii;
}

class Bar {
}
