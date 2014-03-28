class Main {
    public static void main(String[] a){
        System.out.println(new Class().go());
    }
}

class Class {
    public int go() {
        boolean b;
        b = !3;
        return this.noMethod();
    }
}
