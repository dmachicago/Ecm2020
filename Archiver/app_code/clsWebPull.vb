Imports System.IO
Imports System.Net
Imports Chilkat

Public Class clsWebPull

    Dim LOG As New clsLogging()

    'Dim ProxyArchive As New SVCCLCArchive.Service1Client

    Dim CacheDir As String = LOG.getEnvVarSpecialFolderApplicationData + "\SpiderCache".Replace("\\", "\")

    Public Sub saveWebPage(uriString As String)

        'uriString = "http://www.google.com"
        Dim myWebClient As New WebClient()
        Console.WriteLine("Accessing {0} ...", uriString)
        Dim myStream As Stream = myWebClient.OpenRead(uriString)
        Console.WriteLine(ControlChars.Cr + "Displaying Data :" + ControlChars.Cr)
        Dim sr As New StreamReader(myStream)
        'for now, write the page data to a console. Later add it to the repository
        Console.WriteLine(sr.ReadToEnd())
        myStream.Close()

    End Sub

    Public Function getWebPage(uriString As String) As Byte()

        'uriString = "http://www.google.com"
        Dim myWebClient As New WebClient()
        Console.WriteLine("Accessing {0} ...", uriString)
        Dim myStream As Stream = myWebClient.OpenRead(uriString)
        Console.WriteLine(ControlChars.Cr + "Displaying Data :" + ControlChars.Cr)
        Dim sr As New StreamReader(myStream)

        Dim I As Integer = Convert.ToInt32(myStream.Length)
        Dim bytes() As Byte = New Byte(I) {}
        myStream.Read(bytes, 0, I)

        myStream.Close()
        Return bytes

    End Function

    

    Public Function spiderSingleWebPage(uriString As String) As String

        Dim MaxUrlsToSpider As Integer = 5
        Dim MaxOutboundLinks As Integer = 1

        Dim PageHtml As String = ""
        'Dim WebPage As Byte() = Nothing
        Dim spider As New Chilkat.Spider()

        Dim seenDomains As New Chilkat.StringArray()
        Dim seedUrls As New Chilkat.StringArray()

        Dim currProcessedUrl As String = ""
        Dim allProcessedUrl As String = ""

        seenDomains.Unique = True
        seedUrls.Unique = True

        '  You will need to change the start URL to something else...
        'seedUrls.Append("http://something.whateverYouWant.com/")
        seedUrls.Append(uriString)

        '  Set outbound URL exclude patterns
        '  URLs matching any of these patterns will not be added to the
        '  collection of outbound links.
        'spider.AddAvoidOutboundLinkPattern("*?id=*")
        'spider.AddAvoidOutboundLinkPattern("*.mypages.*")
        'spider.AddAvoidOutboundLinkPattern("*.personal.*")
        'spider.AddAvoidOutboundLinkPattern("*.comcast.*")
        'spider.AddAvoidOutboundLinkPattern("*.aol.*")
        'spider.AddAvoidOutboundLinkPattern("*~*")


        If Not Directory.Exists(CacheDir) Then
            Directory.CreateDirectory(CacheDir)
        End If
        '  Use a cache so we don't have to re-fetch URLs previously fetched.
        'spider.CacheDir = "c:/spiderCache/"
        spider.CacheDir = CacheDir
        spider.FetchFromCache = True
        spider.UpdateCache = True

        While seedUrls.Count > 0

            Dim url As String
            url = seedUrls.Pop()
            spider.Initialize(url)

            '  Spider 5 URLs of this domain.
            '  but first, save the base domain in seenDomains
            Dim domain As String
            domain = spider.GetDomain(url)
            seenDomains.Append(spider.GetBaseDomain(domain))

            Dim i As Long
            Dim success As Boolean
            For i = 0 To MaxUrlsToSpider - 1
                success = spider.CrawlNext
                If (success <> True) Then
                    Exit For
                End If

                '  Display the URL we just crawled.
                currProcessedUrl = spider.LastUrl
                allProcessedUrl += currProcessedUrl + " | "


                Application.DoEvents()
                Dim kw As String = spider.LastHtmlKeywords
                Dim LastModDate As String = spider.LastModDateStr
                Dim LastDesc As String = spider.LastHtmlDescription
                Dim PageTitle As String = spider.LastHtmlTitle
                Dim FQN As String = domain + "@" + PageTitle + ".HTML"
                Dim iLen As Integer = spider.LastHtmlTitle.Trim.Length
                If iLen > 0 Then
                    Dim NewFqn As String = currProcessedUrl.Replace("http://", "")
                    Dim iLast As Integer = NewFqn.LastIndexOf("/")
                    If iLast > 0 Then
                        Mid(NewFqn, iLast + 1, 1) = "@"
                    Else
                        NewFqn = FQN
                    End If

                    NewFqn = NewFqn.Replace("/", "~")

                    PageHtml = spider.LastHtml
                    'WebPage = System.Text.Encoding.UTF8.GetBytes(PageHtml)
                    If PageHtml.Length > 0 Then
                        Exit For
                    End If
                End If

                '  If the last URL was retrieved from cache, we won't wait.  Otherwise we'll wait 1 second before fetching the next URL.
                If (spider.LastFromCache <> True) Then
                    spider.SleepMs(1000)
                End If

            Next

            '  Add the outbound links to seedUrls, except
            '  for the domains we've already seen.
            For i = 0 To spider.NumOutboundLinks - 1
                url = spider.GetOutboundLink(i)
                domain = spider.GetDomain(url)
                Dim baseDomain As String
                baseDomain = spider.GetBaseDomain(domain)
                If (Not seenDomains.Contains(baseDomain)) Then
                    seedUrls.Append(url)
                End If

                '  Don't let our list of seedUrls grow too large.
                If (seedUrls.Count > MaxOutboundLinks) Then
                    Exit For
                End If
            Next

        End While

        Return PageHtml

    End Function

    Protected Overridable Overloads Sub Dispose(ByVal disposing As Boolean)

        If disposing Then
            GC.Collect()
            GC.WaitForPendingFinalizers()

            For Each sFile As String In Directory.GetFiles(CacheDir)
                Try
                    File.Delete(sFile)
                Catch ex As Exception
                    Console.WriteLine("Failed to delete A1: " + sFile)
                End Try

            Next

        End If
        ' Free your own state (unmanaged objects).
        ' Set large fields to null.
    End Sub

End Class
