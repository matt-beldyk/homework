package org.beldyk.search;

import java.io.Reader;
import java.util.Set;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.LowerCaseTokenizer;
import org.apache.lucene.analysis.PorterStemFilter;
import org.apache.lucene.analysis.StopAnalyzer;
import org.apache.lucene.analysis.StopFilter;
import org.apache.lucene.analysis.TokenStream;

public class MattsAnalyzer extends Analyzer {

	private Set stopWords;
	
	
	public MattsAnalyzer(){
		this(StopAnalyzer.ENGLISH_STOP_WORDS_SET);
	}
	public MattsAnalyzer(Set stopWords){
		this.stopWords = stopWords;
	}
	
	
	@Override
	public TokenStream tokenStream(String fieldName, Reader reader) {
		StopFilter stopFilter = new StopFilter(true,
												new LowerCaseTokenizer(reader),
												stopWords);
		stopFilter.setEnablePositionIncrements(true);
		return new PorterStemFilter(stopFilter);

	}

}
