package org.beldyk.video.harvester;

import static org.junit.Assert.*;

import org.junit.Test;

public class FileNameParserTest {

	@Test
	public void BasicTest(){
		String fname = "DoctorWho 01";
		FileNameParser ps = new FileNameParser(fname);
		assertEquals("DoctorWho", ps.getSeriesName());
	}
}
