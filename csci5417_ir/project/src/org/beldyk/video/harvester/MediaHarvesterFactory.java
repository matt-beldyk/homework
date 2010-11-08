package org.beldyk.video.harvester;

public class MediaHarvesterFactory {
	public static AbstractMediaHarvester getHarvesterInstance(String path){
		
		if(path.endsWith("avi")){
			return new AviHarvester(path);
		}
		return null;
		
	}

}
