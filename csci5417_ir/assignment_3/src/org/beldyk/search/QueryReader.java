package org.beldyk.search;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Scanner;

public class QueryReader {
	private String path;
	public QueryReader(String pth){
		this.path = pth;
	}
	
	public Collection<MedQuery> readQueries() throws Exception{
		Collection<MedQuery> queries = new ArrayList<MedQuery>();
		Scanner scanner = new Scanner(new File(this.path),"UTF-8");
/*		
		<top>
		<num> Number: OHSU62
		<title> 68 yo woman with anemia of chronic illness
		<desc> Description:
		review of anemia of chronic illness
		</top>

*/
		MedQuery tmp = new MedQuery();
		while(scanner.hasNext()){
			String line = scanner.nextLine();
			if(line.startsWith("<top>")){
				tmp = new MedQuery();
			}else if(line.startsWith("<num>")){
				tmp.setNumb(line.split(" ")[2]);
			}else if(line.startsWith("<title>")){
				tmp.setTitle(line.substring(8));
			}else if(line.startsWith("<desc>")){
				tmp.setQuery(scanner.nextLine());
			}else if(line.startsWith("</top>")){
				queries.add(tmp);
			}else if(line.equalsIgnoreCase("")){
			}else{
				throw new Exception("No idea what to do with line '"+line+"'");
			}
			
		}
		return queries;
	}

}
