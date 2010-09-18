package org.beldyk.search;

import java.util.Collection;

public class Queryer {

	/**
	 * @param args
	 * @throws Exception 
	 */
	public static void main(String[] args) throws Exception {
		String qPath = "/Users/beldyk/Desktop/queries.txt";
		QueryReader rdr = new QueryReader(qPath);
		Collection<MedQuery> querys = rdr.readQueries();
		
		for(MedQuery q: querys){
			System.out.println(q.toString());
		}
	}

}
