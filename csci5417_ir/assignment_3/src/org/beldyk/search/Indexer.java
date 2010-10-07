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
	private Dials dial;
	final static String indexDir = "/tmp/lu_index/";
	public Indexer(Dials dial){
		this.dial = dial;
	}

	/**
	 * @param args
	 * @throws Exception 
	 */
	/*
	public static void main(String[] args) throws Exception {
		Indexer i = new Indexer(new Dials());
		i.indexEm();


	}
	*/

	public void indexEm() throws Exception, LockObtainFailedException, IOException{
		index(dial.getDocPath());
		System.out.println("Huzza, I'm done!");
	}

	public  void index(String documents) throws CorruptIndexException, LockObtainFailedException, IOException{
		DocuReader rdr = new DocuReader();
		//	IndexWriter wr = new IndexWriter(FSDirectory.open(indexDir),  
		IndexWriter wr = new IndexWriter(this.dial.getIndexDir(),  
				this.dial.getAnalyz(), 
				true, new IndexWriter.MaxFieldLength(25000));

		//			indexDir, new StandardAnalyzer(), true);

		try {
			Collection<MedDoc> docs = rdr.read(documents);
			for(MedDoc d: docs){
				Document doc = new Document();
				for(String a:d.keySet()){

					Field f = new Field(a, d.get(a), Field.Store.YES, Field.Index.ANALYZED);
					if(a.equalsIgnoreCase("mesh")){
						f.setBoost((float)71.0);
					}
					doc.add(f);

				}
				wr.addDocument(doc);
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		wr.close();

	}

}
