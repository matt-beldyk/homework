package problem8;

import java.util.ArrayList;
import java.util.Collection;

public class C extends IDReportable {
	public C(){
		super();
	}

	@Override
	public Collection<IDReportable> getContents() {
		return new ArrayList<IDReportable>();
	}

}
