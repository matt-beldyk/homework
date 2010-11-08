package org.beldyk.video.harvester;

import static org.junit.Assert.*;

import org.junit.Test;

public class MediaHarvestorFactoryTest {
	@Test
	public void mkvTest(){
		assertEquals("mkv", MediaHarvesterFactory.getHarvesterInstance("foobar.mkv").getMediaType());
		assertEquals("mkv", MediaHarvesterFactory.getHarvesterInstance("foobar.MKV").getMediaType());

	}

}
