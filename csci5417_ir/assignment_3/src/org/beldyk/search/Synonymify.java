package org.beldyk.search;

import java.util.HashMap;

public class Synonymify {

	 private HashMap<String, String> synonyms;
	 
	 public Synonymify(){
		synonyms = new HashMap<String, String>();
		
		//OSHU55
		// no idea why these aren't being found
		//synonyms.put("dysuria", "pregnancy pyelonephritis ciprofloxacin");
		
		//OSHU63
		synonyms.put("hiv", "Immunodeficiency  ");
		synonyms.put("w/hiv", "Immunodeficiency Kaposi's ileum");
		synonyms.put("gi", "gastroenterology Gastrointestinal oesophageal Cytomegalovirus bowel oesophagus gastroenterology \"gastrointestinal endoscopy\"");
		
		//OSHU58
		synonyms.put("scheurmann's", "Scheuermann's Scheuermann");
		
		//OSHU42
		synonyms.put("thyrotoxicosis", "toxicosis Thyroxine");
		synonyms.put("thyrotoxicosis,", "toxicosis Thyroxine Thyroid hypothyroidism hyperthyroidism Thyroidectomy");

		//synonyms.put("hiv", "AIDS Syndrome/*PA;");
		
	 }
	 
	 public String expandQuery(String oQuery){
		 String nQuery = oQuery;
		 for(String q: oQuery.split(" ")){
			 if(synonyms.containsKey(q.toLowerCase())){
				 nQuery = synonyms.get(q.toLowerCase()) + " " + nQuery;
			 }
		 }
		 return nQuery;
	 }

}
