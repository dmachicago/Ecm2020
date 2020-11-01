Imports System.Text.RegularExpressions
Imports System.IO
Imports ECMEncryption

Module modGlobals

    Private Declare Function GetShortPathName Lib "kernel32" Alias "GetShortPathNameA" (ByVal longPath As String, ByVal shortPath As String, ByVal shortBufferSize As Int32) As Int32

    Dim tempSql As String = ""

    
    Dim ENC2 As New ECMEncrypt()

    Public bExecSqlHAndler As Boolean = False

    Public gPostRestore As Boolean = False
    Public gDoNotOverwriteExistingFile As Boolean = True
    Public gOverwriteExistingFile As Boolean = False
    Public gRestoreToOriginalDirectory As Boolean = False
    Public gRestoreToMyDocuments As Boolean = False
    Public gCreateOriginalDirIfMissing As Boolean = True

    Public HiveConnectionName As String = ""
    Public HiveActive As Boolean = False
    Public RepoSvrName As String = ""

    Public gProcessDates As New Dictionary(Of String, Date)
    Public gSystemParms As New Dictionary(Of String, String)
    Public gUserParms As New Dictionary(Of String, String)
    Public gLicenseItems As New Dictionary(Of String, String)

    Public gServerInstanceName As String = ""
    Public gServerMachineName As String = ""
    Public gServerVersion As String = ""
    Public gLoggedInUser As String = ""
    Public gAttachedMachineName As String = ""
    Public gNumberOfRegisterdMachines As Integer = -1
    Public gMachineExist As Integer = -1

    Public gIsLease As Boolean = False

    Public gErrorCount As Integer = 0
    Public gDateSeparator As String = ""
    Public gTimeSeparator As String = ""
    Public gShortDatePattern As String = ""
    Public gShortTimePattern As String = ""

    Public gHiveServersList As New List(Of String)
    Public gHiveEnabled As Boolean = False

    Public gRunMode As String = ""
    Public gClipBoardActive As Boolean = False

    Public gRedemptionDllExists As Boolean = False

    Public gPdfExtended As Boolean = False
    Public gActiveListeners As New Dictionary(Of String, Boolean)
    Public gListenerActivityStart As Date = Now

    Public gMDIMainLoaded As Boolean = False
    Public gAllLibrariesSet As Boolean = False
    Public gLegalAgree As Boolean = False

    Public gPaginateData As Boolean = True
    Public gItemsPerPage As Integer = 0

    Public gRunUnattended As Boolean = False
    Public gUnattendedErrors As Integer = 0

    Public gCustomerID As String
    Public gNbrOfSeats As Integer = 0
    Public gNbrOfUsers As Integer = 0
    Public gNbrOfRegisteredUsers As Integer = 0

    Public gPasswordProtectedDoc As Boolean = False
    Public gDaysToKeepTraceLogs As Integer = 3
    Public gUserConnectionStringConfirmedGood As Boolean = False
    Public gMaxRecordsToFetch As String = "60"
    Public gIpAddr As String = ""
    Public gMachineID As String = ""
    Public gLocalMachineIP As String = ""
    Public gOfficeInstalled As Boolean = False
    Public gOffice2007Installed As Boolean = False

    Public gMaxSize As Double = 0
    Public gCurrDbSize As Double = 0
    Public gExpirationDate As Date = Nothing
    Public gMaintExpire As Date = Nothing
    Public gEncLicense As String = ""
    Public gIsLicenseValid As Boolean = Nothing
    Public gServerValText As String = ""
    Public gInstanceValText As String = ""

    Public gTerminateImmediately As Boolean = False
    Public gLicenseType = ""
    Public gIsClientOnly As Boolean = False
    Public gIsSDK As Boolean = False
    Public gMaxClients As Integer = 0

    Public gTgtGuid As String = ""
    Public gCurrLoginID As String = ""
    Public gCurrDomainLoginID As String = ""
    Public gIsServiceManager As Boolean = False
    Public gEmailsBackedUp As Integer = 0
    Public gEmailsAdded As Integer = 0
    Public bIncludeLibraryFilesInSearch As Boolean = False
    Public bTerminateCrawler As Boolean = False
    Public bEcmCrawlerAvailable As Boolean = False
    Public SystemSqlTimeout$ = ""
    Public gCurrUserGuidID As String = ""
    Public slExcludedEmailAddr As New Dictionary(Of String, String)
    Public FilesToDelete As New List(Of String)
    Public bRunnner As Boolean = False
    Public slLastEmailArchive As New Dictionary(Of String, String)
    Public slProcessDates As New Dictionary(Of String, String)
    Public CF As New Dictionary(Of String, String)
    Public globalListOfGuids As New List(Of String)
    Public LicList As New Dictionary(Of String, String)
    Public NbrSeats As Integer = 0
    Public MinRating As Integer = 0
    Public gIsAdmin As Boolean = False
    Public gIsGlobalSearcher As Boolean = False
    Public CurrentScreenName$ = ""
    Public CurrentWidgetName$ = ""
    Public gCurrentArchiveGuid$ = ""
    Public ReformattedSearchString$ = ""
    Public NbrOfErrors = 0
    Public CurrDbName As String = ""
    Public HelpOn As Boolean = False
    Public HelpDuration As Integer = 0
    Public HelpOnTime As Date = Nothing
    Public HelpOffTime As Date = Nothing
    Public CurrEmailQry$ = ""
    Public CurrSearchCriteria$ = ""
    Public bInitialized As Boolean = False
    Public bInetAvailable As Boolean = False
    'Public gThesaurusSearchText As String = ""
    Public gThesauri As New List(Of String)
    Public gTempDir As String = ""
    Public gVoiceOn As Boolean = False
    Public gNbrSearches As Integer = 0
    Public gMyContentOnly As Boolean = False
    Public gMasterContentOnly As Boolean = False
    Public gValidated As Boolean = False

    Dim CurrSecureID As Integer = -1

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
        Return False
    End Function

    Public Sub zeroizeExcludedEmailAddr()
        slExcludedEmailAddr.Clear()
    End Sub

    Public Sub AddExcludedEmailAddr(ByVal email As String)
        If slExcludedEmailAddr.ContainsKey(email) Then
            Return
        Else
            slExcludedEmailAddr.Add(email, email)
        End If
    End Sub
    Public Function isExcludedEmail(ByVal EmailAddr As String) As Boolean
        If slExcludedEmailAddr.ContainsKey(EmailAddr) Then
            Return True
        Else
            Return False
        End If
    End Function
    Sub setLastEmailDate(ByVal FolderName As String, ByVal EmailDate As Date)
        Dim B As Boolean = False
        B = slLastEmailArchive.ContainsKey(FolderName)
        If Not B Then
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
        Dim I As Boolean = False
        I = slProcessDates.ContainsKey(FolderName)
        If Not I Then
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

        Dim B As Boolean = False
        B = slProcessDates.ContainsKey(FolderName)
        If Not B Then
            slProcessDates.Add(FolderName, EmailDate)
        End If
    End Sub
    'Public Sub setCurrDbName()
    '    Dim dName$ = ""
    '    Dim bUseConfig As Boolean = True
    '    Dim S as string = ""
    '    S = My.Settings("UserDefaultConnString")
    '    If S.Equals("?") Then
    '        S = System.Configuration.ConfigurationManager.AppSettings("CONN_DMA.DB")
    '    End If
    '    S = System.Configuration.ConfigurationManager.AppSettings("CONN_DMA.DB")
    '    'Data Source=SP6000;Initial Catalog=DMA.UD;Integrated Security=True
    '    Dim A$() = Split(S, ";")
    '    For i As Integer = 0 To UBound(A  )
    '        dName = A(i)
    '        If InStr(1, dName, "Initial Catalog", CompareMethod.Text) > 0 Then
    '            Dim b$() = Split(dName, "=")
    '            If UBound(b) >= 1 Then
    '                dName$ = b(1)
    '                Exit For
    '            End If
    '        End If
    '    Next
    '    Debug.Print("Here for db name")
    '    CurrDbName = dName$
    'End Sub
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
        HelpOn = False
        HelpDuration = 0
        'Dim frm As Form
        'Dim TT As ToolTip = Nothing
        'For Each frm In My.Application.OpenForms
        '    DB.getFormTooltips(frm, TT, False)            
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
    Sub WriteTraceLogX(ByVal msg As String)
        Try
            'Dim cPath As String = getTempEnvironDir()
            'Dim tFQN$ = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

            'Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
            Dim M$ = Now.Month.ToString.Trim
            Dim D$ = Now.Day.ToString.Trim
            Dim Y$ = Now.Year.ToString.Trim

            Dim SerialNo$ = M + "." + D + "." + Y + "."

            Dim tFQN$ = gTempDir + "\ECMLibrary.MstrTrace." + SerialNo$ + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            '
        End Try
        GC.Collect()

    End Sub
    Sub WriteTraceLogBackupX(ByVal msg As String)
        '** WDMXX

        Dim TempFolder$ = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData)
        Dim M$ = Now.Month.ToString.Trim
        Dim D$ = Now.Day.ToString.Trim
        Dim Y$ = Now.Year.ToString.Trim

        Dim SerialNo$ = M + "." + D + "." + Y + "."

        Try
            'Dim cPath As String = GetCurrDir()        
            Dim tFQN$ = TempFolder$ + "\EcmTrace.Log." + SerialNo$ + "txt"
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

    End Sub
    'Sub SetToClipBoard(ByVal sTxt as string)
    '    Try
    '        Clipboard.Clear()
    '        Clipboard.SetText(sTxt )
    '    Catch ex As Exception
    '        Console.WriteLine("Failed to clipboard: " + sTxt)
    '    End Try
    'End Sub
    'Sub setMsgHeader(ByVal tMsg )
    '    frmMessageBar.lblmsg.Text = tMsg
    '    frmMessageBar.Refresh()
    '    Application.DoEvents()
    'End Sub
    'Sub ShowMsgHeader(ByVal tMsg )

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

    Public Function isNumericDma(ByVal value As String) As Boolean
        Dim number As Integer
        Dim result As Boolean = Int32.TryParse(value, number)
        If result Then
            Return True
        Else
            Return False
        End If
    End Function

    Function MidX(ByVal tgtString As String, ByVal I As Integer, ByVal ReplaceChar As String) As String
        Dim S1 As String = ""
        Dim S2 As String = ""
        S1 = tgtString.Substring(1, I - 1)
        S2 = tgtString.Substring(I + 1)
        S1 = S1 + ReplaceChar + S2
        Return S1
    End Function

    Function getSystemParm(ByVal sysParmName As String) As String
        Dim i As Integer = gSystemParms.Count
        If i = 0 Then
            Return ""
        End If
        Dim tVal As String = ""

        If gSystemParms.ContainsKey(sysParmName) Then
            tVal = gSystemParms.Item(sysParmName)
        Else
            tVal = ""
        End If
        Return tVal
    End Function

    Function gElapsedTime(ByVal dStart As DateTime, ByVal dEnd As DateTime) As String
        Dim timeDiff As String = ""
        Dim sDateFrom As String = dStart
        Dim sDateTo As String = Now
        Try
            If DateTime.TryParse(sDateFrom, dStart) AndAlso DateTime.TryParse(sDateTo, dEnd) Then
                Dim TS As TimeSpan = dEnd - dStart
                Dim hour As Integer = TS.Hours
                Dim mins As Integer = TS.Minutes
                Dim secs As Integer = TS.Seconds
                Dim ms As Integer = TS.Milliseconds
                timeDiff = ((hour.ToString("00") & ":") + mins.ToString("00") & ":") + secs.ToString("00") + "." + Mid(ms.ToString, 1, 3)
            End If
        Catch ex As Exception
            Console.WriteLine("ERROR ElapsedTime: " + ex.Message)
        End Try

        Return timeDiff
    End Function

    Sub ExecuteSql(ByRef gSecureID As string, ByVal Mysql As String)
        CurrSecureID = gSecureID
        tempSql = Mysql
        'Dim proxy As New SVCSearch.Service1Client

        If Not bExecSqlHAndler Then
            'AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteSql
            setSearchSvcEndPoint(ProxySearch)
            bExecSqlHAndler = True
        End If
        Mysql = ENC2.AES256EncryptString(Mysql)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(gSecureID, Mysql, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(Mysql))

    End Sub

    Sub client_ExecuteSql(RC As Boolean, S As String)
        If RC Then
        Else
            gErrorCount += 1
            Dim LOG As New clsLogMain
            LOG.WriteToSqlLog("ERROR 100.99.1 ExecuteSql: " + S)
            LOG = Nothing
        End If
    End Sub

    Private Sub setSearchSvcEndPoint(ByRef proxy As SVCSearch.Service1Client)

        If (SearchEndPoint.Length = 0) Then
            Return
        End If

        Dim ServiceUri As New Uri(SearchEndPoint)
        Dim EPA As New System.ServiceModel.EndpointAddress(ServiceUri)

        ProxySearch.Endpoint.Address = EPA
        GC.Collect()
        GC.WaitForPendingFinalizers()
    End Sub
End Module

