package org.beldyk.search;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

public class MeshTerms {

	private Map<String, List<String>> meshTerms;
	
	public MeshTerms(){
		meshTerms = new HashMap<String, List<String>>();
	}
	
	public MeshTerms(File f) throws FileNotFoundException{
		this();
		this.readFile(f);
		
		
	}
	protected void readFile(File f) throws FileNotFoundException{
		Scanner scanner = new Scanner(f,"UTF-8");
		while(scanner.hasNext()){
			String line = scanner.nextLine();
			//System.out.println("Just read: '"+line+"'");
			String[] splitLine = line.split("\t");
			this.add(splitLine[1], splitLine[0]);
		}
		
	}
	
	
	public void add( String docID, String meshTerm){
		if(!meshTerms.containsKey(docID)){
			meshTerms.put(docID, new ArrayList<String>());
		}
		meshTerms.get(docID).add(meshTerm);
	}
	public List<String> get(String docID){
		return meshTerms.get(docID);
	}
	
	@Override
	public String toString(){
		String tmp = "";
		for(String i: this.meshTerms.keySet()){
			tmp += "\n"+i+": ";
			for(String j: this.meshTerms.get(i)){
				tmp += ", " + j;
			}
		}
		tmp += "\n";
		return tmp;
	}

	public List<String> getAllDocIDs() {
		
		List <String> tmp = new ArrayList<String>();
		tmp.addAll(this.meshTerms.keySet());
		return tmp;
	}
	
}
