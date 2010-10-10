package org.beldyk.search;

import java.io.Reader;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.LowerCaseTokenizer;
import org.apache.lucene.analysis.PorterStemFilter;
import org.apache.lucene.analysis.StopAnalyzer;
import org.apache.lucene.analysis.StopFilter;
import org.apache.lucene.analysis.TokenStream;

public class MattsAnalyzer extends Analyzer {

	private Set stopWords ;
	
	// The top 60 terms from the corpus of text:
	
	// Have some delicious perl code... mmmm mmm mmm
// cat medical.txt |perl -e 'while(<>){map{$f{$_} += 1;}(split(/[^\w]+/,$_));}; map{print "$_ $f{$_}\n";} (sort {$f{$b} <=> $f{$a}} keys %f);' |perl -ne '/(\w+)\s/;print "\"$1\", ";'
	
	private String [] myStopWords = {
			 "of", "the", "and", "in", "to", "S", "a", "with", "U", 
			 "P", "A", "T", "was", "M", "I", "were", "patients", 
			 "for", "The", "ARTICLE", "JOURNAL", "Human", "by", "that", 
			 "W", "1", "is", "or", "2", "J", "from", "on", "than", "0", "t", 
			 "Support", "Gov", "5", "3", "as", "be", "at", "an", "ME", "Male", 
			 "Female", "4", "6", "not", "are", "cells", "PA", "after", "In", 
			 "had", "H", "Non", "this", "Adult"
	};
	public MattsAnalyzer(){


		this(StopAnalyzer.ENGLISH_STOP_WORDS_SET);
	}
	public MattsAnalyzer(Set stopWords){
		this.stopWords = new HashSet();
		for (String word: (Set<String>) stopWords){
			this.stopWords.add(word);
		}
		for (String word: myStopWords){
			this.stopWords.add(word);
		}
		
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
