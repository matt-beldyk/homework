package problem8;

import java.util.ArrayList;
import java.util.Collection;

public class A extends IDReportable {
	
	private Collection<B> bees;

	public A(B[] bees) throws TooFewBs, TooManyBs{
		if(bees.length < 2){
			throw new TooFewBs();
		}
		if(bees.length > 4){
			throw new TooManyBs();
		}
		this.bees = new ArrayList<B>();
		for(B b:bees){
			this.bees.add(b);
		}
	}
	
	public void addB(B b) throws TooManyBs{
		if(bees.size() >=4){
			throw new TooManyBs();
		}
		bees.add(b);
	}
	
	public void removeB(B b) throws TooFewBs{
		if(bees.size() <=2){
			throw new TooFewBs();
		}
		bees.remove(b);
	}
	@Override
	public Collection<IDReportable> getContents() {
		return new ArrayList<IDReportable>(bees);
	}

}
