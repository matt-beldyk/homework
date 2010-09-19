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
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.store.LockObtainFailedException;
import org.apache.lucene.util.Version;

public class Indexer {

	/**
	 * @param args
	 * @throws IOException 
	 * @throws LockObtainFailedException 
	 * @throws CorruptIndexException 
	 */
	public static void main(String[] args) throws CorruptIndexException, LockObtainFailedException, IOException {
		// TODO Auto-generated method stub

		File indexDir = new File("/tmp/lu_index/");
		String documents = "/home/beldyk/Desktop/medical.txt";
		//String documents = "/home/beldyk/Desktop/short_med.txt";
		index(indexDir, documents);
		System.out.println("Huzza, I'm done!");

	}

	public static void index(File indexDir, String documents) throws CorruptIndexException, LockObtainFailedException, IOException{
		DocuReader rdr = new DocuReader();
		IndexWriter wr = new IndexWriter(FSDirectory.open(indexDir),  
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
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		wr.close();
	
	}

}
