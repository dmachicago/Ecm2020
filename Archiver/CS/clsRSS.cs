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

using System.Xml.Serialization;
using System.Net;
using System.Xml;
using System.IO;
using Chilkat;


namespace EcmArchiveClcSetup
{
	public class clsRSS
	{
		public clsRSS()
		{
			// VBConversions Note: Non-static class variable initialization is below.  Class variables cannot be initially assigned non-static values in C#.
			WorkingDir = System.Configuration.ConfigurationManager.AppSettings["WEBProcessingDir"];
			
		}
		
		SVCCLCArchive.Service1Client ProxyArchive = new SVCCLCArchive.Service1Client();
		string WorkingDir; // VBConversions Note: Initial value of "System.Configuration.ConfigurationManager.AppSettings["WEBProcessingDir"]" cannot be assigned here since it is non-static.  Assignment has been moved to the class constructors.
		
		clsWebPull WEB = new clsWebPull();
		clsUtility UTIL = new clsUtility();
		
		public List<rssChannelItem> ReadRssDataFromSite(string RssUrl, bool CaptureLink)
		{
			
			List<rssChannelItem> ListOfRssScreens = new List<rssChannelItem>();
			string KeyWords = "";
			Chilkat.Rss obj = new Chilkat.Rss();
			Chilkat.Rss rss = new Chilkat.Rss();
			bool success;
			string RssPage = null;
			string xLine = "";
			
			//  Download from the feed URL:
			//success = rss.DownloadRss("http://blog.chilkatsoft.com/?feed=rss2")
			success = System.Convert.ToBoolean(RSS.DownloadRss(RssUrl));
			if (success != true)
			{
				MessageBox.Show(RSS.LastErrorText);
				return null;
			}
			
			
			//  Get the 1st channel.
			Chilkat.Rss rssChannel;
			
			rssChannel = RSS.GetChannel(0);
			if (rssChannel == null)
			{
				MessageBox.Show("No channel found in RSS feed.");
				return null;
			}
			
			frmNotify2 frmRSSLoad = new frmNotify2();
			frmRSSLoad.Text = "Loading RSS Items";
			frmRSSLoad.Show();
			
			//  Display the various pieces of information about the channel:
			string rssTitle = (string) ("Title: " + rssChannel.GetString("title"));
			string rssLink = (string) ("Link: " + rssChannel.GetString("link"));
			string rssdesc = (string) ("Description: " + rssChannel.GetString("description"));
			
			//  For each item in the channel, display the title, link,
			//  publish date, and categories assigned to the post.
			long numItems;
			numItems = rssChannel.NumItems;
			long i;
			string RssFQN;
			string WebFQN;
			
			bool SaveThisWebPage = false;
			
			for (i = 0; i <= numItems - 1; i++)
			{
				xLine = "";
				Chilkat.Rss rssItem;
				rssItem = rssChannel.GetItem((int) i);
				
				int iCnt = System.Convert.ToInt32(rssItem.NumItems);
				int X = 0;
				
				for (X = 0; X <= iCnt - 1; X++)
				{
					object O = rssItem.GetItem(X).ToXmlString;
				}
				
				rssChannelItem rssData = new rssChannelItem();
				
				rssData.title = (string) (rssItem.GetString("title"));
				rssData.pubDate = (string) (rssItem.GetString("pubDate"));
				rssData.link = (string) (rssItem.GetString("link"));
				rssData.description = (string) (rssItem.GetString("description"));
				
				frmRSSLoad.lblEmailMsg.Text = rssData.title.ToString();
				frmRSSLoad.lblMsg2.Text = rssData.description;
				frmRSSLoad.lblFolder.Text = rssData.pubDate;
				frmRSSLoad.Refresh();
				Application.DoEvents();
				
				string title = (string) (rssItem.GetString("title"));
				string pubdate = (string) (rssItem.GetString("pubDate"));
				string rlink = (string) (rssItem.GetString("link"));
				SaveThisWebPage = false;
				if (CaptureLink)
				{
					RssPage = WEB.spiderSingleWebPage(rlink);
					
					if (! Directory.Exists(WorkingDir))
					{
						Directory.CreateDirectory(WorkingDir);
					}
					
					if (RssPage.Length > 0)
					{
						SaveThisWebPage = true;
						RssFQN = UTIL.ConvertUrlToFQN(WorkingDir, rlink, ".HTML");
						StreamWriter outfile = new StreamWriter(RssFQN, false);
						outfile.Write(RssPage);
						outfile.Close();
						outfile.Dispose();
						GC.Collect();
						GC.WaitForPendingFinalizers();
						xLine = title + "|" + pubdate + "|" + rlink + "|" + RssFQN;
						
						if (! File.Exists(RssFQN))
						{
							MessageBox.Show(RssFQN + " is MISSING.");
						}
						
						rssData.webFqn = RssFQN;
					}
					else
					{
						Console.WriteLine(RssFQN + " DID not load.");
					}
				}
				else
				{
					xLine = title + "|" + pubdate + "|" + rlink + "|" + " ";
					rssData.webFqn = "";
				}
				
				long numCategories;
				numCategories = rssItem.GetCount("category");
				
				long j;
				if ((numCategories > 0) && SaveThisWebPage)
				{
					for (j = 0; j <= numCategories - 1; j++)
					{
						string rssCategory = (string) (rssItem.MGetString("category", (int) j));
						KeyWords += rssCategory + " ";
					}
					rssData.keyWords = KeyWords.Trim();
				}
				
				if (RssPage.Length > 0 && SaveThisWebPage)
				{
					ListOfRssScreens.Add(rssData);
				}
				KeyWords = "";
				Console.WriteLine("Save RSS Pull data here for: " + rlink);
				
			}
			frmRSSLoad.Close();
			frmRSSLoad = null;
			GC.Collect();
			GC.WaitForPendingFinalizers();
			return ListOfRssScreens;
		}
		
