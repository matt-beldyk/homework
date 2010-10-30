package org.beldyk.search;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Scanner;

public class QRels {
	/*
	OHSU60	87124892	1
	OHSU60	87234845	1
	OHSU60	87237893	1
	OHSU60	87114243	1
	OHSU61	87316326	2
	OHSU61	87181409	2
	OHSU61	87097517	1
	OHSU61	87316320	2
	OHSU61	87114244	2
	OHSU61	87322900	1
	OHSU62	87124616	1
	OHSU62	87152597	2
	OHSU62	87258095	2
	OHSU62	87209897	2
	OHSU63	87153292	2
	 */
	private HashMap<String,Collection<String>> qRels;
	public QRels (String f) throws FileNotFoundException{
		qRels = new HashMap<String, Collection<String>>();
		this.readFile(f);
	}

	private void readFile(String f) throws FileNotFoundException{
		Scanner scanner = new Scanner(new File(f),"UTF-8");
		while (scanner.hasNextLine()){
			String line = scanner.nextLine();
			String [] bits = line.split("\\s+");
			String queryID = bits[0];
			String docID = bits[1];
			if(! qRels.containsKey(queryID)){
				qRels.put(queryID, new ArrayList<String>());
			}
			qRels.get(queryID).add(docID);
		}
		scanner.close();
	}
	
	public Collection<String> getResults(String query){
		return qRels.get(query);
	}
}
