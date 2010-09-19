package org.beldyk.search;

import java.util.ArrayList;
import java.util.Collection;

public class StatsUtil {
	public static Double rPrecision(Integer count, Collection<String> knownRelevant, Collection<String> returnedRelevant){

		Collection<String> prunedRet = new ArrayList<String>();
		String[] rets = returnedRelevant.toArray(new String[1]);
		for (int i =0; i<count && i <returnedRelevant.size(); ++i){
			prunedRet.add(rets[i]);
		}
		return (double)intersection(knownRelevant, prunedRet).size()/(double)prunedRet.size();
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

	public static double average(Collection<Double> b){
		double tot = 0;
		for (double a:b){
			tot += a;
		}
		return tot/(double)b.size();
	}
}
