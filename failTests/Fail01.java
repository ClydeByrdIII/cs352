class Main {
    public static void main(String[] a){
        System.out.println(new Class().go());
    }
}

class Class extends NoClass {
    public int go() {
        return 1;
    }
}
