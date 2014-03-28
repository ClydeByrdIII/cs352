class Main {
    public static void main(String[] a){
        System.out.println(new Class().go());
    }
}

class Class {
    int ii;

    public int go() {
        int i;
        i = new Class2().ii;
        i = new Class2().go();
        return 1;
    }
}

class Class2 extends Class {
}
