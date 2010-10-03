package org.beldyk.search;

import java.io.IOException;

import org.apache.lucene.store.Directory;
import org.apache.lucene.store.LockObtainFailedException;
import org.apache.lucene.store.RAMDirectory;

public class IndexNQuery {

	/**
	 * @param args
	 * @throws Exception 
	 * @throws IOException 
	 * @throws LockObtainFailedException 
	 */
	public static void main(String[] args) throws LockObtainFailedException, IOException, Exception {
		// TODO Auto-generated method stub
		Directory dir = new RAMDirectory();
		Indexer dex = new Indexer(dir);
		Queryer qyr = new Queryer(dir);
		
		dex.indexEm();
		qyr.runQueries();

	}

}
