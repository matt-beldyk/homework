package org.beldyk.search;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

public class KNNasgnment {
	public static void main(String[] args) throws Exception{
		Dials dials = new Dials();
		Indexer indexer = new Indexer(dials);
		indexer.indexEm();

		KNNFinder knnF = new KNNFinder(dials);
		MeshTerms masterMeshTerms = knnF.getMasterMeshTerms();

		DocuReader dReader = new DocuReader();
		Collection<MedDoc> allDocs = dReader.read(dials.getDocPath());
		dReader = new DocuReader();
		Collection<MedDoc> docs2Search = dReader.read(dials.getDocs2Query());

		
		Map<String, MedDoc> mappedDocs = new HashMap<String, MedDoc>();
		for(MedDoc doc: allDocs){
			mappedDocs.put(doc.get("U"), doc);
		}
		
		Collection<String> ids2Classify = findIDs2Classify(dials.getTestSetPath());
		
		
		FileOutputStream outFile = new FileOutputStream(dials.getResultsPath());

		Collection<Double> fmeasures = new ArrayList<Double>();
		Collection<Double> precisions = new ArrayList<Double>();
		Collection<Double> recalls = new ArrayList<Double>();
		for(String docID: ids2Classify){
			
			System.out.println("About to find kNN for "+ docID);
			List<String> results = knnF.findKNN(dials.getTermCount2Search(), mappedDocs.get(docID));
			for(String res: results){
				outFile.write((docID+" "+res+"\n").getBytes());
			}
			System.out.println("Optimally: " + masterMeshTerms.get(docID));
			System.out.println("Found: " + results);
			precisions.add(StatsUtil.precision(masterMeshTerms.get(docID), results));
			recalls.add(StatsUtil.recall(masterMeshTerms.get(docID), results));
			System.out.println("F1-Measure: "+StatsUtil.f1Measure(masterMeshTerms.get(docID), results));
			Double f = StatsUtil.f1Measure(masterMeshTerms.get(docID), results);
				fmeasures.add(f);
		}
		//System.out.println("F1-Measures: "+ fmeasures);
		System.out.println("Classified Documents: " + fmeasures.size());
		System.out.println("Average F1-Measure: "+ StatsUtil.average(fmeasures));
		System.out.println("Average Precision: "+ StatsUtil.average(precisions));
		System.out.println("Average Recall: "+ StatsUtil.average(recalls));
		

		outFile.close();
	}
	
	static public Collection<String> findIDs2Classify(String fPath) throws FileNotFoundException{
		Collection<String> ids = new ArrayList<String>();
		Scanner scanner = new Scanner(new File(fPath),"UTF-8");

		while(scanner.hasNextLine()){
			String line = scanner.nextLine();
			if (line.matches("\\d+")){
				ids.add(line);
			}
		}
		return ids;
	}

}
