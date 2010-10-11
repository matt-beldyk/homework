package org.beldyk.search;

import java.util.HashMap;

public class Synonymify {

	 private HashMap<String, String> synonyms;
	 
	 public Synonymify(){
		synonyms = new HashMap<String, String>();
		//OSHU63
		synonyms.put("hiv", "aids immune Immunodeficiency  ");
		synonyms.put("gi", "Gastroenterol Gastrointestinal");
		
		//OSHU58
		synonyms.put("scheurmann's", "Scheuermann's Scheuermann");
		
		//OSHU42
		synonyms.put("thyrotoxicosis", "toxicosis Thyroxine");
		synonyms.put("thyrotoxicosis,", "toxicosis Thyroxine");

		//synonyms.put("hiv", "AIDS Syndrome/*PA;");
		
	 }
	 
	 public String expandQuery(String oQuery){
		 String nQuery = oQuery;
		 for(String q: oQuery.split(" ")){
			 if(synonyms.containsKey(q.toLowerCase())){
				 nQuery = nQuery + " " + synonyms.get(q.toLowerCase());
			 }
		 }
		 return nQuery;
	 }

}
