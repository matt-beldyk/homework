package problem8;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class B extends IDReportable {

	List<C> cees;
	public B(C[] cees) throws TooFewCs{
		super();
		if(cees.length < 3){
			throw new TooFewCs();
		}
		this.cees = new ArrayList<C>();
		for(C c: cees){
			this.cees.add(c);
		}
	}
	
	public void addC(C c){
		cees.add(c);
	}
	public void removeC(C c) throws TooFewCs{
		if(cees.size() == 3){
			throw new TooFewCs();
		}
		cees.remove(c);
	}

	@Override
	public Collection<IDReportable> getContents() {
		return new ArrayList<IDReportable>(cees);
	}
	
	
}
