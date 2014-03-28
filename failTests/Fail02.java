class Main {
    public static void main(String[] a){
        System.out.println(new Class().go());
    }
}

class Class extends Class2 {
    public int go() {
        return 1;
    }
}

class Class2 extends Class {
}
