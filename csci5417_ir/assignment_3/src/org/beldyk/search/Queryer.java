package org.beldyk.search;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;

import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.index.CorruptIndexException;
import org.apache.lucene.queryParser.MultiFieldQueryParser;
import org.apache.lucene.queryParser.ParseException;
import org.apache.lucene.queryParser.QueryParser;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.Version;

public class Queryer {

	private Dials dials;
	
	public Queryer(Dials dials){
		this.dials = dials;
	}
	/**
	 * @param args
	 * @throws Exception 
	 */
	/*
	public static void main(String[] args) throws Exception {
		Queryer q = new Queryer(new Dials());
		q.runQueries();
	}
*/
	public  void runQueries() throws Exception{


		FileOutputStream outFile = new FileOutputStream(dials.getResultsPath());


		QRels qRels = new QRels(dials.getqRelPath());

		QueryReader rdr = new QueryReader(dials.getqPath());
		Collection<MedQuery> querys = rdr.readQueries();
		Collection<Double> rPrecisions = new ArrayList<Double>();
		
		for(MedQuery q: querys){
			//System.out.println(q.toString());
			Collection<String> goldStandard = qRels.getResults(q.getNumb());
			Collection<Document> hits = search(q.getQueryText(), dials.getIndexDir(),goldStandard.size());
			Collection <String> results = new ArrayList<String>();
			for (Document doc: hits){
				results.add(doc.get("U"));
			}
			for(String a: results){
				outFile.write((q.getNumb()+" "+ a+"\n").getBytes());
			}
			Double prec = StatsUtil.rPrecision(goldStandard.size(), qRels.getResults(q.getNumb()), results);
			rPrecisions.add(prec);
			
			//System.out.println(results.toString());
			System.out.println("There are "+hits.size()+" results for: "+q.getNumb()+":"+q.getQueryText());
			System.out.println("Out of a possible "+goldStandard.size()+" Precision: "+prec);
		}
		outFile.close();
		System.out.println("Average R-Precision: "+StatsUtil.average(rPrecisions));
	}
	public Collection<Document> search(String qry, Directory dir, Integer howMany) throws CorruptIndexException, IOException, ParseException{
		IndexSearcher is = new IndexSearcher(dir);
		String [] fields = {"W", "M", "T"};
		QueryParser qp = new MultiFieldQueryParser(
				Version.LUCENE_CURRENT, 
				fields, 
				dials.getAnalyz()
				);
		
		System.out.println("Searching: "+qry);
		Query query = qp.parse(qry);

		ScoreDoc[] hits = is.search(query, howMany).scoreDocs;
		Collection<Document> docs = new ArrayList<Document>();
		for (ScoreDoc hit: hits) {
			Document hitDoc = is.doc(hit.doc);
			docs.add(hitDoc);
		//	System.out.println(hitDoc.toString());
		}
		return docs;
	}

}
