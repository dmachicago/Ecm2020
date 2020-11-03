Imports System.Text.RegularExpressions
Imports System.IO
Imports Outlook = Microsoft.Office.Interop.Outlook
Imports System
Imports System.Net
Imports System.Text
Imports ECMEncryption
'Imports Microsoft.Data.Sqlite
Imports System.Data.SQLite

Module modGlobals

    Dim ENC As New ECMEncrypt
    Dim ISO As New clsIsolatedStorage

    ' Private Declare Function GetShortPathName Lib "kernel32" Alias "GetShortPathNameA" (ByVal
    ' longPath As String, ByVal shortPath As String, ByVal shortBufferSize As Long) As Long

    Public FTILogs As String = System.Configuration.ConfigurationManager.AppSettings("FTILogs")
    Public ContentBatchSize As Int32 = Convert.ToInt32(System.Configuration.ConfigurationManager.AppSettings("ContentBatchSize"))
    Public gUseThreading As Int32 = Convert.ToInt32(System.Configuration.ConfigurationManager.AppSettings("UseThreading"))
    Public gTraceFunctionCalls As Int32 = Convert.ToInt32(System.Configuration.ConfigurationManager.AppSettings("TraceFunctionCALLS"))
    Public TrackUploads As Int32 = Convert.ToInt32(System.Configuration.ConfigurationManager.AppSettings("TrackUploads"))
    Public UseDebugSQLite As Int32 = Convert.ToInt32(System.Configuration.ConfigurationManager.AppSettings("UseDebugSQLite"))
    Public MaxFileToLoadMB As Int64 = Convert.ToInt32(System.Configuration.ConfigurationManager.AppSettings("MaxFileToLoadMB"))
    Public TempDisableDirListener As Boolean = False
    Public UseDirectoryListener As Int32 = Convert.ToInt32(System.Configuration.ConfigurationManager.AppSettings("UseDirectoryListener"))
    Public SQLiteListenerDB As String = System.Configuration.ConfigurationManager.AppSettings("SQLiteListenerDB")

    Public gAllowedExts As New List(Of String)
    Public FilesBackedUp As Integer = 0
    Public FilesSkipped As Integer = 0
    Public MoreFileToProcess As Integer = 0

    Public gBatchLogin As String = ""
    Public gBatchEncryptedPW As String = ""

    Public gEmailArchiveDisabled As Boolean = False
    Public gAutoExec As Boolean = False
    Public gAutoExecContentComplete As Boolean = True
    Public gAutoExecEmailComplete As Boolean = True
    Public gAutoExecExchangeComplete As Boolean = True

    Public gCustomerName As String = System.Configuration.ConfigurationManager.AppSettings("CustomerName")
    Public gCustomerID As String = System.Configuration.ConfigurationManager.AppSettings("CustomerID")

    Private Declare Auto Function GetShortPathName Lib "kernel32" (ByVal longPath As String, ByVal shortPath As StringBuilder, ByVal shortBufferSize As Integer) As Integer
    Public gDictOfConstr As New Dictionary(Of Integer, String)
    Public DictEmails As New Dictionary(Of String, String)
    Public DictContent As New Dictionary(Of String, String)

    Public gLocalDBCS As String = ""
    Public gResetEndpoints As Boolean = True
    Public gLoginValidated As Boolean = True

    Public SVCFS_Endpoint As String = ""
    Public SVCGateway_Endpoint As String = ""
    Public SVCCLCArchive_Endpoint As String = ""
    Public SVCSearch_Endpoint As String = ""
    Public SVCclcDownload_Endpoint As String = ""

    Public gSoftware As List(Of String) = New List(Of String)
    Public gCurrRepoID As Integer = -1
    Public gLicense As String = ""


    Public gNotifyMsg As String = ""
    Public gSecureID As Integer = -1
    Public gGateWayID As Integer = -1
    Public gAttachedMachineName As String = ""
    Public gLocalMachineIP As String = ""
    Public gServerInstanceName As String = ""
    Public gServerMachineName As String = ""

    Public gRepoID As String = ""
    Public gUserID As String = ""
    Public gActiveGuid As Guid
    Public gSessionGuid As Guid
    Public gEncryptPW As String = ""

    Public ZipFilesListener As New ArrayList
    Public ZipFilesQuick As New ArrayList
    Public ZipFilesContent As New ArrayList
    Public ZipFilesEmail As New ArrayList
    Public ZipFilesAttachment As New ArrayList
    Public ZipFilesExchange As New ArrayList

    Public gCurrentConnectionString As String = ""
    Public gFilesToArchive As New SortedList(Of String, Integer)
    Public gfile_Length As Double = 0

    Public gCurrLoginID As String = ""
    Public gEncPassword As String = ""
    Public gUnEncPassword As String = ""

    Public gContentArchiving As Boolean = False
    Public gOutlookArchiving As Boolean = False
    Public gExchangeArchiving As Boolean = False
    Public gContactsArchiving As Boolean = False

    Public oEcmHistFolder As Outlook.MAPIFolder = Nothing
    Public oHistoryEntryID As String = ""
    Public oHistoryStoreID As String = ""

    Public gCurrThesaurusCS As String = ""
    Public gCurrRepositoryCS As String = ""

    Public gRunMinimized As Boolean = False
    Public gDateSeparator As String = ""
    Public gTimeSeparator As String = ""
    Public gShortDatePattern As String = ""
    Public gShortTimePattern As String = ""

    Public gHiveServersList As New List(Of String)
    Public gHiveEnabled As Boolean = False

    Public gRunMode As String = ""
    Public gClipBoardActive As Boolean = False

    Public gRedemptionDllExists As Boolean = False

    Public gPdfExtended As Boolean = True
    Public gActiveListeners As New SortedList(Of String, Boolean)
    Public gListenerActivityStart As Date = Now

    Public gMDIMainLoaded As Boolean = False
    Public gAllLibrariesSet As Boolean = False
    Public gLegalAgree As Boolean = False

    Public gPaginateData As Boolean = False
    Public gItemsPerPage As Integer = 0

    Public gRunUnattended As Boolean = False
    Public gUnattendedErrors As Integer = 0

    Public gNbrOfSeats As Integer = 0
    Public gNbrOfUsers As Integer = 0

    Public gPasswordProtectedDoc As Boolean = False
    Public gDaysToKeepTraceLogs As Integer = 3
    Public gUserConnectionStringConfirmedGood As Boolean = False
    Public gMaxRecordsToFetch As String = ""
    Public gIpAddr As String = ""
    Public gNetworkID As String = ""
    Public gMachineID As String = ""
    Public gOfficeInstalled As Boolean = False
    Public gOffice2007Installed As Boolean = False

    Public gMaxSize As Double = 0

    Public gTerminateImmediately As Boolean = False
    Public gLicenseType = ""
    Public gIsClientOnly As Boolean = False
    Public gIsSDK As Boolean = False
    Public gMaxClients As Integer = 0

    Public gTgtGuid As String = ""

    Public gIsServiceManager As Boolean = False
    Public gEmailsBackedUp As Integer = 0
    Public gEmailsAdded As Integer = 0
    Public bIncludeLibraryFilesInSearch As Boolean = False
    Public bTerminateCrawler As Boolean = False
    Public bEcmCrawlerAvailable As Boolean = False
    Public SystemSqlTimeout As String = ""
    Public gCurrUserGuidID As String = ""
    Public slExcludedEmailAddr As New SortedList
    Public FilesToDelete As New List(Of String)
    Public bRunnner As Boolean = False
    Public slLastEmailArchive As New SortedList
    Public slProcessDates As New SortedList
    Public CF As New SortedList(Of String, String)
    Public globalListOfGuids As New ArrayList
    Public LicList As New SortedList(Of String, String)
    Public NbrSeats As Integer = 0
    Public MinRating As Integer = 0
    Public isAdmin As Boolean = False
    Public isGlobalSearcher As Boolean = False
    Public CurrentScreenName As String = ""
    Public CurrentWidgetName As String = ""
    Public gCurrentArchiveGuid As String = ""
    Public ReformattedSearchString As String = ""
    Public NbrOfErrors = 0
    Public CurrDbName As String = ""
    Public HelpOn As Boolean = False
    Public HelpDuration As Integer = 0
    Public HelpOnTime As Date = Nothing
    Public HelpOffTime As Date = Nothing
    Public CurrEmailQry As String = ""
    Public CurrSearchCriteria As String = ""
    Public bInitialized As Boolean = False
    Public bInetAvailable As Boolean = False

    'Public gThesaurusSearchText As String = ""
    Public gThesauri As New ArrayList

    Public gTempDir As String = ""
    Public gVoiceOn As Boolean = False
    Public gNbrSearches As Integer = 0
    Public gMyContentOnly As Boolean = False
    Public gMasterContentOnly As Boolean = False
    Public gValidated As Boolean = False

    Private _DocLastAccessDate As Date
    Private _DocCreateDate As Date

    Public Sub MYExnHandler(ByVal sender As Object, ByVal e As UnhandledExceptionEventArgs)

        Dim EX As Exception
        EX = e.ExceptionObject
        Dim st As New StackTrace(True)
        st = New StackTrace(EX, True)

        Dim LOG As New clsLogging

        LOG.WriteToArchiveLog("MYExnHandler Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
        LOG.WriteToArchiveLog("EX.Message MYExnHandler: " + EX.Message)
        LOG.WriteToArchiveLog("EX.StackTrace MYExnHandler: " + EX.StackTrace)
        LOG.WriteToArchiveLog("EX.TargetSite MYExnHandler: " & EX.TargetSite.ToString)
        'Log.WriteToArchiveLog("EX.InnerException: " & EX.InnerException.ToString)

        LOG = Nothing

    End Sub

    Public Sub MYThreadHandler(ByVal sender As Object, ByVal e As Threading.ThreadExceptionEventArgs)
        Console.WriteLine(e.Exception.StackTrace)
        Dim st As New StackTrace(True)
        st = New StackTrace(e.Exception, True)

        Dim LOG As New clsLogging

        LOG.WriteToArchiveLog("MYThreadHandlerLine: " & st.GetFrame(0).GetFileLineNumber().ToString)
        LOG.WriteToArchiveLog("MYThreadHandler e.Exception.Message: " + e.Exception.Message)
        LOG.WriteToArchiveLog("MYThreadHandler e.Exception.StackTrace: " + e.Exception.StackTrace)
        LOG.WriteToArchiveLog("MYThreadHandler e.Exception.TargetSite: " & e.Exception.TargetSite.ToString)
        'Log.WriteToArchiveLog("MYThreadHandler e.Exception.InnerException: " & e.Exception.InnerException.ToString)

        LOG = Nothing

    End Sub

    Private Sub setUseDebugSQLite()
        Try
            UseDebugSQLite = System.Configuration.ConfigurationManager.AppSettings("UseDebugSQLite")
        Catch ex As Exception
            UseDebugSQLite = 0
        End Try
    End Sub

    Sub CreateSQLiteDBIfMissing()

        slDatabase = System.Configuration.ConfigurationManager.AppSettings("SQLiteLocalDB")
        OriginalDB = getPublishedSQLiteDBpath()

        Dim tdir As String = Path.GetDirectoryName(slDatabase)
        If Not Directory.Exists(tdir) Then
            Directory.CreateDirectory(tdir)
        End If

        If Not File.Exists(slDatabase) Then
            File.Copy(OriginalDB, slDatabase, False)
        End If


    End Sub

    Public Function getPublishedSQLiteDBpath() As String

        Dim AppPath As String = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().CodeBase)

        Dim aName As String = System.Reflection.Assembly.GetExecutingAssembly.GetModules()(0).FullyQualifiedName
        Dim aPath As String = System.IO.Path.GetDirectoryName(aName)
        Dim files As String() = Directory.GetFiles(aPath, "EcmArchive.db", SearchOption.AllDirectories)
        Dim dbfqn As String = ""

        If files.Length > 0 Then
            For I = 0 To files.Length - 1
                DBName = files(I)
                If DBName.ToUpper().Contains("ECMARCHIVE.DB") Then
                    dbfqn = files(I)
                    Exit For
                End If
            Next
        End If

        If Not File.Exists(dbfqn) Then
            MessageBox.Show("SQLite DB missing, please correct this issue...")
        End If
        Return dbfqn
    End Function



    Function setThesaurusConnStr() As String

        Dim pw As String = System.Configuration.ConfigurationManager.AppSettings("ENCPW")
        pw = ENC.AES256DecryptString(pw)
        Dim CS As String = System.Configuration.ConfigurationManager.AppSettings("ECMThesaurus")
        CS = CS.Replace("@@PW@@", pw)
        Return CS

    End Function


    Public Sub SaveGlobalData(vars As String)
        Try
            Dim filePath As String
            filePath = System.IO.Path.Combine(
                       My.Computer.FileSystem.SpecialDirectories.MyDocuments, "gVars.txt")
            My.Computer.FileSystem.WriteAllText(filePath, vars, False)
        Catch fileException As Exception
            Throw fileException
        End Try
    End Sub

    Public Property gDocLastAccessDate() As Date
        Get
            Return _DocLastAccessDate
        End Get
        Set(ByVal Val As Date)
            _DocLastAccessDate = Val
        End Set

    End Property

    Public Property gDocCreateDate() As Date
        Get
            Return _DocCreateDate
        End Get
        Set(ByVal Val As Date)
            _DocCreateDate = Val
        End Set

    End Property

    Public Function getShortDirName(ByVal tgtDir As String) As String

        Try
            Dim shortName As New StringBuilder(260)
            GetShortPathName(tgtDir, shortName, shortName.Capacity)
            Console.WriteLine(shortName)
            Dim NewName As String = shortName.ToString
            Return NewName
        Catch ex As Exception
            Dim LOG As New clsLogging
            LOG.WriteToArchiveLog("ERROR: Directory name issue - '" + tgtDir + "'." + vbCrLf + ex.Message)
            LOG = Nothing
        End Try
        Return tgtDir
    End Function

    Public Function isGuid(ByVal sGuid As String) As Boolean
        If sGuid.Length > 0 Then
            Dim guidRegEx As New Regex("^(\{{0,1}([0-9a-fA-F]){8}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){12}\}{0,1}) ")
            Return guidRegEx.IsMatch(sGuid)
        End If
        Return False
    End Function

    Public Sub zeroizeExcludedEmailAddr()
        slExcludedEmailAddr.Clear()
    End Sub

    Public Sub AddExcludedEmailAddr(ByVal email As String)
        If slExcludedEmailAddr.IndexOfKey(email) > 0 Then
            Return
        Else
            slExcludedEmailAddr.Add(email, email)
        End If
    End Sub

    Public Function isExcludedEmail(ByVal EmailAddr As String) As Boolean
        If slExcludedEmailAddr.IndexOfKey(EmailAddr) > 0 Then
            Return True
        Else
            Return False
        End If
    End Function

    Sub setLastEmailDate(ByVal FolderName As String, ByVal EmailDate As Date)
        Dim I As Integer = 0
        I = slLastEmailArchive.IndexOfKey(FolderName)
        If I < 0 Then
            slLastEmailArchive.Add(FolderName, EmailDate)
        Else
            Dim DT As Date
            DT = slLastEmailArchive.Item(FolderName)
            If DT > Now Then
                DT = Now
                slLastEmailArchive.Remove(FolderName)
                'slLastEmailArchive.Add(FolderName, EmailDate)
            End If
            If DT < EmailDate Then
                slLastEmailArchive.Remove(FolderName)
                slLastEmailArchive.Add(FolderName, EmailDate)
            End If
        End If
    End Sub

    Function compareEmailProcessDate(ByVal FolderName As String, ByVal EmailDate As Date) As Boolean
        Dim B As Boolean = False
        Dim I As Integer = 0
        I = slProcessDates.IndexOfKey(FolderName)
        If I < 0 Then
            slProcessDates.Add(FolderName, #1/1/1900#)
        Else
            Dim LastProcessDate As Date
            LastProcessDate = slProcessDates.Item(FolderName)
            If LastProcessDate > EmailDate Then
                B = True
            Else
                B = False
            End If
        End If
        Return B
    End Function

    Sub addEmailProcessDate(ByVal FolderName As String, ByVal EmailDate As Date)

        Dim I As Integer = 0
        I = slProcessDates.IndexOfKey(FolderName)
        If I < 0 Then
            slProcessDates.Add(FolderName, EmailDate)
        End If
    End Sub

    Public Sub setCurrDbName()
        Dim dName As String = ""
        Dim bUseConfig As Boolean = True
        Dim S As String = ""
        S = My.Settings("UserDefaultConnString")
        If S.Equals("?") Then
            S = System.Configuration.ConfigurationManager.AppSettings("ECMREPO")
        End If
        S = System.Configuration.ConfigurationManager.AppSettings("ECMREPO")
        'Data Source=SP6000;Initial Catalog=DMA.UD;Integrated Security=True
        Dim A As String() = Split(S, ";")
        For i As Integer = 0 To UBound(A)
            dName = A(i)
            If InStr(1, dName, "Initial Catalog", CompareMethod.Text) > 0 Then
                Dim b As String() = Split(dName, "=")
                If UBound(b) >= 1 Then
                    dName = b(1)
                    Exit For
                End If
            End If
        Next
        Debug.Print("Here for DBARCH name")
        CurrDbName = dName
    End Sub

    Public Sub TurnHelpOn(ByVal duration As Integer)

        HelpOn = True
        HelpDuration = duration

        Dim CurrYear As Integer = Now.Year
        Dim Currday As Integer = Now.Day
        Dim CurrMonth As Integer = Now.Month
        Dim Currhour As Integer = Now.Hour
        Dim CurrMin As Integer = Now.Minute

        If duration = 0 Then
            HelpDuration = 0
        Else
            HelpOffTime = Now.AddMinutes(duration)
        End If

    End Sub

    Public Sub TurnHelpOff()
        'Dim DBARCH As New clsDatabaseARCH
        HelpOn = False
        HelpDuration = 0
        'Dim frm As Form
        'Dim TT As ToolTip = Nothing
        'For Each frm In My.Application.OpenForms
        '    DBARCH.getFormTooltips(frm, TT, False)
        'Next
        'DBARCH = Nothing
        'GC.Collect()
    End Sub

    Public Sub HelpExpired()
        If HelpDuration = 0 Then
            Return
        Else
            If HelpOffTime <= Now Then
                TurnHelpOff()
            End If
        End If
    End Sub

    Sub SetToClipBoard(ByVal sTxt As String)
        Try
            Clipboard.Clear()
            Clipboard.SetText(sTxt)
        Catch ex As Exception
            Console.WriteLine("Failed to clipboard: " + sTxt)
        End Try
    End Sub

    Sub setMsgHeader(ByVal tMsg As String)

        frmMessageBar.lblmsg.Text = tMsg
        frmMessageBar.Refresh()
        Application.DoEvents()
    End Sub

    Sub ShowMsgHeader(ByVal tMsg As String)

        Application.DoEvents()
        frmMessageBar.lblmsg.Text = tMsg
        'frmMessageBar.MdiParent = FrmMDIMain
        frmMessageBar.Show()
        Application.DoEvents()
    End Sub

    Sub CloseMsgHeader()
        frmMessageBar.Close()
        Application.DoEvents()
    End Sub

    Public Function ElapsedTime(ByVal tStart As Date, ByVal tStop As Date) As String
        Dim elapsed_time As TimeSpan
        elapsed_time = tStop.Subtract(tStart)
        Return elapsed_time.TotalSeconds.ToString("00000.000")
    End Function

    Public Function ElapsedTimeSec(ByVal tStart As Date, ByVal tStop As Date) As Integer
        Dim elapsed_time As TimeSpan
        elapsed_time = tStop.Subtract(tStart)
        Return elapsed_time.TotalSeconds
    End Function

    Public Function FlipDateByRegion(ByVal tdate As String) As String

        Dim tLocation As String = System.Globalization.RegionInfo.CurrentRegion.NativeName.ToString
        'Dim tSplitter As String = System.Globalization.Info.DateSeparator

        Dim NewDate As String = Nothing
        Dim sDay As String = Nothing
        Dim sMonth As String = Nothing
        Dim sYear As String = Nothing
        Dim A() As String = Nothing

        'gDateSeparator = Info.DateSeparator
        'gTimeSeparator = Info.TimeSeparator
        'gShortDatePattern = Info.ShortDatePattern
        'gShortTimePattern = Info.ShortTimePattern

        'M/d/yyyy
        If gShortDatePattern.ToUpper = "M/D/YYYY" Then
            NewDate = tdate
        ElseIf gShortDatePattern.ToUpper = "D/M/YYYY" Then
            A = tdate.Split(gDateSeparator)
            sDay = A(0)
            sMonth = A(1)
            sYear = A(2)
            NewDate = sMonth + "/" + sDay + "/" + sYear
        Else
            A = tdate.Split(gDateSeparator)
            sDay = A(0)
            sMonth = A(1)
            sYear = A(2)
            NewDate = sMonth + "/" + sDay + "/" + sYear
        End If
        Return NewDate

    End Function

End Module