Option Strict On
Option Explicit On
Imports System.Xml.Serialization
Imports System
Imports System.Net
Imports System.Xml
Imports System.Data
Imports System.IO
Imports Chilkat

Public Class clsRSS

    'Dim ProxyArchive As New SVCCLCArchive.Service1Client
    Dim WorkingDir As String = System.Configuration.ConfigurationManager.AppSettings("WEBProcessingDir")

    Dim WEB As New clsWebPull
    Dim UTIL As New clsUtility

    Function ReadRssDataFromSite(RssUrl As String, CaptureLink As Boolean) As List(Of rssChannelItem)

        Dim ListOfRssScreens As New List(Of rssChannelItem)
        Dim KeyWords As String = ""
        Dim obj As New Chilkat.Rss
        Dim rss As New Chilkat.Rss()
        Dim success As Boolean
        Dim RssPage As String = Nothing
        Dim xLine As String = ""

        '  Download from the feed URL:
        'success = rss.DownloadRss("http://blog.chilkatsoft.com/?feed=rss2")
        success = rss.DownloadRss(RssUrl)
        If (success <> True) Then
            MsgBox(rss.LastErrorText)
            Exit Function
        End If


        '  Get the 1st channel.
        Dim rssChannel As Chilkat.Rss

        rssChannel = rss.GetChannel(0)
        If (rssChannel Is Nothing) Then
            MsgBox("No channel found in RSS feed.")
            Exit Function
        End If

        Dim frmRSSLoad As New frmNotify2
        frmRSSLoad.Text = "Loading RSS Items"
        frmRSSLoad.Show()

        '  Display the various pieces of information about the channel:
        Dim rssTitle As String = "Title: " & rssChannel.GetString("title")
        Dim rssLink As String = "Link: " & rssChannel.GetString("link")
        Dim rssdesc As String = "Description: " & rssChannel.GetString("description")

        '  For each item in the channel, display the title, link,
        '  publish date, and categories assigned to the post.
        Dim numItems As Long
        numItems = rssChannel.NumItems
        Dim i As Long = 0
        Dim RssFQN As String = ""
        Dim WebFQN As String = ""

        Dim SaveThisWebPage As Boolean = False

        For i = 0 To numItems - 1
            xLine = ""
            Dim rssItem As Chilkat.Rss
            rssItem = rssChannel.GetItem(CInt(i))

            Dim iCnt As Integer = rssItem.NumItems
            Dim X As Integer = 0

            For X = 0 To iCnt - 1
                Dim O As Object = rssItem.GetItem(X).ToXmlString
            Next

            Dim rssData As New rssChannelItem

            rssData.title = rssItem.GetString("title")
            rssData.pubDate = rssItem.GetString("pubDate")
            rssData.link = rssItem.GetString("link")
            rssData.description = rssItem.GetString("description")

            frmRSSLoad.lblEmailMsg.Text = rssData.title.ToString
            frmRSSLoad.lblMsg2.Text = rssData.description
            frmRSSLoad.lblFolder.Text = rssData.pubDate
            frmRSSLoad.Refresh()
            Application.DoEvents()

            Dim title As String = rssItem.GetString("title")
            Dim pubdate As String = rssItem.GetString("pubDate")
            Dim rlink As String = rssItem.GetString("link")
            SaveThisWebPage = False
            If CaptureLink Then
                RssPage = WEB.spiderSingleWebPage(rlink)

                If Not Directory.Exists(WorkingDir) Then
                    Directory.CreateDirectory(WorkingDir)
                End If

                If RssPage.Length > 0 Then
                    SaveThisWebPage = True
                    RssFQN = UTIL.ConvertUrlToFQN(WorkingDir, rlink, ".HTML")
                    Dim outfile As New StreamWriter(RssFQN, False)
                    outfile.Write(RssPage)
                    outfile.Close()
                    outfile.Dispose()
                    GC.Collect()
                    GC.WaitForPendingFinalizers()
                    xLine = title + "|" + pubdate + "|" + rlink + "|" + RssFQN

                    If Not File.Exists(RssFQN) Then
                        MessageBox.Show(RssFQN + " is MISSING.")
                    End If

                    rssData.webFqn = RssFQN
                Else
                    Console.WriteLine(RssFQN + " DID not load.")
                End If
            Else
                xLine = title + "|" + pubdate + "|" + rlink + "|" + " "
                rssData.webFqn = ""
            End If

            Dim numCategories As Long
            numCategories = rssItem.GetCount("category")

            Dim j As Long
            If (numCategories > 0) And SaveThisWebPage Then
                For j = 0 To numCategories - 1
                    Dim rssCategory As String = rssItem.MGetString("category", CInt(j))
                    KeyWords += rssCategory + " "
                Next
                rssData.keyWords = KeyWords.Trim
            End If

            If RssPage.Length > 0 And SaveThisWebPage Then
                ListOfRssScreens.Add(rssData)
            End If
            KeyWords = ""
            Console.WriteLine("Save RSS Pull data here for: " + rlink)

        Next
        frmRSSLoad.Close()
        frmRSSLoad = Nothing
        GC.Collect()
        GC.WaitForPendingFinalizers()
        Return ListOfRssScreens
    End Function

    Public Sub readRssData(RssUrl As String)


        Dim DG As New DataGridView
        Dim dgRow As DataGridViewRow
        Dim dgCol As DataGridViewColumn
        Dim Columntext As String = ""
        Dim iRow As Integer = 0
        Dim iCol As Integer = 0

        'Create a WebRequest 
        'Dim rssReq As WebRequest = WebRequest.Create("http://www.asp.net/news/rss.ashx")
        Dim rssReq As WebRequest = WebRequest.Create(RssUrl)
        'Create a Proxy 

        'Dim px As New WebProxy("http://www.asp.net/news/rss.ashx", True)
        Dim px As New WebProxy(RssUrl, True)
        'Assign the proxy to the WebRequest 
        rssReq.Proxy = px
        'Set the timeout in Seconds for the WebRequest 
        rssReq.Timeout = 5000

        Try
            'Get the WebResponse 
            Dim rep As WebResponse = rssReq.GetResponse()
            'Read the Response in a XMLTextReader 
            Dim xtr As New XmlTextReader(rep.GetResponseStream())
            'Create a new DataSet 
            Dim ds As New DataSet()
            'Read the Response into the DataSet 
            ds.ReadXml(xtr)
            'Bind the Results to the Repeater 
            DG.DataSource = ds.Tables(2)

            For Each dgCol In DG.Columns
                Console.WriteLine(dgCol.Name)
            Next

            For Each dgRow In DG.Rows
                Columntext = ""
                For iCol = 0 To DG.Columns.Count - 1
                    Columntext = Columntext + " " + ChrW(254) + " "
                Next
                '** For now, write it out to the consle. Later, put it into the repository.
                Console.WriteLine(Columntext)
                iRow += 1
            Next

        Catch ex As Exception

            Throw ex

        End Try

    End Sub

End Class

Public Class RSS
    <XmlElementAttribute("channel")> _
    Public channel As New rssChannel()
    <XmlAttributeAttribute("version")> _
    Public version As String = "2.0"
End Class

Public Class rssChannel
    Public title As String
    Public link As String
    Public description As String
    Public language As String = "en-us"
    <XmlElementAttribute("item")> _
    Public item As New rssChannelItems()
End Class

Public Class rssChannelItems
    Inherits CollectionBase

    Public Sub Add(ByVal Item As rssChannelItem)
        Dim I As Integer = List.Add(Item)
    End Sub

    Default Public ReadOnly Property Item(ByVal Index As Integer) As rssChannelItem
        Get
            Return CType(List.Item(Index), rssChannelItem)
        End Get
    End Property
End Class

Public Class rssChannelItem
    Public title As String
    Public description As String
    Public link As String
    Public pubDate As String
    Public webFqn As String
    Public keyWords As String
End Class

Public Class dsWebSite
    Public title As String
    Public url As String
    Public Depth As Integer
    Public Width As Integer
    Public RetentionCode As String
End Class


