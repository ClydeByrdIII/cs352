class MultiOps{
    public static void main(String[] a){
	System.out.println(new OP().Start(20));
    }
}

class OP{
    int[] number ;
    int size ;

    // Invoke methods to initialize, print and search
    // for elements on the array
    public int Start(int sz){
    int aux01 ;
	int aux02 ;
    boolean test;
    boolean test2;
    aux01 = sz + 5 * 6 / 4 % 4;
    test = (true && false || true);
    test2 = (false || true || true);
    aux02 = aux01 - 5 * 100 + (1);
	return aux02 ;
    }

}
