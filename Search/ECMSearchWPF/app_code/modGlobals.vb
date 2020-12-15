' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 07-16-2020
'
' Last Modified By : wdale
' Last Modified On : 12-14-2020
' ***********************************************************************
' <copyright file="modGlobals.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' *************************************************************************
Imports System.Text.RegularExpressions
Imports System.IO
Imports ECMEncryption

''' <summary>
''' Class modGlobals.
''' </summary>
Module modGlobals

    ''' <summary>
    ''' Gets the short name of the path.
    ''' </summary>
    ''' <param name="longPath">The long path.</param>
    ''' <param name="shortPath">The short path.</param>
    ''' <param name="shortBufferSize">Short size of the buffer.</param>
    ''' <returns>Int32.</returns>
    Private Declare Function GetShortPathName Lib "kernel32" Alias "GetShortPathNameA" (ByVal longPath As String, ByVal shortPath As String, ByVal shortBufferSize As Int32) As Int32

    ''' <summary>
    ''' The temporary SQL
    ''' </summary>
    Dim tempSql As String = ""


    ''' <summary>
    ''' The en c2
    ''' </summary>
    Dim ENC2 As New ECMEncrypt()

    ''' <summary>
    ''' The b execute SQL h andler
    ''' </summary>
    Public bExecSqlHAndler As Boolean = False

    ''' <summary>
    ''' The g post restore
    ''' </summary>
    Public gPostRestore As Boolean = False
    ''' <summary>
    ''' The g do not overwrite existing file
    ''' </summary>
    Public gDoNotOverwriteExistingFile As Boolean = True
    ''' <summary>
    ''' The g overwrite existing file
    ''' </summary>
    Public gOverwriteExistingFile As Boolean = False
    ''' <summary>
    ''' The g restore to original directory
    ''' </summary>
    Public gRestoreToOriginalDirectory As Boolean = False
    ''' <summary>
    ''' The g restore to my documents
    ''' </summary>
    Public gRestoreToMyDocuments As Boolean = False
    ''' <summary>
    ''' The g create original dir if missing
    ''' </summary>
    Public gCreateOriginalDirIfMissing As Boolean = True

    ''' <summary>
    ''' The hive connection name
    ''' </summary>
    Public HiveConnectionName As String = ""
    ''' <summary>
    ''' The hive active
    ''' </summary>
    Public HiveActive As Boolean = False
    ''' <summary>
    ''' The repo SVR name
    ''' </summary>
    Public RepoSvrName As String = ""

    ''' <summary>
    ''' The g process dates
    ''' </summary>
    Public gProcessDates As New Dictionary(Of String, Date)
    ''' <summary>
    ''' The g system parms
    ''' </summary>
    Public gSystemParms As New Dictionary(Of String, String)
    ''' <summary>
    ''' The g user parms
    ''' </summary>
    Public gUserParms As New Dictionary(Of String, String)
    ''' <summary>
    ''' The g license items
    ''' </summary>
    Public gLicenseItems As New Dictionary(Of String, String)

    ''' <summary>
    ''' The g server instance name
    ''' </summary>
    Public gServerInstanceName As String = ""
    ''' <summary>
    ''' The g server machine name
    ''' </summary>
    Public gServerMachineName As String = ""
    ''' <summary>
    ''' The g server version
    ''' </summary>
    Public gServerVersion As String = ""
    ''' <summary>
    ''' The g logged in user
    ''' </summary>
    Public gLoggedInUser As String = ""
    ''' <summary>
    ''' The g attached machine name
    ''' </summary>
    Public gAttachedMachineName As String = ""
    ''' <summary>
    ''' The g number of registerd machines
    ''' </summary>
    Public gNumberOfRegisterdMachines As Integer = -1
    ''' <summary>
    ''' The g machine exist
    ''' </summary>
    Public gMachineExist As Integer = -1

    ''' <summary>
    ''' The g is lease
    ''' </summary>
    Public gIsLease As Boolean = False

    ''' <summary>
    ''' The g error count
    ''' </summary>
    Public gErrorCount As Integer = 0
    ''' <summary>
    ''' The g date separator
    ''' </summary>
    Public gDateSeparator As String = ""
    ''' <summary>
    ''' The g time separator
    ''' </summary>
    Public gTimeSeparator As String = ""
    ''' <summary>
    ''' The g short date pattern
    ''' </summary>
    Public gShortDatePattern As String = ""
    ''' <summary>
    ''' The g short time pattern
    ''' </summary>
    Public gShortTimePattern As String = ""

    ''' <summary>
    ''' The g hive servers list
    ''' </summary>
    Public gHiveServersList As New List(Of String)
    ''' <summary>
    ''' The g hive enabled
    ''' </summary>
    Public gHiveEnabled As Boolean = False

    ''' <summary>
    ''' The g run mode
    ''' </summary>
    Public gRunMode As String = ""
    ''' <summary>
    ''' The g clip board active
    ''' </summary>
    Public gClipBoardActive As Boolean = False

    ''' <summary>
    ''' The g redemption DLL exists
    ''' </summary>
    Public gRedemptionDllExists As Boolean = False

    ''' <summary>
    ''' The g PDF extended
    ''' </summary>
    Public gPdfExtended As Boolean = False
    ''' <summary>
    ''' The g active listeners
    ''' </summary>
    Public gActiveListeners As New Dictionary(Of String, Boolean)
    ''' <summary>
    ''' The g listener activity start
    ''' </summary>
    Public gListenerActivityStart As Date = Now

    ''' <summary>
    ''' The g MDI main loaded
    ''' </summary>
    Public gMDIMainLoaded As Boolean = False
    ''' <summary>
    ''' The g all libraries set
    ''' </summary>
    Public gAllLibrariesSet As Boolean = False
    ''' <summary>
    ''' The g legal agree
    ''' </summary>
    Public gLegalAgree As Boolean = False

    ''' <summary>
    ''' The g paginate data
    ''' </summary>
    Public gPaginateData As Boolean = True
    ''' <summary>
    ''' The g items per page
    ''' </summary>
    Public gItemsPerPage As Integer = 0

    ''' <summary>
    ''' The g run unattended
    ''' </summary>
    Public gRunUnattended As Boolean = False
    ''' <summary>
    ''' The g unattended errors
    ''' </summary>
    Public gUnattendedErrors As Integer = 0

    ''' <summary>
    ''' The g customer identifier
    ''' </summary>
    Public gCustomerID As String
    ''' <summary>
    ''' The g NBR of seats
    ''' </summary>
    Public gNbrOfSeats As Integer = 0
    ''' <summary>
    ''' The g NBR of users
    ''' </summary>
    Public gNbrOfUsers As Integer = 0
    ''' <summary>
    ''' The g NBR of registered users
    ''' </summary>
    Public gNbrOfRegisteredUsers As Integer = 0

    ''' <summary>
    ''' The g password protected document
    ''' </summary>
    Public gPasswordProtectedDoc As Boolean = False
    ''' <summary>
    ''' The g days to keep trace logs
    ''' </summary>
    Public gDaysToKeepTraceLogs As Integer = 3
    ''' <summary>
    ''' The g user connection string confirmed good
    ''' </summary>
    Public gUserConnectionStringConfirmedGood As Boolean = False
    ''' <summary>
    ''' The g maximum records to fetch
    ''' </summary>
    Public gMaxRecordsToFetch As String = "60"
    ''' <summary>
    ''' The g ip addr
    ''' </summary>
    Public gIpAddr As String = ""
    ''' <summary>
    ''' The g machine identifier
    ''' </summary>
    Public gMachineID As String = ""
    ''' <summary>
    ''' The g local machine ip
    ''' </summary>
    Public gLocalMachineIP As String = ""
    ''' <summary>
    ''' The g office installed
    ''' </summary>
    Public gOfficeInstalled As Boolean = False
    ''' <summary>
    ''' The g office2007 installed
    ''' </summary>
    Public gOffice2007Installed As Boolean = False

    ''' <summary>
    ''' The g maximum size
    ''' </summary>
    Public gMaxSize As Double = 0
    ''' <summary>
    ''' The g curr database size
    ''' </summary>
    Public gCurrDbSize As Double = 0
    ''' <summary>
    ''' The g expiration date
    ''' </summary>
    Public gExpirationDate As Date = Nothing
    ''' <summary>
    ''' The g maint expire
    ''' </summary>
    Public gMaintExpire As Date = Nothing
    ''' <summary>
    ''' The g enc license
    ''' </summary>
    Public gEncLicense As String = ""
    ''' <summary>
    ''' The g is license valid
    ''' </summary>
    Public gIsLicenseValid As Boolean = Nothing
    ''' <summary>
    ''' The g server value text
    ''' </summary>
    Public gServerValText As String = ""
    ''' <summary>
    ''' The g instance value text
    ''' </summary>
    Public gInstanceValText As String = ""

    ''' <summary>
    ''' The g terminate immediately
    ''' </summary>
    Public gTerminateImmediately As Boolean = False
    ''' <summary>
    ''' The g license type
    ''' </summary>
    Public gLicenseType = ""
    ''' <summary>
    ''' The g is client only
    ''' </summary>
    Public gIsClientOnly As Boolean = False
    ''' <summary>
    ''' The g is SDK
    ''' </summary>
    Public gIsSDK As Boolean = False
    ''' <summary>
    ''' The g maximum clients
    ''' </summary>
    Public gMaxClients As Integer = 0

    ''' <summary>
    ''' The g TGT unique identifier
    ''' </summary>
    Public gTgtGuid As String = ""
    ''' <summary>
    ''' The g curr login identifier
    ''' </summary>
    Public gCurrLoginID As String = ""
    ''' <summary>
    ''' The g curr domain login identifier
    ''' </summary>
    Public gCurrDomainLoginID As String = ""
    ''' <summary>
    ''' The g is service manager
    ''' </summary>
    Public gIsServiceManager As Boolean = False
    ''' <summary>
    ''' The g emails backed up
    ''' </summary>
    Public gEmailsBackedUp As Integer = 0
    ''' <summary>
    ''' The g emails added
    ''' </summary>
    Public gEmailsAdded As Integer = 0
    ''' <summary>
    ''' The b include library files in search
    ''' </summary>
    Public bIncludeLibraryFilesInSearch As Boolean = False
    ''' <summary>
    ''' The b terminate crawler
    ''' </summary>
    Public bTerminateCrawler As Boolean = False
    ''' <summary>
    ''' The b ecm crawler available
    ''' </summary>
    Public bEcmCrawlerAvailable As Boolean = False
    ''' <summary>
    ''' The system SQL timeout
    ''' </summary>
    Public SystemSqlTimeout$ = ""
    ''' <summary>
    ''' The g curr user unique identifier identifier
    ''' </summary>
    Public gCurrUserGuidID As String = ""
    ''' <summary>
    ''' The sl excluded email addr
    ''' </summary>
    Public slExcludedEmailAddr As New Dictionary(Of String, String)
    ''' <summary>
    ''' The files to delete
    ''' </summary>
    Public FilesToDelete As New List(Of String)
    ''' <summary>
    ''' The b runnner
    ''' </summary>
    Public bRunnner As Boolean = False
    ''' <summary>
    ''' The sl last email archive
    ''' </summary>
    Public slLastEmailArchive As New Dictionary(Of String, String)
    ''' <summary>
    ''' The sl process dates
    ''' </summary>
    Public slProcessDates As New Dictionary(Of String, String)
    ''' <summary>
    ''' The cf
    ''' </summary>
    Public CF As New Dictionary(Of String, String)
    ''' <summary>
    ''' The global list of guids
    ''' </summary>
    Public globalListOfGuids As New List(Of String)
    ''' <summary>
    ''' The lic list
    ''' </summary>
    Public LicList As New Dictionary(Of String, String)
    ''' <summary>
    ''' The NBR seats
    ''' </summary>
    Public NbrSeats As Integer = 0
    ''' <summary>
    ''' The minimum rating
    ''' </summary>
    Public MinRating As Integer = 0
    ''' <summary>
    ''' The g is admin
    ''' </summary>
    Public gIsAdmin As Boolean = False
    ''' <summary>
    ''' The g is global searcher
    ''' </summary>
    Public gIsGlobalSearcher As Boolean = False
    ''' <summary>
    ''' The current screen name
    ''' </summary>
    Public CurrentScreenName$ = ""
    ''' <summary>
    ''' The current widget name
    ''' </summary>
    Public CurrentWidgetName$ = ""
    ''' <summary>
    ''' The g current archive unique identifier
    ''' </summary>
    Public gCurrentArchiveGuid$ = ""
    ''' <summary>
    ''' The reformatted search string
    ''' </summary>
    Public ReformattedSearchString$ = ""
    ''' <summary>
    ''' The NBR of errors
    ''' </summary>
    Public NbrOfErrors = 0
    ''' <summary>
    ''' The curr database name
    ''' </summary>
    Public CurrDbName As String = ""
    ''' <summary>
    ''' The help on
    ''' </summary>
    Public HelpOn As Boolean = False
    ''' <summary>
    ''' The help duration
    ''' </summary>
    Public HelpDuration As Integer = 0
    ''' <summary>
    ''' The help on time
    ''' </summary>
    Public HelpOnTime As Date = Nothing
    ''' <summary>
    ''' The help off time
    ''' </summary>
    Public HelpOffTime As Date = Nothing
    ''' <summary>
    ''' The curr email qry
    ''' </summary>
    Public CurrEmailQry$ = ""
    ''' <summary>
    ''' The curr search criteria
    ''' </summary>
    Public CurrSearchCriteria$ = ""
    ''' <summary>
    ''' The b initialized
    ''' </summary>
    Public bInitialized As Boolean = False
    ''' <summary>
    ''' The b inet available
    ''' </summary>
    Public bInetAvailable As Boolean = False
    'Public gThesaurusSearchText As String = ""
    ''' <summary>
    ''' The g thesauri
    ''' </summary>
    Public gThesauri As New List(Of String)
    ''' <summary>
    ''' The g temporary dir
    ''' </summary>
    Public gTempDir As String = ""
    ''' <summary>
    ''' The g voice on
    ''' </summary>
    Public gVoiceOn As Boolean = False
    ''' <summary>
    ''' The g NBR searches
    ''' </summary>
    Public gNbrSearches As Integer = 0
    ''' <summary>
    ''' The g my content only
    ''' </summary>
    Public gMyContentOnly As Boolean = False
    ''' <summary>
    ''' The g master content only
    ''' </summary>
    Public gMasterContentOnly As Boolean = False
    ''' <summary>
    ''' The g validated
    ''' </summary>
    Public gValidated As Boolean = False

    ''' <summary>
    ''' The curr secure identifier
    ''' </summary>
    Dim CurrSecureID As Integer = -1

    ''' <summary>
    ''' Gets the short name of the dir.
    ''' </summary>
    ''' <param name="tgtDir">The TGT dir.</param>
    ''' <returns>System.String.</returns>
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

    ''' <summary>
    ''' Determines whether the specified s unique identifier is unique identifier.
    ''' </summary>
    ''' <param name="sGuid">The s unique identifier.</param>
    ''' <returns><c>true</c> if the specified s unique identifier is unique identifier; otherwise, <c>false</c>.</returns>
    Public Function isGuid(ByVal sGuid As String) As Boolean
        If sGuid.Length > 0 Then
            Dim guidRegEx As New Regex("^(\{{0,1}([0-9a-fA-F]){8}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){12}\}{0,1})$")
            Return guidRegEx.IsMatch(sGuid)
        End If
        Return False
    End Function

    ''' <summary>
    ''' Zeroizes the excluded email addr.
    ''' </summary>
    Public Sub zeroizeExcludedEmailAddr()
        slExcludedEmailAddr.Clear()
    End Sub

    ''' <summary>
    ''' Adds the excluded email addr.
    ''' </summary>
    ''' <param name="email">The email.</param>
    Public Sub AddExcludedEmailAddr(ByVal email As String)
        If slExcludedEmailAddr.ContainsKey(email) Then
            Return
        Else
            slExcludedEmailAddr.Add(email, email)
        End If
    End Sub
    ''' <summary>
    ''' Determines whether [is excluded email] [the specified email addr].
    ''' </summary>
    ''' <param name="EmailAddr">The email addr.</param>
    ''' <returns><c>true</c> if [is excluded email] [the specified email addr]; otherwise, <c>false</c>.</returns>
    Public Function isExcludedEmail(ByVal EmailAddr As String) As Boolean
        If slExcludedEmailAddr.ContainsKey(EmailAddr) Then
            Return True
        Else
            Return False
        End If
    End Function
    ''' <summary>
    ''' Sets the last email date.
    ''' </summary>
    ''' <param name="FolderName">Name of the folder.</param>
    ''' <param name="EmailDate">The email date.</param>
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
    ''' <summary>
    ''' Compares the email process date.
    ''' </summary>
    ''' <param name="FolderName">Name of the folder.</param>
    ''' <param name="EmailDate">The email date.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
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
    ''' <summary>
    ''' Adds the email process date.
    ''' </summary>
    ''' <param name="FolderName">Name of the folder.</param>
    ''' <param name="EmailDate">The email date.</param>
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
    ''' <summary>
    ''' Turns the help on.
    ''' </summary>
    ''' <param name="duration">The duration.</param>
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
    ''' <summary>
    ''' Turns the help off.
    ''' </summary>
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
    ''' <summary>
    ''' Helps the expired.
    ''' </summary>
    Public Sub HelpExpired()
        If HelpDuration = 0 Then
            Return
        Else
            If HelpOffTime <= Now Then
                TurnHelpOff()
            End If
        End If
    End Sub
    ''' <summary>
    ''' Writes the trace log x.
    ''' </summary>
    ''' <param name="msg">The MSG.</param>
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
    ''' <summary>
    ''' Writes the trace log backup x.
    ''' </summary>
    ''' <param name="msg">The MSG.</param>
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
    ''' <summary>
    ''' Elapseds the time.
    ''' </summary>
    ''' <param name="tStart">The t start.</param>
    ''' <param name="tStop">The t stop.</param>
    ''' <returns>System.String.</returns>
    Public Function ElapsedTime(ByVal tStart As Date, ByVal tStop As Date) As String
        Dim elapsed_time As TimeSpan
        elapsed_time = tStop.Subtract(tStart)
        Return elapsed_time.TotalSeconds.ToString("00000.000")
    End Function
    ''' <summary>
    ''' Elapseds the time sec.
    ''' </summary>
    ''' <param name="tStart">The t start.</param>
    ''' <param name="tStop">The t stop.</param>
    ''' <returns>System.Int32.</returns>
    Public Function ElapsedTimeSec(ByVal tStart As Date, ByVal tStop As Date) As Integer
        Dim elapsed_time As TimeSpan
        elapsed_time = tStop.Subtract(tStart)
        Return elapsed_time.TotalSeconds
    End Function

    ''' <summary>
    ''' Flips the date by region.
    ''' </summary>
    ''' <param name="tdate">The tdate.</param>
    ''' <returns>System.String.</returns>
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

    ''' <summary>
    ''' Determines whether [is numeric dma] [the specified value].
    ''' </summary>
    ''' <param name="value">The value.</param>
    ''' <returns><c>true</c> if [is numeric dma] [the specified value]; otherwise, <c>false</c>.</returns>
    Public Function isNumericDma(ByVal value As String) As Boolean
        Dim number As Integer
        Dim result As Boolean = Int32.TryParse(value, number)
        If result Then
            Return True
        Else
            Return False
        End If
    End Function

    ''' <summary>
    ''' Mids the x.
    ''' </summary>
    ''' <param name="tgtString">The TGT string.</param>
    ''' <param name="I">The i.</param>
    ''' <param name="ReplaceChar">The replace character.</param>
    ''' <returns>System.String.</returns>
    Function MidX(ByVal tgtString As String, ByVal I As Integer, ByVal ReplaceChar As String) As String
        Dim S1 As String = ""
        Dim S2 As String = ""
        S1 = tgtString.Substring(1, I - 1)
        S2 = tgtString.Substring(I + 1)
        S1 = S1 + ReplaceChar + S2
        Return S1
    End Function

    ''' <summary>
    ''' Gets the system parm.
    ''' </summary>
    ''' <param name="sysParmName">Name of the system parm.</param>
    ''' <returns>System.String.</returns>
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

    ''' <summary>
    ''' gs the elapsed time.
    ''' </summary>
    ''' <param name="dStart">The d start.</param>
    ''' <param name="dEnd">The d end.</param>
    ''' <returns>System.String.</returns>
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

    ''' <summary>
    ''' Executes the SQL.
    ''' </summary>
    ''' <param name="gSecureID">The g secure identifier.</param>
    ''' <param name="Mysql">The mysql.</param>
    Sub ExecuteSql(ByRef gSecureID As String, ByVal Mysql As String)
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

    ''' <summary>
    ''' Clients the execute SQL.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="S">The s.</param>
    Sub client_ExecuteSql(RC As Boolean, S As String)
        If RC Then
        Else
            gErrorCount += 1
            Dim LOG As New clsLogMain
            LOG.WriteToSqlLog("ERROR 100.99.1 ExecuteSql: " + S)
            LOG = Nothing
        End If
    End Sub

    ''' <summary>
    ''' Sets the search SVC end point.
    ''' </summary>
    ''' <param name="proxy">The proxy.</param>
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

