using System;
using global::System.IO;
using global::System.Net;
using System.Windows.Forms;
using global::Chilkat;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public class clsWebPull
    {
        public clsWebPull()
        {

            // Dim ProxyArchive As New SVCCLCArchive.Service1Client

            CacheDir = LOG.getEnvVarSpecialFolderApplicationData() + @"\SpiderCache".Replace(@"\\", @"\");
        }

        private clsLogging LOG = new clsLogging();
        private string CacheDir;

        public void saveWebPage(string uriString)
        {

            // uriString = "http://www.google.com"
            var myWebClient = new WebClient();
            Console.WriteLine("Accessing {0} ...", uriString);
            var myStream = myWebClient.OpenRead(uriString);
            Console.WriteLine(Conversions.ToString(ControlChars.Cr) + "Displaying Data :" + Conversions.ToString(ControlChars.Cr));
            var sr = new StreamReader(myStream);
            // for now, write the page data to a console. Later add it to the repository
            Console.WriteLine(sr.ReadToEnd());
            myStream.Close();
        }

        public byte[] getWebPage(string uriString)
        {

            // uriString = "http://www.google.com"
            var myWebClient = new WebClient();
            Console.WriteLine("Accessing {0} ...", uriString);
            var myStream = myWebClient.OpenRead(uriString);
            Console.WriteLine(Conversions.ToString(ControlChars.Cr) + "Displaying Data :" + Conversions.ToString(ControlChars.Cr));
            var sr = new StreamReader(myStream);
            int I = Convert.ToInt32(myStream.Length);
            var bytes = new byte[I + 1];
            myStream.Read(bytes, 0, I);
            myStream.Close();
            return bytes;
        }

        public string spiderSingleWebPage(string uriString)
        {
            int MaxUrlsToSpider = 5;
            int MaxOutboundLinks = 1;
            string PageHtml = "";
            // Dim WebPage As Byte() = Nothing
            var spider = new Spider();
            var seenDomains = new StringArray();
            var seedUrls = new StringArray();
            string currProcessedUrl = "";
            string allProcessedUrl = "";
            seenDomains.Unique = true;
            seedUrls.Unique = true;

            // You will need to change the start URL to something else...
            // seedUrls.Append("http://something.whateverYouWant.com/")
            seedUrls.Append(uriString);

            // Set outbound URL exclude patterns
            // URLs matching any of these patterns will not be added to the
            // collection of outbound links.
            // spider.AddAvoidOutboundLinkPattern("*?id=*")
            // spider.AddAvoidOutboundLinkPattern("*.mypages.*")
            // spider.AddAvoidOutboundLinkPattern("*.personal.*")
            // spider.AddAvoidOutboundLinkPattern("*.comcast.*")
            // spider.AddAvoidOutboundLinkPattern("*.aol.*")
            // spider.AddAvoidOutboundLinkPattern("*~*")


            if (!Directory.Exists(CacheDir))
            {
                Directory.CreateDirectory(CacheDir);
            }
            // Use a cache so we don't have to re-fetch URLs previously fetched.
            // spider.CacheDir = "c:/spiderCache/"
            spider.CacheDir = CacheDir;
            spider.FetchFromCache = true;
            spider.UpdateCache = true;
            while (seedUrls.Count > 0)
            {
                string url;
                url = seedUrls.Pop();
                spider.Initialize(url);

                // Spider 5 URLs of this domain.
                // but first, save the base domain in seenDomains
                string domain;
                domain = spider.GetDomain(url);
                seenDomains.Append(spider.GetBaseDomain(domain));
                long i;
                bool success;
                var loopTo = (long)(MaxUrlsToSpider - 1);
                for (i = 0L; i <= loopTo; i++)
                {
                    success = spider.CrawlNext();
                    if (success != true)
                    {
                        break;
                    }

                    // Display the URL we just crawled.
                    currProcessedUrl = spider.LastUrl;
                    allProcessedUrl += currProcessedUrl + " | ";
                    Application.DoEvents();
                    string kw = spider.LastHtmlKeywords;
                    string LastModDate = spider.LastModDateStr;
                    string LastDesc = spider.LastHtmlDescription;
                    string PageTitle = spider.LastHtmlTitle;
                    string FQN = domain + "@" + PageTitle + ".HTML";
                    int iLen = spider.LastHtmlTitle.Trim().Length;
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
                        PageHtml = spider.LastHtml;
                        // WebPage = System.Text.Encoding.UTF8.GetBytes(PageHtml)
                        if (PageHtml.Length > 0)
                        {
                            break;
                        }
                    }

                    // If the last URL was retrieved from cache, we won't wait.  Otherwise we'll wait 1 second before fetching the next URL.
                    if (spider.LastFromCache != true)
                    {
                        spider.SleepMs(1000);
                    }
                }

                // Add the outbound links to seedUrls, except
                // for the domains we've already seen.
                var loopTo1 = (long)(spider.NumOutboundLinks - 1);
                for (i = 0L; i <= loopTo1; i++)
                {
                    url = spider.GetOutboundLink((int)i);
                    domain = spider.GetDomain(url);
                    string baseDomain;
                    baseDomain = spider.GetBaseDomain(domain);
                    if (!seenDomains.Contains(baseDomain))
                    {
                        seedUrls.Append(url);
                    }

                    // Don't let our list of seedUrls grow too large.
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
                GC.Collect();
                GC.WaitForPendingFinalizers();
                foreach (string sFile in Directory.GetFiles(CacheDir))
                {
                    try
                    {
                        File.Delete(sFile);
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine("Failed to delete A1: " + sFile);
                    }
                }
            }
            // Free your own state (unmanaged objects).
            // Set large fields to null.
        }
    }
}