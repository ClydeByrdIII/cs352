class Factorial{
    public static void main(String[] a){
		System.out.println(new Fac().ComputeFac(10));
    }
}

class Fac {

    public int ComputeFac(int num){
	int x;
	int y;

	x = 10 % num;
	y = 5  % num;
	System.out.println(x);
	System.out.println(y);
	System.out.println(13 % num);
	System.out.println(100 % num);
	System.out.println(500213 % 57);
	return 0;
    }

}
