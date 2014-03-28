class Main {
    public static void main(String[] a){
        System.out.println(new Class().go());
    }
}

class Class {
    public int go() {
        Class2 c;
        c = new Class();
        return 1;
    }
}

class Class2 extends Class {
}
