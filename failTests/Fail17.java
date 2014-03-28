class Main {
    public static void main(String[] a){
        System.out.println(new Class().go());
    }
}

class Class {
    public int go() {
        this.go2(this.go3());
        return 1;
    }

    public int go2(int i) {
        return 1;
    }

    public boolean go3() {
        return false;
    }
}
