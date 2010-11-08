package org.beldyk.video.harvester;

public abstract class VideoHarvester extends AbstractMediaHarvester {

	public VideoHarvester(String path) {
		super(path);
	}

	public String findSeriesName(){
		return null;
	}
	
	public String findEpisodeName(){
		return null;
	}
	
	
	public Integer findSeasonNumber(){
		return null;
	}
	
	public Integer findEpisodeNumber(){
		return null;
	}

}
