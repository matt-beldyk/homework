package org.beldyk.search;

import java.io.File;
import java.io.FileNotFoundException;
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
	private MeshTerms masterMeshTerms;


	public MeshTerms getMasterMeshTerms() {
		return masterMeshTerms;
	}

	public void setMasterMeshTerms(MeshTerms masterMeshTerms) {
		this.masterMeshTerms = masterMeshTerms;
	}

	public KNNFinder(Dials dials) throws FileNotFoundException{
		this.dials = dials;
		this.masterMeshTerms = new MeshTerms(new File(dials.getMeshTermsPath()));
	}

	public List<String> findKNN(Integer k, MedDoc doc) throws CorruptIndexException, IOException, ParseException{


		List<String> topMeshTerms = findTopMeshTerms(k, doc);
		List<String> meshTerms = new ArrayList<String>();
		for(Integer i = 0; i < k && i <topMeshTerms.size(); ++i){
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

		String qString = doc.get("T")+"\n" + doc.get("W") + "\n" + doc.get("A");
		qString = qString.replaceAll("[^\\w \n]", " ");
		qString = qString.replaceAll("null", " ");

		System.out.println("about to query upon '"+qString+"'");

		Query query = qp.parse(qString);

		ScoreDoc[] hits = is.search(query, dials.getHowManyDocs2Lookat()).scoreDocs;

		HashMap<String, Integer> meshTerms = new HashMap<String, Integer>();


		for (ScoreDoc hit: hits) {
			Document hitDoc = is.doc(hit.doc);
			String id = hitDoc.get("U");
			List<String> terms = masterMeshTerms.get(id);
			if(!(terms == null)){
				for(String t: terms){
					if(meshTerms.containsKey(t)){
						meshTerms.put(t, meshTerms.get(t) + 1);
					}else{
						meshTerms.put(t, 1);
					}
				}
			}else{
				System.out.println("oi, "+id+" found no terms!!!");
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
