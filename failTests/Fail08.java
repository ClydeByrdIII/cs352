class Main {
    public static void main(String[] a){
        System.out.println(new Class().go());
    }
}

class Class {
    public int go() {
        return this.go2(1);
    }

    public int go2() {
        return 1;
    }
}
