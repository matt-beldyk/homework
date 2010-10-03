package org.beldyk.search;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Collection;

import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.index.CorruptIndexException;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.store.LockObtainFailedException;
import org.apache.lucene.util.Version;

public class Indexer {
	Directory dir;
	final static String indexDir = "/tmp/lu_index/";
	public Indexer(Directory dir){
		this.dir = dir;
	}

	/**
	 * @param args
	 * @throws Exception 
	 */
	public static void main(String[] args) throws Exception {
		Indexer i = new Indexer(FSDirectory.open(new File(indexDir)));
		i.indexEm();
	

	}
	
	public void indexEm() throws Exception, LockObtainFailedException, IOException{
		String documents = "/Users/beldyk/Desktop/medical.txt";
		//String documents = "/home/beldyk/Desktop/short_med.txt";
		index(documents);
		System.out.println("Huzza, I'm done!");
	}

	public  void index(String documents) throws CorruptIndexException, LockObtainFailedException, IOException{
		DocuReader rdr = new DocuReader();
		//	IndexWriter wr = new IndexWriter(FSDirectory.open(indexDir),  
			IndexWriter wr = new IndexWriter(this.dir,  
				new StandardAnalyzer(Version.LUCENE_CURRENT), 
				true, new IndexWriter.MaxFieldLength(25000));

		//			indexDir, new StandardAnalyzer(), true);

		try {
			Collection<MedDoc> docs = rdr.read(documents);
			for(MedDoc d: docs){
				Document doc = new Document();
				for(String a:d.keySet()){
					if(a.equalsIgnoreCase("W")){
						//System.out.println(d.get(a));
					}
						doc.add(new Field(a, d.get(a), Field.Store.YES, Field.Index.ANALYZED));

				}
				wr.addDocument(doc);
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		wr.close();
	
	}

}
