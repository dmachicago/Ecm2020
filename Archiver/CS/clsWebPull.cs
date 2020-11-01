// VBConversions Note: VB project level imports
using System.Collections.Generic;
using System;
using System.Drawing;
using System.Linq;
using System.Diagnostics;
using System.Data;
using Microsoft.VisualBasic;
using MODI;
using System.Xml.Linq;
using System.Collections;
using System.Windows.Forms;
// End of VB project level imports

using System.IO;
using System.Net;
using Chilkat;
using Microsoft.VisualBasic.CompilerServices;


namespace EcmArchiveClcSetup
{
	public class clsWebPull
	{
		public clsWebPull()
		{
			// VBConversions Note: Non-static class variable initialization is below.  Class variables cannot be initially assigned non-static values in C#.
			CacheDir = LOG.getEnvVarSpecialFolderApplicationData() + "\\SpiderCache".Replace("\\\\", "\\");
			
		}
		
		clsLogging LOG = new clsLogging();
		
		SVCCLCArchive.Service1Client ProxyArchive = new SVCCLCArchive.Service1Client();
		
		string CacheDir; // VBConversions Note: Initial value of "LOG.getEnvVarSpecialFolderApplicationData() + "\\SpiderCache".Replace("\\\\", "\\")" cannot be assigned here since it is non-static.  Assignment has been moved to the class constructors.
		
		public void saveWebPage(string uriString)
		{
			
			//uriString = "http://www.google.com"
			WebClient myWebClient = new WebClient();
			Console.WriteLine("Accessing {0} ...", uriString);
			Stream myStream = myWebClient.OpenRead(uriString);
			Console.WriteLine(ControlChars.Cr + "Displaying Data :" + ControlChars.Cr);
			StreamReader sr = new StreamReader(myStream);
			//for now, write the page data to a console. Later add it to the repository
			Console.WriteLine(sr.ReadToEnd());
			myStream.Close();
			
		}
		
		public byte[] getWebPage(string uriString)
		{
			
			//uriString = "http://www.google.com"
			WebClient myWebClient = new WebClient();
			Console.WriteLine("Accessing {0} ...", uriString);
			Stream myStream = myWebClient.OpenRead(uriString);
			Console.WriteLine(ControlChars.Cr + "Displaying Data :" + ControlChars.Cr);
			StreamReader sr = new StreamReader(myStream);
			
			int I = Convert.ToInt32(myStream.Length);
			byte[] bytes = new byte[I+ 1];
			myStream.Read(bytes, 0, I);
			
			myStream.Close();
			return bytes;
			
		}
		
		
		
		public string spiderSingleWebPage(string uriString)
		{
			
			int MaxUrlsToSpider = 5;
			int MaxOutboundLinks = 1;
			
			string PageHtml = "";
			//Dim WebPage As Byte() = Nothing
			Chilkat.Spider spider = new Chilkat.Spider();
			
			Chilkat.StringArray seenDomains = new Chilkat.StringArray();
			Chilkat.StringArray seedUrls = new Chilkat.StringArray();
			
			string currProcessedUrl = "";
			string allProcessedUrl = "";
			
			seenDomains.Unique = true;
			seedUrls.Unique = true;
			
			//  You will need to change the start URL to something else...
			//seedUrls.Append("http://something.whateverYouWant.com/")
			seedUrls.Append(uriString);
			
			//  Set outbound URL exclude patterns
			//  URLs matching any of these patterns will not be added to the
			//  collection of outbound links.
			//spider.AddAvoidOutboundLinkPattern("*?id=*")
			//spider.AddAvoidOutboundLinkPattern("*.mypages.*")
			//spider.AddAvoidOutboundLinkPattern("*.personal.*")
			//spider.AddAvoidOutboundLinkPattern("*.comcast.*")
			//spider.AddAvoidOutboundLinkPattern("*.aol.*")
			//spider.AddAvoidOutboundLinkPattern("*~*")
			
			
			if (! Directory.Exists(CacheDir))
			{
				Directory.CreateDirectory(CacheDir);
			}
			//  Use a cache so we don't have to re-fetch URLs previously fetched.
			//spider.CacheDir = "c:/spiderCache/"
			spider.CacheDir = CacheDir;
			spider.FetchFromCache = true;
			spider.UpdateCache = true;
			
			while (seedUrls.Count > 0)
			{
				
				string url;
				url = (string) (seedUrls.Pop());
				spider.Initialize(url);
				
				//  Spider 5 URLs of this domain.
				//  but first, save the base domain in seenDomains
				string domain;
				domain = (string) (spider.GetDomain(url));
				seenDomains.Append(spider.GetBaseDomain(domain));
				
				long i;
				bool success;
				for (i = 0; i <= MaxUrlsToSpider - 1; i++)
				{
					success = System.Convert.ToBoolean(spider.CrawlNext);
					if (success != true)
					{
						break;
					}
					
					//  Display the URL we just crawled.
					currProcessedUrl = (string) spider.LastUrl;
					allProcessedUrl += currProcessedUrl + " | ";
					
					
					Application.DoEvents();
					string kw = (string) spider.LastHtmlKeywords;
					string LastModDate = (string) spider.LastModDateStr;
					string LastDesc = (string) spider.LastHtmlDescription;
					string PageTitle = (string) spider.LastHtmlTitle;
					string FQN = domain + "@" + PageTitle + ".HTML";
					int iLen = System.Convert.ToInt32(spider.LastHtmlTitle.Trim.Length);
					if (iLen > 0)
					{
						string NewFqn = currProcessedUrl.Replace("http://", "");
						int iLast = NewFqn.LastIndexOf("/");
						if (iLast > 0)
						{
							StringType.MidStmtStr(ref NewFqn, iLast + 1, 1, "@");
						}
						else
						{
							NewFqn = FQN;
						}
						
						NewFqn = NewFqn.Replace("/", "~");
						
						PageHtml = (string) spider.LastHtml;
						//WebPage = System.Text.Encoding.UTF8.GetBytes(PageHtml)
						if (PageHtml.Length > 0)
						{
							break;
						}
					}
					
					//  If the last URL was retrieved from cache, we won't wait.  Otherwise we'll wait 1 second before fetching the next URL.
					if (spider.LastFromCache != true)
					{
						spider.SleepMs(1000);
					}
					
				}
				
				//  Add the outbound links to seedUrls, except
				//  for the domains we've already seen.
				for (i = 0; i <= spider.NumOutboundLinks - 1; i++)
				{
					url = (string) (spider.GetOutboundLink(i));
					domain = (string) (spider.GetDomain(url));
					string baseDomain;
					baseDomain = (string) (spider.GetBaseDomain(domain));
					if (! seenDomains.Contains(baseDomain))
					{
						seedUrls.Append(url);
					}
					
					//  Don't let our list of seedUrls grow too large.
					if (seedUrls.Count > MaxOutboundLinks)
					{
						break;
					}
				}
				
			}
			
			return PageHtml;
			
		}
		
		protected virtual void Dispose(bool disposing)
		{
			
			if (disposing)
			{
				ProxyArchive = null;
				GC.Collect();
				GC.WaitForPendingFinalizers();
				
				foreach (string sFile in Directory.GetFiles(CacheDir))
				{
					try
					{
						File.Delete(sFile);
					}
					catch (Exception)
					{
						Console.WriteLine("Failed to delete: " + sFile);
					}
					
				}
				
			}
			// Free your own state (unmanaged objects).
			// Set large fields to null.
		}
		
	}
	
}
