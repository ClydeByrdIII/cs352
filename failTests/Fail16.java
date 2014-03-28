class Main {
    public static void main(String[] a){
        System.out.println(new Class().go());
    }
}

class Class {
    public int go() {
        boolean b;
        b = this.go2();
        return 1;
    }

    public int go2() {
        return 1;
    }
}
