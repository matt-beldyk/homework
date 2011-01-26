package problem8;

import java.util.Collection;

public abstract class IDReportable {

	Integer id;
	protected IDReportable(){
		id = IDGiver.getNewId();
	}
	public String getReport(){
		StringBuilder tmp = new StringBuilder(this.getClass().getName()+"["+id+"]");
		Collection<IDReportable> conts = getContents();
		if(! conts.isEmpty()){
			tmp.append(" contains ");

			for(IDReportable c: getContents()){
				tmp.append(c.getReport() + ", ");
			}
		}

		return tmp.toString();
	}
	public abstract Collection<IDReportable> getContents();

	public Integer getId(){
		return id;
	}
}
