package org.beldyk.search;

import java.util.ArrayList;
import java.util.Collection;

public class StatsUtil {
	public static Double rPrecision(Collection<String> knownRelevant, Collection<String> returnedRelevant){
		
		return 0.0;
	}
	public static Double precision(Collection<String> knownRelevant, Collection<String> returnedRelevant){
		int retItems = returnedRelevant.size();
		int actualRelevantCount = intersection(knownRelevant, returnedRelevant).size();
		return (double)actualRelevantCount/(double)retItems;
	}
	
	public static Double recall(Collection<String> knownRelevant, Collection<String> returnedRelevant){
		return (double)(intersection(knownRelevant, returnedRelevant).size())/(double)knownRelevant.size();
	}
	
	public static Collection<String> intersection(Collection<String> a, Collection<String> b){
		Collection<String> inter = new ArrayList<String>();
		for(String f: b){
			if(a.contains(f)){
				inter.add(f);
			}
		}
		return inter;
	}

}
