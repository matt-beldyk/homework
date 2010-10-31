package org.beldyk.search;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

import org.apache.lucene.document.Document;
import org.apache.lucene.index.CorruptIndexException;
import org.apache.lucene.queryParser.MultiFieldQueryParser;
import org.apache.lucene.queryParser.ParseException;
import org.apache.lucene.queryParser.QueryParser;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.util.Version;

public class KNNFinder {
	private Dials dials;
	public KNNFinder(Dials dials){
		this.dials = dials;
	}

	public List<String> findKNN(Integer k, MedDoc doc) throws CorruptIndexException, IOException, ParseException{


		List<String> topMeshTerms = findTopMeshTerms(k, doc);
		List<String> meshTerms = new ArrayList<String>();
		for(Integer i = 0; i < k ; ++i){
			meshTerms.add(topMeshTerms.get(i));
		}
		return meshTerms;
	}

	public List<String> findTopMeshTerms(Integer k, MedDoc doc) throws CorruptIndexException, IOException, ParseException{

		IndexSearcher is = new IndexSearcher(dials.getIndexDir());

		String [] fields = {"W", "M", "T"};

		QueryParser qp = new MultiFieldQueryParser(
				Version.LUCENE_CURRENT, 
				fields, 
				dials.getAnalyz()
		);

		Query query = qp.parse(doc.get("T"));

		ScoreDoc[] hits = is.search(query, k).scoreDocs;

		HashMap<String, Integer> meshTerms = new HashMap<String, Integer>();

		
		for (ScoreDoc hit: hits) {
			Document hitDoc = is.doc(hit.doc);
			String id = hitDoc.get("U");
			List<String> terms = masterMeshTerms.get(id);
			for(String t: terms){
				if(meshTerms.containsKey(t)){
					meshTerms.put(t, meshTerms.get(t) + 1);
				}else{
					meshTerms.put(t, 1);
				}
			}
		}
		Set <String> meshKeys = meshTerms.keySet();
		List <NamedCounter> allTerms = new ArrayList<NamedCounter>();
		for(String i: meshKeys){
			allTerms.add(new NamedCounter(i, meshTerms.get(i)));
		}
		
		Collections.sort(allTerms);
		List <String> topKTerms = new ArrayList<String>();
		for(Integer i = 0; i < k && i<allTerms.size(); ++i){
			topKTerms.add(allTerms.get(i).getName());
		}
		return topKTerms;
	}
}
