class Simple {
	public static void main(String[] a) {
		System.out.println(new Sim().sum(20));
	}
}

class Sim {
		public int sum(int i) {
			

			while((i = i - 1) != 0) {
				System.out.println(i);
			}
			
			return 20;
		}
}