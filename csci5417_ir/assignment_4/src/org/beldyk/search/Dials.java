package org.beldyk.search;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.RAMDirectory;
import org.apache.lucene.util.Version;

public class Dials {

	private Analyzer analyz;
	private String lu_dir_name;
	private Directory indexDir;
	/*
	private String pth = "/Users/beldyk/homework_data/ir_asgn4/";
	private String qPath = pth +"queries.txt";
	private String qRelPath = pth + "qrels.txt";
	private String resultsPath = pth + "beldyk-assgn4-out.txt";
		private String docPath;

	*/
	
	private String pth;
	private String qPath;
	private String qRelPath;
	private String resultsPath;
	private String docPath;
	private String meshTermsPath;
	
	
	public String getQPath() {
		return qPath;
	}

	public void setQPath(String path) {
		qPath = path;
	}

	public String getQRelPath() {
		return qRelPath;
	}

	public void setQRelPath(String relPath) {
		qRelPath = relPath;
	}

	public String getDocPath() {
		return docPath;
	}

	public void setDocPath(String docPath) {
		this.docPath = docPath;
	}

	public Dials(){
		//pth = "/Users/beldyk/Desktop/";
		pth = "/home/beldyk/homework_data/ir_asgn4/";
		qPath = pth +"queries.txt";
		qRelPath = pth + "qrels.txt";
		resultsPath = pth + "beldyk-assgn4-out.txt";
		//docPath = pth + "medical.txt";
		docPath = pth + "short_med.txt";
		meshTermsPath = pth + "qrels.mesh.batch.87";
		indexDir = new RAMDirectory();
		analyz = new  StandardAnalyzer(Version.LUCENE_CURRENT);
	}
	
	
	public String getMeshTermsPath() {
		return meshTermsPath;
	}

	public void setMeshTermsPath(String meshTermsPath) {
		this.meshTermsPath = meshTermsPath;
	}

	public Analyzer getAnalyz() {
		return analyz;
	}
	public void setAnalyz(Analyzer analyz) {
		this.analyz = analyz;
	}
	public String getLu_dir_name() {
		return lu_dir_name;
	}
	public void setLu_dir_name(String luDirName) {
		lu_dir_name = luDirName;
	}
	public Directory getIndexDir() {
		return indexDir;
	}
	public void setIndexDir(Directory indexDir) {
		this.indexDir = indexDir;
	}
	public String getPth() {
		return pth;
	}
	public void setPth(String pth) {
		this.pth = pth;
	}
	public String getqPath() {
		return qPath;
	}
	public void setqPath(String qPath) {
		this.qPath = qPath;
	}
	public String getqRelPath() {
		return qRelPath;
	}
	public void setqRelPath(String qRelPath) {
		this.qRelPath = qRelPath;
	}
	public String getResultsPath() {
		return resultsPath;
	}
	public void setResultsPath(String resultsPath) {
		this.resultsPath = resultsPath;
	}
	
	
}
