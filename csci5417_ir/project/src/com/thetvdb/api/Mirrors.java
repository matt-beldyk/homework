package com.thetvdb.api;
import java.io.IOException;

import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpHost;
import org.apache.http.HttpResponse;
import org.apache.http.HttpVersion;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.conn.ClientConnectionManager;
import org.apache.http.conn.scheme.PlainSocketFactory;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.scheme.SchemeRegistry;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.conn.tsccm.ThreadSafeClientConnManager;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpParams;
import org.apache.http.params.HttpProtocolParams;
import org.apache.http.util.EntityUtils;



public class Mirrors {

	static final private String apiKey = "F6DA4127EE279633";

	public String getMirrorXML() throws ClientProtocolException, IOException{
		String request = "http://thetvdb.com/api/"+apiKey+"/mirrors.xml";
		HttpHost target = new HttpHost("thetvdb.com", 80, "http");

		// general setup
		SchemeRegistry supportedSchemes = new SchemeRegistry();

		// Register the "http" protocol scheme, it is required
		// by the default operator to look up socket factories.
		supportedSchemes.register(new Scheme("http", 
				PlainSocketFactory.getSocketFactory(), 80));

		// prepare parameters
		HttpParams params = new BasicHttpParams();
		HttpProtocolParams.setVersion(params, HttpVersion.HTTP_1_1);
		HttpProtocolParams.setContentCharset(params, "UTF-8");
		HttpProtocolParams.setUseExpectContinue(params, true);

		ClientConnectionManager connMgr = new ThreadSafeClientConnManager(params, 
				supportedSchemes);
		DefaultHttpClient httpclient = new DefaultHttpClient(connMgr, params);

		HttpGet req = new HttpGet("/api/"+apiKey+"/mirrors.xml");

		HttpResponse rsp = httpclient.execute(target, req);
		HttpEntity entity = rsp.getEntity();

		String mirrorsXml = null;
		if (entity != null) {

			mirrorsXml = EntityUtils.toString(entity);
		}

		// When HttpClient instance is no longer needed, 
		// shut down the connection manager to ensure
		// immediate deallocation of all system resources
		httpclient.getConnectionManager().shutdown();    
		return mirrorsXml;
	}

}
