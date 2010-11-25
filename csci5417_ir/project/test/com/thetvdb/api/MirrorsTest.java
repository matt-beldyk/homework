package com.thetvdb.api;

import static org.junit.Assert.*;

import java.io.IOException;

import org.apache.http.client.ClientProtocolException;
import org.junit.Test;

public class MirrorsTest {

	@Test
	public void grabXMLTest() throws ClientProtocolException, IOException{
		Mirrors m = new Mirrors();
		String response = m.getMirrorXML();
		assertTrue(response.startsWith("<?xml version=\"1.0\" encoding=\"UTF-8\" ?>"));
	}
}
