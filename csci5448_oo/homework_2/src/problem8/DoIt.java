package problem8;

public class DoIt {

	/**
	 * @param args
	 * @throws TooFewCs 
	 * @throws TooManyBs 
	 * @throws TooFewBs 
	 */
	public static void main(String[] args) throws TooFewCs, TooFewBs, TooManyBs {

		B b1 = createB();
		System.out.println("Created a B");
		System.out.println(b1.getReport());
		
		B b2 = createB();
		
		B[] bees = {b1, b2};
		A a1 = new A(bees);
		System.out.println("Created an A");
		System.out.println(a1.getReport());
		
		System.out.println("About to add a B to the A");
		a1.addB(createB());
		System.out.println(a1.getReport());

		System.out.println("About to add a B to the A");
		a1.addB(createB());
		System.out.println(a1.getReport());

		System.out.println("About to add a B to the A");
		a1.addB(createB());
		System.out.println(a1.getReport());

	}
	
	public static B createB() throws TooFewCs{
		// I can't create a B with fewer than 3 C's

		C[] cees1 = {new C(), new C(), new C()};
		return new B(cees1);
	}

}
