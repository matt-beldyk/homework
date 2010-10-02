package org.beldyk.search;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;

import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.index.CorruptIndexException;
import org.apache.lucene.queryParser.ParseException;
import org.apache.lucene.queryParser.QueryParser;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.Version;

public class Queryer {

	private Directory dir;
	private static final String indexDir = "/tmp/lu_index/";
	
	public Queryer(Directory dir){
		this.dir = dir;
	}
	/**
	 * @param args
	 * @throws Exception 
	 */
	public static void main(String[] args) throws Exception {
		Queryer q = new Queryer(FSDirectory.open(new File(indexDir)));
		q.runQueries();
	}

	public  void runQueries() throws Exception{
		String pth = "/Users/beldyk/Desktop/";
		String qPath = pth +"queries.txt";
		String qRelPath = pth + "qrels.txt";
		String resultsPath = pth + "beldyk-assgn3-out.txt";

		FileOutputStream outFile = new FileOutputStream(resultsPath);


		QRels qRels = new QRels(qRelPath);

		QueryReader rdr = new QueryReader(qPath);
		Collection<MedQuery> querys = rdr.readQueries();
		Collection<Double> rPrecisions = new ArrayList<Double>();
		
		for(MedQuery q: querys){
			//System.out.println(q.toString());
			Collection<Document> hits = search(q.getQuery(), this.dir);
			Collection<String> goldStandard = qRels.getResults(q.getNumb());
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
			System.out.println("There are "+hits.size()+" results for: "+q.getNumb()+":"+q.getQuery());
			System.out.println("Out of a possible "+goldStandard.size()+" Precision: "+prec);
		}
		outFile.close();
		System.out.println("Average R-Precision: "+StatsUtil.average(rPrecisions));
	}
	public Collection<Document> search(String qry, Directory dir) throws CorruptIndexException, IOException, ParseException{
		IndexSearcher is = new IndexSearcher(dir);
		QueryParser qp = new QueryParser(Version.LUCENE_CURRENT, "W", new StandardAnalyzer(Version.LUCENE_CURRENT));
		System.out.println("Searching: "+qry);
		Query query = qp.parse(qry);

		ScoreDoc[] hits = is.search(query, 100).scoreDocs;
		Collection<Document> docs = new ArrayList<Document>();
		for (ScoreDoc hit: hits) {
			Document hitDoc = is.doc(hit.doc);
			docs.add(hitDoc);
		//	System.out.println(hitDoc.toString());
		}
		return docs;
	}

}