		public void readRssData(string RssUrl)
		{
			
			
			DataGridView DG = new DataGridView();
			
			
			string Columntext = "";
			int iRow = 0;
			int iCol = 0;
			
			//Create a WebRequest
			//Dim rssReq As WebRequest = WebRequest.Create("http://www.asp.net/news/rss.ashx")
			WebRequest rssReq = WebRequest.Create(RssUrl);
			//Create a Proxy
			
			//Dim px As New WebProxy("http://www.asp.net/news/rss.ashx", True)
			WebProxy px = new WebProxy(RssUrl, true);
			//Assign the proxy to the WebRequest
			rssReq.Proxy = px;
			//Set the timeout in Seconds for the WebRequest
			rssReq.Timeout = 5000;
			
			try
			{
				//Get the WebResponse
				WebResponse rep = rssReq.GetResponse();
				//Read the Response in a XMLTextReader
				XmlTextReader xtr = new XmlTextReader(rep.GetResponseStream());
				//Create a new DataSet
				DataSet ds = new DataSet();
				//Read the Response into the DataSet
				ds.ReadXml(xtr);
				//Bind the Results to the Repeater
				DG.DataSource = ds.Tables[2];
				
				foreach (DataGridViewColumn dgCol in DG.Columns)
				{
					Console.WriteLine(dgCol.Name);
				}
				
				foreach (DataGridViewRow dgRow in DG.Rows)
				{
					Columntext = "";
					for (iCol = 0; iCol <= DG.Columns.Count - 1; iCol++)
					{
						Columntext = Columntext + " " + Strings.ChrW(254) + " ";
					}
					//** For now, write it out to the consle. Later, put it into the repository.
					Console.WriteLine(Columntext);
					iRow++;
				}
				
			}
			catch (Exception ex)
			{
				
				throw (ex);
				
			}
			
		}
		
	}
	
	public class RSS
	{
		[XmlElementAttribute("channel")]public rssChannel channel = new rssChannel();
		[XmlAttributeAttribute("version")]public string version = "2.0";
	}
	
	public class rssChannel
	{
		public string title;
		public string link;
		public string description;
		public string language = "en-us";
		[XmlElementAttribute("item")]public rssChannelItems item = new rssChannelItems();
	}
	
	public class rssChannelItems : CollectionBase
	{
		
		public void Add(rssChannelItem Item)
		{
			int I = List.Add(Item);
		}
		
		public rssChannelItem this[int Index]
		{
			get
			{
				return ((rssChannelItem) (List[Index]));
			}
		}
	}
	
	public class rssChannelItem
	{
		public string title;
		public string description;
		public string link;
		public string pubDate;
		public string webFqn;
		public string keyWords;
	}
	
	public class dsWebSite
	{
		public string title;
		public string url;
		public int Depth;
		public int Width;
		public string RetentionCode;
	}
	
	
	
}
