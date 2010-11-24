package org.beldyk.video.harvester;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class FileNameParser {
	private String fileName;
	
	public FileNameParser(String fName){
		this.fileName = fName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFileName() {
		return fileName;
	}
	

	public String getSeriesName(){
		Pattern patt = Pattern.compile("([\\w_]+) \\d+");
		Matcher matt = patt.matcher(this.fileName);
		matt.find();
		System.err.println(matt.group(1));
		return matt.group(1);
	}
}
