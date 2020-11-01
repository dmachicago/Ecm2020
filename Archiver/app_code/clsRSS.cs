using global::System;
using System.Collections;
using System.Collections.Generic;
using global::System.Data;
using global::System.IO;
using global::System.Net;
using System.Windows.Forms;
using global::System.Xml;
using global::System.Xml.Serialization;
using global::Chilkat;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public class clsRSS
    {

        // Dim ProxyArchive As New SVCCLCArchive.Service1Client
        private string WorkingDir = System.Configuration.ConfigurationManager.AppSettings["WEBProcessingDir"];
        private clsWebPull WEB = new clsWebPull();
        private clsUtility UTIL = new clsUtility();

        public List<rssChannelItem> ReadRssDataFromSite(string RssUrl, bool CaptureLink)
        {
            var ListOfRssScreens = new List<rssChannelItem>();
            string KeyWords = "";
            var obj = new Rss();
            var rss = new Rss();
            bool success;
            string RssPage = null;
            string xLine = "";

            // Download from the feed URL:
            // success = rss.DownloadRss("http://blog.chilkatsoft.com/?feed=rss2")
            success = rss.DownloadRss(RssUrl);
            if (success != true)
            {
                Interaction.MsgBox(rss.LastErrorText);
                return default;
            }


            // Get the 1st channel.
            Rss rssChannel;
            rssChannel = rss.GetChannel(0);
            if (rssChannel is null)
            {
                Interaction.MsgBox("No channel found in RSS feed.");
                return default;
            }

            var frmRSSLoad = new frmNotify2();
            frmRSSLoad.Text = "Loading RSS Items";
            frmRSSLoad.Show();

            // Display the various pieces of information about the channel:
            string rssTitle = "Title: " + rssChannel.GetString("title");
            string rssLink = "Link: " + rssChannel.GetString("link");
            string rssdesc = "Description: " + rssChannel.GetString("description");

            // For each item in the channel, display the title, link,
            // publish date, and categories assigned to the post.
            long numItems;
            numItems = rssChannel.NumItems;
            long i = 0L;
            string RssFQN = "";
            string WebFQN = "";
            bool SaveThisWebPage = false;
            var loopTo = numItems - 1L;
            for (i = 0L; i <= loopTo; i++)
            {
                xLine = "";
                Rss rssItem;
                rssItem = rssChannel.GetItem((int)i);
                int iCnt = rssItem.NumItems;
                int X = 0;
                var loopTo1 = iCnt - 1;
                for (X = 0; X <= loopTo1; X++)
                    object O = rssItem.GetItem(X).ToXmlString();
                var rssData = new rssChannelItem();
                rssData.title = rssItem.GetString("title");
                rssData.pubDate = rssItem.GetString("pubDate");
                rssData.link = rssItem.GetString("link");
                rssData.description = rssItem.GetString("description");
                frmRSSLoad.lblEmailMsg.Text = rssData.title.ToString();
                frmRSSLoad.lblMsg2.Text = rssData.description;
                frmRSSLoad.lblFolder.Text = rssData.pubDate;
                frmRSSLoad.Refresh();
                Application.DoEvents();
                string title = rssItem.GetString("title");
                string pubdate = rssItem.GetString("pubDate");
                string rlink = rssItem.GetString("link");
                SaveThisWebPage = false;
                if (CaptureLink)
                {
                    RssPage = WEB.spiderSingleWebPage(rlink);
                    if (!Directory.Exists(WorkingDir))
                    {
                        Directory.CreateDirectory(WorkingDir);
                    }

                    if (RssPage.Length > 0)
                    {
                        SaveThisWebPage = true;
                        RssFQN = UTIL.ConvertUrlToFQN(WorkingDir, rlink, ".HTML");
                        var outfile = new StreamWriter(RssFQN, false);
                        outfile.Write(RssPage);
                        outfile.Close();
                        outfile.Dispose();
                        GC.Collect();
                        GC.WaitForPendingFinalizers();
                        xLine = title + "|" + pubdate + "|" + rlink + "|" + RssFQN;
                        if (!File.Exists(RssFQN))
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
                if (numCategories > 0L & SaveThisWebPage)
                {
                    var loopTo2 = numCategories - 1L;
                    for (j = 0L; j <= loopTo2; j++)
                    {
                        string rssCategory = rssItem.MGetString("category", (int)j);
                        KeyWords += rssCategory + " ";
                    }

                    rssData.keyWords = KeyWords.Trim();
                }

                if (RssPage.Length > 0 & SaveThisWebPage)
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
            var DG = new DataGridView();
            string Columntext = "";
            int iRow = 0;
            int iCol = 0;

            // Create a WebRequest 
            // Dim rssReq As WebRequest = WebRequest.Create("http://www.asp.net/news/rss.ashx")
            var rssReq = WebRequest.Create(RssUrl);
            // Create a Proxy 

            // Dim px As New WebProxy("http://www.asp.net/news/rss.ashx", True)
            var px = new WebProxy(RssUrl, true);
            // Assign the proxy to the WebRequest 
            rssReq.Proxy = px;
            // Set the timeout in Seconds for the WebRequest 
            rssReq.Timeout = 5000;
            try
            {
                // Get the WebResponse 
                var rep = rssReq.GetResponse();
                // Read the Response in a XMLTextReader 
                var xtr = new XmlTextReader(rep.GetResponseStream());
                // Create a new DataSet 
                var ds = new DataSet();
                // Read the Response into the DataSet 
                ds.ReadXml(xtr);
                // Bind the Results to the Repeater 
                DG.DataSource = ds.Tables[2];
                foreach (DataGridViewColumn dgCol in DG.Columns)
                    Console.WriteLine(dgCol.Name);
                foreach (DataGridViewRow dgRow in DG.Rows)
                {
                    Columntext = "";
                    var loopTo = DG.Columns.Count - 1;
                    for (iCol = 0; iCol <= loopTo; iCol++)
                        Columntext = Columntext + " " + Conversions.ToString('þ') + " ";
                    // ** For now, write it out to the consle. Later, put it into the repository.
                    Console.WriteLine(Columntext);
                    iRow += 1;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }

    public class RSS
    {
        [XmlElement("channel")]
        public rssChannel channel = new rssChannel();
        [XmlAttribute("version")]
        public string version = "2.0";
    }

    public class rssChannel
    {
        public string title;
        public string link;
        public string description;
        public string language = "en-us";
        [XmlElement("item")]
        public rssChannelItems item = new rssChannelItems();
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
                return (rssChannelItem)List[Index];
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