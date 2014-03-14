class Simple {
	public static void main(String[] a) {
		System.out.println(new S().simple(3));
	}
}

class S {
	public int simple(int num){
    	while ((num=num-1)>0){
        	num=1;
    	}
    	return num;
	}
}