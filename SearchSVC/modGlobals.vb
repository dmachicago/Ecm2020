Imports System.Text.RegularExpressions
Imports System.IO
Imports ECMEncryption

Module modGlobals

    Private Declare Function GetShortPathName Lib "kernel32" Alias "GetShortPathNameA" (ByVal longPath As String, ByVal shortPath As String, ByVal shortBufferSize As Int32) As Int32

    Dim ENC As New ECMEncrypt
    Dim LOG As New clsLogging

    Public gWorkingDir = ""
    Public gDecryptedCSRepo As String = ""
    Public gCompanyID As String = ""
    Public gRepoID As String = ""
    Public gSecureID As Integer = -1

    Public gDateSeparator As String = ""
    Public gTimeSeparator As String = ""
    Public gShortDatePattern As String = ""
    Public gShortTimePattern As String = ""

    Public gHiveServersList As New List(Of String)
    Public gHiveEnabled As Boolean = false

    Public gRunMode As String = ""
    Public gClipBoardActive As Boolean = false

    Public gRedemptionDllExists As Boolean = false

    Public gPdfExtended As Boolean = false
    Public gActiveListeners As New SortedList(Of String, Boolean)
    Public gListenerActivityStart As Date = Now

    Public gMDIMainLoaded As Boolean = false
    Public gAllLibrariesSet As Boolean = false
    Public gLegalAgree As Boolean = false

    Public gPaginateData As Boolean = True
    Public gItemsPerPage As Integer = 0

    Public gRunUnattended As Boolean = false
    Public gUnattendedErrors As Integer = 0

    Public gNbrOfSeats As Integer = 0
    Public gNbrOfUsers As Integer = 0

    Public gPasswordProtectedDoc As Boolean = false
    Public gDaysToKeepTraceLogs As Integer = 3
    Public gUserConnectionStringConfirmedGood As Boolean = false
    Public gMaxRecordsToFetch As String = ""
    Public gIpAddr As String = ""
    Public gMachineID As String = ""
    Public gOfficeInstalled As Boolean = false
    Public gOffice2007Installed As Boolean = false

    Public gMaxSize As Double = 0

    Public gTerminateImmediately As Boolean = false
    Public gLicenseType = ""
    Public gIsClientOnly As Boolean = false
    Public gIsSDK As Boolean = false
    Public gMaxClients As Integer = 0

    Public gTgtGuid As String = ""
    Public gCurrLoginID As String = ""
    Public gCurrDomainLoginID As String = ""
    Public gIsServiceManager As Boolean = false
    Public gEmailsBackedUp As Integer = 0
    Public gEmailsAdded As Integer = 0
    Public bIncludeLibraryFilesInSearch As Boolean = false
    Public bTerminateCrawler As Boolean = false
    Public bEcmCrawlerAvailable As Boolean = false
    Public SystemSqlTimeout As String = ""
    Public gCurrUserGuidID As String = ""
    Public slExcludedEmailAddr As New SortedList
    Public FilesToDelete As New List(Of String)
    Public bRunnner As Boolean = false
    Public slLastEmailArchive As New SortedList
    Public slProcessDates As New SortedList(Of String, Date)
    Public CF As New SortedList(Of String, String)
    Public globalListOfGuids As New ArrayList
    Public LicList As New SortedList(Of String, String)
    Public NbrSeats As Integer = 0
    Public MinRating As Integer = 0
    Public gIsAdmin As Boolean = false
    Public gIsGlobalSearcher As Boolean = false
    Public CurrentScreenName As String = ""
    Public CurrentWidgetName As String = ""
    Public gCurrentArchiveGuid As String = ""
    Public ReformattedSearchString As String = ""
    Public NbrOfErrors = 0
    Public CurrDbName As String = ""
    Public HelpOn As Boolean = false
    Public HelpDuration As Integer = 0
    Public HelpOnTime As Date = Nothing
    Public HelpOffTime As Date = Nothing
    Public CurrEmailQry As String = ""
    Public CurrSearchCriteria As String = ""
    Public bInitialized As Boolean = false
    Public bInetAvailable As Boolean = false
    'Public gThesaurusSearchText As String = ""
    Public gThesauri As New ArrayList
    Public gTempDir As String = ""
    Public gVoiceOn As Boolean = false
    Public gNbrSearches As Integer = 0
    Public gMyContentOnly As Boolean = false
    Public gMasterContentOnly As Boolean = false
    Public gValidated As Boolean = False

    Public Function DBgetConnStr() As String

        Dim CS As String = System.Configuration.ConfigurationManager.AppSettings("ECMREPO")
        Dim pw As String = System.Configuration.ConfigurationManager.AppSettings("ENCPW")
        pw = ENC.AES256DecryptString(pw)
        CS = CS.Replace("@@PW@@", pw)

        Return CS
    End Function

    Public Function parseConnStr(cs As String) As String

        Dim pw As String = System.Configuration.ConfigurationManager.AppSettings("ENCPW")
        pw = ENC.AES256DecryptString(pw)
        cs = CS.Replace("@@PW@@", pw)

        Return CS
    End Function

    Public Sub client_ExecuteSqlNewConn(RC As Boolean, S As String)
        If Not RC Then
            Dim ErrSql As String = S
            LOG.WriteToSqlLog("ERROR clsLibEmail 100: " + ErrSql)
        End If
    End Sub

    Public Function getShortDirName(ByVal tgtDir As String) As String
        'The path you want to convert to its short representation path.
        Dim longPathName As String = tgtDir
        'Get the size of the string to pass to the string buffer.
        Dim longPathLength As Int32 = longPathName.Length
        'A string with a buffer to receive the short path from the api call...
        Dim shortPathName As String = Space(longPathLength)
        'Will hold the return value of the api call which should be the length.
        Dim returnValue As Int32
        'Now call the function to do the conversion...
        returnValue = GetShortPathName(longPathName, shortPathName, longPathLength)
        Return returnValue
    End Function

    Public Function isGuid(ByVal sGuid As String) As Boolean
        If sGuid.Length > 0 Then
            Dim guidRegEx As New Regex("^(\{{0,1}([0-9a-fA-F]){8}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){12}\}{0,1})$")
            Return guidRegEx.IsMatch(sGuid)
        End If
        Return false
    End Function

    Public Sub zeroizeExcludedEmailAddr()
        slExcludedEmailAddr.Clear()
    End Sub
    Public Sub AddExcludedEmailAddr(ByVal email as string)
        If slExcludedEmailAddr.IndexOfKey(email) > 0 Then
            Return
        Else
            slExcludedEmailAddr.Add(email, email)
        End If
    End Sub
    Public Function isExcludedEmail(ByVal EmailAddr as string) As Boolean
        If slExcludedEmailAddr.IndexOfKey(EmailAddr) > 0 Then
            Return True
        Else
            Return False
        End If
    End Function
    Sub setLastEmailDate(ByVal FolderName as string, byval EmailDate As Date)
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
    Function compareEmailProcessDate(ByVal FolderName as string, byval EmailDate As Date) As Boolean
        Dim B As Boolean = false
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
                B = false
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
            S = DBgetConnStr
        End If
        S = DBgetConnStr()
        'Data Source=SP6000;Initial Catalog=DMA.UD;Integrated Security=True
        Dim A$() = Split(S, ";")
        For i As Integer = 0 To UBound(A)
            dName = A(i)
            If InStr(1, dName, "Initial Catalog", CompareMethod.Text) > 0 Then
                Dim b$() = Split(dName, "=")
                If UBound(b) >= 1 Then
                    dName = b(1)
                    Exit For
                End If
            End If
        Next
        Debug.Print("Here for db name")
        CurrDbName = dName$
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
        'Dim DB As New clsDatabase
        HelpOn = false
        HelpDuration = 0
        'Dim frm As Form
        'Dim TT As ToolTip = Nothing
        'For Each frm In My.Application.OpenForms
        '    DB.getFormTooltips(frm, TT, false)            
        'Next
        'DB = Nothing
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
    Sub WriteTraceLog(ByVal SecureID As Integer, ByVal msg as string, byval StmtID As Integer)
        Try
            Dim DB As New clsDatabaseSVR
            DB.DBTrace(SecureID, StmtID, "WriteTraceLog", "LOG: " + msg)
            DB = Nothing
            GC.Collect()
        Catch ex As Exception
            Console.WriteLine("ERROR" + msg + vbCrLf + msg)
        End Try
        GC.Collect()
        GC.WaitForFullGCComplete()
    End Sub
    Sub WriteTraceLogBackup(ByVal msg as string)
        '** WDMXX

        Dim TempFolder As String = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData)
        Dim M As String = Now.Month.ToString.Trim
        Dim D As String = Now.Day.ToString.Trim
        Dim Y As String = Now.Year.ToString.Trim

        Dim SerialNo As String = M + "." + D + "." + Y + "."

        Try
            'Dim cPath As String = GetCurrDir()        
            Dim tFQN As String = TempFolder$ + "\EcmTrace.Log." + SerialNo$ + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            Console.WriteLine("Error 154.324.1d: WriteTraceLogBackup: " + vbCrLf + ex.Message)
        End Try
        GC.Collect()
        GC.WaitForFullGCComplete()
    End Sub
    'Sub SetToClipBoard(ByVal sTxt as string)
    '    Try
    '        Clipboard.Clear()
    '        Clipboard.SetText(sTxt as string)
    '    Catch ex As Exception
    '        Console.WriteLine("Failed to clipboard: " + sTxt)
    '    End Try
    'End Sub
    'Sub setMsgHeader(ByVal tMsg as string)
    '    frmMessageBar.lblmsg.Text = tMsg
    '    frmMessageBar.Refresh()
    '    Application.DoEvents()
    'End Sub
    'Sub ShowMsgHeader(ByVal tMsg as string)

    '    'frmMessageBar.Top = frmMessageBar.
    '    'frmMessageBar.Width = frm.Width
    '    'frmMessageBar.Left = frm.Left
    '    Application.DoEvents()
    '    frmMessageBar.lblmsg.Text = tMsg
    '    frmMessageBar.MdiParent = FrmMDIMain
    '    frmMessageBar.Show()
    '    Application.DoEvents()
    'End Sub
    'Sub CloseMsgHeader()
    '    frmMessageBar.Close()
    '    Application.DoEvents()
    'End Sub
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
