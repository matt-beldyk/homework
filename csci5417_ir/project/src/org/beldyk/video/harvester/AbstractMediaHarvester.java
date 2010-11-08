package org.beldyk.video.harvester;

public abstract class AbstractMediaHarvester {
	private String path;
	
	public abstract String getMediaType();
	public  AbstractMediaHarvester(String path){
		this.path = path;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path){
		this.path = path;
	}
}
