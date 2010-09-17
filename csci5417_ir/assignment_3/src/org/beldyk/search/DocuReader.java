package org.beldyk.search;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Scanner;

public class DocuReader {
	public Collection<MedDoc> read (String fName) throws FileNotFoundException{
		Collection<MedDoc> docs = new ArrayList<MedDoc>();
		Scanner scanner = new Scanner(new File(fName),"UTF-8");
		try {
			String state = null;
			MedDoc curDoc = null;
			while (scanner.hasNextLine()){
				String line = scanner.nextLine();
				if(line.startsWith(".")){
					state = line.substring(1, 2);
					//System.out.println(state);
					if(state.equalsIgnoreCase("I")){
						if(curDoc != null){docs.add(curDoc);}
						curDoc = new MedDoc();

					}
				} else {
					if(curDoc.containsKey(state)){
						curDoc.put(state, curDoc.get(state)+line);
					} else {
						curDoc.put(state, line);
					}
				}
			}
		}
		finally{
			scanner.close();
		}

		return docs;
	}

}
