package org.beldyk.search;

public class MedQuery {
	private String title;
	private String query;
	private String numb;
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getQuery() {
		return query;
	}
	public String getQueryText() {
		return query + " " +title;
	}
	public void setQuery(String query) {
		this.query = query;
	}
	public String getNumb() {
		return numb;
	}
	public void setNumb(String numb) {
		this.numb = numb;
	}
	public String toString(){
		return numb+"\n"+title+"\n"+query;
	}

}
