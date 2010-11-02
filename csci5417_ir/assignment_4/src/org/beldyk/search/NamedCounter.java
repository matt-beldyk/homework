package org.beldyk.search;

public class NamedCounter implements Comparable <NamedCounter>{

	private String name;
	private Integer count;
	public NamedCounter(String name, Integer count){
		this.name = name;
		this.count = count;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	@Override
	public int compareTo(NamedCounter o) {
		// TODO Auto-generated method stub
		return -1 * this.count.compareTo(o.count);
	}
	
	
}
