#Const RemoteOcr = 0
'** This constant, EnableSingleSource, currently DISABLES the
'** Single Source capability until we can figure out exactly
'** how to incorporate it into a search.

'#Const Office2007 = 0f
'Imports Microsoft.Office.Interop.Outlook.ApplicationClass
Imports System.Data.SqlClient
Imports System.IO
Imports System.Reflection
Imports System.Threading
Imports ECMEncryption
Imports Outlook = Microsoft.Office.Interop.Outlook
Imports System.Diagnostics

''' <summary>
''' This service runs in background and archives selected emails to a common archive database. The
''' database is a SQL Server DBARCH and allows for full text search of archived emails.
''' </summary>
''' <remarks></remarks>
Public Class clsArchiver
    Inherits clsDatabaseARCH

    Dim ENC As New ECMEncrypt
    Dim ISO As New clsIsolatedStorage
    Dim RSS As New clsRSS
    Dim LOG As New clsLogging
    Dim COMP As New clsCompression
    Dim UTIL As New clsUtility
    Dim GE As New clsGlobalEntity

    Dim WorkingDir As String = System.Configuration.ConfigurationManager.AppSettings("WEBProcessingDir")

    '**WDM Dim PDF As New clsPdfAnalyzer
    'Dim Proxy As New SVCCLCArchive.Service1Client

    Dim DBLocal As New clsDbLocal
    Public EmailLibrary As String = ""
    Dim bAddThisFileAsNewVersion As Boolean = False
    Dim ChildFoldersList As New SortedList(Of String, String)
    Dim TotalFilesArchived As Integer = 0

    Private Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" _
            (ByVal hwnd As Long,
            ByVal lpOperation As String,
            ByVal lpFile As String,
            ByVal lpParameters As String,
            ByVal lpDirectory As String,
            ByVal nShowCmd As Long) As Long

    Public xDebug As Boolean = False

    Private Declare Function GetDesktopWindow Lib "user32" () As Long

    Public IncludedTypes As New ArrayList
    Public ExcludedTypes As New ArrayList
    Public ZipFiles As New ArrayList
    Dim FilesBackedUp As Integer = 0
    Dim FilesSkipped As Integer = 0

    Dim MP3 As New clsMP3

    Dim DGV As New clsDataGrid

    'Dim KAT As New clsChilKat
    ' Create Outlook application.
    'Dim xDebug As Boolean = False
    Dim EMF As New clsEMAILFOLDER

    Dim EM2D As New clsEMAILTODELETE
    Dim FQN As String = "YourPath"
    Dim folderCount, fileCount As Integer
    Dim ATYPE As New clsATTACHMENTTYPE
    Dim QDIR As New clsQUICKDIRECTORY
    Dim UNASGND As New clsAVAILFILETYPESUNDEFINED
    Dim SRCATTR As New clsSOURCEATTRIBUTE
    Dim ZF As New clsZipFiles
    'Dim DBARCH As New clsDatabaseARCH

    Dim bParseDir As Boolean = False
    Dim DirToParse As String = ""

    'Dim Redeem As New clsRedeem
    Dim ParseArchiveFolder As String = ""

    Dim ArchiveSentMail As String = ""
    Dim ArchiveInbox As String = ""

    Dim MaxDaysBeforeArchive As Integer = 0
    Dim EMAIL As New clsEMAIL
    Dim RECIPS As New clsRECIPIENTS
    Dim DMA As New clsDma
    Dim CNTCT As New clsCONTACTSARCHIVE

    Dim SL As New SortedList
    Dim SL2 As New SortedList

    Public g_nspNameSpace As Outlook.NameSpace
    Public g_olApp As Outlook.Application

    Dim OcrTextBack As String = ""
    Dim OcrText As String = ""

    Sub New()

        Dim sDebug As String = getUserParm("debug_clsArchive")
        If sDebug.Equals("1") Then
            xDebug = True
        Else
            xDebug = False
        End If

    End Sub

    Public Sub setChildFoldersList(ByVal CFL As SortedList(Of String, String))
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        For Each sKey As String In CFL.Keys
            ChildFoldersList.Add(sKey, sKey)
        Next

    End Sub

    'Public Sub xArchiveStart(ByVal T As Timer)
    '    ' Add code here to start your service. This method should set things
    '    ' in motion so your service can do its work.

    ' '** Get the polling interval Dim PollingInterval As Integer =
    ' Val(System.Configuration.ConfigurationManager.AppSettings("PollIntervalMinutes")) '** Convert
    ' the MINUTES to Milliseconds. T.Interval = PollingInterval * 60000

    'End Sub
    Function RestoreFolderExists(ByVal CurrFolder As Outlook.MAPIFolder) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim FolderKeyName As String = ""
        ' Dim SubFolder As Outlook.MAPIFolder = olfolder
        Dim II As Integer = CurrFolder.Items.Count
        Dim JJ As Integer = CurrFolder.Folders.Count

        If JJ > 0 Then
            If xDebug Then LOG.WriteToArchiveLog(CurrFolder.Name)
            If xDebug Then LOG.WriteToArchiveLog(CurrFolder.Items.Count)
            If xDebug Then LOG.WriteToArchiveLog(CurrFolder.Folders.Count)
            'FolderKeyName  = FolderKeyName  + CurrFolder.Name
            FolderKeyName = CurrFolder.Name
            For I As Integer = 1 To JJ
                Dim tFolder As Outlook.MAPIFolder = CurrFolder.Folders.Item(I)
                If FolderKeyName.Equals(tFolder.Name) Then
                    Return True
                End If
            Next
            ' ProcessAllFolders(CurrFolder)
        End If
        Return False
    End Function

    Sub ProcessAllFolders(ByVal UID As String, ByVal TopFolderName As String,
                          ByVal CurrFolder As Outlook.MAPIFolder,
                          ByVal DeleteFile As Boolean,
                          ByVal ArchiveEmails As String,
                           ByVal RemoveAfterArchive As String,
                           ByVal SetAsDefaultFolder As String,
                           ByVal ArchiveAfterXDays As String,
                           ByVal RemoveAfterXDays As String,
                           ByVal RemoveXDays As String,
                           ByVal ArchiveXDays As String,
                           ByVal DB_ID As String,
                           ByVal UserID As String,
                           ByVal ArchiveOnlyIfRead As String,
                           ByVal RetentionYears As Integer,
                           ByVal RetentionCode As String,
                           ByVal ProcessingPstFile As Boolean,
                           ByVal PstFQN As String,
                           ByVal ParentFolderID As String, ByVal slStoreId As SortedList, ByVal ispublic As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Static FolderKeyName As String
        Dim StoreID As String = CurrFolder.StoreID

        ' Dim SubFolder As Outlook.MAPIFolder = olfolder
        Dim II As Integer = CurrFolder.Items.Count
        Dim JJ As Integer = CurrFolder.Folders.Count

        'Dim oApp As New Outlook.Application
        'Dim oNS As Outlook.NameSpace = oApp.GetNamespace("mapi")
        'Dim oTgtFolder As Outlook.MAPIFolder = oNS.Folders("Personal Folder").

        If JJ > 0 Then
            If xDebug Then LOG.WriteToArchiveLog(CurrFolder.Name)
            If xDebug Then LOG.WriteToArchiveLog(CurrFolder.FolderPath)

            GetFolderByPath(CurrFolder.FolderPath.ToString)
            If xDebug Then LOG.WriteToArchiveLog(CurrFolder.Items.Count)
            If xDebug Then LOG.WriteToArchiveLog(CurrFolder.Folders.Count)
            'FolderKeyName  = FolderKeyName  + CurrFolder.Name
            FolderKeyName = CurrFolder.Name
            For I As Integer = 1 To JJ
                Dim tFolder As Outlook.MAPIFolder = CurrFolder.Folders.Item(I)
                Dim FID As String = tFolder.EntryID

                FolderKeyName = TopFolderName + "|" + tFolder.Name

                Dim BB As Integer = ckArchEmailFolder(FolderKeyName, UserID)
                If BB = 0 Then
                    Return
                End If

                If xDebug Then LOG.WriteToArchiveLog(FolderKeyName)
                ProcessAllFolders(UID, TopFolderName, tFolder, DeleteFile, ArchiveEmails,
                   RemoveAfterArchive,
                   SetAsDefaultFolder,
                   ArchiveAfterXDays,
                   RemoveAfterXDays,
                   RemoveXDays,
                   ArchiveXDays, DB_ID, UserID, ArchiveOnlyIfRead, RetentionYears, RetentionCode, ProcessingPstFile, PstFQN, ParentFolderID, slStoreId, ispublic)
            Next
            ' ProcessAllFolders(CurrFolder)
        Else
            If xDebug Then LOG.WriteToArchiveLog(CurrFolder.Name)
            If xDebug Then LOG.WriteToArchiveLog(CurrFolder.FolderPath)
            'GetFolderByPath(CurrFolder.FolderPath.ToString)
            If xDebug Then LOG.WriteToArchiveLog(CurrFolder.Items.Count)
            FolderKeyName = CurrFolder.Name
            If xDebug Then LOG.WriteToArchiveLog(FolderKeyName)

            Dim FID As String = CurrFolder.EntryID
            Dim BB As Integer = ckArchEmailFolder(FolderKeyName, UserID)
            If BB = 0 Then
                Return
            End If

            AddPstFolder(StoreID, TopFolderName, ParentFolderID, FolderKeyName, FID, PstFQN, RetentionCode)

            DBLocal.setOutlookMissing()

            ArchiveEmailsInFolder(UID, TopFolderName, ArchiveEmails,
                  RemoveAfterArchive,
                  SetAsDefaultFolder,
                  ArchiveAfterXDays,
                  RemoveAfterXDays,
                  RemoveXDays,
                  ArchiveXDays,
                  DB_ID, CurrFolder, StoreID, ArchiveOnlyIfRead, RetentionYears, RetentionCode, FolderKeyName, slStoreId, ispublic)
        End If

    End Sub

    Sub ProcessAllFolderSenders(ByVal UID As String, ByVal FolderName As String, ByVal CurrFolder As Outlook.MAPIFolder, ByVal DeleteFile As Boolean, ByVal ArchiveEmails As String,
                   ByVal RemoveAfterArchive As String,
                   ByVal SetAsDefaultFolder As String,
                   ByVal ArchiveAfterXDays As String,
                   ByVal RemoveAfterXDays As String,
                   ByVal RemoveXDays As String,
                   ByVal ArchiveXDays As String, ByVal FileDirectory As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim tFolder As Outlook.MAPIFolder = Nothing
        Static FolderKeyName As String
        ' Dim SubFolder As Outlook.MAPIFolder = olfolder
        Dim II As Integer = CurrFolder.Items.Count
        Dim CountOfSubfolders As Integer = CurrFolder.Folders.Count
        Dim ParentAlreadyProcessed As Boolean = False
        Dim B As Boolean = False

        If xDebug Then LOG.WriteToArchiveLog("Parent Folder: " + FolderName)
        If xDebug Then LOG.WriteToArchiveLog(CurrFolder.Name)

        If CountOfSubfolders = 0 Then
            If xDebug Then LOG.WriteToArchiveLog("CurrFolder.Items.Count: " + CurrFolder.Items.Count.ToString)
            FolderKeyName = CurrFolder.Name
            B = ckFolderExists(gCurrUserGuidID, FolderKeyName, FileDirectory)
            If B Then
                If xDebug Then If xDebug Then LOG.WriteToArchiveLog("Processing Folder: " + FolderKeyName)
                ArchiveEmailsInFolderenders(ArchiveEmails,
                      RemoveAfterArchive,
                      SetAsDefaultFolder,
                      ArchiveAfterXDays,
                      RemoveAfterXDays,
                      RemoveXDays,
                      ArchiveXDays,
                      CurrFolder, DeleteFile)
            End If
            ParentAlreadyProcessed = True
            Return
        Else
            If xDebug Then If xDebug Then LOG.WriteToArchiveLog("Parent SUBFolder: " + FolderName)
            Return
        End If

        If CountOfSubfolders > 0 Then
            If xDebug Then LOG.WriteToArchiveLog(CurrFolder.Name)
            If xDebug Then LOG.WriteToArchiveLog(CurrFolder.Items.Count)
            If xDebug Then LOG.WriteToArchiveLog(CurrFolder.Folders.Count)
            'FolderKeyName  = FolderKeyName  + CurrFolder.Name
            'Dim tFolderKeyName  = CurrFolder.Name
            B = ckFolderExists(gCurrUserGuidID, FolderKeyName, FileDirectory)
            If B Then
                For I As Integer = 1 To CountOfSubfolders
                    tFolder = CurrFolder.Folders.Item(I)
                    Dim FolderID As Integer = CurrFolder.EntryID
                    If xDebug Then LOG.WriteToArchiveLog("FolderID = " & CurrFolder.EntryID)
                    FolderKeyName = FolderKeyName + "->" + tFolder.Name
                    If xDebug Then LOG.WriteToArchiveLog("Location clsArchiver:ProcessAllFolderSenders 0011: '" + tFolder.Name + "'.")
                    If FolderKeyName.Equals(FolderName) Then
                        If xDebug Then LOG.WriteToArchiveLog(FolderKeyName)
                        B = ckFolderExists(gCurrUserGuidID, FolderKeyName, FileDirectory)
                        If B Then
                            ProcessAllFolderSenders(UID, FolderName, tFolder, DeleteFile, ArchiveEmails,
                                RemoveAfterArchive,
                                SetAsDefaultFolder,
                                ArchiveAfterXDays,
                                RemoveAfterXDays,
                                RemoveXDays,
                                ArchiveXDays, FileDirectory)
                        End If
                    Else
                        If xDebug Then LOG.WriteToArchiveLog("Skipping folder: " + FolderKeyName)
                    End If

                Next
            End If
        Else
            If Not ParentAlreadyProcessed Then
                If xDebug Then LOG.WriteToArchiveLog(CurrFolder.Name)
                If xDebug Then LOG.WriteToArchiveLog(CurrFolder.Items.Count)
                FolderKeyName = CurrFolder.Name
                If FolderKeyName.Equals(FolderName) Then
                    B = ckFolderExists(gCurrUserGuidID, FolderKeyName, FileDirectory)
                    If B Then
                        If xDebug Then LOG.WriteToArchiveLog("Processing Folder: " + FolderKeyName)
                        ArchiveEmailsInFolderenders(ArchiveEmails,
                              RemoveAfterArchive,
                              SetAsDefaultFolder,
                              ArchiveAfterXDays,
                              RemoveAfterXDays,
                              RemoveXDays,
                              ArchiveXDays,
                              CurrFolder, DeleteFile)
                    End If
                Else
                    If xDebug Then LOG.WriteToArchiveLog("Skipping folder: " + FolderKeyName)
                End If
            End If

        End If

    End Sub

    Sub getSubFolderEmails(ByVal UID As String, ByVal TopFolderName As String, ByVal MailboxName As String,
                           ByVal FolderName As String,
                           ByVal DeleteFile As Boolean,
                           ByVal ArchiveEmails As String,
                   ByVal RemoveAfterArchive As String,
                   ByVal SetAsDefaultFolder As String,
                   ByVal ArchiveAfterXDays As String,
                   ByVal RemoveAfterXDays As String,
                   ByVal RemoveXDays As String,
                   ByVal ArchiveXDays As String,
                   ByVal DB_ID As String,
                   ByVal UserID As String,
                   ByVal ArchiveOnlyIfRead As String, ByVal FilterDate As String, ByVal RetentionYears As Integer, ByVal RetentionCode As String, ByVal ProcessPstFile As Boolean, ByVal PstFQN As String, ByVal ParentFolderID As String, ByVal slStoreId As SortedList)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim oApp As New Outlook.Application
        Dim sBuild As String = Left(oApp.Version, InStr(1, oApp.Version, ".") + 1)
        Dim oNS As Outlook.NameSpace = oApp.GetNamespace("mapi")

        '******************
        Dim isPublic As String = "N"

        Try
            'Now that we have the MAPI namespace, we can log on using using:
            '<mapinamespace>.Logon(object Profile, object Password, object ShowDialog, object NewSession)
            'Profile: This is a string value that indicates what MAPI profile to use for logging on.
            '    Set this to null if using the currently logged on user, or set to an empty string ("")
            '    if you wish to use the default Outlook Profile.
            'Password: The password for the indicated profile. Set to null if using the currently
            '    logged on user, or set to an empty string ("") if you wish to use the default Outlook Profile password.
            'ShowDialog: Set to True to display the Outlook Profile dialog box.

            'oNS.Logon("OUTLOOK", Missing.Value, True, True)
            oNS.Logon(Missing.Value, Missing.Value, True, True)

            'Dim oMAPI As Outlook._NameSpace
            Dim oParentFolder As Outlook.MAPIFolder

            oParentFolder = oNS.Folders.Item(MailboxName)

            'Dim FLDR As Outlook.Folder
            'For Each FLDR In oParentFolder.Folders
            '    if xDebug then log.WriteToArchiveLog(FLDR.Name)
            'Next

            ' Get Messages collection of Inbox.

            Dim SubFolder As Outlook.MAPIFolder = Nothing
            Dim SFolder As Outlook.MAPIFolder = Nothing

            For Each SubFolder In oParentFolder.Folders
                ProcessAllFolders(UID, TopFolderName, SubFolder, DeleteFile, ArchiveEmails,
                 RemoveAfterArchive,
                    SetAsDefaultFolder,
                    ArchiveAfterXDays,
                    RemoveAfterXDays,
                    RemoveXDays,
                    ArchiveXDays, DB_ID, UserID, ArchiveOnlyIfRead, RetentionYears, RetentionCode, False, "", ParentFolderID, slStoreId, isPublic)

            Next
        Catch ex As Exception
            MessageBox.Show(ex.Message)
        Finally
            ' In any case please remember to turn on Outlook Security after your code, since now it is very easy to switch it off! :-)
            'SecurityManager.DisableOOMWarnings = False
            oApp = Nothing
            oNS = Nothing

            GC.Collect()
        End Try

    End Sub

    Public Sub getSubFolderEmailsSenders(ByVal UID As String, ByVal MailboxName As String, ByVal FolderName As String, ByVal DeleteFile As Boolean, ByVal ArchiveEmails As String,
                    ByVal RemoveAfterArchive As String,
                    ByVal SetAsDefaultFolder As String,
                    ByVal ArchiveAfterXDays As String,
                    ByVal RemoveAfterXDays As String,
                    ByVal RemoveXDays As String,
                    ByVal ArchiveXDays As String, ByVal FileDirectory As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim LL As Integer = 0

        LL = 1784
        Dim oApp As New Outlook.Application
        LL = 1785
        Dim sBuild As String = Left(oApp.Version, InStr(1, oApp.Version, ".") + 1)
        LL = 1786

        LL = 1787
        Dim oNS As Outlook.NameSpace = oApp.GetNamespace("mapi")
        LL = 6
        Try
            LL = 7
            'Now that we have the MAPI namespace, we can log on using using:
            LL = 8
            '<mapinamespace>.Logon(object Profile, object Password, object ShowDialog, object NewSession)
            LL = 9
            'Profile: This is a string value that indicates what MAPI profile to use for logging on.
            LL = 10
            ' Set this to null if using the currently logged on user, or set to an empty string ("")
            LL = 11
            ' if you wish to use the default Outlook Profile.
            LL = 12
            'Password: The password for the indicated profile. Set to null if using the currently
            LL = 13
            ' logged on user, or set to an empty string ("") if you wish to use the default Outlook
            ' Profile password.
            LL = 14
            'ShowDialog: Set to True to display the Outlook Profile dialog box.
            LL = 15

            LL = 16
            'oNS.Logon("OUTLOOK", Missing.Value, True, True)
            LL = 17
            oNS.Logon(Missing.Value, Missing.Value, True, True)
            LL = 18

            LL = 19
            'Dim oMAPI As Outlook._NameSpace
            LL = 20
            Dim OutlookFolders As Outlook.MAPIFolder
            LL = 21

            LL = 22

            LL = 23
            OutlookFolders = oNS.Folders.Item(MailboxName)
            LL = 24

            LL = 25
            ' Get Messages collection of Inbox.
            LL = 26

            LL = 27
            Dim Folder As Outlook.MAPIFolder = Nothing
            LL = 28
            Dim SFolder As Outlook.MAPIFolder = Nothing
            LL = 29

            LL = 30
            For Each Folder In OutlookFolders.Folders
                LL = 31
                If xDebug Then LOG.WriteToArchiveLog("Folder Name: " + OutlookFolders.Name)
                LL = 32
                If xDebug Then LOG.WriteToArchiveLog("Folder Name: " + FolderName)
                LL = 33
                If xDebug Then LOG.WriteToArchiveLog("Folder  : " + Folder.Name)
                LL = 34

                LL = 35
                GetFolderByPath(Folder.FolderPath)
                LL = 36

                LL = 37
                If xDebug Then LOG.WriteToArchiveLog("Folder Items# : " & Folder.Items.Count)
                LL = 38
                If xDebug Then LOG.WriteToArchiveLog("Folder# : " & Folder.Folders.Count)
                LL = 39
                If xDebug Then LOG.WriteToArchiveLog("_____________")
                LL = 40
                'If FolderName .Equals(Folder.Name) Then
                LL = 41
                ProcessAllFolderSenders(UID, FolderName, Folder, DeleteFile, ArchiveEmails,
                RemoveAfterArchive,
                SetAsDefaultFolder,
                ArchiveAfterXDays,
                RemoveAfterXDays,
                RemoveXDays,
                    ArchiveXDays, FileDirectory)
                LL = 48
                'End If
                LL = 49
            Next
            LL = 50

            LL = 51

            LL = 52
        Catch ex As Exception
            LL = 53
            MessageBox.Show(ex.Message)
            LL = 54
        Finally
            LL = 55
            ' In any case please remember to turn on Outlook Security after your code, since now it
            ' is very easy to switch it off! :-)
            LL = 56
            'SecurityManager.DisableOOMWarnings = False
            LL = 57
            oApp = Nothing
            LL = 58
            oNS = Nothing
            LL = 59
            GC.Collect()
            LL = 60
        End Try
        LL = 61
        If xDebug Then LOG.WriteToArchiveLog("Exiting...")
        LL = 62
    End Sub

    Sub ArchiveEmailsInFolder(ByVal UID As String, ByVal TopFolder As String,
                              ByVal ArchiveEmails As String,
                               ByVal RemoveAfterArchive As String,
                               ByVal SetAsDefaultFolder As String,
                               ByVal ArchiveAfterXDays As String,
                               ByVal RemoveAfterXDays As String,
                               ByVal RemoveXDays As String,
                               ByVal ArchiveXDays As String,
                               ByVal DB_ID As String,
                               ByVal CurrOutlookSubFolder As Outlook.MAPIFolder,
                               ByVal StoreID As String,
                               ByVal ArchiveOnlyIfRead As String,
                               ByVal RetentionYears As Integer,
                               ByVal RetentionCode As String,
                               ByVal tgtFolderName As String, ByVal slStoreId As SortedList, ByVal isPublic As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim StackLevel As Integer = 0
        Dim ListOfFiles As New Dictionary(Of String, Integer)

        Dim ID As Integer = 5555
        Dim PauseThreadMS As Integer = 0
        Try
            PauseThreadMS = CInt(getUserParm("UserContent_Pause"))
        Catch ex As Exception
            PauseThreadMS = 0
        End Try

        Dim LL# = 459
        Dim EmailIdentifier As String = ""
        Dim Subject As String = ""
        LL = 464

        LL = 465
        Dim LastEmailArchRunDate As String = UserParmRetrive("LastEmailArchRunDate", gCurrUserGuidID)
        LL = 466
        If LastEmailArchRunDate.Trim.Length = 0 Then
            LL = 467
            LastEmailArchRunDate = "1/1/1950"
            LL = 468
        End If
        LL = 469
        frmMain.SB2.Text = "Last Email Archive run date was " + LastEmailArchRunDate
        LL = 470
        Dim UseLastFilterDate As String = UserParmRetrive("ckUseLastProcessDateAsCutoff", gCurrUserGuidID)
        LL = 471
        Dim bUseCutOffDate As Boolean = False
        LL = 472
        Dim CutOffDate As Date = Nothing
        LL = 473

        LL = 474
        If UseLastFilterDate.ToUpper.Equals("TRUE") Then
            LL = 475
            bUseCutOffDate = True
            LL = 476
        Else
            LL = 477
            bUseCutOffDate = False
            LL = 478
        End If
        LL = 479

        Dim rightNow As Date = Now
        LL = 481
        If RetentionYears = 0 Then
            LL = 482
            RetentionYears = Val(getSystemParm("RETENTION YEARS"))
            LL = 483
        End If
        LL = 484
        rightNow = rightNow.AddYears(RetentionYears)
        Dim RetentionExpirationDate As String = rightNow.ToString
        LL = 487

        LL = 488
        Dim bMoveIt As Boolean = True
        LL = 489

        LL = 490
        Dim oApp = New Outlook.Application
        LL = 491
        Dim oNS As Outlook.NameSpace = oApp.GetNamespace("MAPI")
        LL = 492

        LL = 493
        '** Set up so that deleted items can be moved into the deleted items folder.
        LL = 494
        Dim oDeletedItems As Outlook.MAPIFolder = oNS.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderDeletedItems)
        LL = 495

        LL = 496
        Dim DeleteMsg As Boolean = False
        LL = 497
        Dim CurrDateTime As Date = Now()
        LL = 498
        Dim ArchiveAge As Integer = 0
        LL = 499
        Dim RemoveAge As Integer = 0
        LL = 500
        Dim XDaysArchive As Integer = 0
        LL = 501
        Dim XDaysRemove As Integer = 0
        LL = 502
        Dim CurrMailFolderID As String = CurrOutlookSubFolder.EntryID
        LL = 503
        Dim EmailFQN As String = ""
        LL = 504
        Dim bRemoveAfterArchive As Boolean = False
        LL = 505
        Dim bMsgUnopened As Boolean = False
        LL = 506
        Dim CurrMailFolderName As String = ""
        LL = 507
        Dim MinProcessDate As Date = CDate("01/1/1910")
        LL = 508
        Dim CurrName As String = CurrOutlookSubFolder.Name
        LL = 509
        Dim ArchiveMsg As String = CurrName + ": "
        LL = 510

        LL = 511
        'Console.WriteLine("Archiving CurrName  = " + CurrName )
        LL = 512
        'Console.WriteLine("Should be Archiving CurrName  = " + tgtFolderName)
        LL = 513

        LL = 514
        '** WDM REMOVE THIS SECTION OF CODE AFTER ONE RUN
        LL = 515
        Dim EmailFolderFQN As String = TopFolder + "|" + CurrName
        LL = 516

        LL = 517
        EmailFolderFQN = UTIL.RemoveSingleQuotes(EmailFolderFQN)
        LL = 518

        LL = 519
        If tgtFolderName.Length > 0 Then
            LL = 520
            EmailFolderFQN = tgtFolderName
            LL = 521
        Else
            LL = 522
            EmailFolderFQN = TopFolder + "|" + CurrName
            LL = 523
        End If
        LL = 524

        LL = 525
        If xDebug Then LOG.WriteToArchiveLog("ArchiveEmailsInFolder 100 EmailFolderFQN: " + EmailFolderFQN)
        LL = 526

        LL = 527
        Dim RunThisCode As Boolean = False
        LL = 528
        If RunThisCode Then
            LL = 529

            LL = 530
            Dim S As String = "Update EMAIL set CurrMailFolderID = '" + CurrMailFolderID + "' where OriginalFolder = '" + EmailFolderFQN + "' and CurrMailFolderID is null "
            LL = 531
            Dim bExec As Boolean = ExecuteSqlNewConn(S, False)
            LL = 532
            If Not bExec Then
                LL = 533
                LOG.WriteToArchiveLog("ERROR: 1234.99")
                LL = 534
            End If
            LL = 535
        End If
        LL = 537
        Dim bUseQuickSearch As Boolean = False
        LL = 538
        'Dim NbrOfIds As Integer = getCountStoreIdByFolder()
        LL = 539
        If slStoreId.Count > 0 Then
            bUseQuickSearch = True
        Else
            bUseQuickSearch = False
        End If
        LL = 550
        If ArchiveEmails.Length = 0 Then
            LL = 551
            frmNotify2.Close()
            Return
            LL = 552
        End If
        LL = 553
        Dim DB_ConnectionString As String = ""
        LL = 554

        LL = 555
        If ArchiveEmails.Equals("N") And ArchiveAfterXDays.Equals("N") And RemoveAfterArchive.Equals("N") Then
            LL = 556
            '** Then this folder really should not be in the list
            LL = 557
            frmNotify2.Close()
            Return
            LL = 558
        End If
        LL = 559
        If RemoveAfterArchive.Equals("Y") Then
            LL = 560
            DeleteMsg = True
            LL = 561
            bRemoveAfterArchive = True
            LL = 562
        End If
        LL = 563
        If IsNumeric(RemoveXDays) Then
            LL = 564
            XDaysRemove = Val(RemoveXDays)
            LL = 565
        End If
        LL = 566
        If IsNumeric(ArchiveXDays) Then
            LL = 567
            XDaysArchive = Val(ArchiveXDays)
            LL = 568
        End If
        LL = 569

        LL = 570
        Try
            LL = 571
            SL.Clear()
            LL = 572
            SL2.Clear()
            LL = 573
            Dim oItems As Outlook.Items
            LL = 574

            LL = 575
            If bUseCutOffDate = False Then
                LL = 576
                If xDebug Then LOG.WriteToArchiveLog("ArchiveEmailsInFolder 200: " + EmailFolderFQN)
                LL = 577
                oItems = CurrOutlookSubFolder.Items
                LL = 578
            Else
                LL = 579
                If xDebug Then LOG.WriteToArchiveLog("ArchiveEmailsInFolder 300: " + EmailFolderFQN)
                LL = 580
                oItems = CurrOutlookSubFolder.Items
                LL = 581

            End If
            LL = 619
            'Console.WriteLine("Total for: " & CurrOutlookSubFolder.Name & " : " & oItems.Count)
            LL = 620
            CurrMailFolderName = CurrOutlookSubFolder.Name
            LL = 621

            LL = 622
            frmPstLoader.SB.Text = CurrMailFolderName
            'LL = 623
            frmPstLoader.SB.Refresh()
            LL = 624
            Windows.Forms.Application.DoEvents()
            LL = 625

            LL = 626
            If xDebug Then LOG.WriteToArchiveLog("ArchiveEmailsInFolder 400: " + EmailFolderFQN)
            LL = 627

            LL = 628
            Dim TotalEmails As Integer = oItems.Count
            LL = 629
            frmMain.PBx.Maximum = TotalEmails + 1
            LL = 630
            ''FrmMDIMain.TSPB1.Maximum = TotalEmails + 1
            LL = 631
            ' Loop each unread message.
            LL = 632
            Dim oMsg As Outlook.MailItem
            LL = 633
            Dim i As Integer = 0
            LL = 634

            LL = 635
            frmMain.PBx.Value = 0
            LL = 636
            frmMain.PBx.Maximum = oItems.Count + 2
            LL = 638
            If xDebug Then LOG.WriteToArchiveLog("*** 500 Folder " + TopFolder + ":" + CurrMailFolderName + " / Curr Items = " + oItems.Count.ToString)
            LL = 639
            LOG.WriteToArchiveLog("Processing " + TotalEmails.ToString + " emails by " + gCurrLoginID)
            LL = 642
            frmNotify2.Show()
            frmNotify2.lblEmailMsg.Text = "Email: "
            For i = 1 To oItems.Count
                Application.DoEvents()
                frmNotify2.lblEmailMsg.Text = "Email: " + i.ToString + " of " + oItems.Count.ToString
                frmNotify2.Refresh()
                Application.DoEvents()

                If PauseThreadMS > 0 Then
                    System.Threading.Thread.Sleep(25)
                End If
                LL = 643
                Try
                    Application.DoEvents()
                Catch ex As Exception
                    frmNotify2.Close()
                    If gRunMode.Equals("M-END") Then
                        frmNotify2.WindowState = FormWindowState.Minimized
                    End If
                    Console.WriteLine(ex.Message)
                End Try
                LL = 644
                If i Mod 50 = 0 Then
                    ExecuteSqlNewConn(90201, "checkpoint")
                    GC.Collect()
                    GC.WaitForPendingFinalizers()
                    Application.DoEvents()
                End If
                If gTerminateImmediately Then
                    LL = 650
                    frmNotify2.Close()
                    Return
                    LL = 651
                End If
                LL = 652

                EMAIL.setStoreID(StoreID)
                frmMain.PBx.Value = i
                frmMain.PBx.Refresh()

                Windows.Forms.Application.DoEvents()
                Application.DoEvents()

                Try
                    LL = 662
                    Dim EmailGuid As String = System.Guid.NewGuid.ToString()
                    LL = 663

                    LL = 664
                    Dim OriginalFolder As String = TopFolder + "|" + CurrOutlookSubFolder.Name
                    LL = 665
                    Dim FNAME As String = CurrOutlookSubFolder.Name
                    LL = 666

                    LL = 667
                    'if xDebug then log.WriteToArchiveLog("Message#: " & i)
                    LL = 668
                    If i Mod 2 = 0 Then
                        LL = 669
                        frmMain.SB.Text = FNAME + ":" & i
                        LL = 670
                        frmMain.SB.Refresh()
                        LL = 671
                    End If
                    LL = 672

                    'Test to make sure item is a mail item and not a meeting request.
                    Dim sClassComp As String = "IPM.Schedule.Meeting.Request" : LL = 672.1
                    Try
                        sClassComp = "IPM.Schedule.Meeting.Request" : LL = 672.2
                    Catch ex As Exception
                        LOG.WriteToArchiveLog("ERROR IPM.Schedule.Meeting.Request: " + ex.Message)
                    End Try
                    'Console.WriteLine(oItems.Item(i).MessageClass.ToString)
                    'Console.WriteLine(oItems.Item(i).MessageClass)
                    Try
                        If oItems.Item(i).MessageClass.Equals("REPORT.IPM.Note.NDR") Then
                            GoTo LabelSkipThisEmail2
                        ElseIf oItems.Item(i).MessageClass.Equals("IPM.Schedule.Meeting.Notification.Forward") Then
                            GoTo LabelSkipThisEmail2
                        ElseIf oItems.Item(i).MessageClass.Equals("IPM.Document.doc_auto_file") Then
                            GoTo LabelSkipThisEmail2
                        ElseIf oItems.Item(i).MessageClass.Equals("IPM.Post") Then
                            GoTo LabelSkipThisEmail2
                        ElseIf oItems.Item(i).MessageClass.Equals("IPM.Schedule.Meeting.Request") Then
                            GoTo LabelSkipThisEmail2
                        ElseIf oItems.Item(i).MessageClass.Equals("IPM.Schedule.Meeting.Resp.Pos") Then
                            GoTo LabelSkipThisEmail2
                        ElseIf oItems.Item(i).MessageClass.Equals("IPM.Schedule.Meeting.Resp.Neg") Then
                            GoTo LabelSkipThisEmail2
                            'ElseIf oItems.Item(i).MessageClass.Equals("IPM.Note") Then
                            '    GoTo LabelSkipThisEmail2
                        ElseIf oItems.Item(i).MessageClass.Equals("IPM.Note") Then
                            '** Good - pass it thru
                        ElseIf oItems.Item(i).MessageClass.Equals("IPM.Note.SMIME.MultipartSigned") Then
                            '** Good - pass it thru
                        ElseIf oItems.Item(i).MessageClass.Equals("IPM.Schedule.Meeting.Canceled") Then
                            '** Good - pass it thru
                        ElseIf oItems.Item(i).MessageClass.Equals("IPM.Schedule.Meeting.Notification.Forward") Then
                            '** Good - pass it thru
                        ElseIf oItems.Item(i).MessageClass.Equals("IPM.Sharing") Then
                            '** Good - pass it thru
                            Console.WriteLine(oItems.Item(i).MessageClass)
                            GoTo LabelSkipThisEmail2
                        ElseIf oItems.Item(i).MessageClass.Equals("IPM.Schedule.Meeting.Resp.Tent") Then
                            '** Good - pass it thru
                            Console.WriteLine(oItems.Item(i).MessageClass)
                            GoTo LabelSkipThisEmail2
                        ElseIf oItems.Item(i).MessageClass.Equals("IPM.Post.Rss") Then
                            '** Good - pass it thru
                            LOG.WriteToArchiveLog("NOTIFICATION - RSS Feeds through Outlook are not currently processed.")
                            'Dim oRSS As Outlook.PostItem = oApp.CreateItem(Outlook.OlItemType.olPostItem)
                            'oMsg.MessageClass = "IPM.Post.Rss"
                        Else
                            Console.WriteLine(oItems.Item(i).MessageClass.ToString)
                            Console.WriteLine(oItems.Item(i).MessageClass)
                        End If
                        If oItems.Item(i).MessageClass.Equals(sClassComp) Or oItems.Item(i).MessageClass.Equals("IPM.Schedule.Meeting.Canceled") Then : LL = 674
                            Dim oEntryID As String = oItems.Item(i).EntryID : LL = 675
                            'Dim oStoreID As String = oItems.Item(i).StoreID
                            Dim MsgDate As Date = oItems.Item(i).senton : LL = 676
                            Try
                                Dim passed_time As TimeSpan : LL = 677
                                passed_time = CurrDateTime.Subtract(MsgDate) : LL = 678
                                Dim EmailDays As Integer = passed_time.TotalDays : LL = 679
                                If RemoveAfterXDays.Equals("Y") Then : LL = 680
                                    If EmailDays >= XDaysRemove Then : LL = 681
                                        'oItems.Item(i).move(oEcmHistFolder)
                                        'oItems.Item(i).delete()
                                        LL = 681.1
                                    End If
                                    LL = 682
                                    LOG.WriteToArchiveLog("Notification 01 - Item #" + i.ToString + " in folder " + OriginalFolder + ", is a meeting request and past MOVE date - NOT PROCESSED.")
                                Else
                                    LL = 683
                                    LOG.WriteToArchiveLog("Notification 02 - Item #" + i.ToString + " in folder " + OriginalFolder + ", is a meeting request and NOT PROCESSED.")
                                End If
                                LL = 684
                            Catch ex As Exception
                                LOG.WriteToArchiveLog("Notification 03 - Item #" + i.ToString + " in folder " + OriginalFolder + ", is a meeting request and Failed to MOVE to History.")
                                Console.WriteLine(ex.Message)
                            End Try

                            GoTo LabelSkipThisEmail2
                        End If
                    Catch ex As Exception
                        LOG.WriteToArchiveLog("ERROR ArchiveEmailsInFolder 100 - Line #" + LL.ToString + ".")
                        GoTo LabelSkipThisEmail2
                    End Try

                    Try
                        LL = 674
                        oMsg = oItems.Item(i) : LL = 675
                    Catch ex As Exception
                        LL = 676
                        LOG.WriteToArchiveLog("ERROR - Item #" + i.ToString + " in folder " + OriginalFolder + ", failed to open message of type: " + oItems.Item(i).MessageClass.ToString + ".")
                        LL = 677
                        GoTo LabelSkipThisEmail2
                        LL = 678
                    End Try

                    LL = 679

                    EmailIdentifier = UTIL.genEmailIdentifier(oMsg.CreationTime, oMsg.SenderEmailAddress, Subject)
                    LL = 680
                    Dim bMailAlreadyUploaded As Boolean = False

                    If bUseQuickSearch = True Then
                        LL = 681
                        Dim IX As Integer = slStoreId.IndexOfKey(EmailIdentifier)
                        LL = 682
                        If IX < 0 Then
                            '** The email has NOT been archived, move on...
                            'bMailAlreadyUploaded = DBLocal.addOutlook(EmailIdentifier)
                            'If bMailAlreadyUploaded Then
                            '    '** The key already exists, move on
                            '    GoTo LabelSkipThisEmail
                            'Else
                            '    slStoreId.Add(EmailIdentifier, i)
                            '    bMailAlreadyUploaded = False
                            'End If
                            LL = 683
                            frmMain.SB.Text = "Insert# " + i.ToString
                            frmMain.SB.Refresh()
                            LL = 684
                        Else
                            LL = 685
                            frmMain.EmailsSkipped += 1
                            GoTo LabelSkipThisEmail
                        End If
                    Else
                        LL = 686
                        bMailAlreadyUploaded = DBLocal.OutlookExists(EmailIdentifier)
                        LL = 687
                        If bMailAlreadyUploaded Then
                            LL = 688
                            DBLocal.setOutlookKeyFound(EmailIdentifier)
                            LL = 689
                            GoTo LabelSkipThisEmail
                        End If
                        LL = 690
                    End If

                    LL = 695
                    Dim SentOn As Date = oMsg.SentOn
                    LL = 696
                    Dim ReceivedTime As Date = oMsg.ReceivedTime
                    LL = 697
                    Dim CreationTime As Date = oMsg.CreationTime
                    LL = 699
                    If SentOn = Nothing Then
                        LL = 700
                        If CreationTime <> Nothing Then
                            LL = 701
                            SentOn = CreationTime
                            LL = 702
                        ElseIf ReceivedTime <> Nothing Then
                            LL = 703
                            SentOn = CreationTime
                            LL = 704
                        Else
                            LL = 705
                            SentOn = Now
                            LL = 706
                        End If
                        LL = 707
                    End If
                    LL = 708
                    If ReceivedTime = Nothing Then
                        LL = 711
                        If SentOn <> Nothing Then
                            LL = 712
                            ReceivedTime = SentOn
                            LL = 713
                        ElseIf CreationTime <> Nothing Then
                            LL = 714
                            ReceivedTime = CreationTime
                            LL = 715
                        Else
                            LL = 716
                            ReceivedTime = Now
                            LL = 717
                        End If
                        LL = 718
                    End If
                    LL = 719

                    LL = 720
                    If CreationTime = Nothing Then
                        LL = 721
                        If SentOn <> Nothing Then
                            LL = 722
                            CreationTime = SentOn
                            LL = 723
                        ElseIf ReceivedTime <> Nothing Then
                            LL = 724
                            CreationTime = ReceivedTime
                            LL = 725
                        Else
                            LL = 726
                            CreationTime = Now
                            LL = 727
                        End If
                        LL = 728
                    End If
                    LL = 729
                    If CreationTime < #1/1/1960# Then
                        LL = 730
                        If SentOn <> Nothing Then
                            LL = 731
                            CreationTime = SentOn
                            LL = 732
                        ElseIf CreationTime <> Nothing Then
                            LL = 733
                            CreationTime = ReceivedTime
                            LL = 734
                        Else
                            LL = 735
                            CreationTime = Now
                            LL = 736
                        End If
                        LL = 737
                    End If

                    LL = 740

                    If bUseCutOffDate Then
                        LL = 741
                        Dim bbb As Boolean = compareEmailProcessDate(CurrMailFolderName, CreationTime)
                        LL = 742
                        If bbb Then
                            LL = 743
                            frmMain.EmailsSkipped += 1
                            LOG.WriteToArchiveLog(ArchiveMsg + " This email past the cutoff date, skipped.")
                            Dim BBX As Boolean = ExchangeEmailExists(EmailIdentifier)
                            Dim passed_time As TimeSpan
                            passed_time = CurrDateTime.Subtract(SentOn)
                            If BBX Then
                                Dim EmailDays As Integer = passed_time.TotalDays
                                If RemoveAfterXDays.Equals("Y") Then
                                    If EmailDays >= XDaysRemove Then
                                        MoveToHistoryFolder(oMsg)
                                    End If
                                End If
                            End If
                            GoTo LabelSkipThisEmail
                            LL = 748
                            BBX = Nothing
                            passed_time = Nothing
                        End If
                        LL = 749
                    End If

                    setLastEmailDate(CurrMailFolderName, CreationTime)

                    Dim bIdExists As Boolean = ExchangeEmailExists(EmailIdentifier)

                    If bIdExists Then
                        'This email has already been processed, skip it.

                        GoTo LabelSkipThisEmail
                    End If

                    If bIdExists Then
                        '** This sucker already exists, skip it.
                        LL = 757
                        If bRemoveAfterArchive = True Then
                            LL = 758
                            If xDebug Then LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 900: " + EmailFolderFQN)
                            LL = 759
                            If xDebug Then LOG.WriteToArchiveLog(CurrOutlookSubFolder.Name + ": Deleted DUPLICATE email... ")
                            LL = 760
                            EM2D.setEmailguid(EmailGuid)
                            LL = 761
                            EM2D.setStoreid(StoreID)
                            LL = 762
                            EM2D.setUserid(gCurrUserGuidID)
                            LL = 763
                            EM2D.setMessageid(oMsg.EntryID)
                            LL = 764
                            If bMsgUnopened = False And ArchiveOnlyIfRead = "Y" Then
                                LL = 765
                                EM2D.Insert()
                                LL = 766
                                'log.WriteToArchiveLog("clsArchiver : xGetEmails: Marked File for deletion #100")
                                LL = 767
                            ElseIf ArchiveOnlyIfRead = "N" Then
                                LL = 768
                                'log.WriteToArchiveLog("clsArchiver : xGetEmails: Marked File for deletion #101")
                                LL = 769
                                EM2D.Insert()
                                LL = 770
                            Else
                                LL = 771
                                If xDebug Then LOG.WriteToArchiveLog("No match ... ")
                                LL = 772
                            End If
                            LL = 773

                            LL = 774
                        End If
                        LL = 775
                        'GoTo LabelSkipThisEmail2
                        LL = 776
                        GoTo LabelSkipThisEmail
                        LL = 778
                    End If
                    LL = 779
                    If xDebug Then LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1000: " + EmailFolderFQN)
                    LL = 780
                    Dim SourceTypeCode As String = ""
                    LL = 781
                    Try
                        LL = 782
                        Subject = oMsg.Subject
                        LL = 783
                        'If InStr(Subject, "Accepted: ", CompareMethod.Text) > 0 Then
                        '    LL = 784
                        '    Console.WriteLine("Here on a calendar entry.")
                        '    LL = 785
                        'End If
                        'LL = 786
                    Catch ex As Exception
                        LL = 787
                        LOG.WriteToArchiveLog("ERROR: XXX Subject : " + ex.Message)
                        LL = 788
                    End Try
                    LL = 789

                    LL = 790
                    Try
                        LL = 791
                        SourceTypeCode = "MSG"
                        LL = 792
                    Catch ex As Exception
                        LL = 793
                        LOG.WriteToArchiveLog("ERROR: XXX SourceTypeCode : " + ex.Message)
                        LL = 794
                    End Try
                    LL = 795

                    Dim bAutoForwarded As Boolean = False
                    LL = 797
                    Try
                        LL = 798
                        bAutoForwarded = oMsg.AutoForwarded
                        LL = 799
                    Catch ex As Exception
                        LL = 800
                        LOG.WriteToArchiveLog("ERROR: XXX bAutoForwarded As Boolean: " + ex.Message)
                        LL = 801
                    End Try
                    LL = 802

                    LL = 803
                    Dim BCC As String = ""
                    LL = 804
                    Try
                        LL = 805
                        BCC = oMsg.BCC
                        LL = 806
                    Catch ex As Exception
                        LL = 807
                        LOG.WriteToArchiveLog("ERROR: XXX BCC : " + ex.Message)
                        LL = 808
                    End Try

                    Dim BillingInformation As String = ""

                    Try

                        BillingInformation = oMsg.BillingInformation
                    Catch ex As Exception
                        LL = 814
                        LOG.WriteToArchiveLog("ERROR: XXX BillingInformation : " + ex.Message)
                        LL = 815
                    End Try
                    LL = 816

                    LL = 817
                    Dim EmailBody As String = ""
                    LL = 818
                    Try
                        LL = 819
                        EmailBody = oMsg.Body
                        LL = 820
                    Catch ex As Exception
                        LL = 821
                        LOG.WriteToArchiveLog("ERROR: XXX EmailBody: " + ex.Message)
                        LL = 822
                    End Try
                    LL = 823
                    If EmailBody Is Nothing Then
                        EmailBody = "-"
                    End If
                    '*************** DO NOT SAVE THE WHOLE BODY, JUST THE FIRST 250 CHARACTERS *****************
                    'Dim iBodyLen As Integer = CInt(My.Settings("EmailBodyLength"))
                    'iBodyLen = 100000
                    'EmailBody = EmailBody.Substring(0, iBodyLen)
                    '*******************************************************************************************

                    LL = 824
                    Dim BodyFormat As String = ""
                    LL = 825
                    Try
                        LL = 826
                        BodyFormat = oMsg.BodyFormat.ToString
                        LL = 827
                    Catch ex As Exception
                        LL = 828
                        LOG.WriteToArchiveLog("ERROR: XXX BodyFormat: " + ex.Message)
                        LL = 829
                    End Try
                    LL = 830

                    LL = 831
                    Dim Categories As String = ""
                    LL = 832
                    Try
                        LL = 833
                        Categories = oMsg.Categories
                        LL = 834
                    Catch ex As Exception
                        LL = 835
                        LOG.WriteToArchiveLog("ERROR: XXX Categories: " + ex.Message)
                        LL = 836
                    End Try
                    LL = 839
                    If xDebug Then LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1000a: " + EmailFolderFQN)
                    LL = 840

                    LL = 841
                    Dim Companies As String = ""
                    LL = 842
                    Try
                        LL = 843
                        Companies = oMsg.Companies
                        LL = 844
                    Catch ex As Exception
                        LL = 845
                        LOG.WriteToArchiveLog("ERROR: XXX Companies : " + ex.Message)
                        LL = 846
                    End Try
                    LL = 847

                    LL = 848

                    LL = 849
                    Dim ConversationIndex As String = ""
                    LL = 850
                    Try
                        LL = 851
                        ConversationIndex = oMsg.ConversationIndex
                        LL = 852
                    Catch ex As Exception
                        LL = 853
                        LOG.WriteToArchiveLog("ERROR: XXX ConversationIndex : " + ex.Message)
                        LL = 854
                    End Try
                    LL = 855

                    LL = 856
                    Dim ConversationTopic As String = ""
                    LL = 857
                    Try
                        LL = 858
                        ConversationTopic = oMsg.ConversationTopic
                        LL = 859
                    Catch ex As Exception
                        LL = 860
                        LOG.WriteToArchiveLog("ERROR: XXX ConversationTopic : " + ex.Message)
                        LL = 861
                    End Try
                    LL = 862

                    LL = 863
                    Application.DoEvents()
                    LL = 864
                    Dim DeferredDeliveryTime As Date = Nothing
                    LL = 865
                    Try
                        LL = 866
                        DeferredDeliveryTime = oMsg.DeferredDeliveryTime
                        LL = 867
                    Catch ex As Exception
                        LL = 868
                        LOG.WriteToArchiveLog("ERROR: XXX DeferredDeliveryTime As Date: " + ex.Message)
                        LL = 869
                    End Try
                    LL = 870

                    LL = 871
                    Dim DownloadState As String = ""
                    LL = 872
                    Try
                        LL = 873
                        DownloadState = oMsg.DownloadState.ToString
                        LL = 874
                    Catch ex As Exception
                        LL = 875
                        LOG.WriteToArchiveLog("ERROR: XXX DownloadState : " + ex.Message)
                        LL = 876
                    End Try
                    LL = 877

                    LL = 878
                    Application.DoEvents()
                    LL = 879
                    If xDebug Then LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1000b: " + EmailFolderFQN)
                    LL = 880

                    LL = 881
                    Dim ExpiryTime As Date = Nothing
                    LL = 882
                    Try
                        LL = 883
                        ExpiryTime = oMsg.ExpiryTime
                        LL = 884
                    Catch ex As Exception
                        LL = 885
                        LOG.WriteToArchiveLog("ERROR: XXX ExpiryTime As Date: " + ex.Message)
                        LL = 886
                    End Try
                    LL = 887

                    LL = 888
                    If xDebug Then LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1000b1: " + EmailFolderFQN)
                    LL = 889

                    LL = 890
                    Dim HTMLBody As String = ""
                    LL = 891
                    Try
                        LL = 892
                        HTMLBody = oMsg.HTMLBody
                        LL = 893
                    Catch ex As Exception
                        LL = 894
                        LOG.WriteToArchiveLog("ERROR: XXX HTMLBody : " + ex.Message)
                        LL = 895
                    End Try
                    LL = 896

                    LL = 897
                    If xDebug Then LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1000b2: " + EmailFolderFQN)
                    LL = 898

                    LL = 899
                    Dim Importance As String = ""
                    LL = 900
                    Try
                        LL = 901
                        Importance = oMsg.Importance
                        LL = 902
                    Catch ex As Exception
                        LL = 903
                        LOG.WriteToArchiveLog("ERROR: XXX Importance : " + ex.Message)
                        LL = 904
                    End Try
                    LL = 905

                    LL = 906
                    If xDebug Then LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1000b3: " + EmailFolderFQN)
                    LL = 907

                    LL = 908
                    '** ERROR HERE
                    LL = 909
                    Dim IsMarkedAsTask As Boolean = False
                    LL = 910
                    Try
                        LL = 911
                        IsMarkedAsTask = oMsg.IsMarkedAsTask
                        LL = 912
                    Catch ex As Exception
                        LL = 913
                        LOG.WriteToArchiveLog("ERROR: XXX IsMarkedAsTask As Boolean: " + ex.Message)
                        LL = 914
                    End Try
                    LL = 915

                    LL = 916
                    If xDebug Then LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1000b4: " + EmailFolderFQN)
                    LL = 917

                    LL = 918
                    Dim LastModificationTime As Date = Nothing
                    LL = 919
                    Try
                        LL = 920
                        LastModificationTime = oMsg.LastModificationTime
                        LL = 921
                    Catch ex As Exception
                        LL = 922
                        LOG.WriteToArchiveLog("ERROR: XXX LastModificationTime As Date: " + ex.Message)
                        LL = 923
                    End Try
                    LL = 924

                    LL = 925
                    If xDebug Then LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1000b5: " + EmailFolderFQN)
                    LL = 926

                    LL = 927
                    Dim MessageClass As String = ""
                    LL = 928
                    Try
                        LL = 929
                        MessageClass = oMsg.MessageClass
                        LL = 930
                    Catch ex As Exception
                        LL = 931
                        LOG.WriteToArchiveLog("ERROR: XXX MessageClass : " + ex.Message)
                        LL = 932
                    End Try
                    LL = 933

                    LL = 934

                    LL = 935
                    If xDebug Then LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1000c: " + EmailFolderFQN)
                    LL = 936

                    LL = 937
                    Dim Mileage As String = ""
                    LL = 938
                    Try
                        LL = 939
                        Mileage = oMsg.Mileage
                        LL = 940
                    Catch ex As Exception
                        LL = 941
                        LOG.WriteToArchiveLog("ERROR: XXX Mileage : " + ex.Message)
                        LL = 942
                    End Try
                    LL = 943

                    LL = 944
                    Dim OriginatorDeliveryReportRequested As Boolean = Nothing
                    LL = 945
                    Try
                        LL = 946
                        OriginatorDeliveryReportRequested = oMsg.OriginatorDeliveryReportRequested
                        LL = 947
                    Catch ex As Exception
                        LL = 948
                        LOG.WriteToArchiveLog("ERROR OriginatorDeliveryReportRequested " + ex.Message)
                        LL = 949
                    End Try
                    LL = 950

                    LL = 951
                    Dim OutlookInternalVersion As String = ""
                    LL = 952
                    Try
                        LL = 953
                        OutlookInternalVersion = oMsg.OutlookInternalVersion
                        LL = 954
                    Catch ex As Exception
                        LL = 955
                        LOG.WriteToArchiveLog("ERROR OutlookInternalVersion  " + ex.Message)
                        LL = 956
                    End Try
                    LL = 957

                    LL = 958
                    Dim ReadReceiptRequested As Boolean = Nothing
                    LL = 959
                    Try
                        LL = 960
                        ReadReceiptRequested = oMsg.ReadReceiptRequested
                        LL = 961
                    Catch ex As Exception
                        LL = 962
                        LOG.WriteToArchiveLog("ERROR ReadReceiptRequested  " + ex.Message)
                        LL = 963
                    End Try
                    LL = 964

                    LL = 965
                    Dim ReceivedByEntryID As String = ""
                    LL = 966
                    Try
                        LL = 967
                        ReceivedByEntryID = oMsg.ReceivedByEntryID
                        LL = 968
                    Catch ex As Exception
                        LL = 969
                        LOG.WriteToArchiveLog("ERROR ReceivedByEntryID   " + ex.Message)
                        LL = 970
                    End Try
                    LL = 971

                    LL = 972
                    If xDebug Then LOG.WriteToArchiveLog("ERROR: XXX ** ArchiveEmailsInFolder 1000d: " + EmailFolderFQN)
                    LL = 973

                    LL = 974
                    Dim ReceivedByName As String = ""
                    LL = 975
                    Try
                        LL = 976
                        ReceivedByName = oMsg.ReceivedByName
                        LL = 977
                    Catch ex As Exception
                        LL = 978
                        LOG.WriteToArchiveLog("ERROR ReceivedByName    " + ex.Message)
                        LL = 979
                    End Try
                    LL = 980

                    Dim SenderEmailAddress As String = ""
                    LL = 983
                    Try
                        LL = 984
                        SenderEmailAddress = oMsg.SenderEmailAddress
                        LL = 985
                    Catch ex As Exception
                        LL = 986
                        LOG.WriteToArchiveLog("ERROR: XXX SenderEmailAddress : " + ex.Message)
                        LL = 987
                    End Try
                    LL = 988

                    If ReceivedByName = Nothing Then
                        LL = 992
                        ReceivedByName = "Unknown"
                        LL = 993
                    ElseIf ReceivedByName.Length = 0 Then
                        LL = 994
                        ReceivedByName = "Unknown"
                        LL = 995
                    End If
                    LL = 996

                    LL = 997
                    Dim ReceivedOnBehalfOfName As String = ""
                    LL = 998
                    Try
                        LL = 999
                        ReceivedOnBehalfOfName = oMsg.ReceivedOnBehalfOfName
                        LL = 1000
                    Catch ex As Exception
                        LL = 1001
                        LOG.WriteToArchiveLog("ERROR: XXX ReceivedOnBehalfOfName : " + ex.Message)
                        LL = 1002
                    End Try
                    LL = 1003

                    LL = 1004
                    If xDebug Then LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1000e: " + EmailFolderFQN)
                    LL = 1005

                    LL = 1006
                    Dim Recipients As Object = Nothing
                    LL = 1007
                    Try
                        LL = 1008
                        Recipients = oMsg.Recipients
                        LL = 1009
                    Catch ex As Exception
                        LL = 1010
                        LOG.WriteToArchiveLog("ERROR: XXX Recipients As Object: " + ex.Message)
                        LL = 1011
                    End Try
                    LL = 1012

                    LL = 1013
                    Dim KK As Integer = 0
                    LL = 1014

                    LL = 1015
                    Dim AllRecipients As String = ""
                    LL = 1016
                    Try
                        LL = 1017
                        For KK = 1 To oMsg.Recipients.Count
                            Application.DoEvents()
                            LL = 1018
                            'if xDebug then log.WriteToArchiveLog("Recipients: " + oMsg.Recipients.Item(KK).Address)
                            LL = 1019
                            If xDebug Then If xDebug Then LOG.WriteToArchiveLog("Recipients: " + oMsg.Recipients.Item(KK).Name & " : " & oMsg.Recipients.Count)
                            LL = 1020
                            AllRecipients = AllRecipients + "; " + oMsg.Recipients.Item(KK).Address
                            LL = 1021
                            AddRecipToList(EmailGuid, oMsg.Recipients.Item(KK).Address, "RECIP")
                            LL = 1022
                        Next
                        LL = 1023
                    Catch ex As Exception
                        LL = 1024
                        LOG.WriteToArchiveLog("ERROR: XXX AllRecipients  : " + ex.Message)
                        LL = 1025
                    End Try

                    LL = 1029
                    If AllRecipients.Length > 0 Then
                        LL = 1030
                        If xDebug Then LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1000g: " + EmailFolderFQN)
                        LL = 1031
                        Dim ch As String = Mid(AllRecipients, 1, 1)
                        LL = 1032
                        If ch.Equals(";") Then
                            LL = 1033
                            Mid(AllRecipients, 1, 1) = " "
                            LL = 1034
                            AllRecipients = AllRecipients.Trim
                            LL = 1035
                        End If
                        LL = 1036
                        If xDebug Then LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1000h: " + EmailFolderFQN)
                        LL = 1037
                    End If
                    LL = 1038

                    LL = 1039
                    If xDebug Then LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1001: " + EmailFolderFQN)
                    LL = 1040

                    LL = 1041
                    Dim ReminderSet As Boolean = Nothing
                    LL = 1042
                    Try
                        LL = 1043
                        ReminderSet = oMsg.ReminderSet
                        LL = 1044
                    Catch ex As Exception
                        LL = 1045
                        LOG.WriteToArchiveLog("ERROR: XXX ReminderSet As Boolean: " + ex.Message)
                        LL = 1046
                    End Try
                    LL = 1047

                    LL = 1048
                    Dim ReminderTime As Date = Nothing
                    LL = 1049
                    Try
                        LL = 1050
                        ReminderTime = oMsg.ReminderTime
                        LL = 1051
                    Catch ex As Exception
                        LL = 1052
                        LOG.WriteToArchiveLog("ERROR: XXX ReminderTime As Date: " + ex.Message)
                        LL = 1053
                    End Try
                    LL = 1054

                    LL = 1055
                    Dim ReplyRecipientNames As Object = Nothing
                    LL = 1056
                    Try
                        LL = 1057
                        ReplyRecipientNames = oMsg.ReplyRecipientNames
                        LL = 1058
                    Catch ex As Exception
                        LL = 1059
                        LOG.WriteToArchiveLog("ERROR: XXX ReplyRecipientNames As Object: " + ex.Message)
                        LL = 1060
                    End Try
                    LL = 1061

                    LL = 1062
                    If ReplyRecipientNames <> Nothing Then
                        LL = 1063
                        'For Each R In ReplyRecipientNames
                        LL = 1064
                        If xDebug Then If xDebug Then LOG.WriteToArchiveLog("ReplyRecipientNames: " + ReplyRecipientNames)
                        LL = 1065
                        'Next
                        LL = 1066
                    End If
                    LL = 1067
                    Dim SenderEmailType As String = ""
                    LL = 1068
                    Try
                        LL = 1069
                        SenderEmailType = oMsg.SenderEmailType
                        LL = 1070
                    Catch ex As Exception
                        LL = 1071
                        LOG.WriteToArchiveLog("ERROR: XXX SenderEmailType : " + ex.Message)
                        LL = 1072
                    End Try
                    LL = 1073

                    LL = 1074
                    'Dim SendUsingAccount  = oMsg.SendUsingAccount
                    LL = 1075
                    Dim Sensitivity As String = ""
                    LL = 1076
                    Try
                        LL = 1077
                        Sensitivity = oMsg.Sensitivity
                        LL = 1078
                    Catch ex As Exception
                        LL = 1079
                        LOG.WriteToArchiveLog("ERROR: XXX Sensitivity : " + ex.Message)
                        LL = 1080
                    End Try
                    LL = 1081

                    LL = 1082
                    Dim SentOnBehalfOfName As String = ""
                    LL = 1083
                    Try
                        LL = 1084
                        SentOnBehalfOfName = oMsg.SentOnBehalfOfName
                        LL = 1085
                    Catch ex As Exception
                        LL = 1086
                        LOG.WriteToArchiveLog("ERROR: XXX SentOnBehalfOfName : " + ex.Message)
                        LL = 1087
                    End Try
                    LL = 1088

                    LL = 1089
                    Dim EmailSize As Integer = 0
                    LL = 1090
                    Try
                        LL = 1091
                        'String.Format("{1:F}", price
                        EmailSize = oMsg.Size / 1000
                        'Dim S1 As String = String.Format("{1:F}", EmailSize)
                        frmNotify2.lblEmailMsg.Text += " : " + EmailSize.ToString + "/Kb - " + oMsg.Attachments.Count.ToString
                        frmNotify2.Refresh()
                        LL = 1092
                    Catch ex As Exception
                        LL = 1093
                        LOG.WriteToArchiveLog("ERROR: XXX EmailSize As Integer: " + ex.Message)
                        LL = 1094
                    End Try
                    ArchiveMsg = ArchiveMsg + " : " + Subject
                    LL = 1098

                    LL = 1099
                    Dim TaskCompletedDate As Date = Nothing
                    LL = 1100
                    Try
                        LL = 1101
                        TaskCompletedDate = oMsg.TaskCompletedDate
                        LL = 1102
                    Catch ex As Exception
                        LL = 1103
                        LOG.WriteToArchiveLog("ERROR: XXX TaskCompletedDate As Date: " + ex.Message)
                        LL = 1104
                    End Try
                    LL = 1105

                    LL = 1106
                    Dim TaskDueDate As Date = Nothing
                    LL = 1107
                    Try
                        LL = 1108
                        TaskDueDate = oMsg.TaskDueDate
                        LL = 1109
                    Catch ex As Exception
                        LL = 1110
                        LOG.WriteToArchiveLog("ERROR: XXX TaskDueDate As Date: " + ex.Message)
                        LL = 1111
                    End Try
                    LL = 1112

                    LL = 1113
                    Dim TaskSubject As String = ""
                    LL = 1114
                    Try
                        LL = 1115
                        TaskSubject = oMsg.TaskSubject
                        LL = 1116
                    Catch ex As Exception
                        LL = 1117
                        LOG.WriteToArchiveLog("ERROR: XXX TaskSubject : " + ex.Message)
                        LL = 1118
                    End Try
                    LL = 1119

                    LL = 1120
                    Dim SentTo As String = ""
                    LL = 1121
                    Try
                        LL = 1122
                        SentTo = oMsg.To
                        LL = 1123
                    Catch ex As Exception
                        LL = 1124
                        LOG.WriteToArchiveLog("ERROR: XXX SentTo : " + ex.Message)
                        LL = 1125
                    End Try
                    LL = 1126
                    If SentTo = Nothing Then
                        LL = 1128
                        SentTo = "UKN"
                        LL = 1129
                    End If
                    LL = 1130
                    If SentTo.Trim.Length = 0 Then
                        LL = 1131
                        SentTo = "UKN"
                        LL = 1132
                    End If
                    LL = 1133

                    LL = 1134
                    Dim VotingOptions As String = ""
                    LL = 1135
                    Try
                        LL = 1136
                        VotingOptions = oMsg.VotingOptions
                        LL = 1137
                    Catch ex As Exception
                        LL = 1138
                        LOG.WriteToArchiveLog("ERROR: XXX VotingOptions : " + ex.Message)
                        LL = 1139
                    End Try
                    LL = 1140

                    LL = 1141
                    Dim VotingResponse As String = ""
                    LL = 1142
                    Try
                        LL = 1143
                        VotingResponse = oMsg.VotingResponse
                        LL = 1144
                    Catch ex As Exception
                        LL = 1145
                        LOG.WriteToArchiveLog("ERROR: XXX VotingResponse : " + ex.Message)
                        LL = 1146
                    End Try
                    LL = 1147

                    LL = 1148
                    Dim UserProperties As Object = Nothing
                    LL = 1149
                    Try
                        LL = 1150
                        UserProperties = oMsg.UserProperties
                        LL = 1151
                    Catch ex As Exception
                        LL = 1152
                        LOG.WriteToArchiveLog("ERROR: XXX UserProperties As Object: " + ex.Message)
                        LL = 1153
                    End Try
                    LL = 1154

                    LL = 1155
                    Dim Accounts As String = ""
                    LL = 1156
                    Try
                        LL = 1157
                        Accounts = "None Supplied"
                        LL = 1158
                    Catch ex As Exception
                        LL = 1159
                        LOG.WriteToArchiveLog("ERROR: XXX Accounts : " + ex.Message)
                        LL = 1160
                    End Try
                    LL = 1161

                    LL = 1162
                    Dim NewTime As String = ""
                    LL = 1163
                    Try
                        LL = 1164
                        NewTime = ReceivedTime.ToString.Replace("//", ".")
                        LL = 1165
                        NewTime = ReceivedTime.ToString.Replace("/:", ".")
                        LL = 1166
                        NewTime = ReceivedTime.ToString.Replace(" ", "_")
                        LL = 1167
                    Catch ex As Exception
                        LL = 1168
                        LOG.WriteToArchiveLog("ERROR: XXX NewTime : " + ex.Message)
                        LL = 1169
                    End Try
                    LL = 1170

                    LL = 1171
                    Dim NewSubject As String = ""
                    LL = 1172
                    Try
                        LL = 1173
                        NewSubject = Mid(Subject, 1, 200)
                        LL = 1174
                    Catch ex As Exception
                        LL = 1175
                        LOG.WriteToArchiveLog("ERROR: XXX NewSubject : " + ex.Message)
                        LL = 1176
                    End Try
                    LL = 1177

                    LL = 1178
                    NewSubject = NewSubject.Replace(" ", "_")
                    LL = 1179
                    ConvertName(NewSubject)
                    LL = 1180
                    ConvertName(NewTime)
                    LL = 1181

                    LL = 1182
                    bMsgUnopened = oMsg.UnRead
                    LL = 1183

                    LL = 1184
                    If bMsgUnopened = True And ArchiveOnlyIfRead = "Y" Then
                        LL = 1185
                        '** The email has not been read and we have been instructed to skip it if not read...
                        LL = 1186
                        DeleteMsg = False
                        LL = 1187
                        'GoTo LabelSkipThisEmail2
                        LL = 1188
                    End If
                    LL = 1189

                    LL = 1190
                    If xDebug Then LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1003: " + EmailFolderFQN)
                    LL = 1191

                    LL = 1192
                    Dim bExcluded As Boolean = Nothing
                    LL = 1193
                    Try
                        LL = 1194
                        bExcluded = isExcludedEmail(SenderEmailAddress)
                        LL = 1195
                    Catch ex As Exception
                        LL = 1196
                        LOG.WriteToArchiveLog("ERROR: XXX bExcluded: " + ex.Message)
                        LL = 1197
                    End Try
                    LL = 1198
                    If bExcluded Then
                        LL = 1199
                        If xDebug Then LOG.WriteToArchiveLog("ERROR: XXX ** ArchiveEmailsInFolder 1004: " + EmailFolderFQN)
                        LL = 1200
                        GoTo LabelSkipThisEmail2
                        LL = 1201
                    End If
                    LL = 1202
                    Try
                        LL = 1203
                        If SenderEmailAddress.Length = 0 Then
                            LL = 1204
                            SenderEmailAddress = "Unknown"
                            LL = 1205
                        End If
                    Catch ex As Exception
                        SenderEmailAddress = "Unknown"
                    End Try

                    LL = 1207
                    Dim SenderName As String = ""
                    LL = 1208
                    Try
                        LL = 1209
                        SenderName = oMsg.SenderName
                        LL = 1210
                    Catch ex As Exception
                        LL = 1211
                        LOG.WriteToArchiveLog("ERROR: XXX SenderName : " + ex.Message)
                        LL = 1212
                    End Try
                    LL = 1213
                    If SenderName.Length = 0 Or SenderName = Nothing Then
                        LL = 1215
                        SenderName = "Unknown"
                        LL = 1216
                    End If

                    LL = 1219

                    'Dim bExists As Integer = EMAIL.cnt_FULL_UI_EMAIL(gCurrUserGuidID, ReceivedByName, ReceivedTime, SenderEmailAddress, SenderName, SentOn)

                    LL = 1220
                    If bMailAlreadyUploaded = True Then
                        LL = 1221
                        If xDebug Then LOG.WriteToArchiveLog("** ArchiveEmailsInFolder Curr Items : " + CurrMailFolderName + " : EXISTS.")
                        LL = 1222
                        If RemoveAfterArchive.Equals("Y") Then
                            LL = 1223
                            '** Remove this item from the existing folder.
                            LL = 1224
                            DeleteMsg = True
                            LL = 1225
                            If bMsgUnopened = False And ArchiveOnlyIfRead = "Y" Then
                                LL = 1226
                                DeleteMsg = True
                                LL = 1227
                            ElseIf ArchiveOnlyIfRead = "N" Then
                                LL = 1228
                                DeleteMsg = True
                                LL = 1229
                            Else
                                LL = 1230
                                If xDebug Then LOG.WriteToArchiveLog("No match ... ")
                                LL = 1231
                            End If
                            LL = 1232
                        End If
                        LL = 1233
                        If xDebug Then LOG.WriteToArchiveLog("ArchiveEmailsInFolder : found email already exists in " + tgtFolderName)
                        LL = 1235
                        If xDebug Then LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1005: " + EmailFolderFQN)
                        LL = 1236
                        GoTo LabelSkipThisEmail
                        LL = 1237
                    Else
                        LL = 1238

                        LL = 1239
                        If xDebug Then LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1006: " + EmailFolderFQN)
                        LL = 1240

                        LL = 1241
                        If xDebug Then LOG.WriteToArchiveLog("** ArchiveEmailsInFolder Curr Items : " + CurrMailFolderName + " : DOES NOT EXIST.")
                        LL = 1242
                        'Dim IX As Integer = EMAIL.cnt_EntryID(StoreID , EntryID )
                        LL = 1243
                        If RemoveAfterArchive.Equals("Y") Then
                            LL = 1244
                            If xDebug Then LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1007: " + EmailFolderFQN)
                            LL = 1245
                            If xDebug Then LOG.WriteToArchiveLog("ArchiveEmailsInFolder : found email needs to be removed - " + tgtFolderName)
                            LL = 1246
                            '** Remove this item from the existing folder.
                            LL = 1247
                            DeleteMsg = False
                            LL = 1248
                            If bMsgUnopened = False And ArchiveOnlyIfRead = "Y" Then
                                LL = 1249
                                'EM2D.Insert()
                                LL = 1250
                                DeleteMsg = True
                                LL = 1251
                            ElseIf ArchiveOnlyIfRead = "N" Then
                                LL = 1252
                                'EM2D.Insert()
                                LL = 1253
                                DeleteMsg = True
                                LL = 1254
                            Else
                                LL = 1255
                                If xDebug Then LOG.WriteToArchiveLog("No match ... ")
                                LL = 1256
                            End If
                            LL = 1257
                        End If
                        LL = 1258

                        LL = 1259
                    End If
                    LL = 1260

                    LL = 1261
                    If xDebug Then LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1008: " + EmailFolderFQN)
                    LL = 1262

                    LL = 1263
                    Application.DoEvents()
                    LL = 1264

                    LL = 1265
                    Dim CC As String = oMsg.CC
                    LL = 1266
                    Application.DoEvents()
                    LL = 1267
                    'EMAIL.setStoreID(StoreID )
                    LL = 1269
                    EMAIL.setEntryid(oMsg.EntryID)
                    LL = 1270
                    EMAIL.setEmailguid(EmailGuid)
                    LL = 1271

                    LL = 1272
                    If BCC <> Nothing Then
                        LL = 1273
                        AllRecipients = AllRecipients + "; " + BCC
                        LL = 1274
                    End If
                    LL = 1275
                    If CC <> Nothing Then
                        LL = 1276
                        AllRecipients = AllRecipients + "; " + CC
                        LL = 1277
                    End If

                    EMAIL.setAllrecipients(AllRecipients)
                    LL = 1279
                    EMAIL.setBcc(BCC)
                    LL = 1280
                    EMAIL.setBillinginformation(BillingInformation)
                    LL = 1281
                    EMAIL.setBody(UTIL.RemoveSingleQuotesV1(EmailBody))
                    LL = 1282
                    EMAIL.setCc(CC)
                    LL = 1283
                    EMAIL.setCompanies(Companies)
                    LL = 1284
                    EMAIL.setCreationtime(CreationTime)
                    LL = 1285
                    EMAIL.setCurrentuser(gCurrUserGuidID)
                    LL = 1286
                    EMAIL.setDeferreddeliverytime(DeferredDeliveryTime)
                    LL = 1287
                    EMAIL.setDeferreddeliverytime(DeferredDeliveryTime)
                    LL = 1288
                    EMAIL.setEmailguid(EmailGuid)
                    LL = 1289
                    'EMAIL.setEmailimage()
                    LL = 1290
                    Application.DoEvents()
                    LL = 1291
                    EMAIL.setExpirytime(ExpiryTime)
                    LL = 1292
                    EMAIL.setLastmodificationtime(LastModificationTime)
                    LL = 1293
                    EMAIL.setMsgsize(EmailSize.ToString)
                    LL = 1294
                    EMAIL.setReadreceiptrequested(OriginatorDeliveryReportRequested.ToString)
                    LL = 1295
                    EMAIL.setReceivedbyname(ReceivedByName)
                    LL = 1296
                    EMAIL.setReceivedtime(ReceivedTime)
                    LL = 1297

                    SenderEmailAddress = Mid(SenderEmailAddress, 1, 79)
                    EMAIL.setSenderemailaddress(SenderEmailAddress)
                    LL = 1298

                    SenderName = Mid(SenderName, 1, 79)
                    EMAIL.setSendername(SenderName)
                    LL = 1299

                    EMAIL.setSensitivity(Sensitivity)
                    LL = 1300
                    EMAIL.setSenton(SentOn)
                    LL = 1301
                    EMAIL.setSourcetypecode(SourceTypeCode)
                    LL = 1302
                    'EMAIL.setOriginalfolder(OriginalFolder )

                    EMAIL.setOriginalfolder(EmailFolderFQN)
                    LL = 1304

                    AllRecipients = AllRecipients.Trim
                    LL = 1306
                    If SentTo.Length > 0 Then
                        LL = 1307
                        Dim ch As String = Mid(SentTo, 1, 1)
                        LL = 1308
                        If ch.Equals(";") Then
                            LL = 1309
                            Mid(SentTo, 1, 1) = " "
                            LL = 1310
                            SentTo = SentTo.Trim
                            LL = 1311
                        End If
                        LL = 1312
                    End If
                    LL = 1313
                    EMAIL.setSentto(SentTo)
                    LL = 1314

                    LL = 1315
                    EMAIL.setSubject(UTIL.RemoveSingleQuotesV1(Subject))
                    LL = 1316
                    Dim ShortSubj As String = Mid(Subject, 1, 240)
                    LL = 1317
                    EMAIL.setShortsubj(UTIL.RemoveSingleQuotesV1(ShortSubj))
                    LL = 1318
                    Dim MailAdded As Boolean = False
                    LL = 1319

                    LL = 1320
                    Dim TempEmailDir As String = UTIL.getTempProcessingDir
                    LL = 1321
                    TempEmailDir = TempEmailDir + "\EmailUpload\"
                    TempEmailDir = TempEmailDir.Replace("\\", "\")

                    If Not Directory.Exists(TempEmailDir) Then
                        Directory.CreateDirectory(TempEmailDir)
                    End If

                    EmailFQN = TempEmailDir + "\" + EmailGuid + ".MSG"
                    EmailFQN = EmailFQN.Replace("\\", "\")

                    Dim originalName As String = EmailGuid + ".MSG"
                    LL = 1322
                    For xx As Integer = 1 To EmailFQN.Length
                        Application.DoEvents()
                        LL = 1323
                        Dim ch As String = Mid(EmailFQN, xx, 1)
                        LL = 1324
                        If ch = "@" Then
                            LL = 1325
                            Mid(EmailFQN, xx, 1) = "_"
                            LL = 1326
                        End If
                        LL = 1327
                        If ch = "-" Then
                            LL = 1328
                            Mid(EmailFQN, xx, 1) = "_"
                            LL = 1329
                        End If
                        LL = 1330
                    Next
                    LL = 1331

                    Try
                        '** Save the message as a file here and prepare to upload the file to the server a little later.
                        oMsg.SaveAs(EmailFQN)
                    Catch ex As Exception
                        LOG.WriteToNoticeLog("WARNING clsArchiver : ArchiveEmailsInFolder 771-77a LL:" + LL.ToString + " : " + ex.Message)
                        LOG.WriteToNoticeLog("WARNING clsArchiver : ArchiveEmailsInFolder 771-77b LL:" + LL.ToString + " : " + tgtFolderName)
                    End Try

                    LL = 1333
                    Dim BB As Boolean = False
                    LL = 1334
                    If ArchiveEmails.Length = 0 Then
                        LL = 1335
                        ArchiveEmails = "Y"
                        LL = 1336
                    End If
                    LL = 1337
                    Application.DoEvents()
                    LL = 1338

                    LL = 1339
                    If xDebug Then LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1009: " + EmailFolderFQN)
                    LL = 1340

                    UTIL.StripSemiColon(AllRecipients)
                    UTIL.StripSingleQuotes(AllRecipients)
                    UTIL.StripSemiColon(CC)
                    UTIL.StripSingleQuotes(CC)
                    UTIL.StripSemiColon(SenderName)
                    UTIL.StripSingleQuotes(SenderName)
                    UTIL.StripSingleQuotes(SentTo)
                    UTIL.StripSemiColon(SentTo)
                    UTIL.StripSingleQuotes(SenderEmailAddress)
                    UTIL.StripSemiColon(SenderEmailAddress)
                    UTIL.StripSemiColon(ReceivedByName)
                    UTIL.StripSingleQuotes(ReceivedByName)
                    UTIL.StripSemiColon(BCC)
                    UTIL.StripSingleQuotes(BCC)

                    LL = 1341
                    If ArchiveEmails.Equals("Y") Then
                        LL = 1342
                        If xDebug Then LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1010: " + EmailFolderFQN)
                        LL = 1343
                        Dim bx As Integer = EMAIL.cnt_FULL_UI_EMAIL(EmailIdentifier)

                        LL = 1344
                        If bx = 0 Then
                            LL = 1345

                            Dim CRC As String = ENC.GenerateSHA512HashFromFile(EmailFQN)
                            Dim ImageHash As String = ENC.GenerateSHA512HashFromFile(EmailFQN)

                            '** The EMAIL does not exist, ADD a record to the ContentUser table

                            BB = EMAIL.InsertNewEmail(gMachineID, gNetworkID, "MSG", EmailIdentifier, CRC, EmailFolderFQN)
                            LL = 1348
                            gEmailsAdded += 1
                            LL = 1349
                            If BB Then

                                frmNotify2.lblFolder.Text = Subject
                                bMailAlreadyUploaded = DBLocal.addOutlook(EmailIdentifier)
                                If Not slStoreId.ContainsKey(EmailIdentifier) Then
                                    slStoreId.Add(EmailIdentifier, i)
                                End If

                                EmailsBackedUp += 1
                                Application.DoEvents()
                                ID = 5555.1
                                '*******************************************************************************
                                '** Add the EMAIL as a File to the repository
                                '** Call Filestream service or standard service here
                                Dim bMail As Boolean = UpdateEmailMsg(originalName, ID, UID, EmailFQN, EmailGuid, RetentionCode, isPublic, CRC, tgtFolderName)
                                '*******************************************************************************
                                If bMail = False Then
                                    LL = 1355
                                    Dim fExt As String = UTIL.getFileSuffix(EmailFQN)
                                    If fExt.ToUpper.Equals(".MSG") Or fExt.ToUpper.Equals("MSG") Then
                                        Dim TempFQN As String = ""
                                        Dim BBX As Boolean = False
                                        If fExt.ToUpper.Equals(".MSG") Or fExt.ToUpper.Equals("MSG") Then
                                            EmailFQN = Mid(EmailFQN, 1, InStr(EmailFQN, ".MSG", CompareMethod.Text) - 1)
                                            ID = 5555.2
                                            If File.Exists(EmailFQN) Then
                                                '*******************************************************************************
                                                '** Add the EMAIL as a File to the repository
                                                '** Call Filestream service or standard service here
                                                BBX = UpdateEmailMsg(originalName, ID, UID, EmailFQN, EmailGuid, RetentionCode, isPublic, CRC, tgtFolderName)
                                                '*******************************************************************************
                                                If BBX = True Then
                                                    EMAIL.setSourcetypecode("EML")
                                                    DBLocal.addOutlook(EmailIdentifier)
                                                Else
                                                    '** It failed again, SKIP IT.
                                                    LOG.WriteToArchiveLog("ERROR 299a: Failed to add email" + EmailFQN)
                                                    GoTo LabelSkipThisEmail
                                                End If
                                            End If
                                        End If
                                    End If
                                End If

                                '************************************************
                                '**  Add the key to the Local DBARCH lookup database
                                Dim bExists As Boolean = DBLocal.OutlookExists(EmailIdentifier)
                                If Not bExists Then
                                    DBLocal.addOutlook(EmailIdentifier)
                                End If
                                '************************************************

                                LL = 1356
                                Dim sSql As String = "Update EMAIL set CurrMailFolderID = '" + CurrMailFolderID + "' where EmailGuid = '" + EmailGuid + "'"
                                LL = 1357
                                Dim bbExec As Boolean = ExecuteSqlNewConn(sSql, False)
                                LL = 1358
                                If Not bbExec Then
                                    LL = 1359
                                    LOG.WriteToArchiveLog("ERROR: 1234.99a")
                                    LL = 1360
                                End If
                                LL = 1361

                                sSql = "Update EMAIL set RetentionExpirationDate = '" + RetentionExpirationDate + "' where EmailGuid = '" + EmailGuid + "'"
                                LL = 1371
                                bbExec = ExecuteSqlNewConn(sSql, False)
                                LL = 1372
                                If Not bbExec Then
                                    LL = 1373
                                    LOG.WriteToArchiveLog("ERROR: 1234.99c")
                                    LL = 1374
                                End If
                                LL = 1375
                                sSql = "Update EMAIL set RetentionCode = '" + RetentionCode + "' where EmailGuid = '" + EmailGuid + "'"
                                LL = 1376
                                bbExec = ExecuteSqlNewConn(sSql, False)
                                LL = 1377
                                If Not bbExec Then
                                    LL = 1378
                                    LOG.WriteToArchiveLog("ERROR: 1234.99c")
                                    LL = 1379
                                End If
                                LL = 1380

                                LL = 1381
                                If xDebug Then LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1013: " + EmailFolderFQN)
                                LL = 1382
                                setRetentionDate(EmailGuid, RetentionCode, ".MSG")
                                LL = 1383

                                LL = 1384
                                If EmailLibrary.Trim.Length > 0 Then
                                    LL = 1385
                                    AddLibraryItem(EmailGuid, ShortSubj, ".MSG", EmailLibrary)
                                    LL = 1386
                                End If
                                LL = 1387
                                Application.DoEvents()
                                LL = 1389
                                If xDebug Then LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1014: " + EmailFolderFQN)
                                LL = 1390

                                LL = 1391
                                MailAdded = True
                                LL = 1392
                            Else
                                MailAdded = False
                                LL = 1398
                            End If
                            LL = 1399
                        Else
                            LL = 1400
                            BB = True
                            LL = 1401
                            MailAdded = False
                            LL = 1402
                        End If
                        LL = 1403
                        If BB Then
                            LL = 1404
                            Dim bAddHash As Boolean = False
                            If bAddHash Then
                                EmailAddHash(EmailGuid, EmailIdentifier)
                            End If
                            LL = 1405
                            If File.Exists(EmailFQN) Then
                                Kill(EmailFQN) : LL = 1407
                            End If
                            DeleteMsg = True
                            LL = 1408
                        Else
                            LL = 1409
                            If xDebug Then LOG.WriteToArchiveLog("Error 623.45 - Failed to delete temp email file : " + Subject)
                            LL = 1410
                            If xDebug Then LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1017: " + EmailFolderFQN)
                            LL = 1411
                            MailAdded = False
                            LL = 1412
                            GoTo LabelSkipThisEmail2
                            LL = 1413
                        End If
                        LL = 1414
                    End If
                    LL = 1415

                    LL = 1416
                    If xDebug Then LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1018: " + EmailFolderFQN)
                    LL = 1417

                    LL = 1418
                    If ArchiveEmails.Equals("N") And ArchiveAfterXDays.Equals("Y") Then
                        LL = 1419
                        If xDebug Then LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1019: " + EmailFolderFQN)
                        LL = 1420
                        Dim elapsed_time As TimeSpan
                        LL = 1421
                        If UCase(CurrName).Equals("SENT ITEMS") Then
                            LL = 1422
                            elapsed_time = CurrDateTime.Subtract(SentOn)
                            LL = 1423
                        Else
                            LL = 1424
                            elapsed_time = CurrDateTime.Subtract(CreationTime)
                            LL = 1425
                        End If
                        LL = 1426
                        'elapsed_time = ReceivedTime.Subtract(CurrDateTime)
                        LL = 1427
                        Dim ElapsedDays As Integer = elapsed_time.TotalDays
                        LL = 1428
                        If ElapsedDays >= XDaysRemove Then
                            LL = 1429
                            If xDebug Then LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1020: " + EmailFolderFQN)
                            LL = 1430
                            Dim bx As Boolean = EMAIL.cnt_FULL_UI_EMAIL(EmailIdentifier)
                            LL = 1431
                            If bx = 0 Then
                                LL = 1432
                                If xDebug Then LOG.WriteToArchiveLog("ArchiveEmailsInFolder 101 : added email  - " + tgtFolderName)
                                LL = 1433
                                'BB = ArchiveEmail(EmailFQN, EmailGuid, Subject , AllRecipients , EmailBody, BCC , BillingInformation , CC , Companies , CreationTime, ReadReceiptRequested.ToString, ReceivedByName , ReceivedTime, AllRecipients , gCurrUserGuidID, SenderEmailAddress , SenderName , Sensitivity , SentOn, EmailSize, DeferredDeliveryTime, EntryID , ExpiryTime, LastModificationTime, ShortSubj , SourceTypeCode , OriginalFolder )
                                LL = 1434
                                Dim CRC As String = ENC.GenerateSHA512HashFromFile(FQN)
                                Dim ImageHash As String = ENC.GenerateSHA512HashFromFile(FQN)

                                BB = EMAIL.InsertNewEmail(gMachineID, gNetworkID, "MSG", EmailIdentifier, CRC, EmailFolderFQN)

                                bMailAlreadyUploaded = DBLocal.addOutlook(EmailIdentifier)
                                If slStoreId.ContainsKey(EmailIdentifier) Then
                                    slStoreId.Add(EmailIdentifier, i)
                                End If

                                Application.DoEvents()
                                LL = 1435
                                gEmailsAdded += 1
                                LL = 1436
                                If BB Then
                                    LL = 1437
                                    EmailsBackedUp += 1
                                    LL = 1438
                                    'InsertEmailBinary(EmailFQN, EmailGuid)
                                    LL = 1439
                                    ID = 5555.3
                                    '*******************************************************************************
                                    '** Add the EMAIL as a File to the repository
                                    '** Call Filestream service or standard service here
                                    Dim bMail As Boolean = UpdateEmailMsg(originalName, ID, UID, EmailFQN, EmailGuid, RetentionCode, isPublic, CRC, tgtFolderName)
                                    '*******************************************************************************
                                    If bMail = False Then
                                        EmailAddHash(EmailGuid, EmailIdentifier)
                                        Dim fExt As String = UTIL.getFileSuffix(EmailFQN)
                                        If fExt.ToUpper.Equals(".MSG") Or fExt.ToUpper.Equals("MSG") Then
                                            Dim TempFQN As String = ""
                                            Dim BBX As Boolean = False
                                            If fExt.ToUpper.Equals(".MSG") Or fExt.ToUpper.Equals("MSG") Then
                                                EmailFQN = Mid(EmailFQN, 1, InStr(EmailFQN, ".MSG", CompareMethod.Text) - 1)
                                                ID = 5555.4
                                                '*******************************************************************************
                                                '** Add the EMAIL as a File to the repository
                                                '** Call Filestream service or standard service here
                                                BBX = UpdateEmailMsg(originalName, ID, UID, EmailFQN, EmailGuid, RetentionCode, isPublic, CRC, tgtFolderName)
                                                '*******************************************************************************
                                                If BBX = True Then
                                                    DBLocal.addOutlook(EmailIdentifier)
                                                    EMAIL.setSourcetypecode("EML")
                                                Else
                                                    '** It failed again, SKIP IT.
                                                    LOG.WriteToArchiveLog("ERROR 299b: Failed to add email" + EmailFQN)
                                                    GoTo LabelSkipThisEmail
                                                End If
                                            End If
                                        End If
                                    Else
                                        EmailAddHash(EmailGuid, EmailIdentifier)
                                    End If

                                    LL = 1440
                                    MailAdded = True
                                    'LL = 1441
                                    'Dim sSql  = "Update EMAIL set CurrMailFolderID = '" + CurrMailFolderID + "' where EmailGuid = '" + EmailGuid + "'"
                                    'LL = 1442
                                    'Dim bbExec As Boolean = ExecuteSqlNewConn(sSql, False)
                                    'LL = 1443
                                    'If Not bbExec Then
                                    '    LL = 1444
                                    '    LOG.WriteToArchiveLog("ERROR: 1234.99")
                                    '    LL = 1445
                                    'End If
                                    'LL = 1446

                                    LL = 1447

                                    Dim HexCrc As String = ENC.GenerateSHA512HashFromFile(FQN)
                                    ImageHash = ENC.GenerateSHA512HashFromFile(FQN)

                                    LL = 1448
                                    Dim sSql As String = "Update EMAIL set CRC = '" + HexCrc + "' where EmailGuid = '" + EmailGuid + "'"
                                    LL = 1449
                                    Dim bbExec As Boolean = ExecuteSqlNewConn(sSql, False)
                                    LL = 1450
                                    If Not bbExec Then
                                        LL = 1451
                                        LOG.WriteToArchiveLog("ERROR: 1234.99")
                                        LL = 1452
                                    End If
                                    LL = 1453
                                End If
                                LL = 1454
                                If BB Then
                                    LL = 1455
                                    'BB = UpdateEmailMsg(EmailFQN, EmailGuid)
                                    LL = 1456
                                    Kill(EmailFQN)
                                    LL = 1457
                                    MailAdded = True
                                    LL = 1458
                                Else
                                    LL = 1459
                                    If xDebug Then LOG.WriteToArchiveLog("ArchiveEmailsInFolder 101 : failed to add email  - " + tgtFolderName)
                                    LL = 1460
                                    MailAdded = False
                                    LL = 1461
                                    GoTo LabelSkipThisEmail2
                                    LL = 1462
                                End If
                                LL = 1463
                            End If
                            LL = 1464
                        Else
                            LL = 1465
                            If xDebug Then LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1021: " + EmailFolderFQN)
                            LL = 1466
                            DeleteMsg = False
                            LL = 1467
                            MailAdded = False
                            LL = 1468
                            If xDebug Then LOG.WriteToArchiveLog("ArchiveEmailsInFolder 105 : skipped email  - " + tgtFolderName)
                            LL = 1470
                            GoTo LabelSkipThisEmail
                            LL = 1471
                        End If
                        LL = 1472
                    End If
                    LL = 1473

                    LL = 1474
                    Application.DoEvents()
                    LL = 1475

                    LL = 1476
                    If xDebug Then LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1022: " + EmailFolderFQN)
                    LL = 1477

                    LL = 1478
                    If MailAdded Then
                        LL = 1479
                        If xDebug Then LOG.WriteToArchiveLog("ADDED ** ArchiveEmailsInFolder 1023: " + EmailFolderFQN)
                        LL = 1480
                        SL2.Clear()
                        LL = 1481
                        If Not CC Is Nothing Then
                            LL = 1482
                            If CC.Trim.Length > 0 Then
                                LL = 1483
                                Dim A(0) As String
                                LL = 1484
                                If InStr(1, CC, ";") > 0 Then
                                    LL = 1485
                                    A = Split(CC, ";")
                                    LL = 1486
                                Else
                                    LL = 1487
                                    A(0) = CC
                                    LL = 1488
                                End If
                                LL = 1489
                                For KK = 0 To UBound(A)
                                    LL = 1490
                                    Dim SKEY As String = A(KK)
                                    LL = 1491
                                    If Not SKEY Is Nothing Then
                                        LL = 1492
                                        Dim BX As Boolean = SL.ContainsKey(SKEY)
                                        LL = 1493
                                        If Not BX Then
                                            LL = 1494
                                            SL2.Add(SKEY, "CC")
                                            LL = 1495
                                        End If
                                        LL = 1496
                                    End If
                                    LL = 1497
                                Next
                                LL = 1498
                            End If
                            LL = 1499
                        End If
                        LL = 1500
                        If Not BCC Is Nothing Then
                            LL = 1501
                            If BCC.Trim.Length > 0 Then
                                LL = 1502
                                Dim A(0) As String
                                LL = 1503
                                If InStr(1, BCC, ";") > 0 Then
                                    LL = 1504
                                    A = Split(BCC, ";")
                                    LL = 1505
                                Else
                                    LL = 1506
                                    A(0) = BCC
                                    LL = 1507
                                End If
                                LL = 1508
                                For KK = 0 To UBound(A)
                                    LL = 1509
                                    Dim SKEY As String = A(KK)
                                    LL = 1510
                                    If Not SKEY Is Nothing Then
                                        LL = 1511
                                        Dim BX As Boolean = SL.ContainsKey(SKEY)
                                        LL = 1512
                                        If Not BX Then
                                            LL = 1513
                                            SL2.Add(SKEY, "BCC")
                                            LL = 1514
                                        End If
                                        LL = 1515
                                    End If
                                    LL = 1516
                                Next
                                LL = 1517
                            End If
                            LL = 1518
                        End If
                        LL = 1519

                        LL = 1520
                        For KK = 1 To oMsg.Recipients.Count
                            Application.DoEvents()
                            LL = 1521
                            If xDebug Then If xDebug Then LOG.WriteToArchiveLog("Recipients Address: " + oMsg.Recipients.Item(KK).Address)
                            LL = 1522
                            If xDebug Then If xDebug Then LOG.WriteToArchiveLog("Recipients Name   : " + oMsg.Recipients.Item(KK).Name)
                            LL = 1523
                            Dim Addr As String = oMsg.Recipients.Item(KK).Address.ToString
                            Try
                                LL = 1523.1
                                Addr = oMsg.Recipients.Item(KK).Address.ToString
                            Catch ex As Exception
                                LL = 1523.2
                                LOG.WriteToErrorLog("WARNING 1523.2 : skipped Recipient : " + ex.Message)
                                GoTo SKIP2NEXT
                            End Try
                            LL = 1524
                            RECIPS.setEmailguid(EmailGuid)
                            LL = 1525
                            RECIPS.setRecipient(Addr)
                            LL = 1526
                            Dim BX As Boolean = SL2.ContainsKey(Addr)
                            LL = 1527
                            If Not BX Then
                                LL = 1528
                                RECIPS.setTyperecp("RECIP")
                                LL = 1529
                            Else
                                LL = 1530
                                Dim iKey As Integer = SL2.IndexOfKey(Addr)
                                LL = 1531
                                Dim TypeCC As String = ""
                                LL = 1532
                                TypeCC = SL2.Item(Addr).ToString
                                LL = 1533
                                RECIPS.setTyperecp(TypeCC)
                                LL = 1534
                            End If
                            LL = 1535
                            RECIPS.Insert()
SKIP2NEXT:
                            LL = 1536
                        Next
                        LL = 1537

                        LL = 1538
                        Dim iAtachCount As Integer = oMsg.Attachments.Count
                        LL = 1539

                        If iAtachCount > 0 Then
                            Application.DoEvents()
                            LL = 1540
                            Dim Atmt As Outlook.Attachment
                            LL = 1541
                            Dim iAcount As Integer = 0
                            Dim filenameToDelete As String = ""
                            For Each Atmt In oMsg.Attachments
                                Try
                                    LL = 1542
                                    Dim TempDir As String = UTIL.getTempProcessingDir + "\EmailTempLoad\"
                                    TempDir = TempDir.Replace("\\", "\")

                                    If Not Directory.Exists(TempDir) Then
                                        Directory.CreateDirectory(TempDir)
                                    End If

                                    LL = 1544
                                    Dim filename As String = TempDir + Atmt.FileName
                                    filename = filename.Replace("\\", "\")

                                    filenameToDelete = filename
                                    filenameToDelete = filenameToDelete.Replace("//", "/")

                                    frmNotify2.BackColor = Color.LightSalmon
                                    frmNotify2.lblMsg2.BackColor = Color.Gray
                                    frmNotify2.lblMsg2.Text = ">> " + Atmt.FileName.ToString
                                    frmNotify2.lblMsg2.Refresh()
                                    frmNotify2.Refresh()

                                    LL = 1546
                                    Atmt.SaveAsFile(filename)
                                    LL = 1547

                                    Dim FileExt As String = "." + UTIL.getFileSuffix(filename)
                                    LL = 1549

                                    Dim bCnt As Integer = ATYPE.cnt_PK29(FileExt)
                                    LL = 1550
                                    Dim isZipFile As Boolean = False
                                    LL = 1551
                                    If bCnt = 0 Then
                                        LL = 1552
                                        Dim B1 As Boolean = ZF.isZipFile(filename)
                                        LL = 1553
                                        If B1 Then
                                            ATYPE.setIszipformat("1")
                                            LL = 1555
                                            isZipFile = True
                                            LL = 1556
                                        Else
                                            LL = 1557
                                            ATYPE.setIszipformat("0")
                                            LL = 1558
                                            isZipFile = False
                                            LL = 1559
                                        End If
                                        LL = 1560
                                        ATYPE.setAttachmentcode(FileExt)
                                        LL = 1561
                                        ATYPE.Insert()
                                        LL = 1562
                                    End If
                                    LL = 1563
                                    Dim BBB As Boolean = ZF.isZipFile(filename)
                                    LL = 1564
                                    ATYPE.setDescription("Auto added this code.")
                                    LL = 1565
                                    If BBB Then
                                        LL = 1566
                                        ATYPE.setIszipformat("1")
                                        LL = 1567
                                        isZipFile = True
                                        LL = 1568
                                    Else
                                        LL = 1569
                                        ATYPE.setIszipformat("0")
                                        LL = 1570
                                        isZipFile = False
                                        LL = 1571
                                    End If
                                    LL = 1572
                                    If isZipFile = True Then
                                        LL = 1573
                                        '** Explode and load
                                        LL = 1574
                                        'WDM ZIPFILE
                                        LL = 1575
                                        Dim AttachmentName As String = Atmt.FileName
                                        LL = 1576
                                        Dim SkipIfAlreadyArchived As Boolean = False
                                        DBLocal.addZipFile(filename, EmailGuid, True)
                                        LL = 1577
                                        ListOfFiles.Clear()
                                        'ZF.ProcessEmailZipFile(EmailGuid, filename, gCurrUserGuidID, SkipIfAlreadyArchived, AttachmentName, StackLevel, ListOfFiles)
                                        ZF.ProcessEmailZipFile(gMachineID, EmailGuid, filename, UID, SkipIfAlreadyArchived, AttachmentName, StackLevel, ListOfFiles)
                                        LL = 1578
                                    Else
                                        LL = 1579
                                        FileExt = "." + UTIL.getFileSuffix(filename)
                                        LL = 1580
                                        Dim AttachmentName As String = Atmt.FileName
                                        If InStr(AttachmentName, "dmaquestion") > 0 Or InStr(AttachmentName, "Workbook") > 0 Or InStr(AttachmentName, "girl") > 0 Then
                                            Console.WriteLine("here 001xx")
                                        End If

                                        Dim Sha1Hash As String = ENC.GenerateSHA512HashFromFile(filename)
                                        Dim ImageHash As String = ENC.GenerateSHA512HashFromFile(filename)

                                        Dim iFileID As Integer = DBLocal.GetFileID(filename, Sha1Hash)

                                        If iFileID < 0 Then
                                            Dim strRowGuid As String = InsertAttachmentFqn(gCurrUserGuidID, filename, EmailGuid, AttachmentName, FileExt, gCurrUserGuidID, RetentionCode, Sha1Hash, isPublic, EmailFolderFQN)
                                        End If
                                        LL = 1582
                                        If InStr(FileExt, "trf", Microsoft.VisualBasic.CompareMethod.Text) > 0 Then
                                            Console.WriteLine("Here TRF")
                                        End If
                                        Dim bIsImage As Boolean = isImageFile(FileExt)
                                        LL = 1583

                                    End If
                                    If FileExt.ToUpper.Equals(".MSG") Or FileExt.ToUpper.Equals("MSG") Then
                                        Dim EMX As New clsEmailFunctions
                                        Dim xAttachedFiles As New List(Of String)

                                        If File.Exists(filename) Then
                                            Dim EmailDescription As String = ""
                                            EMX.LoadMsgFile(UID, filename, ServerName, CurrMailFolderName, EmailLibrary, RetentionCode, Subject, EmailBody, xAttachedFiles, False, EmailGuid, EmailDescription)

                                            If EmailDescription.Length > 0 Then
                                                EmailDescription = UTIL.RemoveSingleQuotes(EmailDescription)
                                                concatEmailBody(EmailDescription, EmailGuid)
                                            End If

                                        End If

                                        EMX = Nothing
                                        GC.Collect()
                                        GC.WaitForPendingFinalizers()
                                    End If
                                    LL = 1596
                                    frmNotify2.BackColor = Color.LightGray
                                    frmNotify2.Refresh()

                                    'Dim bOcrNeeded As Boolean = DBARCH.ckOcrNeededFileExt
                                    'If bOcrNeeded Then
                                    '    DBARCH.SetOcrProcessingParms(SourceGuid, "C", filename
                                    'End If
                                Catch ex As Exception
                                    LOG.WriteToArchiveLog("ERROR  -   ARCHIVE OCR: 100 - " + ex.Message)
                                Finally
                                    Try
                                        Kill(filenameToDelete)
                                        frmNotify2.lblFolder.Text = "done"
                                        frmNotify2.lblMsg2.Text = Now.ToString
                                        frmNotify2.lblMsg2.Refresh()
                                    Catch ex As Exception
                                        LOG.WriteToArchiveLog("Notification: " + filenameToDelete + " not deleted.")
                                    End Try
                                End Try
                            Next Atmt
                            GC.Collect()
                            GC.WaitForPendingFinalizers()
                            Application.DoEvents()
                            LL = 1598
                        End If
                        LL = 1599
                    Else
                        LL = 1600
                        If xDebug Then LOG.WriteToArchiveLog("SKIPPED ** ArchiveEmailsInFolder 1099: " + EmailFolderFQN)
                        LL = 1601
                    End If
                    LL = 1602

                    LL = 1603
                    Application.DoEvents()
                    LL = 1604

                    LL = 1605
LabelSkipThisEmail:
                    LL = 1606

                    LL = 1607
                    Application.DoEvents()
                    LL = 1608
                    '** Now, check for the processing rules ***************
                    LL = 1609
                    If RemoveAfterXDays.Equals("Y") Then ' And RemoveAfterArchive .Equals("N") Then
                        LL = 1610
                        Dim elapsed_time As TimeSpan
                        LL = 1611
                        If UCase(CurrName).Equals("SENT ITEMS") Then
                            LL = 1612
                            elapsed_time = CurrDateTime.Subtract(SentOn)
                            LL = 1613
                        Else
                            LL = 1614
                            elapsed_time = CurrDateTime.Subtract(CreationTime)
                            LL = 1615
                        End If
                        LL = 1616
                        'elapsed_time = ReceivedTime.Subtract(CurrDateTime)
                        LL = 1617
                        Dim ElapsedDays As Integer = elapsed_time.TotalDays
                        LL = 1618
                        If ElapsedDays > 1000 Then
                            LL = 1619
                            ElapsedDays = 30
                            LL = 1620
                            SentOn = oMsg.SentOn
                            LL = 1621
                            ReceivedTime = oMsg.ReceivedTime
                            LL = 1622
                            CreationTime = oMsg.CreationTime
                            LL = 1623
                            elapsed_time = CurrDateTime.Subtract(CreationTime)
                            LL = 1624
                            'elapsed_time = ReceivedTime.Subtract(CurrDateTime)
                            LL = 1625
                            ElapsedDays = elapsed_time.TotalDays
                            LL = 1626
                        End If
                        LL = 1627

                        LL = 1628
                        If ElapsedDays < 0 Then
                            LL = 1629
                            ElapsedDays = 30
                            LL = 1630
                            SentOn = oMsg.SentOn
                            LL = 1631
                            ReceivedTime = oMsg.ReceivedTime
                            LL = 1632
                            CreationTime = oMsg.CreationTime
                            LL = 1633
                            elapsed_time = CurrDateTime.Subtract(CreationTime)
                            LL = 1634
                            'elapsed_time = ReceivedTime.Subtract(CurrDateTime)
                            LL = 1635
                            ElapsedDays = elapsed_time.TotalDays
                            LL = 1636
                        End If
                        LL = 1637

                        LL = 1638
                        If ElapsedDays >= XDaysRemove Then
                            LL = 1639
                            If xDebug Then LOG.WriteToArchiveLog(CurrOutlookSubFolder.Name + ": Deleted ElapsedDays email... " & i & ":" & ElapsedDays & " days old.")
                            LL = 1640
                            'oMsg.Display()
                            LL = 1641

                            LL = 1642
                            EM2D.setEmailguid(EmailGuid)
                            LL = 1643
                            EM2D.setStoreid(StoreID)
                            LL = 1644
                            EM2D.setUserid(gCurrUserGuidID)
                            LL = 1645
                            EM2D.setMessageid(oMsg.EntryID)
                            LL = 1646
                            If bMsgUnopened = False And ArchiveOnlyIfRead = "Y" Then
                                LL = 1647
                                'log.WriteToArchiveLog("clsArchiver : xGetEmails: Marked File for deletion #102")
                                LL = 1648
                                Dim BK As Boolean = EM2D.Insert()
                                LL = 1649
                                If BK Then
                                    LL = 1650
                                    'if xDebug then log.WriteToArchiveLog("oMsg.Delete()")
                                    LL = 1651
                                    'oMsg.Delete()
                                    LL = 1652
                                    If bMoveIt Then
                                        LL = 1653
                                        'oMsg.Move(oDeletedItems)
                                        MoveToHistoryFolder(oMsg)
                                        LL = 1654
                                        LOG.WriteToArchiveLog("clsArchiver : GetEmailFolders : Delete Performed 02")
                                        LL = 1655
                                    End If
                                    LL = 1656

                                    LL = 1657
                                End If
                                LL = 1658
                            ElseIf ArchiveOnlyIfRead = "N" Then
                                LL = 1659
                                Dim ExecuteThis As Boolean = True
                                LL = 1660

                                LL = 1661
                                Dim BK As Boolean = EM2D.Insert()
                                LL = 1662
                                'log.WriteToArchiveLog("clsArchiver : xGetEmails: Marked File for deletion #103")
                                LL = 1663
                                If BK Then
                                    LL = 1664
                                    If xDebug Then LOG.WriteToArchiveLog("oMsg.Delete()")
                                    LL = 1665
                                    If ExecuteThis = True Then
                                        LL = 1666
                                        If bMoveIt Then
                                            LL = 1667
                                            LOG.WriteToArchiveLog("clsArchiver : GetEmailFolders : Delete Performed 03")
                                            LL = 1668
                                            'oMsg.Move(oDeletedItems)
                                            MoveToHistoryFolder(oMsg)
                                            LL = 1669
                                        End If
                                        LL = 1670
                                    End If
                                    LL = 1671
                                End If
                                LL = 1672
                            Else
                                LL = 1673
                                If xDebug Then LOG.WriteToArchiveLog("No match ... ")
                                LL = 1674
                            End If
                            LL = 1676
                            'if xDebug then log.WriteToArchiveLog("oMsg.Delete()")
                            LL = 1677
                            GoTo LabelSkipThisEmail2
                            LL = 1678
                        End If
                        LL = 1679
                    End If
                    LL = 1680
                    Application.DoEvents()
                    LL = 1681
                    '** Delete the archived MSG from the archive directory
                    LL = 1682
                    If RemoveAfterArchive.Equals("Y") And DeleteMsg Then
                        LL = 1683
                        If xDebug Then LOG.WriteToArchiveLog(CurrOutlookSubFolder.Name + ": Deleted email... ")
                        LL = 1684
                        'oMsg.Display()
                        LL = 1685
                        'If bMsgUnopened = False And ArchiveOnlyIfRead  = "Y" Then
                        LL = 1686
                        EM2D.setEmailguid(EmailGuid)
                        LL = 1687
                        EM2D.setStoreid(StoreID)
                        LL = 1688
                        EM2D.setUserid(gCurrUserGuidID)
                        LL = 1689
                        EM2D.setMessageid(oMsg.EntryID)
                        LL = 1690
                        If bMsgUnopened = False And ArchiveOnlyIfRead = "Y" Then
                            LL = 1691
                            Dim BK As Boolean = EM2D.Insert()
                            LL = 1692
                            'log.WriteToArchiveLog("clsArchiver : xGetEmails: Marked File for deletion #104")
                            LL = 1693
                            If BK Then
                                LL = 1694
                                If xDebug Then LOG.WriteToArchiveLog("oMsg.Delete()")
                                LL = 1695
                                'oMsg.Delete()
                                LL = 1696
                                Dim ExecuteThis As Boolean = False
                                LL = 1697
                                If ExecuteThis = True Then
                                    LL = 1698
                                    If bMoveIt Then
                                        LL = 1699
                                        LOG.WriteToArchiveLog("clsArchiver : GetEmailFolders : Delete Performed 04")
                                        LL = 1700
                                        'oMsg.Move(oDeletedItems)
                                        MoveToHistoryFolder(oMsg)
                                        LL = 1701
                                    End If
                                    LL = 1702
                                End If
                                LL = 1703
                            End If
                            LL = 1704
                        ElseIf ArchiveOnlyIfRead = "N" Then
                            LL = 1705
                            Dim BK As Boolean = EM2D.Insert()
                            LL = 1706
                            'log.WriteToArchiveLog("clsArchiver : xGetEmails: Marked File for deletion #105")
                            LL = 1707
                            If BK Then
                                LL = 1708
                                If xDebug Then LOG.WriteToArchiveLog("oMsg.Delete()")
                                LL = 1709
                                'oMsg.Delete()
                                LL = 1710
                                If bMoveIt Then
                                    LL = 1711
                                    LOG.WriteToArchiveLog("clsArchiver : GetEmailFolders : Delete Performed 05")
                                    LL = 1712
                                    'oMsg.Move(oDeletedItems)
                                    MoveToHistoryFolder(oMsg)
                                    LL = 1713
                                End If
                                LL = 1715
                            End If
                            LL = 1716
                        Else
                            LL = 1717
                            If xDebug Then LOG.WriteToArchiveLog("No match ... ")
                            LL = 1718
                        End If
                        LL = 1719

                        LL = 1720
                        'End If
                        LL = 1721
                    ElseIf bRemoveAfterArchive Then
                        LL = 1722
                        If xDebug Then LOG.WriteToArchiveLog(CurrOutlookSubFolder.Name + ": Deleted email... ")
                        LL = 1723
                        'oMsg.Display()
                        LL = 1724
                        'If bMsgUnopened = False And ArchiveOnlyIfRead  = "Y" Then
                        LL = 1725
                        EM2D.setEmailguid(EmailGuid)
                        LL = 1726
                        EM2D.setStoreid(StoreID)
                        LL = 1727
                        EM2D.setUserid(gCurrUserGuidID)
                        LL = 1728
                        EM2D.setMessageid(oMsg.EntryID)
                        LL = 1729
                        If bMsgUnopened = False And ArchiveOnlyIfRead = "Y" Then
                            LL = 1730
                            Dim BK As Boolean = EM2D.Insert()
                            LL = 1731
                            'log.WriteToArchiveLog("clsArchiver : xGetEmails: Marked File for deletion #106")
                            LL = 1732
                            If BK Then
                                LL = 1733
                                If xDebug Then LOG.WriteToArchiveLog("oMsg.Delete()")
                                LL = 1734
                                'oMsg.Delete()
                                LL = 1735
                                If bMoveIt Then
                                    LL = 1736
                                    LOG.WriteToArchiveLog("clsArchiver : GetEmailFolders : Delete Performed 06")
                                    LL = 1737
                                    'oMsg.Move(oDeletedItems)
                                    MoveToHistoryFolder(oMsg)
                                    LL = 1738
                                End If
                                LL = 1739
                            End If
                            LL = 1740
                        ElseIf ArchiveOnlyIfRead = "N" Then
                            LL = 1741
                            Application.DoEvents()
                            Dim BK As Boolean = EM2D.Insert()
                            Application.DoEvents()
                            LL = 1742
                            'log.WriteToArchiveLog("clsArchiver : xGetEmails: Marked File for deletion #107")
                            LL = 1743
                            If BK Then
                                LL = 1744
                                If xDebug Then LOG.WriteToArchiveLog("oMsg.Delete()")
                                LL = 1745
                                'oMsg.Delete()
                                LL = 1746
                                If bMoveIt Then
                                    LL = 1747
                                    LOG.WriteToArchiveLog("clsArchiver : GetEmailFolders : Delete Performed 07")
                                    LL = 1748
                                    oMsg.Move(oDeletedItems)
                                    LL = 1749
                                End If
                                LL = 1750
                            End If
                            LL = 1751
                        Else
                            LL = 1752
                            If xDebug Then LOG.WriteToArchiveLog("No match ... ")
                            LL = 1753
                        End If
                        LL = 1754

                        LL = 1755
                    End If
                    LL = 1756
                Catch ex As Exception
                    frmMain.EmailsSkipped += 1
                    Console.WriteLine(oItems.Item(i).MessageClass.ToString)
                    If InStr(ex.Message, "no files found matching", CompareMethod.Text) > 0 Then
                        Console.WriteLine("Warning - file not found LL = " + LL.ToString)
                    Else
                        Dim tMsg As String = ""
                        tMsg = "ERROR: " + ArchiveMsg + " SKIPPED - " + ex.Message + " LL = " + LL.ToString + vbCrLf
                        tMsg += "ERROR: Subj:" + Subject + " SKIPPED - " + ex.Message + " LL = " + LL.ToString + vbCrLf
                        tMsg += "clsArchiver : ArchiveEmailsInFolder: 99999 - item#" + i.ToString + " : " + ex.Message + "Message Type: " + oItems.Item(i).MessageClass.ToString + " LL = " + LL.ToString
                        LOG.WriteToArchiveLog(tMsg)
                    End If
                End Try

LabelSkipThisEmail2:
                LL = 1768
                frmNotify2.lblFolder.Text = gEmailsAdded.ToString
            Next
            LL = 1769

            LL = 1770
            oItems = Nothing
            LL = 1771
            oMsg = Nothing
            LL = 1772
            GC.Collect()
            LL = 1773
        Catch ex As Exception
            LOG.WriteToArchiveLog("ArchiveEmailsInFolder 144.23.1a - " + ex.Message + " LL = " + LL.ToString)
            LOG.WriteToArchiveLog("ArchiveEmailsInFolder 144.23.1b - " + ex.StackTrace + " LL = " + LL.ToString)
        Finally
            LL = 1777
            ' In any case please remember to turn on Outlook Security after your code,
            'since now it is very easy to switch it off! :-)
            LL = 1778
            'SecurityManager.DisableOOMWarnings = False
            LL = 1779
            frmMain.PBx.Value = 0
            LL = 1780
            ''FrmMDIMain.TSPB1.Value = 0
            LL = 1781
        End Try
        LL = 1782
        frmNotify2.Close()
    End Sub

    Sub ArchiveExchangeEmails(ByVal UID As String, ByVal NewGuid As String,
                             ByVal Body As String,
                             ByVal Subject As String,
                             ByVal CC As ArrayList,
                             ByVal BCC As ArrayList,
                             ByVal EmailToAddr As ArrayList,
                             ByVal Recipients As ArrayList,
                             ByVal CurrMailFolderID_ServerName As String,
                             ByVal SenderEmailAddress As String,
                             ByVal SenderName As String,
                             ByVal SentOn As Date,
                             ByVal ReceivedByName As String,
                             ByVal ReceivedTime As Date,
                             ByVal CreationTime As Date,
                             ByVal DB_ID As String,
                             ByVal CurrMailFolder As String,
                             ByVal Server_UserID_StoreID As String,
                             ByVal RetentionYears As Integer,
                             ByVal RetentionCode As String,
                             ByVal EmailSize As Integer,
                             ByVal AttachedFiles As List(Of String),
                             ByVal EntryID As String,
                             ByVal EmailIdentifier As String,
                             ByVal EmailFQN As String,
                             ByVal LibraryName As String,
                             ByVal isPublic As Boolean,
                             ByVal bEmlToMSG As Boolean,
                             ByRef AttachmentsLoaded As Boolean,
                             ByVal DaysToRetain As Integer)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim tgtFolderName = "NA"
        Dim StackLevel As Integer = 0
        Dim ListOfFiles As New Dictionary(Of String, Integer)

        Dim ID As Integer = 7777
        Dim EM As New clsEMAIL

        Dim FI As New FileInfo(EmailFQN)
        Dim OriginalName As String = FI.Name
        FI = Nothing

        Dim LastEmailArchRunDate As String = UserParmRetrive("LastEmailArchRunDate", gCurrUserGuidID)
        If LastEmailArchRunDate.Trim.Length = 0 Then
            LastEmailArchRunDate = "1/1/1950"
        End If
        Dim rightNow As Date = Now
        If RetentionYears = 0 Then
            RetentionYears = Val(getSystemParm("RETENTION YEARS"))
        End If
        rightNow = rightNow.AddYears(RetentionYears)
        Dim RetentionExpirationDate As String = rightNow.ToString

        Dim EmailsSkipped As Integer = 0
        Dim DeleteMsg As Boolean = False
        Dim CurrDateTime As Date = Now()
        Dim ArchiveAge As Integer = 0
        Dim RemoveAge As Integer = 0
        Dim XDaysArchive As Integer = 0
        Dim XDaysRemove As Integer = 0
        'Dim EmailFQN  = ""
        Dim bRemoveAfterArchive As Boolean = False
        Dim bMsgUnopened As Boolean = False
        Dim CurrMailFolderName As String = ""
        Dim MinProcessDate As Date = CDate("01/1/1910")
        Dim CurrName As String = CurrMailFolder
        Dim ArchiveMsg As String = CurrName + ": "
        Dim DaysOld As Integer = 0
        Dim DB_ConnectionString As String = ""
        Dim LL As Integer = 0
        Try : LL = 3

            SL.Clear() : LL = 5
            SL2.Clear() : LL = 6

            CurrMailFolderName = CurrMailFolder : LL = 8
            ' Loop each unread message. :LL = 9
            Dim i As Integer = 0 : LL = 10

            EM.setStoreID(CurrMailFolder) : LL = 12

            Try : LL = 14

                Dim EmailGuid As String = NewGuid.ToString
                Dim OriginalFolder As String = CurrMailFolder : LL = 16
                Dim FNAME As String = CurrMailFolder : LL = 17
                Dim keyEmailIdentifier As String = NewGuid : LL = 19

                If SentOn = Nothing Then : LL = 21
                    SentOn = #1/1/1899# : LL = 22
                End If : LL = 23

                If ReceivedTime = Nothing Then : LL = 25
                    ReceivedTime = #1/1/1899# : LL = 26
                End If : LL = 27

                If CreationTime = Nothing Then : LL = 29
                    CreationTime = #1/1/1970# : LL = 30
                End If : LL = 31
                If CreationTime < #1/1/1960# Then : LL = 32
                    CreationTime = #1/1/1960# : LL = 33
                End If : LL = 34

                'If frmReconMain.ckUseLastProcessDateAsCutoff.Checked Then :LL =  36
                setLastEmailDate(CurrMailFolderName, CreationTime) : LL = 37

                Dim SourceTypeCode As String = "EML" : LL = 39
                If bEmlToMSG = True Then : LL = 40
                    SourceTypeCode = "MSG" : LL = 41
                End If : LL = 42

                Dim bAutoForwarded As Boolean = False : LL = 44

                Dim BillingInformation As String = Nothing : LL = 46
                Dim EmailBody As String = Body : LL = 47
                Dim FullBody As String = EmailBody
                '*************** DO NOT SAVE THE WHOLE BODY, JUST THE FIRST 100 CHARACTERS *****************
                'EmailBody = EmailBody.Substring(0, 100)
                '*******************************************************************************************

                Dim BodyFormat As String = "" : LL = 48
                Dim Categories As String = "" : LL = 49

                Dim Companies As String = "" : LL = 51
                Dim ConversationIndex As String = "" : LL = 52
                Dim ConversationTopic As String = "" : LL = 53

                Dim DeferredDeliveryTime As Date = Nothing : LL = 55
                Dim DownloadState As String = "" : LL = 56

                Dim HTMLBody As String = "" : LL = 58
                Dim Importance As String = "" : LL = 59
                Dim IsMarkedAsTask As Boolean = False : LL = 60
                Dim LastModificationTime As Date = Now : LL = 61
                Dim MessageClass As String = "" : LL = 62
                Dim Mileage As String = "" : LL = 63
                Dim OriginatorDeliveryReportRequested As Boolean = False : LL = 64
                Dim OutlookInternalVersion As String = "" : LL = 65
                Dim ReadReceiptRequested As Boolean = False : LL = 66
                Dim ReceivedByEntryID As String = "" : LL = 67

                If ReceivedByName = Nothing Then : LL = 69
                    ReceivedByName = "Unknown" : LL = 70
                ElseIf ReceivedByName.Length = 0 Then : LL = 71
                    ReceivedByName = "Unknown" : LL = 72
                End If : LL = 73
                Dim ReceivedOnBehalfOfName As String = "" : LL = 74

                Dim KK As Integer = 0 : LL = 76
                Dim AllRecipients As String = "" : LL = 77
                For KK = 0 To Recipients.Count - 1 : LL = 78
                    AllRecipients = AllRecipients + "; " + Recipients.Item(KK) : LL = 79
                    AddRecipToList(EmailGuid, Recipients.Item(KK), "RECIP") : LL = 80
                Next : LL = 81

                If AllRecipients.Length > 0 Then : LL = 83
                    Dim ch As String = Mid(AllRecipients, 1, 1) : LL = 84
                    If ch.Equals(";") Then : LL = 85
                        Mid(AllRecipients, 1, 1) = " " : LL = 86
                        AllRecipients = AllRecipients.Trim : LL = 87
                    End If : LL = 88
                End If : LL = 89

                Dim ReminderSet As Boolean = False : LL = 91
                Dim ReminderTime As Date = Nothing : LL = 92
                Dim ReplyRecipientNames As Object = Nothing : LL = 93
                Dim SenderEmailType As String = "" : LL = 94
                Dim Sensitivity As String = "" : LL = 95
                Dim SentOnBehalfOfName As String = "" : LL = 96

                ArchiveMsg = ArchiveMsg + " : " + Subject : LL = 98

                Dim TaskCompletedDate As Date = Nothing : LL = 100
                Dim TaskDueDate As Date = Now : LL = 101
                Dim TaskSubject As String = "" : LL = 102

                Dim VotingOptions As String = "" : LL = 104
                Dim VotingResponse As String = "" : LL = 105
                Dim UserProperties As Object = Nothing : LL = 106
                Dim Accounts As String = "None Supplied" : LL = 107

                Dim NewTime As String = ReceivedTime.ToString.Replace("//", ".") : LL = 109
                NewTime = ReceivedTime.ToString.Replace("/:", ".") : LL = 110
                NewTime = ReceivedTime.ToString.Replace(" ", "_") : LL = 111
                Dim NewSubject As String = Mid(Subject, 1, 200) : LL = 112
                NewSubject = NewSubject.Replace(" ", "_") : LL = 113
                ConvertName(NewSubject) : LL = 114
                ConvertName(NewTime) : LL = 115

                Dim bExcluded As Boolean = isExcludedEmail(SenderEmailAddress) : LL = 117
                If bExcluded Then : LL = 118
                    GoTo LabelSkipThisEmail : LL = 119
                End If : LL = 120

                If SenderEmailAddress.Length = 0 Or SenderEmailAddress = Nothing Then : LL = 122
                    SenderEmailAddress = "Unknown" : LL = 123
                End If : LL = 124

                If SentOn = Nothing Then : LL = 126
                    SentOn = #1/1/1900# : LL = 127
                End If : LL = 128

                If SenderName.Length = 0 Or SenderName = Nothing Then : LL = 130
                    SenderName = "Unknown" : LL = 131
                End If : LL = 132

                Dim bExists As Integer = EM.cnt_FULL_UI_EMAIL(EmailIdentifier) : LL = 134
                If bExists > 0 Then : LL = 135
                    GoTo LabelSkipThisEmail : LL = 136
                End If : LL = 137

                AllRecipients += ";" + ReceivedByName : LL = 139

                EM.setEntryid(EntryID) : LL = 141
                EM.setEmailguid(EmailGuid) : LL = 142

                If BCC.Count > 0 Then : LL = 144
                    For Each sBcc As String In BCC : LL = 145
                        AllRecipients = AllRecipients + "; " + sBcc : LL = 146
                    Next : LL = 147

                End If : LL = 149
                If CC.Count > 0 Then : LL = 150
                    For Each sBcc As String In CC : LL = 151
                        AllRecipients = AllRecipients + "; " + sBcc : LL = 152
                    Next : LL = 153
                End If : LL = 154

                Dim AllBcc As String = "" : LL = 156
                For Each sBcc As String In BCC : LL = 157
                    AllBcc = AllBcc + "; " + sBcc : LL = 158
                Next : LL = 159
                Dim AllCC As String = "" : LL = 160
                For Each sBcc As String In CC : LL = 161
                    AllCC = AllCC + "; " + sBcc : LL = 162
                Next : LL = 163

                EM.setAllrecipients(AllRecipients) : LL = 165
                EM.setBcc(AllBcc) : LL = 166
                EM.setBillinginformation(BillingInformation) : LL = 167
                EM.setBody(UTIL.RemoveSingleQuotes(EmailBody)) : LL = 168
                EM.setCc(AllCC) : LL = 169
                EM.setCompanies(Companies) : LL = 170
                EM.setCreationtime(CreationTime) : LL = 171
                EM.setCurrentuser(gCurrUserGuidID) : LL = 172
                EM.setDeferreddeliverytime(DeferredDeliveryTime) : LL = 173
                EM.setDeferreddeliverytime(DeferredDeliveryTime) : LL = 174
                EM.setEmailguid(EmailGuid) : LL = 175
                'EM.setEmailimage() :LL =  176

                EM.setExpirytime(RetentionExpirationDate) : LL = 178
                EM.setLastmodificationtime(LastModificationTime) : LL = 179
                EM.setMsgsize(EmailSize.ToString) : LL = 180
                EM.setReadreceiptrequested(OriginatorDeliveryReportRequested.ToString) : LL = 181
                EM.setReceivedbyname(ReceivedByName) : LL = 182
                EM.setReceivedtime(ReceivedTime) : LL = 183
                EM.setSenderemailaddress(SenderEmailAddress) : LL = 184
                EM.setSendername(SenderName) : LL = 185
                EM.setSensitivity(Sensitivity) : LL = 186
                EM.setSenton(SentOn) : LL = 187
                If bEmlToMSG = True Then : LL = 188
                    EM.setSourcetypecode("MSG") : LL = 189
                Else : LL = 190
                    EM.setSourcetypecode(SourceTypeCode) : LL = 191
                End If : LL = 192

                EM.setOriginalfolder(OriginalFolder) : LL = 194

                Dim SentTo As String = "" : LL = 196
                If Recipients.Count > 0 Then : LL = 197
                    For iI As Integer = 0 To Recipients.Count - 1 : LL = 198
                        SentTo += Recipients(iI) + ";" : LL = 199
                    Next : LL = 200
                End If : LL = 201

                EM.setSentto(ReceivedByName) : LL = 203
                EM.setSubject(UTIL.RemoveSingleQuotes(Subject)) : LL = 204
                Dim ShortSubj As String = Mid(Subject, 1, 240) : LL = 205
                EM.setShortsubj(UTIL.RemoveSingleQuotes(ShortSubj)) : LL = 206
                Dim MailAdded As Boolean = False : LL = 207

                Dim BB As Boolean = False : LL = 209

                Dim bx As Integer = EM.cnt_FULL_UI_EMAIL(EmailIdentifier) : LL = 211
                If bx = 0 Then : LL = 212
                    '*****  *********************************************** :LL =  213
                    'Convert to MSG and store the image as a MSG file :LL =  214
                    Dim CRC As String = ENC.GenerateSHA512HashFromFile(FQN)
                    Dim ImageHash As String = ENC.GenerateSHA512HashFromFile(FQN)
                    If bEmlToMSG = True Then : LL = 215
                        BB = EM.InsertNewEmail(gMachineID, gNetworkID, "MSG", EmailIdentifier, CRC, CurrMailFolder) : LL = 216
                    Else : LL = 217
                        BB = EM.InsertNewEmail(gMachineID, gNetworkID, "EML", EmailIdentifier, CRC, CurrMailFolder) : LL = 218
                    End If : LL = 219
                    '*****  *********************************************** :LL =  220

                    If BB = True Then : LL = 222
                        EmailAddHash(EmailGuid, EmailIdentifier)
                        ID = 7777.1
                        '**********************************************************************************************
                        '** Call Filestream service or standard service here
                        Dim bFileApplied As Boolean = UpdateEmailMsg(OriginalName, ID, UID, EmailFQN, EmailGuid, RetentionCode, isPublic, CRC, tgtFolderName)
                        '**********************************************************************************************
                        If bFileApplied = False And bEmlToMSG = True Then : LL = 225
                            If bEmlToMSG = True Then : LL = 226
                                Dim TempFQN As String = "" : LL = 227
                                Dim BBX As Boolean = False : LL = 228
                                Dim fExt As String = UTIL.getFileSuffix(EmailFQN) : LL = 229
                                If fExt.ToUpper.Equals(".MSG") Or fExt.ToUpper.Equals("MSG") Then : LL = 230
                                    EmailFQN = Mid(EmailFQN, 1, InStr(EmailFQN, ".MSG", CompareMethod.Text) - 1) : LL = 231
                                    ID = 7777.2
                                    '**********************************************************************************************
                                    '** Call Filestream service or standard service here
                                    BBX = UpdateEmailMsg(OriginalName, ID, UID, EmailFQN, EmailGuid, RetentionCode, isPublic, CRC, tgtFolderName)
                                    '**********************************************************************************************
                                    If BBX = True Then : LL = 233
                                        bEmlToMSG = False : LL = 234
                                        EM.setSourcetypecode("EML") : LL = 235
                                    Else : LL = 236
                                        '** It failed again, SKIP IT. :LL =  237
                                        LOG.WriteToArchiveLog("ERROR 299: Failed to add email" + CurrMailFolderID_ServerName + vbCrLf + EmailFQN) : LL = 238
                                        GoTo LabelSkipThisEmail : LL = 239
                                    End If : LL = 240
                                End If : LL = 241
                            End If : LL = 242
                        Else : LL = 243
                            'frmExchangeMonitor.lblMsg.Text = ("Added EMAIL" + Now.ToLocalTime.ToString)
                            Application.DoEvents()
                        End If : LL = 245

                        'EmailIdentifier :LL =  247
                        '**WDM Removed below 3/11/2010 :LL =  248
                        Dim sSql As String = "Update EMAIL set EmailIdentifier = '" + EmailIdentifier + "' where EmailGuid = '" + EmailGuid + "'" : LL = 249
                        Dim bbExec As Boolean = ExecuteSqlNewConn(sSql, False) : LL = 250
                        If Not bbExec Then : LL = 251
                            LOG.WriteToArchiveLog("ERROR: 1234.99xx: " + EmailFQN + vbCrLf + sSql) : LL = 252
                        End If : LL = 253

                        'LibraryName , ByVal isPublic As Boolean :LL =  255
                        If LibraryName.Trim.Length > 0 Then : LL = 256
                            Dim LibraryOwnerUserID As String = GetLibOwnerByName(LibraryName) : LL = 257
                            If LibraryOwnerUserID.Trim.Length = 0 Then
                                LOG.WriteToArchiveLog("ERROR: 300 - No Lib Owner found for LibraryName = '" + LibraryName + "'.")
                            End If
                            If LibraryOwnerUserID.Length > 0 Then
                                Dim tSql As String = "" : LL = 258
                                Dim LI As New clsLIBRARYITEMS : LL = 259
                                Dim iCnt As Integer = cnt_UniqueEntry(LibraryName, EmailGuid) : LL = 260
                                If iCnt = 0 Then : LL = 261
                                    LI.setSourceguid(EmailGuid) : LL = 262
                                    LI.setItemtitle(Mid(Subject, 1, 200)) : LL = 263
                                    LI.setItemtype(SourceTypeCode) : LL = 264
                                    LI.setLibraryitemguid(Guid.NewGuid.ToString) : LL = 265
                                    LI.setDatasourceowneruserid(gCurrUserGuidID) : LL = 266
                                    LI.setLibraryowneruserid(LibraryOwnerUserID) : LL = 267
                                    LI.setLibraryname(LibraryName) : LL = 268
                                    LI.setAddedbyuserguidid(gCurrUserGuidID) : LL = 269
                                    Dim b As Boolean = LI.Insert() : LL = 270
                                    'frmExchangeMonitor.lblCnt.Text = Now.ToString
                                    frmExchangeMonitor.Refresh()

                                    If b = False Then : LL = 271
                                        LOG.WriteToArchiveLog("ERROR: 198.171.76 - Failed to add Email Library Item: " + LibraryName + " : + " + Subject) : LL = 272
                                    End If : LL = 273
                                End If : LL = 274
                                LI = Nothing : LL = 275
                            End If

                            GC.Collect() : LL = 276
                        End If : LL = 277
                        If bEmlToMSG = True Then : LL = 278
                            sSql = "Update EMAIL set ConvertEmlToMSG = 1 where EmailGuid = '" + EmailGuid + "'" : LL = 279
                            bbExec = ExecuteSqlNewConn(sSql, False) : LL = 280
                            If Not bbExec Then : LL = 281
                                LOG.WriteToArchiveLog("ERROR: 1234.99zx1") : LL = 282
                            End If : LL = 283
                        End If : LL = 284
                        If isPublic = True Then : LL = 285
                            sSql = "Update EMAIL set isPublic = 1 where EmailGuid = '" + EmailGuid + "'" : LL = 286
                        Else : LL = 287
                            sSql = "Update EMAIL set isPublic = 0 where EmailGuid = '" + EmailGuid + "'" : LL = 288
                        End If : LL = 289
                        bbExec = ExecuteSqlNewConn(sSql, False) : LL = 290
                        If Not bbExec Then : LL = 291
                            LOG.WriteToArchiveLog("ERROR: 1234.99xx2") : LL = 292
                        End If : LL = 293

                        sSql = "Update EMAIL set CurrMailFolderID = '" + CurrMailFolderID_ServerName + "' where EmailGuid = '" + EmailGuid + "'" : LL = 295
                        bbExec = ExecuteSqlNewConn(sSql, False) : LL = 296
                        If Not bbExec Then : LL = 297
                            LOG.WriteToArchiveLog("ERROR: 1234.99a") : LL = 298
                        End If : LL = 299

                        sSql = "Update EMAIL set CRC = convert(nvarchar(100), " + CRC + ") where EmailGuid = '" + EmailGuid + "'" : LL = 302
                        bbExec = ExecuteSqlNewConn(sSql, False) : LL = 303
                        If Not bbExec Then : LL = 304
                            LOG.WriteToArchiveLog("ERROR: 1234.99b") : LL = 305
                        End If : LL = 306

                        'RetentionExpirationDate :LL =  308
                        sSql = "Update EMAIL set RetentionExpirationDate = '" + RetentionExpirationDate + "' where EmailGuid = '" + EmailGuid + "'" : LL = 309
                        bbExec = ExecuteSqlNewConn(sSql, False) : LL = 310
                        If Not bbExec Then : LL = 311
                            LOG.WriteToArchiveLog("ERROR: 1234.99c") : LL = 312
                        End If : LL = 313
                        sSql = "Update EMAIL set RetentionCode = '" + RetentionCode + "' where EmailGuid = '" + EmailGuid + "'" : LL = 314
                        bbExec = ExecuteSqlNewConn(sSql, False) : LL = 315
                        If Not bbExec Then : LL = 316
                            LOG.WriteToArchiveLog("ERROR: 1234.99c") : LL = 317
                        End If : LL = 318

                        setRetentionDate(EmailGuid, RetentionCode, ".EML") : LL = 320

                        MailAdded = True : LL = 322
                    Else
                        LL = 323
                        EmailAddHash(EmailGuid, EmailIdentifier)

                        TotalFilesArchived += 1 : LL = 324
                        '**WDM Removed below 3/11/2010 :LL =  325
                        Dim sSql As String = "Update EMAIL set EmailIdentifier = '" + EmailIdentifier + "' where EmailGuid = '" + EmailGuid + "'" : LL = 326
                        Dim bbExec As Boolean = ExecuteSqlNewConn(sSql, False) : LL = 327
                        If Not bbExec Then : LL = 328
                            LOG.WriteToArchiveLog("ERROR: 1234.99xx12") : LL = 329
                        End If : LL = 330

                        If bEmlToMSG = True Then : LL = 332
                            sSql = "Update EMAIL set ConvertEmlToMSG = 1 where EmailGuid = '" + EmailGuid + "'" : LL = 333
                            bbExec = ExecuteSqlNewConn(sSql, False) : LL = 334
                        End If : LL = 335

                        If LibraryName.Trim.Length > 0 Then : LL = 337
                            Dim LibraryOwnerUserID As String = GetLibOwnerByName(LibraryName) : LL = 338
                            If LibraryOwnerUserID.Trim.Length = 0 Then
                                LOG.WriteToArchiveLog("ERROR: 400 - No Lib Owner found.")
                            End If

                            Dim tSql As String = "" : LL = 339
                            Dim LI As New clsLIBRARYITEMS : LL = 340
                            Dim iCnt As Integer = cnt_UniqueEntry(LibraryName, EmailGuid) : LL = 341
                            If iCnt = 0 Then : LL = 342
                                LI.setSourceguid(EmailGuid) : LL = 343
                                LI.setItemtitle(Mid(Subject, 1, 200)) : LL = 344
                                LI.setItemtype(SourceTypeCode) : LL = 345
                                LI.setLibraryitemguid(Guid.NewGuid.ToString) : LL = 346
                                LI.setDatasourceowneruserid(gCurrUserGuidID) : LL = 347
                                LI.setLibraryowneruserid(LibraryOwnerUserID) : LL = 348
                                LI.setLibraryname(LibraryName) : LL = 349
                                LI.setAddedbyuserguidid(gCurrUserGuidID) : LL = 350
                                Dim b As Boolean = LI.Insert() : LL = 351
                                If b = False Then : LL = 352
                                    LOG.WriteToArchiveLog("ERROR: 198.171.76 - Failed to add Email Library Item: " + LibraryName + " : + " + Subject) : LL = 353
                                End If : LL = 354
                            End If : LL = 355
                            LI = Nothing : LL = 356
                            GC.Collect() : LL = 357
                        End If : LL = 358

                        If isPublic = True Then : LL = 360
                            sSql = "Update EMAIL set isPublic = 1 where EmailGuid = '" + EmailGuid + "'" : LL = 361
                        Else : LL = 362
                            sSql = "Update EMAIL set isPublic = 0 where EmailGuid = '" + EmailGuid + "'" : LL = 363
                        End If : LL = 364
                        bbExec = ExecuteSqlNewConn(sSql, False) : LL = 365
                        If Not bbExec Then : LL = 366
                            LOG.WriteToArchiveLog("ERROR: 1234.99xx6") : LL = 367
                        End If : LL = 368

                        MailAdded = False : LL = 370

                    End If : LL = 372
                Else : LL = 373
                    BB = True : LL = 374
                    MailAdded = False : LL = 375
                End If : LL = 376
                If BB Then : LL = 377
                    'BB = UpdateEmailMsg(EmailFQN, EmailGuid ) :LL =  378
                    Try : LL = 379
                        Kill(EmailFQN) : LL = 380
                    Catch ex As System.Exception : LL = 381
                        LOG.WriteToArchiveLog("ArchiveExchangeEmails 1000: " + ex.Message) : LL = 382
                    End Try : LL = 383

                    DeleteMsg = True : LL = 385
                Else : LL = 386
                    MailAdded = False : LL = 387
                    GoTo LabelSkipThisEmail : LL = 388
                End If : LL = 389

                If MailAdded Then : LL = 391
                    SL2.Clear() : LL = 392
                    If Not AllCC Is Nothing Then : LL = 393
                        If AllCC.Trim.Length > 0 Then : LL = 394
                            Dim A(0) As String : LL = 395
                            If InStr(1, AllCC, ";") > 0 Then : LL = 396
                                A = Split(AllCC, ";") : LL = 397
                            Else : LL = 398
                                A(0) = AllCC : LL = 399
                            End If : LL = 400
                            For KK = 0 To UBound(A) : LL = 401
                                Dim SKEY As String = A(KK) : LL = 402
                                If Not SKEY Is Nothing Then : LL = 403
                                    Dim BXX As Boolean = SL.ContainsKey(SKEY) : LL = 404
                                    If Not BXX Then : LL = 405
                                        SL2.Add(SKEY, "CC") : LL = 406
                                    End If : LL = 407
                                End If : LL = 408
                            Next : LL = 409
                        End If : LL = 410
                    End If : LL = 411
                    If Not AllBcc Is Nothing Then : LL = 412
                        If AllBcc.Trim.Length > 0 Then : LL = 413
                            Dim A(0) As String : LL = 414
                            If InStr(1, AllBcc, ";") > 0 Then : LL = 415
                                A = Split(AllBcc, ";") : LL = 416
                            Else : LL = 417
                                A(0) = AllBcc : LL = 418
                            End If : LL = 419
                            For KK = 0 To UBound(A) : LL = 420
                                Dim SKEY As String = A(KK) : LL = 421
                                If Not SKEY Is Nothing Then : LL = 422
                                    Dim BXX As Boolean = SL.ContainsKey(SKEY) : LL = 423
                                    If Not BXX Then : LL = 424
                                        SL2.Add(SKEY, "allbcc") : LL = 425
                                    End If : LL = 426
                                End If : LL = 427
                            Next : LL = 428
                        End If : LL = 429
                    End If : LL = 430

                    'For KK = 0 To Recipients.Count - 1 :LL =  432
                    For Each tAddr As String In Recipients : LL = 433
                        'Dim Addr  = Recipients.Item(i) :LL =  434
                        Dim Addr As String = tAddr : LL = 435
                        RECIPS.setEmailguid(EmailGuid) : LL = 436
                        RECIPS.setRecipient(Addr) : LL = 437
                        Dim BXX As Boolean = SL2.ContainsKey(Addr) : LL = 438
                        If Not BXX Then : LL = 439
                            RECIPS.setTyperecp("RECIP") : LL = 440
                        Else : LL = 441
                            Dim iKey As Integer = SL2.IndexOfKey(Addr) : LL = 442
                            Dim TypeCC As String = "" : LL = 443
                            TypeCC = SL2.Item(Addr).ToString : LL = 444
                            RECIPS.setTyperecp(TypeCC) : LL = 445
                        End If : LL = 446
                        RECIPS.Insert() : LL = 447
                    Next : LL = 448

                    Dim bWinMail As Boolean = False : LL = 450

START_WINMAIL_PROCESS:

                    If AttachedFiles.Count > 0 Then : LL = 453
                        For Each FileName As String In AttachedFiles : LL = 454
                            'Dim TempDir  = System.IO.Path.GetTempPath :LL =  455
                            'FileName  = AttachedFiles.Item(II) :LL =  456
                            Dim FileExt As String = "." + UTIL.getFileSuffix(FileName) : LL = 457

                            Dim bCnt As Integer = ATYPE.cnt_PK29(FileExt) : LL = 459
                            Dim isZipFile As Boolean = False : LL = 460

                            If InStr(FileName, "winmail.dat", CompareMethod.Text) > 0 Then : LL = 462
                                GoTo SkipThisOne : LL = 463
                            End If : LL = 464

                            If FileExt.ToUpper.Equals(".MSG") Or FileExt.ToUpper.Equals("MSG") Then : LL = 466
                                Dim EMX As New clsEmailFunctions : LL = 467
                                Dim xAttachedFiles As New List(Of String) : LL = 468

                                If File.Exists(FileName) Then : LL = 471
                                    EMX.LoadMsgFile(UID, FileName, CurrMailFolderID_ServerName, CurrMailFolder, LibraryName, RetentionCode, Subject, EmailBody, xAttachedFiles, False, NewGuid, DaysToRetain) : LL = 472
                                End If : LL = 473

                                EMX = Nothing : LL = 475
                                GC.Collect() : LL = 476
                                GC.WaitForPendingFinalizers() : LL = 477

                                For IIX As Integer = 0 To xAttachedFiles.Count - 1 : LL = 479
                                    Try : LL = 480
                                        Dim tFqn As String = xAttachedFiles(IIX) : LL = 481
                                        If Not AttachedFiles.Contains(tFqn) Then : LL = 482
                                            AttachedFiles.Add(tFqn) : LL = 483
                                        End If : LL = 484
                                    Catch ex As System.Exception : LL = 485
                                        Console.WriteLine("Corrected attached file 100")
                                    End Try : LL = 487
                                Next : LL = 488
                                For III As Integer = 0 To AttachedFiles.Count - 1 : LL = 489
                                    If InStr(AttachedFiles(III), "winmail.dat", CompareMethod.Text) > 0 Then : LL = 490
                                        AttachedFiles(III) = "" : LL = 491
                                    End If : LL = 492
                                    If AttachedFiles(III).ToUpper.Equals(FileName.ToUpper) Then : LL = 493
                                        AttachedFiles(III) = "" : LL = 494
                                    End If : LL = 495
                                Next : LL = 496
                                GoTo START_WINMAIL_PROCESS : LL = 497
                            End If : LL = 498

                            If bCnt = 0 Then : LL = 500
                                Dim B1 As Boolean = ZF.isZipFile(FileName) : LL = 501
                                If B1 Then : LL = 502
                                    ATYPE.setIszipformat("1") : LL = 503
                                    isZipFile = True : LL = 504
                                Else : LL = 505
                                    ATYPE.setIszipformat("0") : LL = 506
                                    isZipFile = False : LL = 507
                                End If : LL = 508
                                ATYPE.setAttachmentcode(FileExt) : LL = 509
                                ATYPE.Insert() : LL = 510
                            End If : LL = 511

                            Dim BBB As Boolean = ZF.isZipFile(FileName) : LL = 513

                            ATYPE.setDescription("Auto added this code.") : LL = 515
                            If BBB Then : LL = 516
                                ATYPE.setIszipformat("1") : LL = 517
                                isZipFile = True : LL = 518
                            Else : LL = 519
                                ATYPE.setIszipformat("0") : LL = 520
                                isZipFile = False : LL = 521
                            End If : LL = 522
                            If isZipFile = True Then : LL = 523
                                '** Explode and load :LL =  524
                                Dim AttachmentName As String = FileName : LL = 525
                                Dim SkipIfAlreadyArchived As Boolean = False : LL = 526
                                DBLocal.addZipFile(FileName, EmailGuid, True)
                                'ZF.ProcessEmailZipFile(EmailGuid, FileName , gCurrUserGuidID, SkipIfAlreadyArchived, AttachmentName, False) : LL = 527
                                ZF.ProcessEmailZipFile(gMachineID, EmailGuid, FileName, UID, SkipIfAlreadyArchived, AttachmentName, StackLevel, ListOfFiles)
                            Else : LL = 528
                                FileExt = "." + UTIL.getFileSuffix(FileName) : LL = 529
                                Dim AttachmentName As String = FileName

                                Dim Sha1Hash As String = ENC.GenerateSHA512HashFromFile(FileName)
                                Dim ImageHash As String = ENC.GenerateSHA512HashFromFile(FileName)

                                Dim bbx As Boolean = InsertAttachmentFqn(gCurrUserGuidID, FileName, EmailGuid, AttachmentName, FileExt, gCurrUserGuidID, RetentionCode, Sha1Hash, isPublic, OriginalFolder)
                                If bbx = False Then
                                    LOG.WriteToArchiveLog("WARNING: Failed to process attachment for " + Subject + " / " + EmailGuid)
                                End If
                            End If : LL = 548
SkipThisOne:
                        Next : LL = 551
                    End If : LL = 552

                End If : LL = 554

LabelSkipThisEmail:
            Catch ex As System.Exception
                EmailsSkipped += 1
                LOG.WriteToArchiveLog(ArchiveMsg + "LL: " + LL.ToString + " -  SKIPPED - " + ex.Message)
                LOG.WriteToArchiveLog("clsArchiver : ArchiveEmailsInFolder: 100a - LL#" + LL.ToString)
                LOG.WriteToArchiveLog("clsArchiver : ArchiveEmailsInFolder: 100b - item#" + i.ToString + " : " + ex.Message)
            End Try

            GC.Collect()
            GC.WaitForFullGCComplete()
        Catch ex As System.Exception
            LOG.WriteToArchiveLog("FATAL ERROR clsArchiver : ArchiveEmailsInFolder: 100-D - LL# " + LL.ToString + " : " + ex.Message)
        Finally
            ' In any case please remember to turn on Outlook Security after your code, since now it is very easy to switch it off! :-)
            'SecurityManager.DisableOOMWarnings = False
            EM = Nothing
        End Try

        'UpdateAttachmentCounts()

        Dim DoThis As Boolean = False
        If DoThis Then
            If AttachmentsLoaded = True Then
                AppendOcrTextEmail(NewGuid)
                AttachmentsLoaded = False
            End If
        End If

    End Sub

    Sub AddRecipientsToDB()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim R As New clsRECIPIENTS
        Dim I As Integer = 0
        For I = 0 To SL.Count - 1
            Dim S As String = SL.GetKey(I).ToString
            Dim A As String() = Split(S, Chr(254))
            R.setEmailguid(A(0))
            R.setRecipient(A(1))
            R.setTyperecp(A(2))
            Dim Recips As String() = Split(A(1), ";")

            For k As Integer = 0 To UBound(Recips)
                Dim II As Integer = R.cnt_PK32A(A(0), Recips(k))
                If II = 0 Then
                    Dim b As Boolean = R.Insert()
                    If Not b Then
                        If xDebug Then LOG.WriteToArchiveLog("Error 7391.2: Failed to add RECIPIENT " + A(1))
                    End If
                End If
            Next
        Next
    End Sub

    Sub AddRecipToList(ByVal sGuid As String, ByVal RECIP As String, ByVal TypeRecip As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        RECIP = UTIL.RemoveSingleQuotes(RECIP)
        Dim b As Boolean = False
        Dim tKey As String = sGuid + Chr(254) + RECIP + Chr(254) + TypeRecip
        b = SL.Contains(tKey)
        If Not b Then
            Try
                SL.Add(tKey, TypeRecip)
            Catch ex As Exception
                If xDebug Then LOG.WriteToArchiveLog("Error 66521: skiped recip list item: " + ex.Message)
            End Try

        End If
    End Sub

    Sub ArchiveEmailsInFolderenders(ByVal ArchiveEmails As String,
                   ByVal RemoveAfterArchive As String,
                   ByVal SetAsDefaultFolder As String,
                   ByVal ArchiveAfterXDays As String,
                   ByVal RemoveAfterXDays As String,
                   ByVal RemoveXDays As String,
                   ByVal ArchiveXDays As String,
                   ByVal CurrMailFolder As Outlook.MAPIFolder, ByVal DeleteEmail As Boolean)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim DeleteMsg As Boolean = False
        Dim CurrDateTime As Date = Now()
        Dim ArchiveAge As Integer = 0
        Dim RemoveAge As Integer = 0
        Dim XDaysArchive As Integer = 0
        Dim XDaysRemove As Integer = 0

        Dim DB_ConnectionString As String = ""

        If ArchiveEmails.Equals("N") And ArchiveAfterXDays.Equals("N") And RemoveAfterArchive.Equals("N") Then
            '** Then this folder really should not be in the list
            Return
        End If
        If RemoveAfterArchive.Equals("Y") Then
            DeleteMsg = True
        End If
        If IsNumeric(RemoveXDays) Then
            XDaysRemove = Val(RemoveXDays)
        End If
        If IsNumeric(ArchiveXDays) Then
            XDaysArchive = Val(ArchiveXDays)
        End If

        Try

            Dim oItems As Outlook.Items = CurrMailFolder.Items
            If xDebug Then LOG.WriteToArchiveLog("Total : " & oItems.Count)

            ' Get unread e-mail messages.
            'oItems = oItems.Restrict("[Unread] = true")
            If xDebug Then LOG.WriteToArchiveLog("Total Unread : " & oItems.Count)

            ' Loop each unread message.
            Dim oMsg As Outlook.MailItem
            Dim i As Integer = 0

            For i = 1 To oItems.Count
                Try
                    If i Mod 50 = 0 Then
                        If xDebug Then LOG.WriteToArchiveLog("Message#: " & i & " of " & oItems.Count)
                    End If

                    oMsg = oItems.Item(i)

                    Dim SenderEmailAddress As String = oMsg.SenderEmailAddress
                    Dim SenderName As String = oMsg.SenderName
                    Dim ListKey As String = SenderEmailAddress.Trim + "|" + SenderName.Trim

                    Dim MySql As String = ""
                    MySql = MySql + " SELECT count(*) as cnt"
                    MySql = MySql + " FROM  [OutlookFrom]"
                    MySql = MySql + " where FromEmailAddr = '" + SenderEmailAddress + "'"
                    MySql = MySql + " and SenderName = '" + SenderName + "'"
                    MySql = MySql + " and UserID = '" + gCurrUserGuidID + "'"

                    Dim bb As Integer = iDataExist(MySql)

                    If bb > 0 Then
                        MySql = ""
                        MySql = MySql + " Update  [OutlookFrom]"
                        MySql = MySql + " set [Verified] = 1 "
                        MySql = MySql + " where FromEmailAddr = '" + SenderEmailAddress + "'"
                        MySql = MySql + " and SenderName = '" + SenderName + "'"
                        MySql = MySql + " and UserID = '" + gCurrUserGuidID + "'"
                        Dim bSuccess As Boolean = ExecuteSqlNewConn(MySql, False)
                        If Not bSuccess Then
                            If xDebug Then LOG.WriteToArchiveLog("Update failed:" + vbCrLf + MySql)
                        End If
                    Else
                        MySql = ""
                        MySql = MySql + " INSERT INTO  [OutlookFrom]"
                        MySql = MySql + " ([FromEmailAddr]"
                        MySql = MySql + " ,[SenderName]"
                        MySql = MySql + " ,[UserID]"
                        MySql = MySql + " ,[Verified])"
                        MySql = MySql + " VALUES ("
                        MySql = MySql + "'" + SenderEmailAddress + "',"
                        MySql = MySql + " '" + SenderName + "',"
                        MySql = MySql + " '" + gCurrUserGuidID + "',"
                        MySql = MySql + " 1)"
                        Dim bSuccess As Boolean = ExecuteSqlNewConn(MySql, False)
                        If Not bSuccess Then
                            If xDebug Then LOG.WriteToArchiveLog("Insert failed:" + vbCrLf + MySql)
                        End If
                    End If

                    Application.DoEvents()
                Catch ex As Exception
                    If xDebug Then LOG.WriteToArchiveLog("Error: " + vbCrLf + ex.Message)
                    If xDebug Then LOG.WriteToArchiveLog("Skipping Message# " + i.ToString)
                End Try
            Next

            oItems = Nothing
            oMsg = Nothing
            GC.Collect()
        Catch ex As Exception
            MessageBox.Show(ex.Message)
        Finally
            ' In any case please remember to turn on Outlook Security after your code, since now it is very easy to switch it off! :-)
            'SecurityManager.DisableOOMWarnings = False
        End Try

    End Sub

    ''' <summary>
    ''' This subroutine gets all fo the appointments from within the Outlook Appointment book.
    ''' </summary>
    ''' <remarks></remarks>
    Sub getAppts()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        ' Create Outlook application.
        Dim oApp As Outlook.Application = New Outlook.Application()

        ' Get NameSpace and Logon.
        Dim oNS As Outlook.NameSpace = oApp.GetNamespace("mapi")
        oNS.Logon("YourValidProfile", Missing.Value, False, True) ' TODO:

        ' Get Appointments collection from the Calendar folder.
        Dim oCalendar As Outlook.MAPIFolder = oNS.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderCalendar)
        Dim oItems As Outlook.Items = oCalendar.Items

        ' TODO: You may want to use Find or Restrict to retrieve the appointment that you prefer. ...

        ' Get the first AppointmentItem.
        Dim oAppt As Outlook.AppointmentItem = oItems.GetFirst()

        '' Display some common properties.
        'Console.WriteLine(oAppt.Organizer)
        'Console.WriteLine(oAppt.Subject)
        'Console.WriteLine(oAppt.Body)
        'Console.WriteLine(oAppt.Location)
        'Console.WriteLine(oAppt.Start.ToString())
        'Console.WriteLine(oAppt.End.ToString())

        ' Display.
        'oAppt.Display(true)

        ' Log off.
        oNS.Logoff()

        ' Clean up.
        oApp = Nothing
        oNS = Nothing
        oItems = Nothing
        oAppt = Nothing
        GC.Collect()
    End Sub

    ''' <summary>
    ''' List all the Members of a Distribution List Programmatically
    ''' </summary>
    ''' <remarks></remarks>
    Sub DistributionList()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        ' Create Outlook application.
        Dim oApp As Outlook.Application = New Outlook.Application()

        ' Get Mapi NameSpace and Logon.
        Dim oNS As Outlook.NameSpace = oApp.GetNamespace("mapi")
        oNS.Logon("YourValidProfile", Missing.Value, False, True) ' TODO:

        ' Get Global Address List.
        Dim oDLs As Outlook.AddressLists = oNS.AddressLists
        Dim oGal As Outlook.AddressList = oDLs.Item("Global Address List")
        Console.WriteLine(oGal.Name)

        ' Get a specific distribution list.
        ' TODO: Replace the distribution list with a distribution list that is available to you.
        Dim sDL As String = "TestDL"
        Dim oEntries As Outlook.AddressEntries = oGal.AddressEntries
        ' No filter available to AddressEntries
        Dim oDL As Outlook.AddressEntry = oEntries.Item(sDL)

        Console.WriteLine(oDL.Name)
        Console.WriteLine(oDL.Address)
        Console.WriteLine(oDL.Manager)

        ' Get all of the members of the distribution list.
        oEntries = oDL.Members
        Dim oEntry As Outlook.AddressEntry
        Dim i As Integer

        For i = 1 To oEntries.Count
            oEntry = oEntries.Item(i)
            Console.WriteLine(oEntry.Name)
            ' Display the Details dialog box.
            oDL.Details(Missing.Value)
        Next

        ' Log off.
        oNS.Logoff()

        ' Clean up.
        oApp = Nothing
        oNS = Nothing
        oDLs = Nothing
        oGal = Nothing
        oEntries = Nothing
        oEntry = Nothing
        GC.Collect()
    End Sub

    ''' <summary>
    ''' Create a meeting request
    ''' </summary>
    ''' <remarks></remarks>
    Sub GenMeetingRequest()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        ' Create an Outlook application.
        Dim oApp As Outlook.Application = New Outlook.Application()

        ' Get Mapi NameSpace and Logon.
        Dim oNS As Outlook.NameSpace = oApp.GetNamespace("mapi")
        oNS.Logon("YourValidProfile", Missing.Value, False, True) ' TODO:

        ' Create an AppointmentItem.
        Dim oAppt As Outlook._AppointmentItem = oApp.CreateItem(Outlook.OlItemType.olAppointmentItem)
        'oAppt.Display(true)  'Modal

        ' Change AppointmentItem to a Meeting.
        oAppt.MeetingStatus = Outlook.OlMeetingStatus.olMeeting

        ' Set some common properties.
        oAppt.Subject = "Created using OOM in VB.NET"
        oAppt.Body = "Hello World"
        oAppt.Location = "Samm E"

        oAppt.Start = Convert.ToDateTime("11/30/2001 9:00:00 AM")
        oAppt.End = Convert.ToDateTime("11/30/2001 1:00:00 PM")

        oAppt.ReminderSet = True
        oAppt.ReminderMinutesBeforeStart = 5
        oAppt.BusyStatus = Outlook.OlBusyStatus.olBusy  '  olBusy
        oAppt.IsOnlineMeeting = False
        oAppt.AllDayEvent = False

        ' Add attendees.
        Dim oRecipts As Outlook.Recipients = oAppt.Recipients

        ' Add required attendee.
        Dim oRecipt As Outlook.Recipient
        oRecipt = oRecipts.Add("UserTest1") ' TODO:
        oRecipt.Type = Outlook.OlMeetingRecipientType.olRequired

        ' Add optional attendee.
        oRecipt = oRecipts.Add("UserTest2") ' TODO:
        oRecipt.Type = Outlook.OlMeetingRecipientType.olOptional

        oRecipts.ResolveAll()

        'oAppt.Display(true)

        ' Send out request.
        oAppt.Send()

        ' Logoff.
        oNS.Logoff()

    End Sub

    ''' <summary>
    ''' retrieve all contacts
    ''' </summary>
    ''' <remarks></remarks>
    Sub ArchiveContacts()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Thread.BeginCriticalRegion()

        Dim bInstalled As Boolean = True

        Try
            Dim oAppTest As Outlook.Application = New Outlook.Application
            bInstalled = True
            oAppTest = Nothing
        Catch E As Exception
            LOG.WriteToArchiveLog("NOTICE: OUTLOOK does not appear to be installed - skipping archive." + vbCrLf + E.Message)
            bInstalled = False
        End Try
        If bInstalled = False Then
            Thread.EndCriticalRegion()
            Return
        End If

        Dim FrmInfo As New frmNotifyContact
        FrmInfo.Show()
        FrmInfo.Title = "CONTACTS"

        FrmInfo.Text = "Outlook Contacts"
        FrmInfo.lblMsg.Text = "Contacts"
        FrmInfo.Location = New Point(25, 50)
        FrmInfo.lblMsg2.Text = "Contacts: "

        Dim SkipArchiveDate As Date = getLastContactArchiveDate()

        ' Create Outlook application.
        Dim Account As String = ""
        Dim Anniversary As String = ""
        Dim Application As String = ""
        Dim AssistantName As String = ""
        Dim AssistantTelephoneNumber As String = ""
        Dim BillingInformation As String = ""
        Dim Birthday As String = ""
        Dim Business2TelephoneNumber As String = ""
        Dim BusinessAddress As String = ""
        Dim BusinessAddressCity As String = ""
        Dim BusinessAddressCountry As String = ""
        Dim BusinessAddressPostalCode As String = ""
        Dim BusinessAddressPostOfficeBox As String = ""
        Dim BusinessAddressState As String = ""
        Dim BusinessAddressStreet As String = ""
        Dim BusinessCardType As String = ""
        Dim BusinessFaxNumber As String = ""
        Dim BusinessHomePage As String = ""
        Dim BusinessTelephoneNumber As String = ""
        Dim CallbackTelephoneNumber As String = ""
        Dim CarTelephoneNumber As String = ""
        Dim Categories As String = ""
        Dim Children As String = ""
        Dim xClass As String = ""
        Dim Companies As String = ""
        Dim CompanyName As String = ""
        Dim ComputerNetworkName As String = ""
        Dim Conflicts As String = ""
        Dim ConversationTopic As String = ""
        Dim CreationTime As String = ""
        Dim CustomerID As String = ""
        Dim Department As String = ""
        Dim Email1Address As String = ""
        Dim Email1AddressType As String = ""
        Dim Email1DisplayName As String = ""
        Dim Email1EntryID As String = ""
        Dim Email2Address As String = ""
        Dim Email2AddressType As String = ""
        Dim Email2DisplayName As String = ""
        Dim Email2EntryID As String = ""
        Dim Email3Address As String = ""
        Dim Email3AddressType As String = ""
        Dim Email3DisplayName As String = ""
        Dim Email3EntryID As String = ""
        Dim FileAs As String = ""
        Dim FirstName As String = ""
        Dim FTPSite As String = ""
        Dim FullName As String = ""
        Dim Gender As String = ""
        Dim GovernmentIDNumber As String = ""
        Dim Hobby As String = ""
        Dim Home2TelephoneNumber As String = ""
        Dim HomeAddress As String = ""
        Dim HomeAddressCountry As String = ""
        Dim HomeAddressPostalCode As String = ""
        Dim HomeAddressPostOfficeBox As String = ""
        Dim HomeAddressState As String = ""
        Dim HomeAddressStreet As String = ""
        Dim HomeFaxNumber As String = ""
        Dim HomeTelephoneNumber As String = ""
        Dim IMAddress As String = ""
        Dim Importance As String = ""
        Dim Initials As String = ""
        Dim InternetFreeBusyAddress As String = ""
        Dim JobTitle As String = ""
        Dim Journal As String = ""
        Dim Language As String = ""
        Dim LastModificationTime As String = ""
        Dim LastName As String = ""
        Dim LastNameAndFirstName As String = ""
        Dim MailingAddress As String = ""
        Dim MailingAddressCity As String = ""
        Dim MailingAddressCountry As String = ""
        Dim MailingAddressPostalCode As String = ""
        Dim MailingAddressPostOfficeBox As String = ""
        Dim MailingAddressState As String = ""
        Dim MailingAddressStreet As String = ""
        Dim ManagerName As String = ""
        Dim MiddleName As String = ""
        Dim Mileage As String = ""
        Dim MobileTelephoneNumber As String = ""
        Dim NetMeetingAlias As String = ""
        Dim NetMeetingServer As String = ""
        Dim NickName As String = ""
        Dim Title As String = ""
        Dim Body As String = ""
        Dim OfficeLocation As String = ""
        Dim Subject As String = ""

        Dim MySql As String = ""

        Dim I As Integer = 0

        Dim oApp As Outlook.Application = New Outlook.Application

        ' Get namespace and Contacts folder reference.
        Dim oNS As Outlook.NameSpace = oApp.GetNamespace("MAPI")
        Dim cContacts As Outlook.MAPIFolder = oNS.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderContacts)

        ' Get the first contact from the Contacts folder.
        Dim oItems As Outlook.Items = cContacts.Items
        Dim oCt As Outlook.ContactItem
        Dim K As Integer = oItems.Count
        Dim iCount As Integer
        Dim bContact As Boolean = False

        For I = 0 To K
            Try
                System.Windows.Forms.Application.DoEvents()
                'frmReconMain.PB1.Value = I
                oCt = oItems(I)
                Dim II As Integer = 0
                FrmInfo.lblMsg2.Text = "Contacts: " & I & " of " & K
                FrmInfo.Refresh()
                System.Windows.Forms.Application.DoEvents()

                Email1Address = oCt.Email1Address

                If Email1Address Is Nothing Then
                    Email1Address = "NA"
                End If

                Email1Address = UTIL.RemoveSingleQuotes(Email1Address)

                FullName = oCt.FullName
                If Len(FullName.Trim) = 0 Then
                    LOG.WriteToArchiveLog("ERROR: Full name must be supplied for conntact, skipping EMAIL address '" + Email1Address + "'")
                    GoTo SkipContact
                End If

                bContact = DBLocal.contactExists(UTIL.RemoveSingleQuotes(FullName), Email1Address)

                If bContact Then
                    GoTo SkipContact
                Else
                    bContact = DBLocal.addContact(FullName, Email1Address)
                    Dim b As Boolean = CNTCT.Insert()
                    If Not b Then
                        LOG.WriteToArchiveLog("ERROR 100 Contact " & FullName + " / " + Email1Address + " not loaded.")
                    End If
                End If

                Account = oCt.Account
                Anniversary = oCt.Anniversary
                Application = oCt.Application.ToString
                AssistantName = oCt.AssistantName
                AssistantTelephoneNumber = oCt.AssistantTelephoneNumber
                BillingInformation = oCt.BillingInformation
                Birthday = oCt.Birthday
                Business2TelephoneNumber = oCt.Business2TelephoneNumber
                BusinessAddress = oCt.BusinessAddress
                BusinessAddressCity = oCt.BusinessAddressCity
                BusinessAddressCountry = oCt.BusinessAddressCountry
                BusinessAddressPostalCode = oCt.BusinessAddressPostalCode
                BusinessAddressPostOfficeBox = oCt.BusinessAddressPostOfficeBox
                BusinessAddressState = oCt.BusinessAddressState
                BusinessAddressStreet = oCt.BusinessAddressStreet
                BusinessCardType = oCt.BusinessCardType
                BusinessFaxNumber = oCt.BusinessFaxNumber
                BusinessHomePage = oCt.BusinessHomePage
                BusinessTelephoneNumber = oCt.BusinessTelephoneNumber
                CallbackTelephoneNumber = oCt.CallbackTelephoneNumber
                CarTelephoneNumber = oCt.CarTelephoneNumber
                Categories = oCt.Categories
                Children = oCt.Children
                xClass = oCt.Class
                Companies = oCt.Companies
                CompanyName = oCt.CompanyName
                ComputerNetworkName = oCt.ComputerNetworkName
                Conflicts = oCt.Conflicts.ToString
                ConversationTopic = oCt.ConversationTopic
                CreationTime = oCt.CreationTime
                CustomerID = oCt.CustomerID
                Department = oCt.Department

                If Email1Address = Nothing Then
                    Email1Address = " "
                End If
                If Len(Email1Address.Trim) = 0 Or Email1Address = Nothing Then
                    Email1Address = " "
                End If
                Email1AddressType = oCt.Email1AddressType
                Email1DisplayName = oCt.Email1DisplayName
                Email1EntryID = oCt.Email1EntryID
                Email2Address = oCt.Email2Address
                Email2AddressType = oCt.Email2AddressType
                Email2DisplayName = oCt.Email2DisplayName
                Email2EntryID = oCt.Email2EntryID
                Email3Address = oCt.Email3Address
                Email3AddressType = oCt.Email3AddressType
                Email3DisplayName = oCt.Email3DisplayName
                Email3EntryID = oCt.Email3EntryID
                FileAs = oCt.FileAs
                FirstName = oCt.FirstName
                FTPSite = oCt.FTPSite

                Gender = oCt.Gender
                GovernmentIDNumber = oCt.GovernmentIDNumber
                Hobby = oCt.Hobby
                Home2TelephoneNumber = oCt.Home2TelephoneNumber
                HomeAddress = oCt.HomeAddress
                HomeAddressCountry = oCt.HomeAddressCountry
                HomeAddressPostalCode = oCt.HomeAddressPostalCode
                HomeAddressPostOfficeBox = oCt.HomeAddressPostOfficeBox
                HomeAddressState = oCt.HomeAddressState
                HomeAddressStreet = oCt.HomeAddressStreet
                HomeFaxNumber = oCt.HomeFaxNumber
                HomeTelephoneNumber = oCt.HomeTelephoneNumber
                IMAddress = oCt.IMAddress
                Importance = oCt.Importance
                Initials = oCt.Initials
                InternetFreeBusyAddress = oCt.InternetFreeBusyAddress
                JobTitle = oCt.JobTitle
                Journal = oCt.Journal
                Language = oCt.Language
                LastModificationTime = oCt.LastModificationTime

                If LastModificationTime > SkipArchiveDate Then
                    '** Write out a new last mod date
                    saveLastContactArchiveDate(LastModificationTime.ToString)
                Else
                    GoTo SkipContact
                End If

                LastName = oCt.LastName
                LastNameAndFirstName = oCt.LastNameAndFirstName
                MailingAddress = oCt.MailingAddress
                MailingAddressCity = oCt.MailingAddressCity
                MailingAddressCountry = oCt.MailingAddressCountry
                MailingAddressPostalCode = oCt.MailingAddressPostalCode
                MailingAddressPostOfficeBox = oCt.MailingAddressPostOfficeBox
                MailingAddressState = oCt.MailingAddressState
                MailingAddressStreet = oCt.MailingAddressStreet
                ManagerName = oCt.ManagerName
                MiddleName = oCt.MiddleName
                Mileage = oCt.Mileage
                MobileTelephoneNumber = oCt.MobileTelephoneNumber
                NetMeetingAlias = oCt.NetMeetingAlias
                NetMeetingServer = oCt.NetMeetingServer
                NickName = oCt.NickName
                Title = oCt.Title
                Body = oCt.Body
                OfficeLocation = oCt.OfficeLocation
                Subject = oCt.Subject

                CNTCT.setAccount(Account)
                CNTCT.setAnniversary(Anniversary)
                CNTCT.setApplication(Application)
                CNTCT.setAssistantname(AssistantName)
                CNTCT.setAssistanttelephonenumber(AssistantTelephoneNumber)
                CNTCT.setBillinginformation(BillingInformation)
                CNTCT.setBirthday(Birthday)
                CNTCT.setBusiness2telephonenumber(Business2TelephoneNumber)
                CNTCT.setBusinessaddress(BusinessAddress)
                CNTCT.setBusinessaddresscity(BusinessAddressCity)
                CNTCT.setBusinessaddresscountry(BusinessAddressCountry)
                CNTCT.setBusinessaddresspostalcode(BusinessAddressPostalCode)
                CNTCT.setBusinessaddresspostofficebox(BusinessAddressPostOfficeBox)
                CNTCT.setBusinessaddressstate(BusinessAddressState)
                CNTCT.setBusinessaddressstreet(BusinessAddressStreet)
                CNTCT.setBusinesscardtype(BusinessCardType)
                CNTCT.setBusinessfaxnumber(BusinessFaxNumber)
                CNTCT.setBusinesshomepage(BusinessHomePage)
                CNTCT.setBusinesstelephonenumber(BusinessTelephoneNumber)
                CNTCT.setCallbacktelephonenumber(CallbackTelephoneNumber)
                CNTCT.setCartelephonenumber(CarTelephoneNumber)
                CNTCT.setCategories(Categories)
                CNTCT.setChildren(Children)
                CNTCT.setXclass(xClass)
                CNTCT.setCompanies(Companies)
                CNTCT.setCompanyname(CompanyName)
                CNTCT.setComputernetworkname(ComputerNetworkName)
                CNTCT.setConflicts(Conflicts)
                CNTCT.setConversationtopic(ConversationTopic)
                CNTCT.setCreationtime(CreationTime)
                CNTCT.setCustomerid(CustomerID)
                CNTCT.setDepartment(Department)
                CNTCT.setEmail1address(Email1Address)
                CNTCT.setEmail1addresstype(Email1AddressType)
                CNTCT.setEmail1displayname(Email1DisplayName)
                CNTCT.setEmail1entryid(Email1EntryID)
                CNTCT.setEmail2address(Email2Address)
                CNTCT.setEmail2addresstype(Email2AddressType)
                CNTCT.setEmail2displayname(Email2DisplayName)
                CNTCT.setEmail2entryid(Email2EntryID)
                CNTCT.setEmail3address(Email3Address)
                CNTCT.setEmail3addresstype(Email3AddressType)
                CNTCT.setEmail3displayname(Email3DisplayName)
                CNTCT.setEmail3entryid(Email3EntryID)
                CNTCT.setFileas(FileAs)
                CNTCT.setFirstname(FirstName)
                CNTCT.setFtpsite(FTPSite)
                CNTCT.setFullname(FullName)
                CNTCT.setGender(Gender)
                CNTCT.setGovernmentidnumber(GovernmentIDNumber)
                CNTCT.setHobby(Hobby)
                CNTCT.setHome2telephonenumber(Home2TelephoneNumber)
                CNTCT.setHomeaddress(HomeAddress)
                CNTCT.setHomeaddresscountry(HomeAddressCountry)
                CNTCT.setHomeaddresspostalcode(HomeAddressPostalCode)
                CNTCT.setHomeaddresspostofficebox(HomeAddressPostOfficeBox)
                CNTCT.setHomeaddressstate(HomeAddressState)
                CNTCT.setHomeaddressstreet(HomeAddressStreet)
                CNTCT.setHomefaxnumber(HomeFaxNumber)
                CNTCT.setHometelephonenumber(HomeTelephoneNumber)
                CNTCT.setImaddress(IMAddress)
                CNTCT.setImportance(Importance)
                CNTCT.setInitials(Initials)
                CNTCT.setInternetfreebusyaddress(InternetFreeBusyAddress)
                CNTCT.setJobtitle(JobTitle)
                CNTCT.setJournal(Journal)
                CNTCT.setLanguage(Language)
                CNTCT.setLastmodificationtime(LastModificationTime)
                CNTCT.setLastname(LastName)
                CNTCT.setLastnameandfirstname(LastNameAndFirstName)
                CNTCT.setMailingaddress(MailingAddress)
                CNTCT.setMailingaddresscity(MailingAddressCity)
                CNTCT.setMailingaddresscountry(MailingAddressCountry)
                CNTCT.setMailingaddresspostalcode(MailingAddressPostalCode)
                CNTCT.setMailingaddresspostofficebox(MailingAddressPostOfficeBox)
                CNTCT.setMailingaddressstate(MailingAddressState)
                CNTCT.setMailingaddressstreet(MailingAddressStreet)
                CNTCT.setManagername(ManagerName)
                CNTCT.setMiddlename(MiddleName)
                CNTCT.setMileage(Mileage)
                CNTCT.setMobiletelephonenumber(MobileTelephoneNumber)
                CNTCT.setNetmeetingalias(NetMeetingAlias)
                CNTCT.setNetmeetingserver(NetMeetingServer)
                CNTCT.setNickname(NickName)
                CNTCT.setTitle(Title)
                CNTCT.setBody(Body)
                CNTCT.setOfficelocation(OfficeLocation)
                CNTCT.setSubject(Subject)
                If gCurrUserGuidID.Trim.Length = 0 Then
                    gCurrUserGuidID = getUserGuidID(gCurrLoginID)
                End If
                CNTCT.setUserid(gCurrUserGuidID)

                System.Windows.Forms.Application.DoEvents()

                'Email1Address = UTIL.RemoveSingleQuotes(Email1Address)
                'FullName = UTIL.RemoveSingleQuotes(FullName)

                'Dim bContact As Boolean = DBLocal.contactExists(FullName, Email1Address)

                'If bContact Then
                '    GoTo SkipContact
                'Else
                '    bContact = DBLocal.addContact(FullName, Email1Address)
                '    Dim b As Boolean = CNTCT.Insert()
                '    If Not b Then
                '        LOG.WriteToArchiveLog("ERROR 100 Contact " & FullName + " / " + Email1Address + " not loaded.")
                '    End If
                'End If

                System.Windows.Forms.Application.DoEvents()
            Catch ex As Exception
                LOG.WriteToArchiveLog("Error: " + ex.Message)
                LOG.WriteToArchiveLog("Contact " & FullName + " / " + Email1Address + " not loaded.")
            End Try

SkipContact:
        Next I

        Console.WriteLine(iCount)

        ' Clean up.
        FrmInfo.Close()
        FrmInfo.Dispose()
        oApp = Nothing
        oItems = Nothing
        oCt = Nothing
        GC.Collect()
        'frmReconMain.PB1.Value = 0
        'frmReconMain.SB.Text = "Complete, " + I.ToString + " contacts processed."
        LOG.WriteToArchiveLog("INFO: Contact archive Complete, " + I.ToString + " contacts processed.")
        Thread.EndCriticalRegion()

    End Sub

    Sub RetrieveContactEmailInfo(ByVal DG As System.Windows.Forms.DataGridView, ByVal UID As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        ' Create Outlook application.
        Dim oApp As Outlook.Application = New Outlook.Application

        ' Get namespace and Contacts folder reference.
        Dim oNS As Outlook.NameSpace = oApp.GetNamespace("MAPI")
        Dim cContacts As Outlook.MAPIFolder = oNS.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderContacts)

        ' Get the first contact from the Contacts folder.
        Dim oItems As Outlook.Items = cContacts.Items
        Dim oCt As Outlook.ContactItem
        Dim K As Integer = oItems.Count
        Dim iCount As Integer
        iCount = 0
        Try
            DG.Rows.Clear()
        Catch ex As Exception
            Console.WriteLine("Moving on...")
        End Try

        DG.Columns.Add("ea", "Email Address")
        DG.Columns("ea").Width = 150
        DG.Columns.Add("fn", "Full Name")
        DG.Columns("fn").Width = 250
        DG.Columns.Add("UserID", "UserID")
        DG.Columns("UserID").Width = 75

        'DG.Columns(0).HeaderText = "Email Address"
        'DG.Columns(1).HeaderText = "Full Name"
        'DG.Columns(2).HeaderText = "UserID"

        For i As Integer = 0 To K - 1
            Try
                DG.Rows.Add()
                oCt = oItems(i)
                If i Mod 25 = 0 Then
                    If xDebug Then LOG.WriteToArchiveLog("Row# " & i)
                End If
                'Console.WriteLine(oCt.FullName)
                'Console.WriteLine(oCt.Email1Address)
                'Console.WriteLine("ROWS = " & DG.Rows.Count)
                Dim SenderEmailAddress As String = oCt.Email1Address
                Dim SenderName As String = oCt.FullName
                'DG.Rows(iCount).Cells("UserID").Value = UID

                Dim MySql As String = ""
                MySql = MySql + " SELECT count(*) as cnt"
                MySql = MySql + " FROM  [ContactFrom]"
                MySql = MySql + " where FromEmailAddr = '" + SenderEmailAddress + "'"
                MySql = MySql + " and SenderName = '" + SenderName + "'"
                MySql = MySql + " and UserID = '" + gCurrUserGuidID + "'"

                If SenderEmailAddress.Trim.Length > 0 Then
                    Dim bb As Integer = iDataExist(MySql)

                    If bb > 0 Then
                        MySql = MySql + " Update  [ContactFrom]"
                        MySql = MySql + " set [Verified] = 1 "
                        MySql = MySql + " where FromEmailAddr = '" + SenderEmailAddress + "'"
                        MySql = MySql + " and SenderName = '" + SenderName + "'"
                        MySql = MySql + " and UserID = '" + gCurrUserGuidID + "'"
                        Dim bSuccess As Boolean = ExecuteSqlNewConn(MySql, False)
                        If Not bSuccess Then
                            If xDebug Then LOG.WriteToArchiveLog("Update failed:" + vbCrLf + MySql)
                        End If
                    Else
                        MySql = MySql + " INSERT INTO  [ContactFrom]"
                        MySql = MySql + " ([FromEmailAddr]"
                        MySql = MySql + " ,[SenderName]"
                        MySql = MySql + " ,[UserID]"
                        MySql = MySql + " ,[Verified])"
                        MySql = MySql + " VALUES ("
                        MySql = MySql + "'" + SenderEmailAddress + "',"
                        MySql = MySql + " '" + SenderName + "',"
                        MySql = MySql + " '" + gCurrUserGuidID + "',"
                        MySql = MySql + " 1)"
                        Dim bSuccess As Boolean = ExecuteSqlNewConn(MySql, False)
                        If Not bSuccess Then
                            If xDebug Then LOG.WriteToArchiveLog("Insert failed:" + vbCrLf + MySql)
                        End If
                    End If
                End If

                Application.DoEvents()

                iCount = iCount + 1
            Catch ex As Exception
                Console.WriteLine("Error: " + ex.Message)
                Console.WriteLine("Contact " & i & " not loaded.")
            End Try
        Next i

        Console.WriteLine(iCount)

        ' Clean up.
        oApp = Nothing
        oItems = Nothing
        oCt = Nothing

        GC.Collect()

    End Sub

    Sub PopulateExcludedSendersFromTbl(ByVal DG As System.Windows.Forms.DataGridView)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim FromEmailAddr As String = ""
        Dim SenderName As String = ""
        Dim UserID As String = ""

        Dim S As String = ""
        S = S + " SELECT [FromEmailAddr],[SenderName],[UserID] "
        S = S + " FROM  [ExcludeFrom]"
        S = S + " where UserID = '" + gCurrUserGuidID + "' "
        S = S + " order by [FromEmailAddr],[SenderName]"

        Dim iCount As Integer
        iCount = 0
        Try
            DG.Rows.Clear()
        Catch ex As Exception
            Console.WriteLine("Moving on...")
        End Try

        DG.Columns.Add("ea", "Email Address")
        DG.Columns("ea").Width = 150
        DG.Columns.Add("fn", "Full Name")
        DG.Columns("fn").Width = 250
        DG.Columns.Add("UserID", "UserID")
        DG.Columns("UserID").Width = 75

        Dim rsData As SqlDataReader = Nothing

        Dim CS As String = setConnStr()   ' getGateWayConnStr(gGateWayID)
        Dim CONN As New SqlConnection(CS)
        CONN.Open()
        Dim command As New SqlCommand(S, CONN)
        rsData = command.ExecuteReader()

        If rsData.HasRows Then
            Do While rsData.Read()
                FromEmailAddr = rsData.GetValue(0).ToString
                SenderName = rsData.GetValue(1).ToString
                UserID = rsData.GetValue(2).ToString
                Try
                    DG.Rows.Add()
                    'if xDebug then log.WriteToArchiveLog(FromEmailAddr )
                    'Console.WriteLine("ROWS = " & DG.Rows.Count)
                    DG.Rows(iCount).Cells("ea").Value = FromEmailAddr
                    DG.Rows(iCount).Cells("fn").Value = SenderName
                    DG.Rows(iCount).Cells("UserID").Value = UserID
                    iCount = iCount + 1
                Catch ex As Exception
                    Console.WriteLine("Error: " + ex.Message)
                    Console.WriteLine("Contact " & FromEmailAddr & " not loaded.")
                End Try
                Application.DoEvents()
            Loop
        End If

        If Not rsData.IsClosed Then
            rsData.Close()
        End If
        rsData = Nothing
        command.Dispose()
        command = Nothing

        If CONN.State = ConnectionState.Open Then
            CONN.Close()
        End If
        CONN.Dispose()

        Console.WriteLine(iCount)
        GC.Collect()
    End Sub

    Sub PopulateContactGridOutlookFromTbl(ByVal DG As System.Windows.Forms.DataGridView)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim FromEmailAddr As String = ""
        Dim SenderName As String = ""
        Dim UserID As String = ""

        Dim S As String = ""
        S = S + " SELECT [FromEmailAddr],[SenderName],[UserID] "
        S = S + " FROM  [OutlookFrom]"
        S = S + " where UserID = '" + gCurrUserGuidID + "' and Verified = 1 "
        S = S + " order by [FromEmailAddr],[SenderName]"

        Dim iCount As Integer
        iCount = 0
        Try
            DG.Rows.Clear()
        Catch ex As Exception
            Console.WriteLine("Moving on...")
        End Try

        DG.Columns.Add("ea", "Email Address")
        DG.Columns("ea").Width = 150
        DG.Columns.Add("fn", "Full Name")
        DG.Columns("fn").Width = 250
        DG.Columns.Add("UserID", "UserID")
        DG.Columns("UserID").Width = 75

        Dim rsData As SqlDataReader = Nothing

        Dim CS As String = setConnStr()   ' getGateWayConnStr(gGateWayID)
        Dim CONN As New SqlConnection(CS)
        CONN.Open()
        Dim command As New SqlCommand(S, CONN)
        rsData = command.ExecuteReader()

        If rsData.HasRows Then
            Do While rsData.Read()
                FromEmailAddr = rsData.GetValue(0).ToString
                SenderName = rsData.GetValue(1).ToString
                UserID = rsData.GetValue(2).ToString
                Try
                    DG.Rows.Add()
                    'if xDebug then log.WriteToArchiveLog(FromEmailAddr )
                    'Console.WriteLine("ROWS = " & DG.Rows.Count)
                    DG.Rows(iCount).Cells("ea").Value = FromEmailAddr
                    DG.Rows(iCount).Cells("fn").Value = SenderName
                    DG.Rows(iCount).Cells("UserID").Value = UserID
                    iCount = iCount + 1
                Catch ex As Exception
                    Console.WriteLine("Error: " + ex.Message)
                    Console.WriteLine("Contact " & FromEmailAddr & " not loaded.")
                End Try
                Application.DoEvents()
            Loop
        End If

        If Not rsData.IsClosed Then
            rsData.Close()
        End If
        rsData = Nothing
        command.Dispose()
        command = Nothing

        If CONN.State = ConnectionState.Open Then
            CONN.Close()
        End If
        CONN.Dispose()

        Console.WriteLine(iCount)
        GC.Collect()
    End Sub

    Sub PopulateContactGridContactFromTbl(ByVal DG As System.Windows.Forms.DataGridView)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim FromEmailAddr As String = ""
        Dim SenderName As String = ""
        Dim UserID As String = ""

        Dim S As String = ""
        S = S + " SELECT [FromEmailAddr],[SenderName],[UserID] "
        S = S + " FROM  [ContactFrom]"
        S = S + " where UserID = '" + gCurrUserGuidID + "' and Verified = 1 "
        S = S + " order by [FromEmailAddr],[SenderName]"

        Dim iCount As Integer
        iCount = 0
        Try
            DG.Rows.Clear()
        Catch ex As Exception
            Console.WriteLine("Moving on...")
        End Try

        DG.Columns.Add("ea", "Email Address")
        DG.Columns("ea").Width = 150
        DG.Columns.Add("fn", "Full Name")
        DG.Columns("fn").Width = 250
        DG.Columns.Add("UserID", "UserID")
        DG.Columns("UserID").Width = 75

        Dim rsData As SqlDataReader = Nothing

        Dim CS As String = setConnStr()   ' getGateWayConnStr(gGateWayID)
        Dim CONN As New SqlConnection(CS)
        CONN.Open()
        Dim command As New SqlCommand(S, CONN)
        rsData = command.ExecuteReader()

        If rsData.HasRows Then
            Do While rsData.Read()
                FromEmailAddr = rsData.GetValue(0).ToString
                SenderName = rsData.GetValue(1).ToString
                UserID = rsData.GetValue(2).ToString
                Try
                    DG.Rows.Add()
                    'if xDebug then log.WriteToArchiveLog(FromEmailAddr )
                    'Console.WriteLine("ROWS = " & DG.Rows.Count)
                    DG.Rows(iCount).Cells("ea").Value = FromEmailAddr
                    DG.Rows(iCount).Cells("fn").Value = SenderName
                    DG.Rows(iCount).Cells("UserID").Value = UserID
                    iCount = iCount + 1
                Catch ex As Exception
                    Console.WriteLine("Error: " + ex.Message)
                    Console.WriteLine("Contact " & FromEmailAddr & " not loaded.")
                End Try
                Application.DoEvents()
            Loop
        End If

        If Not rsData.IsClosed Then
            rsData.Close()
        End If
        rsData = Nothing
        command.Dispose()
        command = Nothing

        If CONN.State = ConnectionState.Open Then
            CONN.Close()
        End If
        CONN.Dispose()

        Console.WriteLine(iCount)
        GC.Collect()
    End Sub

    Sub PopulateContactGrid(ByVal DG As System.Windows.Forms.DataGridView, ByVal S As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim FromEmailAddr As String = ""
        Dim SenderName As String = ""
        Dim UserID As String = ""

        Dim iCount As Integer
        iCount = 0
        Try
            DG.Rows.Clear()
            DG.Columns.Clear()
        Catch ex As Exception
            Console.WriteLine("Moving on...")
        End Try

        DG.Columns.Add("ea", "Email Address")
        DG.Columns("ea").Width = 150
        DG.Columns.Add("fn", "Full Name")
        DG.Columns("fn").Width = 250
        DG.Columns.Add("UserID", "UserID")
        DG.Columns("UserID").Width = 75

        Dim rsData As SqlDataReader = Nothing

        Dim CS As String = setConnStr()   ' getGateWayConnStr(gGateWayID)
        Dim CONN As New SqlConnection(CS)
        CONN.Open()
        Dim command As New SqlCommand(S, CONN)
        rsData = command.ExecuteReader()

        If rsData.HasRows Then
            Do While rsData.Read()
                FromEmailAddr = rsData.GetValue(0).ToString
                SenderName = rsData.GetValue(1).ToString
                UserID = gCurrUserGuidID
                Try
                    DG.Rows.Add()
                    'if xDebug then log.WriteToArchiveLog(FromEmailAddr )
                    'Console.WriteLine("ROWS = " & DG.Rows.Count)
                    DG.Rows(iCount).Cells("ea").Value = FromEmailAddr
                    DG.Rows(iCount).Cells("fn").Value = SenderName
                    DG.Rows(iCount).Cells("UserID").Value = UserID
                    iCount = iCount + 1
                Catch ex As Exception
                    Console.WriteLine("Error: " + ex.Message)
                    Console.WriteLine("Contact " & FromEmailAddr & " not loaded.")
                End Try
                Application.DoEvents()
            Loop
        End If

        If Not rsData.IsClosed Then
            rsData.Close()
        End If
        rsData = Nothing
        command.Dispose()
        command = Nothing

        If CONN.State = ConnectionState.Open Then
            CONN.Close()
        End If
        CONN.Dispose()

        Console.WriteLine(iCount)
        GC.Collect()
    End Sub

    ''' <summary>
    ''' Gets an email's attachments
    ''' </summary>
    ''' <param name="FolderName"></param>
    ''' <remarks></remarks>
    Sub GetAttachments(ByVal FolderName As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim filename As String = ""
        Dim objOL As Outlook.Application
        Dim objNS As Outlook.NameSpace
        'Dim objFolder As Outlook.Folders
        'Dim Item As Object
        Dim myItems As Outlook.Items
        Dim x As Int16

        objOL = New Outlook.Application()
        objNS = objOL.GetNamespace("MAPI")

        Dim olfolder As Outlook.MAPIFolder
        olfolder = objOL.GetNamespace("MAPI").PickFolder
        myItems = olfolder.Items

        Dim i As Integer = 0
        For x = 1 To myItems.Count
            Dim EmailSenderName As String = myItems.Item(x).SenderName
            Dim EmailSenderEmailAddress As String = myItems.Item(x).SenderEmailAddress
            Dim EmailSubject As String = myItems.Item(x).Subject

            Dim EmailBody As String = myItems.Item(x).Body
            Dim FullBody As String
            '*************** DO NOT SAVE THE WHOLE BODY, JUST THE FIRST 100 CHARACTERS *****************
            'EmailBody = EmailBody.Substring(0, 100)
            '*******************************************************************************************

            Dim EmailTo As String = myItems.Item(x).to
            Dim EmailReceivedByName As String = myItems.Item(x).ReceivedByName
            Dim EmailReceivedOnBehalfOfName As String = myItems.Item(x).ReceivedOnBehalfOfName
            Dim EmailReplyRecipientNames As String = myItems.Item(x).ReplyRecipientNames
            Dim EmailSentOnBehalfOfName As String = myItems.Item(x).SentOnBehalfOfName
            Dim EmailCC As String = myItems.Item(x).CC
            Dim EmailReceivedTime As String = myItems.Item(x).ReceivedTime

            Dim Atmt As Outlook.Attachment
            For Each Atmt In myItems.Item(x).Attachments
                filename = DMA.getEnvVarTempDir + "\" + Atmt.FileName
                Atmt.SaveAsFile(filename)
            Next Atmt

        Next x

    End Sub

    Public Function OutlookFolderNames(ByVal MailboxName As String, ByVal bTest As Boolean) As String
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Try
            '********************************************************
            'PARAMETER: MailboxName = Name of Parent Outlook Folder for
            'the current user: Usually in the form of
            '"Mailbox - Doe, John" or
            '"Public Folders
            'RETURNS: Array of SubFolders in Current User's Mailbox
            'Or unitialized array if error occurs
            'Because it returns an array, it is for VB6 only.
            'Change to return a variant or a delimited list for
            'previous versions of vb
            'EXAMPLE:
            'Dim sArray() As String
            'Dim ictr As Integer
            'sArray = OutlookFolderNames("Mailbox - Doe, John")
            '            'On Error Resume Next
            'For ictr = 0 To UBound(sArray)
            ' if xDebug then log.WriteToArchiveLog sArray(ictr)
            'Next
            '*********************************************************
            Dim oOutlook As Outlook.Application
            Dim oMAPI As Outlook._NameSpace
            Dim oParentFolder As Outlook.MAPIFolder
            Dim sArray() As String
            Dim i As Integer
            Dim iElement As Integer = 0

            oOutlook = New Outlook.Application()
            oMAPI = oOutlook.GetNamespace("MAPI")
            MailboxName = "Personal Folders"
            oParentFolder = oMAPI.Folders.Item(MailboxName)

            ReDim Preserve sArray(0)

            If oParentFolder.Folders.Count <> 0 Then
                For i = 1 To oParentFolder.Folders.Count
                    If Trim(oParentFolder.Folders.Item(i).Name) <> "" Then
                        If xDebug Then LOG.WriteToArchiveLog(oParentFolder.Folders.Item(i).Name)
                        'If Trim(oMAPI.GetDefaultFolder(OlDefaultFolders.olFolderInbox).Folders.Item(i).Name) <> "" Then
                        '     If sArray(0) = "" Then
                        '          iElement = 0
                        '     Else
                        '          iElement = UBound(sArray) + 1
                        '     End If
                        '     ReDim Preserve sArray(iElement)
                        '     sArray(iElement) = oParentFolder.Folders.Item(i).Name
                        'End If
                    End If
                Next i
            Else
                sArray(0) = oParentFolder.Name
            End If

            'OutlookFolderNames = sArray
            oMAPI = Nothing
            GC.Collect()
        Catch ex As Exception
            MessageBox.Show(ex.Message)
        End Try
        GC.Collect()
        GC.WaitForFullGCComplete()
        Return ""
    End Function

    Sub RegisterOutlookContainer()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim oOutlook As New Outlook.Application
        Dim oMAPI As Outlook.NameSpace = Nothing
        Dim oParentFolder As Outlook.MAPIFolder = Nothing
        Dim oChildFolder As Outlook.MAPIFolder = Nothing
        Dim Containers As New List(Of String)

        'RegisterAllContainers(Containers)
        Try
            oMAPI = oMAPI.GetNamespace("MAPI")
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR : RegisterOutlookContainers 200 - " + ex.Message)
            Return
        End Try

        Dim iFolderCount As Integer = oMAPI.Folders.Count
        For Each MF As Outlook.MAPIFolder In oMAPI.Folders
            If ddebug Then Console.WriteLine(MF.Name)
            Containers.Add(MF.Name)
        Next

        For Each Container As String In Containers
            'RegisterChildFolders(ByVal Container , ByVal oChildFolder As Outlook.MAPIFolder, ByVal FQN )
            Try
                oParentFolder = oMAPI.Folders.Item(Container)
            Catch ex As Exception
                LOG.WriteToArchiveLog("ERROR: RegisterOutlookContainers 100 - " + ex.Message)
            End Try

            For Each oChildFolder In oParentFolder.Folders
                Dim K As Integer = 0
                K = oChildFolder.Folders.Count
                Dim cFolder As String = oChildFolder.Name.ToString
                If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 010: '" + cFolder + "'.")
                'LB.Items.Add(cFolder )
                If K > 0 Then
                    RegisterChildFolders(Container, oChildFolder, cFolder)
                End If
            Next
        Next

        oOutlook = Nothing
        oMAPI = Nothing
        oParentFolder = Nothing
        oChildFolder = Nothing
        Containers = Nothing

    End Sub

    Sub RegisterAllContainers(ByRef Containers As List(Of String))

        Dim bOfficeInstalled As Boolean = True

        Dim B As Boolean = False

        Containers.Clear()

        Dim oOutlook As Outlook.Application
        Dim oMAPI As Outlook.NameSpace = Nothing
        Dim oParentFolder As Outlook.MAPIFolder = Nothing
        Dim oChildFolder As Outlook.MAPIFolder = Nothing
        'Dim sArray() As String
        'Dim i As Integer
        Dim iElement As Integer = 0

        oOutlook = New Outlook.Application()
        Try
            oMAPI = oOutlook.GetNamespace("MAPI")
        Catch ex As Exception
            MessageBox.Show(ex.Message)
        End Try

        Dim iFolderCount As Integer = oMAPI.Folders.Count
        For Each MF As Outlook.MAPIFolder In oMAPI.Folders
            If ddebug Then Console.WriteLine(MF.Name)
            Containers.Add(MF.Name)
        Next

        oOutlook = Nothing
        oMAPI = Nothing
        oParentFolder = Nothing
        oChildFolder = Nothing

    End Sub

    Sub GetContainerFolders(ByVal Containers As List(Of String), ByRef EmailFolders As List(Of String))

        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim bOfficeInstalled As Boolean = True

#If Office2007 Then
        bOfficeInstalled = UTIL.isOffice2007Installed
#Else
        bOfficeInstalled = UTIL.isOffice2003Installed
#End If

        If bOfficeInstalled = False Then
            Return
        End If

        Dim B As Boolean = False

        If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 001: ")

        EmailFolders.Clear()

        '********************************************************
        'PARAMETER: MailboxName = Name of Parent Outlook Folder for
        'the current user: Usually in the form of
        '"Mailbox - Doe, John" or
        '"Public Folders
        'RETURNS: Array of SubFolders in Current User's Mailbox
        'Or unitialized array if error occurs
        'Because it returns an array, it is for VB6 only.
        'Change to return a variant or a delimited list for
        'previous versions of vb
        'EXAMPLE:
        'Dim sArray() As String
        'Dim ictr As Integer
        'sArray = OutlookFolderNames("Mailbox - Doe, John")
        '        'On Error Resume Next
        'For ictr = 0 To UBound(sArray)
        ' if xDebug then log.WriteToArchiveLog sArray(ictr)
        'Next
        '*********************************************************
        Dim oOutlook As Outlook.Application
        Dim oMAPI As Outlook.NameSpace = Nothing
        Dim oParentFolder As Outlook.MAPIFolder = Nothing
        Dim oChildFolder As Outlook.MAPIFolder = Nothing
        Dim i As Integer
        Dim iElement As Integer = 0

        oOutlook = New Outlook.Application()
        Try
            oMAPI = oOutlook.GetNamespace("MAPI")
        Catch ex As Exception
            MessageBox.Show(ex.Message)
        End Try

        For Each Container As String In Containers

            If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 002: '" + Container + "'.")

            Dim aFolders As New List(Of String)
            Dim iFolderCount As Integer = oMAPI.Folders.Count

            Try
                oParentFolder = oMAPI.Folders.Item(Container)
                For i = 1 To oParentFolder.Folders.Count

                    Console.WriteLine(oParentFolder.Folders.Item(i).Name())

                    If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 003: '" + oParentFolder.Folders.Item(i).Name)

                    Dim isEmailFolder As Boolean = False
                    Dim NbrOfItemsTested As Integer = 0
                    If TypeOf oParentFolder.Folders(i) Is Outlook.MAPIFolder Then
                        If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 004: '" + oParentFolder.Folders.Item(i).Name)
                        For Each Obj As Object In oParentFolder.Folders(i).Items
                            NbrOfItemsTested += 1
                            Console.WriteLine(Obj.ToString)
                            If TypeOf Obj Is Outlook.MailItem Then
                                If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 005: '" + oParentFolder.Folders.Item(i).Name)
                                isEmailFolder = True
                                Exit For
                            Else
                                If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 006: '" + oParentFolder.Folders.Item(i).Name)
                                If NbrOfItemsTested > 10 Then
                                    isEmailFolder = False
                                    Exit For
                                End If
                            End If
                        Next
                        If isEmailFolder = False And gEmailArchiveDisabled.Equals(False) Then
                            LOG.WriteToArchiveLog("WARNING: THIS FOLDER COULD NOT BE VERIFIED TO BE AN EMAIL FOLDER. It will be processed as if it is as it has been selected by a user: " + oParentFolder.Folders.Item(i).Name())
                            isEmailFolder = True
                        End If
                    Else
                        If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 007: '" + oParentFolder.Folders.Item(i).Name)
                    End If

                    If NbrOfItemsTested = 0 Then
                        isEmailFolder = True
                    End If

                    If isEmailFolder = True Then
                        If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 008: '" + oParentFolder.Folders.Item(i).Name + " : Appears to be an email folder.")
                    Else
                        If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 008: '" + oParentFolder.Folders.Item(i).Name + " : Appears NOT to be an email folder.")
                        GoTo SkipThisNonEmailFolder
                    End If

                    'If TypeOf oParentFolder Is Outlook.MailItem Then
                    '    Console.WriteLine(oParentFolder.Folders.Item(i).Name)
                    'End If

                    If Trim(oParentFolder.Folders.Item(i).Name) <> "" Then
                        Dim StoreID As String = oParentFolder.StoreID
#If Office2007 Then
Dim StoreName AS String  = ""
                        Try
                            StoreName  = oParentFolder.Store.DisplayName.ToString
                        Catch ex As Exception
                            StoreName  = "Not Available"
                        End Try
                        If xDebug Then log.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 009 Office 2007: '" + StoreName  + "'.")
#Else
                        Dim StoreName As String = ""
                        Try
                            StoreName = oParentFolder.Name
                        Catch ex As Exception
                            StoreName = "Not Available"
                        End Try
                        If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 009 Office 2003: '" + StoreName + "'.")
#End If
                        Dim ParentID As String = oParentFolder.EntryID
                        Dim ChildID As String = oParentFolder.Folders.Item(i).EntryID
                        Dim tFolderName As String = oParentFolder.Folders.Item(i).Name
                        If xDebug Then LOG.WriteToArchiveLog(tFolderName)
                        Console.WriteLine("Folder: " + tFolderName)
                        tFolderName = tFolderName.Trim
                        Dim II As Integer = EMF.cnt_PK_EmailFolder(ChildID, gCurrUserGuidID)
                        II = EMF.cnt_UI_EmailFolder(Container, tFolderName, gCurrUserGuidID)

                        Dim LL As Integer = 10
                        If II = 0 Then
                            Try
                                EMF.setFolderid(ChildID)
                                LL = 20
                                EMF.setFoldername(tFolderName)
                                LL = 30
                                EMF.setParentfolderid(ParentID)
                                LL = 40
                                EMF.setParentfoldername(oParentFolder.Name)
                                LL = 50
                                EMF.setUserid(gCurrUserGuidID)
                                LL = 60
                                EMF.setStoreid(StoreID)
                                LL = 70
                                Dim BB As Boolean = EMF.Insert(Container)
                                LL = 80
                            Catch ex As Exception
                                LOG.WriteToArchiveLog("ERROR: getOutlookFolderNames 100a LL =: " + LL.ToString())
                                LOG.WriteToArchiveLog("ERROR: getOutlookFolderNames 100a: tFolderName  = " + tFolderName + " : " + "oParentFolder.Name = " + oParentFolder.Name)
                            End Try
                        Else
                            Dim WC As String = EMF.wc_UI_EmailFolder(Container, tFolderName, gCurrUserGuidID)
                            EMF.setFolderid(ChildID)
                            EMF.setFoldername(tFolderName)
                            EMF.setParentfolderid(ParentID)
                            EMF.setParentfoldername(oParentFolder.Name)
                            EMF.setUserid(gCurrUserGuidID)
                            EMF.setStoreid(StoreID)
                            Dim BB As Boolean = EMF.Insert(Container)
                        End If
                    End If
SkipThisNonEmailFolder:
                Next i
            Catch ex As Exception
                MessageBox.Show(ex.Message)
            End Try
        Next

    End Sub

    Public Function getOutlookFolderNames(ByVal FileDirectory As String, ByRef LB As ListBox) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim bOfficeInstalled As Boolean = True

        Try
            bOfficeInstalled = UTIL.isOffice2007Installed
        Catch ex As Exception
            Try
                bOfficeInstalled = UTIL.isOffice2003Installed
            Catch ex2 As Exception
                bOfficeInstalled = False
            End Try
        End Try

        If bOfficeInstalled = False Then
            LB.Items.Clear()
            LB.Items.Add("**ERROR: Missing Office - may not be installed in this machine.")
            LOG.WriteToArchiveLog("**ERROR: Missing Office - may not be installed in this machine.")
        End If

        Dim B As Boolean = False

        Try
            If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 001: ")

            LB.Items.Clear()

            '********************************************************
            'PARAMETER: MailboxName = Name of Parent Outlook Folder for
            'the current user: Usually in the form of
            '"Mailbox - Doe, John" or
            '"Public Folders
            'RETURNS: Array of SubFolders in Current User's Mailbox
            'Or unitialized array if error occurs
            'Because it returns an array, it is for VB6 only.
            'Change to return a variant or a delimited list for
            'previous versions of vb
            'EXAMPLE:
            'Dim sArray() As String
            'Dim ictr As Integer
            'sArray = OutlookFolderNames("Mailbox - Doe, John")
            '            'On Error Resume Next
            'For ictr = 0 To UBound(sArray)
            ' if xDebug then log.WriteToArchiveLog sArray(ictr)
            'Next
            '*********************************************************
            Dim oOutlook As Outlook.Application
            Dim oMAPI As Outlook.NameSpace = Nothing
            Dim oParentFolder As Outlook.MAPIFolder = Nothing
            Dim oChildFolder As Outlook.MAPIFolder = Nothing
            'Dim sArray() As String
            Dim i As Integer
            Dim iElement As Integer = 0

            oOutlook = New Outlook.Application()
            Try
                oMAPI = oOutlook.GetNamespace("MAPI")
            Catch ex As Exception
                MessageBox.Show(ex.Message)
            End Try

            'Dim MailboxName  = System.Configuration.ConfigurationManager.AppSettings("EmailFolder1")
            Dim MailboxName As String = ""

            MailboxName = FileDirectory
            If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 002: '" + MailboxName + "'.")

            Dim OutlookContainers As New List(Of String)
            Dim iFolderCount As Integer = oMAPI.Folders.Count

            RegisterAllContainers(OutlookContainers)

            Try
                oParentFolder = oMAPI.Folders.Item(MailboxName)
            Catch ex As Exception
                MessageBox.Show(ex.Message)
            End Try

            'AddChildFolders(LB, MailboxName )

            If oParentFolder.Folders.Count <> 0 Then
                For i = 1 To oParentFolder.Folders.Count

                    Console.WriteLine(oParentFolder.Folders.Item(i).Name())

                    If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 003: '" + oParentFolder.Folders.Item(i).Name)

                    Dim isEmailFolder As Boolean = False
                    Dim NbrOfItemsTested As Integer = 0
                    If TypeOf oParentFolder.Folders(i) Is Outlook.MAPIFolder Then
                        If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 004: '" + oParentFolder.Folders.Item(i).Name)
                        For Each Obj As Object In oParentFolder.Folders(i).Items
                            NbrOfItemsTested += 1
                            Console.WriteLine(Obj.ToString)
                            If TypeOf Obj Is Outlook.MailItem Then
                                If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 005: '" + oParentFolder.Folders.Item(i).Name)
                                isEmailFolder = True
                                Exit For
                            Else
                                If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 006: '" + oParentFolder.Folders.Item(i).Name)
                                If NbrOfItemsTested > 10 Then
                                    isEmailFolder = False
                                    Exit For
                                End If
                            End If
                        Next
                        If isEmailFolder = False And gEmailArchiveDisabled.Equals(False) Then
                            LOG.WriteToArchiveLog("WARNING: THIS FOLDER COULD NOT BE VERIFIED TO BE AN EMAIL FOLDER. It will be processed as if it is as it has been selected by a user: " + oParentFolder.Folders.Item(i).Name())
                            isEmailFolder = True
                        End If
                    Else
                        If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 007: '" + oParentFolder.Folders.Item(i).Name)
                    End If

                    If NbrOfItemsTested = 0 Then
                        isEmailFolder = True
                    End If

                    If isEmailFolder = True Then
                        If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 008: '" + oParentFolder.Folders.Item(i).Name + " : Appears to be an email folder.")
                    Else
                        If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 008: '" + oParentFolder.Folders.Item(i).Name + " : Appears NOT to be an email folder.")
                        GoTo SkipThisNonEmailFolder
                    End If

                    'If TypeOf oParentFolder Is Outlook.MailItem Then
                    '    Console.WriteLine(oParentFolder.Folders.Item(i).Name)
                    'End If

                    If Trim(oParentFolder.Folders.Item(i).Name) <> "" Then
                        Dim StoreID As String = oParentFolder.StoreID
#If Office2007 Then
Dim StoreName AS String  = ""
                        Try
                            StoreName  = oParentFolder.Store.DisplayName.ToString
                        Catch ex As Exception
                            StoreName  = "Not Available"
                        End Try
                        If xDebug Then log.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 009 Office 2007: '" + StoreName  + "'.")
#Else
                        Dim StoreName As String = ""
                        Try
                            StoreName = oParentFolder.Name
                        Catch ex As Exception
                            StoreName = "Not Available"
                        End Try
                        If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 009 Office 2003: '" + StoreName + "'.")
#End If
                        Dim ParentID As String = oParentFolder.EntryID
                        Dim ChildID As String = oParentFolder.Folders.Item(i).EntryID
                        Dim tFolderName As String = oParentFolder.Folders.Item(i).Name
                        If xDebug Then LOG.WriteToArchiveLog(tFolderName)
                        Console.WriteLine("Folder: " + tFolderName)
                        tFolderName = tFolderName.Trim
                        Dim II As Integer = EMF.cnt_PK_EmailFolder(ChildID, gCurrUserGuidID)
                        II = EMF.cnt_UI_EmailFolder(FileDirectory, tFolderName, gCurrUserGuidID)

                        Dim kk As Integer = 10
                        If II = 0 Then
                            kk = 20
                            Try
                                kk = 30
                                EMF.setFolderid(ChildID)
                                kk = 40
                                EMF.setFoldername(tFolderName)
                                kk = 50
                                EMF.setParentfolderid(ParentID)
                                kk = 60
                                EMF.setParentfoldername(oParentFolder.Name)
                                kk = 70
                                EMF.setUserid(gCurrUserGuidID)
                                kk = 80
                                EMF.setStoreid(StoreID)
                                kk = 90
                                EMF.setSelectedforarchive("?")
                                kk = 100
                                Dim BB As Boolean = EMF.Insert(FileDirectory)
                                kk = 110
                            Catch ex As Exception
                                LOG.WriteToArchiveLog("ERROR: getOutlookFolderNames 100b kk =: " + kk.ToString)
                                LOG.WriteToArchiveLog("ERROR: getOutlookFolderNames 100b: " + ex.Message + vbCrLf + vbCrLf + ex.StackTrace)
                                LOG.WriteToArchiveLog("ERROR: getOutlookFolderNames 100b: tFolderName  = " + tFolderName + " : " + "oParentFolder.Name = " + oParentFolder.Name)
                            End Try
                        Else
                            Dim FolderFQN As String = oParentFolder.Name.Trim + "|" + tFolderName.Trim
                            Dim WC As String = EMF.wc_UI_EmailFolder(FileDirectory, FolderFQN, gCurrUserGuidID)
                            EMF.setFolderid(ChildID)
                            EMF.setFoldername(FolderFQN)
                            EMF.setParentfolderid(ParentID)
                            EMF.setParentfoldername(oParentFolder.Name)
                            EMF.setUserid(gCurrUserGuidID)
                            EMF.setStoreid(StoreID)
                            EMF.setSelectedforarchive("?")
                            Dim BB As Boolean = EMF.Update(WC)
                            If Not BB Then
                                LOG.WriteToArchiveLog("ERROR: 102 Failed to update Email Folder : " + FileDirectory + " : " + tFolderName)
                            End If
                        End If
                        LB.Items.Add(oParentFolder.Folders.Item(i).Name)
                    End If
SkipThisNonEmailFolder:
                Next i
            End If

            For Each oChildFolder In oParentFolder.Folders
                Dim K As Integer = 0
                K = oChildFolder.Folders.Count
                Dim cFolder As String = oChildFolder.Name.ToString
                If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 010: '" + cFolder + "'.")
                'LB.Items.Add(cFolder )
                If K > 0 Then
                    ListChildFolders(FileDirectory, oChildFolder, LB, cFolder)
                End If
            Next
            oMAPI = Nothing
            GC.Collect()
            B = True
        Catch ex As Exception
            MessageBox.Show("Error 653.21a: " + ex.Message)
            LOG.WriteToArchiveLog("ERROR 653.21a clsArchiver:getOutlookFolderNames 011: '" + ex.Message + "'.")
            B = False
        End Try
        If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 012.")
        Return B
    End Function

    Public Function getOutlookFolderNames(ByVal TopLevelOutlookFolderName As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim B As Boolean = False
        Try
            If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 001: ")

            Dim oOutlook As Outlook.Application
            Dim oMAPI As Outlook.NameSpace = Nothing
            Dim oParentFolder As Outlook.MAPIFolder = Nothing
            Dim oChildFolder As Outlook.MAPIFolder = Nothing
            'Dim sArray() As String
            Dim i As Integer
            Dim iElement As Integer = 0

            oOutlook = New Outlook.Application()
            Try
                oMAPI = oOutlook.GetNamespace("MAPI")
            Catch ex As Exception
                MessageBox.Show(ex.Message)
            End Try

            'Dim MailboxName  = System.Configuration.ConfigurationManager.AppSettings("EmailFolder1")
            Dim MailboxName As String = ""

            MailboxName = TopLevelOutlookFolderName
            If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 002: '" + MailboxName + "'.")

            Dim aFolders As New List(Of String)
            Dim iFolderCount As Integer = oMAPI.Folders.Count
            For Each MF As Outlook.MAPIFolder In oMAPI.Folders
                Console.WriteLine(MF.Name)
                aFolders.Add(MF.Name)
            Next

            Try
                oParentFolder = oMAPI.Folders.Item(MailboxName)
            Catch ex As Exception
                MessageBox.Show(ex.Message)
            End Try

            'AddChildFolders(LB, MailboxName )

            If oParentFolder.Folders.Count <> 0 Then
                For i = 1 To oParentFolder.Folders.Count

                    If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 003: '" + oParentFolder.Folders.Item(i).Name)

                    Dim isEmailFolder As Boolean = False
                    Dim NbrOfItemsTested As Integer = 0
                    If TypeOf oParentFolder.Folders(i) Is Outlook.MAPIFolder Then
                        If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 004: '" + oParentFolder.Folders.Item(i).Name)
                        For Each Obj As Object In oParentFolder.Folders(i).Items
                            NbrOfItemsTested += 1
                            If TypeOf Obj Is Outlook.MailItem Then
                                If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 005: '" + oParentFolder.Folders.Item(i).Name)
                                isEmailFolder = True
                                Exit For
                            Else
                                If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 006: '" + oParentFolder.Folders.Item(i).Name)
                                If NbrOfItemsTested > 20 Then
                                    Exit For
                                End If
                            End If
                        Next
                    Else
                        If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 007: '" + oParentFolder.Folders.Item(i).Name)
                    End If

                    If NbrOfItemsTested = 0 Then
                        isEmailFolder = True
                    End If

                    If isEmailFolder = True Then
                        If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 008: '" + oParentFolder.Folders.Item(i).Name + " : Appears to be an email folder.")
                    Else
                        If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 008: '" + oParentFolder.Folders.Item(i).Name + " : Appears NOT to be an email folder.")
                        GoTo SkipThisNonEmailFolder
                    End If

                    'If TypeOf oParentFolder Is Outlook.MailItem Then
                    '    Console.WriteLine(oParentFolder.Folders.Item(i).Name)
                    'End If

                    If Trim(oParentFolder.Folders.Item(i).Name) <> "" Then
                        Dim StoreID As String = oParentFolder.StoreID
#If Office2007 Then
Dim StoreName AS String  = oParentFolder.Store.ToString
                        If xDebug Then log.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 009 Office 2007: '" + StoreName  + "'.")
#Else
                        Dim StoreName As String = oParentFolder.Name
                        If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 009 Office 2003: '" + StoreName + "'.")
#End If
                        Dim ParentID As String = oParentFolder.EntryID
                        Dim ChildID As String = oParentFolder.Folders.Item(i).EntryID
                        Dim tFolderName As String = oParentFolder.Folders.Item(i).Name
                        If xDebug Then LOG.WriteToArchiveLog(tFolderName)
                        Dim II As Integer = EMF.cnt_PK_EmailFolder(ChildID, gCurrUserGuidID)
                        II = EMF.cnt_UI_EmailFolder(TopLevelOutlookFolderName, tFolderName, gCurrUserGuidID)
                        If II = 0 Then
                            EMF.setFolderid(ChildID)
                            EMF.setFoldername(tFolderName)
                            EMF.setParentfolderid(ParentID)
                            EMF.setParentfoldername(oParentFolder.Name)
                            EMF.setUserid(gCurrUserGuidID)
                            EMF.setStoreid(StoreID)
                            Dim BB As Boolean = EMF.Insert(TopLevelOutlookFolderName)
                            'If Not BB Then
                            '    messagebox.show("Did not add folder " + tFolderName  + " to list of folders...")
                            'End If
                        End If
                    End If
SkipThisNonEmailFolder:
                Next i
            End If

            For Each oChildFolder In oParentFolder.Folders
                Dim K As Integer = 0
                K = oChildFolder.Folders.Count
                Dim cFolder As String = oChildFolder.Name.ToString
                If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 010: '" + cFolder + "'.")
                'LB.Items.Add(cFolder )
            Next
            oMAPI = Nothing
            GC.Collect()
            B = True
        Catch ex As Exception
            MessageBox.Show("Error 653.21a2: " + ex.Message)
            LOG.WriteToArchiveLog("ERROR 653.21a2 clsArchiver:getOutlookFolderNames V2 011: '" + ex.Message + "'.")
            B = False
        End Try
        If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 012.")

        Return B
    End Function

    Public Function getOutlookParentFolderNames(ByRef CB As ComboBox) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Dim L As Integer = 0
        Dim B As Boolean = False
        Try
            If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 001: ")

            CB.Items.Clear() : L = 1

            Dim oOutlook As Outlook.Application : L = 2
            Dim oMAPI As Outlook.NameSpace = Nothing : L = 3
            Dim oParentFolder As Outlook.MAPIFolder = Nothing : L = 4
            Dim oChildFolder As Outlook.MAPIFolder = Nothing : L = 5
            'Dim sArray() As String
            Dim i As Integer : L = 6
            Dim iElement As Integer = 0 : L = 7

            oOutlook = New Outlook.Application() : L = 8
            Try
                oMAPI = oOutlook.GetNamespace("MAPI") : L = 9
            Catch ex As Exception
                MessageBox.Show(ex.Message)
            End Try

            Dim MailboxName As String = System.Configuration.ConfigurationManager.AppSettings("EmailFolder1") : L = 10
            If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 002: '" + MailboxName + "'.") : L = 11

            Dim aFolders As New List(Of String) : L = 12
            Dim iFolderCount As Integer = oMAPI.Folders.Count : L = 13
            For Each MF As Outlook.MAPIFolder In oMAPI.Folders : L = 14
                Console.WriteLine(MF.Name) : L = 15
                CB.Items.Add(MF.Name) : L = 16
            Next : L = 17
        Catch ex As Exception
            LOG.WriteToArchiveLog("getOutlookParentFolderNames 100: L = " + L.ToString + vbCrLf + "Failed to get the Outlook Containers." + ex.Message)
            MessageBox.Show("getOutlookParentFolderNames 100: L = " + L.ToString + vbCrLf + "Failed to get the Outlook Containers." + ex.Message)
            B = False
        End Try

        Return B
    End Function

    Public Function getOutlookParentFolderNames() As ArrayList

        Dim AL As New ArrayList

        Dim B As Boolean = False
        Try
            If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookParentFolderNames 001: ")

            Dim oOutlook As Outlook.Application
            Dim oMAPI As Outlook.NameSpace = Nothing
            Dim oParentFolder As Outlook.MAPIFolder = Nothing
            Dim oChildFolder As Outlook.MAPIFolder = Nothing

            oOutlook = New Outlook.Application()
            Try
                oMAPI = oOutlook.GetNamespace("MAPI")
            Catch ex As Exception
                MessageBox.Show(ex.Message)
            End Try

            Dim MailboxName As String = System.Configuration.ConfigurationManager.AppSettings("EmailFolder1")
            If xDebug Then LOG.WriteToArchiveLog("clsArchiver:getOutlookParentFolderNames 002: '" + MailboxName + "'.")

            Dim aFolders As New List(Of String)
            Dim iFolderCount As Integer = oMAPI.Folders.Count
            For Each MF As Outlook.MAPIFolder In oMAPI.Folders
                Console.WriteLine(MF.Name)
                AL.Add(MF.Name)
            Next
        Catch ex As Exception
            LOG.WriteToArchiveLog("getOutlookParentFolderNames 100: " + ex.Message)
        End Try

        Return AL
    End Function

    Public Sub ProcessOutlookFolderNames(ByVal FileDirectory As String, ByVal TopFolder As String, ByRef LB As ListBox)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim ArchiveEmails As String = ""
        Dim RemoveAfterArchive As String = ""
        Dim SetAsDefaultFolder As String = ""
        Dim ArchiveAfterXDays As String = ""
        Dim RemoveAfterXDays As String = ""
        Dim RemoveXDays As String = ""
        Dim ArchiveXDays As String = ""
        Dim DB_ID As String = ""
        Dim DeleteFile As Boolean = False

        Try
            LB.Items.Clear()

            '********************************************************
            'PARAMETER: MailboxName = Name of Parent Outlook Folder for
            'the current user: Usually in the form of
            '"Mailbox - Doe, John" or
            '"Public Folders
            'RETURNS: Array of SubFolders in Current User's Mailbox
            'Or unitialized array if error occurs
            'Because it returns an array, it is for VB6 only.
            'Change to return a variant or a delimited list for
            'previous versions of vb
            'EXAMPLE:
            'Dim sArray() As String
            'Dim ictr As Integer
            'sArray = OutlookFolderNames("Mailbox - Doe, John")
            '            'On Error Resume Next
            'For ictr = 0 To UBound(sArray)
            ' if xDebug then log.WriteToArchiveLog sArray(ictr)
            'Next
            '*********************************************************
            Dim oOutlook As Outlook.Application
            Dim oMAPI As Outlook.NameSpace = Nothing
            Dim oParentFolder As Outlook.MAPIFolder = Nothing
            Dim oChildFolder As Outlook.MAPIFolder = Nothing
            'Dim sArray() As String
            Dim i As Integer
            Dim iElement As Integer = 0
            Dim BB As Boolean = False

            oOutlook = New Outlook.Application()
            Try
                oMAPI = oOutlook.GetNamespace("MAPI")
            Catch ex As Exception
                MessageBox.Show(ex.Message)
            End Try

            Dim MailboxName As String = "Personal Folders"
            Try
                oParentFolder = oMAPI.Folders.Item(MailboxName)
            Catch ex As Exception
                MessageBox.Show(ex.Message)
            End Try

            'AddChildFolders(LB, MailboxName )

            If oParentFolder.Folders.Count <> 0 Then
                For i = 1 To oParentFolder.Folders.Count
                    If Trim(oParentFolder.Folders.Item(i).Name) <> "" Then
                        LB.Items.Add(oParentFolder.Folders.Item(i).Name)
                        Dim B As Boolean = ckFolderExists(gCurrUserGuidID, oParentFolder.Folders.Item(i).Name, FileDirectory)
                        If B Then
                            Dim CurrMailFolder As Outlook.MAPIFolder = oParentFolder.Folders(i)
                            If xDebug Then LOG.WriteToArchiveLog("MUST Process folder: " + oParentFolder.Folders.Item(i).Name)
                            ArchiveEmailsInFolderenders(ArchiveEmails,
                                RemoveAfterArchive,
                                SetAsDefaultFolder,
                                ArchiveAfterXDays,
                                RemoveAfterXDays,
                                RemoveXDays,
                                ArchiveXDays,
                                CurrMailFolder, DeleteFile)
                        Else
                            If xDebug Then LOG.WriteToArchiveLog("IGNORE folder: " + oParentFolder.Folders.Item(i).Name)
                        End If
                    End If
                Next i
            End If

            For Each oChildFolder In oParentFolder.Folders
                Dim K As Integer = 0
                K = oChildFolder.Folders.Count
                Dim cFolder As String = oChildFolder.Name.ToString
                'LB.Items.Add(cFolder )
                If K > 0 Then
                    ListChildFolders(FileDirectory, TopFolder, oChildFolder, LB, cFolder, BB)
                End If
            Next
            oMAPI = Nothing
            GC.Collect()
        Catch ex As Exception
            MessageBox.Show(ex.Message)
        End Try

    End Sub

    Sub RegisterChildFolders(ByVal Container As String, ByVal oChildFolder As Outlook.MAPIFolder, ByVal FQN As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Try
            Dim tFolder As Outlook.MAPIFolder = Nothing
            Dim tFqn = FQN
            For Each tFolder In oChildFolder.Folders
                Dim ParentID As String = oChildFolder.EntryID
                Dim ChildID As String = tFolder.EntryID
                Dim tFolderName As String = tFolder.Name.ToString
                tFqn = FQN + "->" + tFolderName
                'If xDebug Then log.WriteToArchiveLog("Location clsArchiver:ListChildFolders 0022: '" + tFolderName  + "'.")
                'If xDebug Then log.WriteToArchiveLog("Location clsArchiver:ListChildFolders 0022: '" + tFqn + ":" + tFolder.EntryID)
                'LB.Items.Add(tFqn)
                Dim II As Integer = EMF.cnt_PK_EmailFolder(ChildID, gCurrUserGuidID)
                II = EMF.cnt_UI_EmailFolder(Container, tFqn, gCurrUserGuidID)
                If II = 0 Then
                    Dim oChildFolderName As String = oChildFolder.Name
                    EMF.setFolderid(ChildID)
                    EMF.setFoldername(tFqn)
                    EMF.setParentfolderid(ParentID)
                    EMF.setParentfoldername(oChildFolderName)
                    EMF.setUserid(gCurrUserGuidID)
                    Dim BB As Boolean = EMF.Insert(Container)
                Else
                    Dim oChildFolderName As String = oChildFolder.Name
                    EMF.setFolderid(ChildID)
                    EMF.setFoldername(tFqn)
                    EMF.setParentfolderid(ParentID)
                    EMF.setParentfoldername(oChildFolderName)
                    EMF.setUserid(gCurrUserGuidID)
                    Dim WC As String = EMF.wc_UI_EmailFolder(Container, oChildFolderName, gCurrUserGuidID)
                    Dim BB As Boolean = EMF.Update(WC)
                End If
                Dim k As Integer = tFolder.Folders.Count
                If k > 0 Then
                    RegisterChildFolders(Container, tFolder, tFqn)
                End If
            Next
            'For i As Integer = 0 To LB.Items.Count - 1
            '    if xDebug then log.WriteToArchiveLog(LB.Items(i).ToString)
            'Next
            'if xDebug then log.WriteToArchiveLog("------------")
        Catch ex As Exception
            'messagebox.show("Error 932.12 - " + ex.Message)
            If xDebug Then LOG.WriteToArchiveLog("Error 932.12 - " + ex.Message)
        End Try

    End Sub

    Sub ListChildFolders(ByVal FileDirectory As String, ByVal oChildFolder As Outlook.MAPIFolder, ByRef LB As ListBox, ByVal FQN As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Try
            Dim tFolder As Outlook.MAPIFolder = Nothing
            Dim tFqn = FQN
            For Each tFolder In oChildFolder.Folders
                Dim ParentID As String = oChildFolder.EntryID
                Dim ChildID As String = tFolder.EntryID
                Dim tFolderName As String = tFolder.Name.ToString
                tFqn = FQN + "->" + tFolderName
                If xDebug Then LOG.WriteToArchiveLog("Location clsArchiver:ListChildFolders 0022: '" + tFolderName + "'.")
                If xDebug Then LOG.WriteToArchiveLog("Location clsArchiver:ListChildFolders 0022: '" + tFqn + ":" + tFolder.EntryID)
                LB.Items.Add(tFqn)
                Dim II As Integer = EMF.cnt_PK_EmailFolder(ChildID, gCurrUserGuidID)
                II = EMF.cnt_UI_EmailFolder(FileDirectory, tFqn, gCurrUserGuidID)
                Dim oChildFolderName As String = oChildFolder.Name
                If II = 0 Then
                    Dim FolderFQN As String = FileDirectory + "|" + tFqn
                    EMF.setFolderid(ChildID)
                    EMF.setFoldername(tFqn)
                    EMF.setParentfolderid(ParentID)
                    EMF.setParentfoldername(oChildFolderName)
                    EMF.setUserid(gCurrUserGuidID)
                    EMF.setSelectedforarchive("?")
                    Dim BB As Boolean = EMF.Insert(FileDirectory)
                    If Not BB Then
                        LOG.WriteToArchiveLog("ERROR: Faild to  register EMAIL folder: " + FileDirectory + " : " + oChildFolderName)
                    End If
                Else
                    Dim FolderFQN As String = FileDirectory + "|" + tFqn
                    EMF.setFolderid(ChildID)
                    EMF.setFoldername(FolderFQN)
                    EMF.setParentfolderid(ParentID)
                    EMF.setParentfoldername(oChildFolderName)
                    EMF.setUserid(gCurrUserGuidID)
                    EMF.setSelectedforarchive("?")
                    Dim WC As String = EMF.wc_UI_EmailFolder(FileDirectory, FolderFQN, gCurrUserGuidID)
                    Dim BB As Boolean = EMF.Update(WC)
                    If Not BB Then
                        LOG.WriteToArchiveLog("ERROR: Faild to update registration for EMAIL folder: " + FileDirectory + " : " + tFolderName)
                    End If
                End If
                Dim k As Integer = tFolder.Folders.Count
                If k > 0 Then
                    ListChildFolders(FileDirectory, tFolder, LB, tFqn)
                End If
            Next
            'For i As Integer = 0 To LB.Items.Count - 1
            '    if xDebug then log.WriteToArchiveLog(LB.Items(i).ToString)
            'Next
            'if xDebug then log.WriteToArchiveLog("------------")
        Catch ex As Exception
            'messagebox.show("Error 932.12 - " + ex.Message)
            If xDebug Then LOG.WriteToArchiveLog("Error 932.12 - " + ex.Message)
        End Try

    End Sub

    Sub ListChildFolders(ByVal oChildFolder As Outlook.MAPIFolder, ByVal FQN As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Try
            Dim tFolder As Outlook.MAPIFolder = Nothing
            Dim tFqn = FQN
            For Each tFolder In oChildFolder.Folders
                Dim ParentID As String = oChildFolder.EntryID
                Dim ChildID As String = tFolder.EntryID
                Dim tFolderName As String = tFolder.Name.ToString
                tFqn = FQN + "->" + tFolderName
                If xDebug Then LOG.WriteToArchiveLog("Location clsArchiver:ListChildFolders 0033: '" + tFolderName + "'.")
                If xDebug Then LOG.WriteToArchiveLog("Location clsArchiver:ListChildFolders 0033: '" + tFqn + ":" + tFolder.EntryID)
                If ChildFoldersList.ContainsKey(tFqn) Then
                Else
                    Try
                        ChildFoldersList.Add(tFqn, ChildID)
                    Catch ex As Exception
                        LOG.WriteToArchiveLog("NOTICE: ListChildFolders - ChildFoldersList.Add: " + ex.Message)
                    End Try
                End If
                Dim k As Integer = tFolder.Folders.Count
                If k > 0 Then
                    ListChildFolders(tFolder, tFqn)
                End If
            Next
            'For i As Integer = 0 To LB.Items.Count - 1
            '    if xDebug then log.WriteToArchiveLog(LB.Items(i).ToString)
            'Next
            'if xDebug then log.WriteToArchiveLog("------------")
        Catch ex As Exception
            'messagebox.show("Error 932.12 - " + ex.Message)
            If xDebug Then LOG.WriteToArchiveLog("Error 932.12 - " + ex.Message)
        End Try

    End Sub

    Sub ListChildFolders(ByVal UID As String, ByVal EmailFolderFQN As String, ByVal TopFolder As String, ByVal currFolder As String, ByVal oChildFolder As Outlook.MAPIFolder, ByVal FQN As String, ByVal slStoreId As SortedList, ByVal isPublic As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Dim StoreID As String = oChildFolder.StoreID
        Try
            Dim FolderName As String = ""
            Dim ArchiveEmails As String = ""
            Dim RemoveAfterArchive As String = ""
            Dim SetAsDefaultFolder As String = ""
            Dim ArchiveAfterXDays As String = ""
            Dim RemoveAfterXDays As String = ""
            Dim RemoveXDays As String = ""
            Dim ArchiveXDays As String = ""
            Dim DB_ID As String = ""
            Dim DeleteFile As Boolean = False
            Dim ARCH As New clsArchiver
            Dim ArchiveOnlyIfRead As String = ""

            Dim ParentID As String = ""
            Dim ChildID As String = ""
            Dim tFolderName As String = ""
            Dim BB As Integer = 0
            Dim idx As Integer = 0

            Dim subFolder As Outlook.MAPIFolder = Nothing
            Dim tFolder As Outlook.MAPIFolder = Nothing
            Dim tFqn = FQN

            Console.WriteLine("Listing the children of: " + tFqn)
            Console.WriteLine("oChildFolder.Folders count : " + oChildFolder.Folders.Count.ToString)

            For Each tFolder In oChildFolder.Folders

                ParentID = oChildFolder.EntryID
                ChildID = tFolder.EntryID
                tFolderName = tFolder.Name.ToString
                tFqn = FQN + "->" + tFolderName
                'Console.WriteLine("Processing Child Folder: " + tFqn)
                If xDebug Then LOG.WriteToArchiveLog("Processing Child Folder: " + tFqn)
                If xDebug Then LOG.WriteToArchiveLog("Location clsArchiver:ListChildFolders 0044: '" + tFolderName + "'.")
                If xDebug Then LOG.WriteToArchiveLog("Location clsArchiver:ListChildFolders 0044: '" + tFqn + ":" + tFolder.EntryID)

                idx = ChildFoldersList.IndexOfKey(tFqn)
                If idx >= 0 Then
                    ChildID = ChildFoldersList.Item(tFqn)
                Else
                    idx = ckArchEmailFolder(tFqn, gCurrUserGuidID)
                    If idx = 0 Then
                        ChildID = "0000"
                    Else
                        ChildID = getArchEmailFolderIDByFolder(tFqn, gCurrUserGuidID)
                    End If
                End If

                BB = ckArchChildEmailFolder(ChildID, gCurrUserGuidID)

                If BB > 0 Then
                    If xDebug Then LOG.WriteToArchiveLog("Location clsArchiver:ListChildFolders 0044a Found it: '" + tFqn + ":" + tFolder.EntryID)
                    Dim RetentionCode As String = ""
                    Dim RetentionYears As Integer = 10

                    RetentionCode = getArchEmailFolderRetentionCode(ChildID, gCurrUserGuidID)
                    If RetentionCode.Length > 0 Then
                        RetentionYears = getRetentionPeriod(RetentionCode)
                    End If

                    'messagebox.show("Get the emails from " + tFolderName )
                    Dim oChildFolderName As String = tFolder.Name
                    EMF.setFolderid(ChildID)
                    EMF.setFoldername(tFqn)
                    EMF.setParentfolderid(ParentID)
                    EMF.setParentfoldername(oChildFolderName)
                    EMF.setUserid(gCurrUserGuidID)
                    If xDebug Then LOG.WriteToArchiveLog(tFolderName)
                    'BB = ckArchEmailFolder(ChildID , gCurrUserGuidID)
                    'If BB Then
                    EMF.setFolderid(ChildID)
                    EMF.setFoldername(tFolderName)
                    EMF.setParentfolderid(ParentID)
                    EMF.setParentfoldername(oChildFolder.Name)
                    EMF.setUserid(gCurrUserGuidID)
                    BB = GetEmailFolderParms(TopFolder, gCurrUserGuidID, tFqn, ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, DB_ID, ArchiveOnlyIfRead)

                    DBLocal.setOutlookMissing()

                    ArchiveEmailsInFolder(UID, TopFolder, ArchiveEmails,
                                  RemoveAfterArchive,
                                  SetAsDefaultFolder,
                                  ArchiveAfterXDays,
                                  RemoveAfterXDays,
                                  RemoveXDays,
                                  ArchiveXDays,
                                  DB_ID, tFolder, StoreID, ArchiveOnlyIfRead, RetentionYears, RetentionCode, tFqn, slStoreId, isPublic)
                End If

                For Each subFolder In tFolder.Folders
                    Dim sFqn As String = tFqn + "->" + subFolder.Name
                    sFqn = TopFolder + "|" + sFqn
                    ListChildFolders(UID, EmailFolderFQN, TopFolder, currFolder, subFolder, sFqn, slStoreId, isPublic)
                Next
                'Dim k As Integer = tFolder.Folders.Count
                'If k > 0 Then
                '    ListChildFolders(EmailFolderFQN, TopFolder , currFolder , oChildFolder, FQN )
                'End If
            Next

            '*******************************************************

            ParentID = oChildFolder.EntryID
            ChildID = tFolder.EntryID
            tFolderName = tFolder.Name.ToString
            tFqn = FQN + "->" + tFolderName
            Console.WriteLine("Processing Child Folder: " + tFqn)
            If xDebug Then LOG.WriteToArchiveLog("Processing Child Folder: " + tFqn)
            If xDebug Then LOG.WriteToArchiveLog("Location clsArchiver:ListChildFolders 0044: '" + tFolderName + "'.")
            If xDebug Then LOG.WriteToArchiveLog("Location clsArchiver:ListChildFolders 0044: '" + tFqn + ":" + tFolder.EntryID)

            idx = ChildFoldersList.IndexOfKey(tFqn)
            If idx >= 0 Then
                ChildID = ChildFoldersList.Item(tFqn)
            Else
                idx = ckArchEmailFolder(tFqn, gCurrUserGuidID)
                If idx = 0 Then
                    ChildID = "0000"
                Else
                    ChildID = getArchEmailFolderIDByFolder(tFqn, gCurrUserGuidID)
                End If
            End If

            BB = ckArchChildEmailFolder(ChildID, gCurrUserGuidID)

            If BB > 0 Then

                Dim RetentionCode As String = ""
                Dim RetentionYears As Integer = 10

                RetentionCode = getArchEmailFolderRetentionCode(ChildID, gCurrUserGuidID)
                If RetentionCode.Length > 0 Then
                    RetentionYears = getRetentionPeriod(RetentionCode)
                End If

                'messagebox.show("Get the emails from " + tFolderName )
                Dim oChildFolderName As String = tFolder.Name
                EMF.setFolderid(ChildID)
                EMF.setFoldername(tFqn)
                EMF.setParentfolderid(ParentID)
                EMF.setParentfoldername(oChildFolderName)
                EMF.setUserid(gCurrUserGuidID)
                If xDebug Then LOG.WriteToArchiveLog(tFolderName)
                'BB = ckArchEmailFolder(ChildID , gCurrUserGuidID)
                'If BB Then
                EMF.setFolderid(ChildID)
                EMF.setFoldername(tFolderName)
                EMF.setParentfolderid(ParentID)
                EMF.setParentfoldername(oChildFolder.Name)
                EMF.setUserid(gCurrUserGuidID)
                BB = GetEmailFolderParms(TopFolder, gCurrUserGuidID, tFqn, ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, DB_ID, ArchiveOnlyIfRead)

                DBLocal.setOutlookMissing()

                ArchiveEmailsInFolder(UID, TopFolder, ArchiveEmails,
                              RemoveAfterArchive,
                              SetAsDefaultFolder,
                              ArchiveAfterXDays,
                              RemoveAfterXDays,
                              RemoveXDays,
                              ArchiveXDays,
                              DB_ID, tFolder, DeleteFile, StoreID, ArchiveOnlyIfRead, RetentionYears, RetentionCode, slStoreId, isPublic)

            End If

            subFolder = Nothing
            For Each subFolder In tFolder.Folders
                Dim sFqn As String = tFqn + "->" + subFolder.Name
                sFqn = TopFolder + "|" + sFqn
                ListChildFolders(UID, EmailFolderFQN, TopFolder, currFolder, subFolder, sFqn, slStoreId, isPublic)
            Next
            'Dim k As Integer = tFolder.Folders.Count
            'If k > 0 Then
            '    ListChildFolders(EmailFolderFQN, TopFolder , currFolder , oChildFolder, FQN )
            'End If

            '*******************************************************
        Catch ex As Exception
            If xDebug Then LOG.WriteToArchiveLog("Error 932.12a - " + ex.Message)
        End Try

    End Sub

    Sub ListChildFolders(ByVal FileDirectory As String, ByVal TopFolder As String, ByVal oChildFolder As Outlook.MAPIFolder, ByRef LB As ListBox, ByVal FQN As String, ByVal B As Boolean)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Dim ArchiveEmails As String = ""
        Dim RemoveAfterArchive As String = ""
        Dim SetAsDefaultFolder As String = ""
        Dim ArchiveAfterXDays As String = ""
        Dim RemoveAfterXDays As String = ""
        Dim RemoveXDays As String = ""
        Dim ArchiveXDays As String = ""
        Dim DB_ID As String = ""
        Dim DeleteFile As Boolean = False
        Dim ArchiveOnlyIfRead As String = ""

        Try
            Dim tFolder As Outlook.MAPIFolder = Nothing
            Dim tFqn = FQN
            For Each tFolder In oChildFolder.Folders
                Dim tFolderName As String = tFolder.Name.ToString
                GetFolderByPath(tFolder.FolderPath)
                tFqn = FQN + "->" + tFolderName
                If xDebug Then LOG.WriteToArchiveLog("Location clsArchiver:ListChildFolders 0055: '" + tFolderName + "'.")
                LB.Items.Add(tFqn)
                Dim k As Integer = tFolder.Folders.Count
                If k > 0 Then
                    ListChildFolders(FileDirectory, tFolder, LB, tFqn)
                End If
                Dim CurrFolderName As String = tFqn
                tFqn = UTIL.RemoveSingleQuotes(tFqn)
                B = ckFolderExists(gCurrUserGuidID, tFqn, FileDirectory)
                If B Then
                    If xDebug Then LOG.WriteToArchiveLog("MUST Process folder: " + CurrFolderName + ", alias: " + tFolder.Name)
                    Dim BB As Boolean = GetEmailFolderParms(TopFolder, gCurrUserGuidID, CurrFolderName, ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, DB_ID, ArchiveOnlyIfRead)
                    If BB Then
                        ArchiveEmailsInFolderenders(ArchiveEmails,
                                RemoveAfterArchive,
                                SetAsDefaultFolder,
                                ArchiveAfterXDays,
                                RemoveAfterXDays,
                                RemoveXDays,
                                ArchiveXDays,
                                tFolder, DeleteFile)
                    End If
                Else
                    If xDebug Then LOG.WriteToArchiveLog("IGNORE folder: " + CurrFolderName)
                End If
            Next
        Catch ex As Exception
            If xDebug Then LOG.WriteToArchiveLog("ERROR 1211.1 - " + ex.Message)
        End Try
    End Sub

    Sub ProcessAllFolders(ByVal oChildFolder As Outlook.MAPIFolder, ByRef LB As ListBox, ByVal FQN As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Dim tFolder As Outlook.MAPIFolder = Nothing
        Dim tFqn = FQN
        For Each tFolder In oChildFolder.Folders
            Dim tFolderName As String = tFolder.Name.ToString
            tFqn = FQN + "->" + tFolderName
            If xDebug Then LOG.WriteToArchiveLog("Location clsArchiver:ProcessAllFolders 0066 '" + tFolderName + "'.")
            LB.Items.Add(tFqn)
            Dim k As Integer = tFolder.Folders.Count
            If k > 0 Then
                ProcessAllFolders(tFolder, LB, tFqn)
            Else
                If xDebug Then LOG.WriteToArchiveLog("Examine Folder: " + tFolder.Name)
            End If
        Next
        For i As Integer = 0 To LB.Items.Count - 1
            If xDebug Then LOG.WriteToArchiveLog(LB.Items(i).ToString)
        Next
    End Sub

    Sub AddChildFolders(ByRef LB As ListBox, ByVal MailboxName As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim oOutlook As Outlook.Application
        Dim oMAPI As Outlook.NameSpace = Nothing
        Dim oChildFolder As Outlook.MAPIFolder = Nothing

        oOutlook = New Outlook.Application()

        Try
            oMAPI = oOutlook.GetNamespace("MAPI")
        Catch ex As Exception
            MessageBox.Show(ex.Message)
        End Try

        Try
            oChildFolder = oMAPI.Folders.Item(MailboxName)
        Catch ex As Exception
            'messagebox.show(ex.Message)
            LB.Items.Add(MailboxName)
            Return
        End Try

        If oChildFolder.Folders.Count = 0 Then
            LB.Items.Add(MailboxName)
            'LB.Items.Add(oChildFolder.Folders.Item(i).Name)
        Else
            Dim I As Integer = 0
            For I = 1 To oChildFolder.Folders.Count
                If Trim(oChildFolder.Folders.Item(I).Name) <> "" Then
                    Dim ChildFolderName As String = oChildFolder.Folders.Item(I).Name.ToString
                    AddChildFolders(LB, ChildFolderName)
                End If
            Next I
        End If

    End Sub

    Sub ConvertName(ByRef FQN As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        For i As Integer = 1 To FQN.Length
            Dim CH As String = Mid(FQN, i, 1)
            Dim II As Integer = InStr(1, "abcdefghijklmnopqrstuvwxyz0123456789_.", CH, CompareMethod.Text)
            If II = 0 Then
                Mid(FQN, i, 1) = "_"
            End If
            'If CH = " " Then
            '    Mid(FQN, i, 1) = "_"
            'End If
            'If CH = "?" Then
            '    Mid(FQN, i, 1) = "_"
            'End If
            'If CH = "-" Then
            '    Mid(FQN, i, 1) = "_"
            'End If
            'If CH = ":" Then
            '    Mid(FQN, i, 1) = "."
            'End If
            'If CH = "/" Then
            '    Mid(FQN, i, 1) = "."
            'End If
        Next
    End Sub

    'Private Sub Timer1_Tick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Timer1.Tick
    '     Try

    ' 'Dim test1 As String = System.Configuration.ConfigurationManager.AppSettings("Test1") 'Dim
    ' oConn As New
    ' SqlConnection(System.Configuration.ConfigurationManager.AppSettings("DB_CONN_STR")) If
    ' Timer1.Enabled Then '** Get the polling interval Dim PollingInterval As Integer =
    ' Val(System.Configuration.ConfigurationManager.AppSettings("PollIntervalMinutes")) '** Convert
    ' the MINUTES to Milliseconds. Timer1.Interval = PollingInterval * 60000

    ' Dim S = System.Configuration.ConfigurationManager.AppSettings("ParseDirectory") If
    ' S.Equals("YES") Then bParseDir = True DirToParse =
    ' System.Configuration.ConfigurationManager.AppSettings("DirectoryToParse") Else bParseDir =
    ' False End If ParseArchiveFolder =
    ' System.Configuration.ConfigurationManager.AppSettings("ParseArchiveFolder") ArchiveSentMail =
    ' System.Configuration.ConfigurationManager.AppSettings("ArchiveSentMail") ArchiveInbox =
    ' System.Configuration.ConfigurationManager.AppSettings("ArchiveInbox") MaxDaysBeforeArchive = Val(System.Configuration.ConfigurationManager.AppSettings("MaxDaysBeforeArchive"))

    '               Timer1.Enabled = False
    '               If ParseArchiveFolder .Equals("YES") Then
    '                    LoadArchiveFolder()
    '               End If
    '               If ArchiveSentMail.Equals("YES") Then
    '                    GetEmails(oNS.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderSentMail), False)
    '               End If
    '               If bParseDir = True Then
    '                    Redeem.ProcessDir(DirToParse , "", True)
    '               End If
    '               If ArchiveInbox.Equals("YES") Then
    '                    GetEmails(oNS.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderInbox), False)
    '               End If
    '               Timer1.Enabled = True
    '          Else
    '               if xDebug then log.WriteToArchiveLog("Timer OFF")
    '          End If
    '          'oConn.Close()
    '          'oConn = Nothing
    '     Catch ex As Exception
    '          messagebox.show(ex.Message)
    '     End Try
    'End Sub
    Sub GetActiveEmailSenders(ByVal FileDirectory As String, ByVal TopFolder As String, ByVal UID As String, ByVal MailboxName As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim ActiveFolders(0) As String
        Dim FolderName As String = ""
        Dim DeleteFile As Boolean = False

        Dim ArchiveEmails As String = ""
        Dim RemoveAfterArchive As String = ""
        Dim SetAsDefaultFolder As String = ""
        Dim ArchiveAfterXDays As String = ""
        Dim RemoveAfterXDays As String = ""
        Dim RemoveXDays As String = ""
        Dim ArchiveXDays As String = ""
        Dim DB_ID As String = ""
        Dim ArchiveOnlyIfRead As String = ""

        Dim EmailFolders(0) As String

        GetEmailFolders(UID, EmailFolders)

        For i As Integer = 0 To UBound(EmailFolders)
            FolderName = EmailFolders(i).ToString.Trim
            If xDebug Then LOG.WriteToArchiveLog("Folder to Process: " + FolderName)
            Dim B As Boolean = ckFolderExists(FileDirectory, UID, FolderName)
            If B Then
                Dim BB As Boolean = GetEmailFolderParms(TopFolder, UID, FolderName, ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, DB_ID, ArchiveOnlyIfRead)
                If BB Then
                    'ARCH.getSubFolderEmails(FolderName , bDeleteMsg)
                    If xDebug Then LOG.WriteToArchiveLog("Processing Senders from : " + FolderName)
                    getSubFolderEmailsSenders(UID, MailboxName, FolderName, DeleteFile, ArchiveEmails,
                    RemoveAfterArchive,
                    SetAsDefaultFolder,
                    ArchiveAfterXDays,
                    RemoveAfterXDays,
                    RemoveXDays,
                    ArchiveXDays, FileDirectory)
                    'ARCH.GetEmails(FolderName , ArchiveEmails , RemoveAfterArchive , SetAsDefaultFolder , ArchiveAfterXDays , RemoveAfterXDays , RemoveXDays , ArchiveXDays , DB_ID )
                End If
            End If
        Next

    End Sub

    Sub DeleteContact(ByVal EmailAddress As String, ByVal FullName As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        On Error GoTo Err_Handler
        Dim DQ As String = Chr(34)
        Dim olContact As Outlook.ContactItem
        Dim olFolder As Outlook.MAPIFolder

        If Not InitializeOutlook() Then
            MessageBox.Show("Cannot initialize Outlook")
            Exit Sub
        End If

        olFolder = g_nspNameSpace.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderContacts)
        olContact = olFolder.Items.Find("[Email1Address] = " + DQ + EmailAddress + DQ + " AND " &
        "[FullName] = " + DQ + FullName + DQ)

        If Not olContact Is Nothing Then
            olContact.Display()
            olContact.Delete()

            LOG.WriteToArchiveLog("clsArchiver : DeleteContact : Delete Performed 07")
        Else
            MessageBox.Show("Cannot find contact")
        End If

Exit_Handler:

        ' On Error Resume Next

        If Not olFolder Is Nothing Then
            olFolder = Nothing
        End If

        If Not olContact Is Nothing Then
            olContact = Nothing
        End If
        GC.Collect()
        Exit Sub

Err_Handler:
        MessageBox.Show(Err.Description + " - Error No: " & Err.Number)
        Resume Exit_Handler

    End Sub

    Sub DeleteEmail(ByVal SenderEmailAddress As String, ByVal ReceivedByName As String, ByVal ReceivedTime As String, ByVal SenderName As String, ByVal SentOn As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        On Error GoTo Err_Handler
        Dim DQ As String = Chr(34)
#If Office2007 Then
        Dim olEmail As Outlook.Folder
#Else
        Dim olEmail As Outlook.Folders
#End If
        Dim olFolder As Outlook.MAPIFolder

        If Not InitializeOutlook() Then
            MessageBox.Show("Cannot initialize Outlook")
            Exit Sub
        End If

        Dim S As String = "[SenderEmailAddress] = " + DQ + SenderEmailAddress + DQ
        S = S + "and [ReceivedByName] = " + DQ + ReceivedByName + DQ
        S = S + "and [ReceivedTime] = " + DQ + ReceivedTime + DQ
        S = S + "and [ReceivedByName] = " + DQ + ReceivedByName + DQ

        olFolder = g_nspNameSpace.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderInbox)
        olEmail = olFolder.Items.Find(S)

        If Not olEmail Is Nothing Then
            'olEmail.Display()
            olEmail.Delete()
            If ddebug Then LOG.WriteToArchiveLog("clsArchiver : DeleteEmail : Delete Performed 09")
        Else
            MessageBox.Show("Cannot find email: ")
        End If

Exit_Handler:

        ' On Error Resume Next

        If Not olFolder Is Nothing Then
            olFolder = Nothing
        End If

        If Not olEmail Is Nothing Then
            olEmail = Nothing
        End If
        GC.Collect()
        Exit Sub

Err_Handler:
        MessageBox.Show(Err.Description, vbExclamation + " - Error No: " & Err.Number)
        Resume Exit_Handler

    End Sub

    Sub AddOutlookContact(ByVal DG As DataGridView, ByVal SkipIfExists As Boolean, ByVal OverwriteContact As Boolean, ByVal AddIfMissing As Boolean)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        'Dim DR As DataGridViewRow

        Dim olContact As Outlook.ContactItem = Nothing
        Dim olFolder As Outlook.MAPIFolder = Nothing

        If Not InitializeOutlook() Then
            MsgBox("Cannot initialize Outlook",
            vbExclamation,
            "Automation Error")
            Exit Sub
        End If
        'DGV.DisplayColNames(DG)
        DGV.ListColumnNames(DG)
        Dim SL As New SortedList
        DGV.DisplayColNames(DG, SL)
        Try
            olFolder = g_nspNameSpace.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderContacts)
            Try
                For Each SelectedRow As DataGridViewRow In DG.SelectedRows
                    Dim Email1Address As String = SelectedRow.Cells("Email1Address").Value.ToString
                    Dim FullName As String = SelectedRow.Cells("FullName").Value.ToString
                    Dim UserID As String = SelectedRow.Cells("UserID").Value.ToString
                    Dim Account As String = SelectedRow.Cells("Account").Value.ToString
                    Dim Anniversary As String = SelectedRow.Cells("Anniversary").Value.ToString
                    Dim Application As String = SelectedRow.Cells("Application").Value.ToString
                    Dim AssistantName As String = SelectedRow.Cells("AssistantName").Value.ToString
                    Dim AssistantTelephoneNumber As String = SelectedRow.Cells("AssistantTelephoneNumber").Value.ToString
                    Dim BillingInformation As String = SelectedRow.Cells("BillingInformation").Value.ToString
                    Dim Birthday As String = SelectedRow.Cells("Birthday").Value.ToString
                    Dim Business2TelephoneNumber As String = SelectedRow.Cells("Business2TelephoneNumber").Value.ToString
                    Dim BusinessAddress As String = SelectedRow.Cells("BusinessAddress").Value.ToString
                    Dim BusinessAddressCity As String = SelectedRow.Cells("BusinessAddressCity").Value.ToString
                    Dim BusinessAddressCountry As String = SelectedRow.Cells("BusinessAddressCountry").Value.ToString
                    Dim BusinessAddressPostalCode As String = SelectedRow.Cells("BusinessAddressPostalCode").Value.ToString
                    Dim BusinessAddressPostOfficeBox As String = SelectedRow.Cells("BusinessAddressPostOfficeBox").Value.ToString
                    Dim BusinessAddressState As String = SelectedRow.Cells("BusinessAddressState").Value.ToString
                    Dim BusinessAddressStreet As String = SelectedRow.Cells("BusinessAddressStreet").Value.ToString
                    Dim BusinessCardType As String = SelectedRow.Cells("BusinessCardType").Value.ToString
                    Dim BusinessFaxNumber As String = SelectedRow.Cells("BusinessFaxNumber").Value.ToString
                    Dim BusinessHomePage As String = SelectedRow.Cells("BusinessHomePage").Value.ToString
                    Dim BusinessTelephoneNumber As String = SelectedRow.Cells("BusinessTelephoneNumber").Value.ToString
                    Dim CallbackTelephoneNumber As String = SelectedRow.Cells("CallbackTelephoneNumber").Value.ToString
                    Dim CarTelephoneNumber As String = SelectedRow.Cells("CarTelephoneNumber").Value.ToString
                    Dim Categories As String = SelectedRow.Cells("Categories").Value.ToString
                    Dim Children As String = SelectedRow.Cells("Children").Value.ToString
                    Dim XClass As String = SelectedRow.Cells("XClass").Value.ToString
                    Dim Companies As String = SelectedRow.Cells("Companies").Value.ToString
                    Dim CompanyName As String = SelectedRow.Cells("CompanyName").Value.ToString
                    Dim ComputerNetworkName As String = SelectedRow.Cells("ComputerNetworkName").Value.ToString
                    Dim Conflicts As String = SelectedRow.Cells("Conflicts").Value.ToString
                    Dim ConversationTopic As String = SelectedRow.Cells("ConversationTopic").Value.ToString
                    Dim CreationTime As String = SelectedRow.Cells("CreationTime").Value.ToString
                    Dim CustomerID As String = SelectedRow.Cells("CustomerID").Value.ToString
                    Dim Department As String = SelectedRow.Cells("Department").Value.ToString
                    Dim Email1AddressType As String = SelectedRow.Cells("Email1AddressType").Value.ToString
                    Dim Email1DisplayName As String = SelectedRow.Cells("Email1DisplayName").Value.ToString
                    Dim Email1EntryID As String = SelectedRow.Cells("Email1EntryID").Value.ToString
                    Dim Email2Address As String = SelectedRow.Cells("Email2Address").Value.ToString
                    Dim Email2AddressType As String = SelectedRow.Cells("Email2AddressType").Value.ToString
                    Dim Email2DisplayName As String = SelectedRow.Cells("Email2DisplayName").Value.ToString
                    Dim Email2EntryID As String = SelectedRow.Cells("Email2EntryID").Value.ToString
                    Dim Email3Address As String = SelectedRow.Cells("Email3Address").Value.ToString
                    Dim Email3AddressType As String = SelectedRow.Cells("Email3AddressType").Value.ToString
                    Dim Email3DisplayName As String = SelectedRow.Cells("Email3DisplayName").Value.ToString
                    Dim Email3EntryID As String = SelectedRow.Cells("Email3EntryID").Value.ToString
                    Dim FileAs As String = SelectedRow.Cells("FileAs").Value.ToString
                    Dim FirstName As String = SelectedRow.Cells("FirstName").Value.ToString
                    Dim FTPSite As String = SelectedRow.Cells("FTPSite").Value.ToString
                    Dim Gender As String = SelectedRow.Cells("Gender").Value.ToString
                    Dim GovernmentIDNumber As String = SelectedRow.Cells("GovernmentIDNumber").Value.ToString
                    Dim Hobby As String = SelectedRow.Cells("Hobby").Value.ToString
                    Dim Home2TelephoneNumber As String = SelectedRow.Cells("Home2TelephoneNumber").Value.ToString
                    Dim HomeAddress As String = SelectedRow.Cells("HomeAddress").Value.ToString
                    Dim HomeAddressCountry As String = SelectedRow.Cells("HomeAddressCountry").Value.ToString
                    Dim HomeAddressPostalCode As String = SelectedRow.Cells("HomeAddressPostalCode").Value.ToString
                    Dim HomeAddressPostOfficeBox As String = SelectedRow.Cells("HomeAddressPostOfficeBox").Value.ToString
                    Dim HomeAddressState As String = SelectedRow.Cells("HomeAddressState").Value.ToString
                    Dim HomeAddressStreet As String = SelectedRow.Cells("HomeAddressStreet").Value.ToString
                    Dim HomeFaxNumber As String = SelectedRow.Cells("HomeFaxNumber").Value.ToString
                    Dim HomeTelephoneNumber As String = SelectedRow.Cells("HomeTelephoneNumber").Value.ToString
                    Dim IMAddress As String = SelectedRow.Cells("IMAddress").Value.ToString
                    Dim Importance As String = SelectedRow.Cells("Importance").Value.ToString
                    Dim Initials As String = SelectedRow.Cells("Initials").Value.ToString
                    Dim InternetFreeBusyAddress As String = SelectedRow.Cells("InternetFreeBusyAddress").Value.ToString
                    Dim JobTitle As String = SelectedRow.Cells("JobTitle").Value.ToString
                    Dim Journal As String = SelectedRow.Cells("Journal").Value.ToString
                    Dim Language As String = SelectedRow.Cells("Language").Value.ToString
                    Dim LastModificationTime As String = SelectedRow.Cells("LastModificationTime").Value.ToString
                    Dim LastName As String = SelectedRow.Cells("LastName").Value.ToString
                    Dim LastNameAndFirstName As String = SelectedRow.Cells("LastNameAndFirstName").Value.ToString
                    Dim MailingAddress As String = SelectedRow.Cells("MailingAddress").Value.ToString
                    Dim MailingAddressCity As String = SelectedRow.Cells("MailingAddressCity").Value.ToString
                    Dim MailingAddressCountry As String = SelectedRow.Cells("MailingAddressCountry").Value.ToString
                    Dim MailingAddressPostalCode As String = SelectedRow.Cells("MailingAddressPostalCode").Value.ToString
                    Dim MailingAddressPostOfficeBox As String = SelectedRow.Cells("MailingAddressPostOfficeBox").Value.ToString
                    Dim MailingAddressState As String = SelectedRow.Cells("MailingAddressState").Value.ToString
                    Dim MailingAddressStreet As String = SelectedRow.Cells("MailingAddressStreet").Value.ToString
                    Dim ManagerName As String = SelectedRow.Cells("ManagerName").Value.ToString
                    Dim MiddleName As String = SelectedRow.Cells("MiddleName").Value.ToString
                    Dim Mileage As String = SelectedRow.Cells("Mileage").Value.ToString
                    Dim MobileTelephoneNumber As String = SelectedRow.Cells("MobileTelephoneNumber").Value.ToString
                    Dim NetMeetingAlias As String = SelectedRow.Cells("NetMeetingAlias").Value.ToString
                    Dim NetMeetingServer As String = SelectedRow.Cells("NetMeetingServer").Value.ToString
                    Dim NickName As String = SelectedRow.Cells("NickName").Value.ToString
                    Dim Title As String = SelectedRow.Cells("Title").Value.ToString
                    Dim Body As String = SelectedRow.Cells("Body").Value.ToString
                    Dim OfficeLocation As String = SelectedRow.Cells("OfficeLocation").Value.ToString
                    Dim Subject As String = SelectedRow.Cells("Subject").Value.ToString

                    Dim DQ As String = Chr(34)

                    olContact = olFolder.Items.Find("[Email1Address] = " + DQ + Email1Address + DQ + " AND " &
                    "[FullName] = " + DQ + FullName + DQ)
                    'FrmMDIMain.SB.Text = FullName

                    If Not olContact Is Nothing Then
                        If (OverwriteContact Or AddIfMissing) Then
                            olContact.Delete()
                            'LOG.WriteToArchiveLog("clsArchiver : AddOutlookContact : Delete Performed 10: " + Email1Address )
                            AddContactDetail(Account, Anniversary, Application, AssistantName, AssistantTelephoneNumber, BillingInformation, Birthday, Business2TelephoneNumber, BusinessAddress, BusinessAddressCity, BusinessAddressCountry, BusinessAddressPostalCode, BusinessAddressPostOfficeBox, BusinessAddressState, BusinessAddressStreet, BusinessCardType, BusinessFaxNumber, BusinessHomePage, BusinessTelephoneNumber, CallbackTelephoneNumber, CarTelephoneNumber, Categories, Children, XClass, Companies, CompanyName, ComputerNetworkName, Conflicts, ConversationTopic, CreationTime, CustomerID, Department, Email1Address, Email1AddressType, Email1DisplayName, Email1EntryID, Email2Address, Email2AddressType, Email2DisplayName, Email2EntryID, Email3Address, Email3AddressType, Email3DisplayName, Email3EntryID, FileAs, FirstName, FTPSite, FullName, Gender, GovernmentIDNumber, Hobby, Home2TelephoneNumber, HomeAddress, HomeAddressCountry, HomeAddressPostalCode, HomeAddressPostOfficeBox, HomeAddressState, HomeAddressStreet, HomeFaxNumber, HomeTelephoneNumber, IMAddress, Importance, Initials, InternetFreeBusyAddress, JobTitle, Journal, Language, LastModificationTime, LastName, LastNameAndFirstName, MailingAddress, MailingAddressCity, MailingAddressCountry, MailingAddressPostalCode, MailingAddressPostOfficeBox, MailingAddressState, MailingAddressStreet, ManagerName, MiddleName, Mileage, MobileTelephoneNumber, NetMeetingAlias, NetMeetingServer, NickName, Title, Body, OfficeLocation, Subject)
                        Else
                            Console.WriteLine("Contact already exist... skipping.")
                            'olContact.Display()
                        End If
                    Else
                        AddContactDetail(Account, Anniversary, Application, AssistantName, AssistantTelephoneNumber, BillingInformation, Birthday, Business2TelephoneNumber, BusinessAddress, BusinessAddressCity, BusinessAddressCountry, BusinessAddressPostalCode, BusinessAddressPostOfficeBox, BusinessAddressState, BusinessAddressStreet, BusinessCardType, BusinessFaxNumber, BusinessHomePage, BusinessTelephoneNumber, CallbackTelephoneNumber, CarTelephoneNumber, Categories, Children, XClass, Companies, CompanyName, ComputerNetworkName, Conflicts, ConversationTopic, CreationTime, CustomerID, Department, Email1Address, Email1AddressType, Email1DisplayName, Email1EntryID, Email2Address, Email2AddressType, Email2DisplayName, Email2EntryID, Email3Address, Email3AddressType, Email3DisplayName, Email3EntryID, FileAs, FirstName, FTPSite, FullName, Gender, GovernmentIDNumber, Hobby, Home2TelephoneNumber, HomeAddress, HomeAddressCountry, HomeAddressPostalCode, HomeAddressPostOfficeBox, HomeAddressState, HomeAddressStreet, HomeFaxNumber, HomeTelephoneNumber, IMAddress, Importance, Initials, InternetFreeBusyAddress, JobTitle, Journal, Language, LastModificationTime, LastName, LastNameAndFirstName, MailingAddress, MailingAddressCity, MailingAddressCountry, MailingAddressPostalCode, MailingAddressPostOfficeBox, MailingAddressState, MailingAddressStreet, ManagerName, MiddleName, Mileage, MobileTelephoneNumber, NetMeetingAlias, NetMeetingServer, NickName, Title, Body, OfficeLocation, Subject)
                    End If
                Next
            Catch ex As Exception
                LOG.WriteToArchiveLog("AddOutlookContact: 110.11 - " + vbCrLf + ex.Message)
                LOG.WriteToArchiveLog("AddOutlookContact: 110.11 - " + vbCrLf + ex.StackTrace)
            End Try
        Catch ex As Exception
            LOG.WriteToArchiveLog("AddOutlookContact: 110.12 - " + vbCrLf + ex.Message)
            LOG.WriteToArchiveLog("AddOutlookContact: 110.12 - " + vbCrLf + ex.StackTrace)
        End Try

        If Not olFolder Is Nothing Then
            olFolder = Nothing
        End If

        If Not olContact Is Nothing Then
            olContact = Nothing
        End If
        GC.Collect()

    End Sub

    Sub AddOutlookEmail(ByVal DG As DataGridView, ByVal SkipIfExists As Boolean, ByVal OverwriteContact As Boolean, ByVal AddIfMissing As Boolean)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        'Dim DR As DataGridViewRow

        Dim olEmailItem As Outlook.MailItem = Nothing
        Dim olFolder As Outlook.MAPIFolder = Nothing

#If Office2007 Then
        Dim olEmail As Outlook.Folder = Nothing
#Else
        Dim olEmail As Outlook.Folders = Nothing
#End If

        If Not InitializeOutlook() Then
            MsgBox("Cannot initialize Outlook",
            vbExclamation,
            "Automation Error")
            Exit Sub
        End If

        For Each SelectedRow As DataGridViewRow In DG.SelectedRows

            Dim SenderEmailAddress As String = SelectedRow.Cells("SenderEmailAddress").Value.ToString
            Dim SUBJECT As String = SelectedRow.Cells("SUBJECT").Value.ToString
            Dim Body As String = SelectedRow.Cells("Body").Value.ToString
            Dim ReceivedByName As String = SelectedRow.Cells("ReceivedByName").Value.ToString
            Dim ReceivedTime As String = SelectedRow.Cells("ReceivedTime").Value.ToString
            Dim SentTO As String = SelectedRow.Cells("SentTO").Value.ToString
            Dim SenderName As String = SelectedRow.Cells("SenderName").Value.ToString
            Dim Bcc As String = SelectedRow.Cells("Bcc").Value.ToString
            Dim BillingInformation As String = SelectedRow.Cells("BillingInformation").Value.ToString
            Dim CC As String = SelectedRow.Cells("CC").Value.ToString
            Dim Companies As String = SelectedRow.Cells("Companies").Value.ToString
            Dim CreationTime As String = SelectedRow.Cells("CreationTime").Value.ToString
            Dim ReadReceiptRequested As String = SelectedRow.Cells("ReadReceiptRequested").Value.ToString
            Dim AllRecipients As String = SelectedRow.Cells("AllRecipients").Value.ToString
            Dim Sensitivity As String = SelectedRow.Cells("Sensitivity").Value.ToString
            Dim SentOn As String = SelectedRow.Cells("SentOn").Value.ToString
            Dim MsgSize As String = SelectedRow.Cells("MsgSize").Value.ToString
            Dim DeferredDeliveryTime As String = SelectedRow.Cells("DeferredDeliveryTime").Value.ToString
            Dim keyEmailIdentifier As String = SelectedRow.Cells("EntryID").Value.ToString
            Dim ExpiryTime As String = SelectedRow.Cells("ExpiryTime").Value.ToString
            Dim LastModificationTime As String = SelectedRow.Cells("LastModificationTime").Value.ToString
            Dim EmailImage As String = SelectedRow.Cells("EmailImage").Value.ToString
            Dim Accounts As String = SelectedRow.Cells("Accounts").Value.ToString
            Dim RowID As String = SelectedRow.Cells("RowID").Value.ToString
            Dim ShortSubj As String = SelectedRow.Cells("ShortSubj").Value.ToString
            Dim SourceTypeCode As String = SelectedRow.Cells("SourceTypeCode").Value.ToString
            Dim UserID As String = SelectedRow.Cells("UserID").Value.ToString
            Dim EmailGuid As String = SelectedRow.Cells("EmailGuid").Value.ToString

            On Error GoTo Err_Handler
            Dim DQ As String = Chr(34)

            Dim S As String = "[SenderEmailAddress] = " + DQ + SenderEmailAddress + DQ
            S = S + "and [ReceivedByName] = " + DQ + ReceivedByName + DQ
            S = S + "and [ReceivedTime] = " + DQ + ReceivedTime + DQ
            S = S + "and [ReceivedByName] = " + DQ + ReceivedByName + DQ

            olFolder = g_nspNameSpace.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderInbox)
            olEmail = olFolder.Items.Find(S)

            olEmailItem = olFolder.Items.Find(S)

            If Not olEmailItem Is Nothing Then
                If (OverwriteContact Or AddIfMissing) Then
                    olEmailItem.Delete()
                    LOG.WriteToArchiveLog("clsArchiver : AddOutlookEmail : Delete Performed 11")

                    '*************** DO NOT SAVE THE WHOLE BODY, JUST THE FIRST 100 CHARACTERS *****************
                    Body = Body.Substring(0, 100)
                    '*******************************************************************************************
                    AddEmailDetail(SenderEmailAddress, SUBJECT, Body, ReceivedByName, ReceivedTime, SentTO, SenderName, Bcc, BillingInformation, CC, Companies, CreationTime, ReadReceiptRequested, AllRecipients, Sensitivity, SentOn, MsgSize, DeferredDeliveryTime, ExpiryTime, LastModificationTime, EmailImage, Accounts, ShortSubj)
                Else
                    MessageBox.Show("Contact already exist... skipping.")
                    'olEmailItem.Display()
                End If
            Else
                AddEmailDetail(SenderEmailAddress, SUBJECT, Body, ReceivedByName, ReceivedTime, SentTO, SenderName, Bcc, BillingInformation, CC, Companies, CreationTime, ReadReceiptRequested, AllRecipients, Sensitivity, SentOn, MsgSize, DeferredDeliveryTime, ExpiryTime, LastModificationTime, EmailImage, Accounts, ShortSubj)
            End If

        Next

Exit_Handler:

        ' On Error Resume Next

        If Not olFolder Is Nothing Then
            olFolder = Nothing
        End If

        If Not olEmailItem Is Nothing Then
            olEmailItem = Nothing
        End If

        If Not olEmail Is Nothing Then
            olEmail = Nothing
        End If
        GC.Collect()
        Exit Sub

Err_Handler:
        MsgBox(Err.Description, vbExclamation, "Error No: " & Err.Number)
        Resume Exit_Handler

    End Sub

    Function InitializeOutlook() As Boolean
        On Error GoTo Err_Handler
        If g_olApp Is Nothing Then
            g_olApp = New Outlook.Application
            g_nspNameSpace = g_olApp.GetNamespace("MAPI")
            InitializeOutlook = True
        Else
            InitializeOutlook = True
        End If
Exit_Handler:
        Exit Function
Err_Handler:
        ' No Error message - simply let the function return false
        Resume Exit_Handler
    End Function

    Sub AddContactDetail(ByVal Account As String, ByVal Anniversary As String, ByVal Application As String, ByVal AssistantName As String, ByVal AssistantTelephoneNumber As String, ByVal BillingInformation As String, ByVal Birthday As String, ByVal Business2TelephoneNumber As String, ByVal BusinessAddress As String, ByVal BusinessAddressCity As String, ByVal BusinessAddressCountry As String, ByVal BusinessAddressPostalCode As String, ByVal BusinessAddressPostOfficeBox As String, ByVal BusinessAddressState As String, ByVal BusinessAddressStreet As String, ByVal BusinessCardType As String, ByVal BusinessFaxNumber As String, ByVal BusinessHomePage As String, ByVal BusinessTelephoneNumber As String, ByVal CallbackTelephoneNumber As String, ByVal CarTelephoneNumber As String, ByVal Categories As String, ByVal Children As String, ByVal xClass As String, ByVal Companies As String, ByVal CompanyName As String, ByVal ComputerNetworkName As String, ByVal Conflicts As String, ByVal ConversationTopic As String, ByVal CreationTime As String, ByVal CustomerID As String, ByVal Department As String, ByVal Email1Address As String, ByVal Email1AddressType As String, ByVal Email1DisplayName As String, ByVal Email1EntryID As String, ByVal Email2Address As String, ByVal Email2AddressType As String, ByVal Email2DisplayName As String, ByVal Email2EntryID As String, ByVal Email3Address As String, ByVal Email3AddressType As String, ByVal Email3DisplayName As String, ByVal Email3EntryID As String, ByVal FileAs As String, ByVal FirstName As String, ByVal FTPSite As String, ByVal FullName As String, ByVal Gender As String, ByVal GovernmentIDNumber As String, ByVal Hobby As String, ByVal Home2TelephoneNumber As String, ByVal HomeAddress As String, ByVal HomeAddressCountry As String, ByVal HomeAddressPostalCode As String, ByVal HomeAddressPostOfficeBox As String, ByVal HomeAddressState As String, ByVal HomeAddressStreet As String, ByVal HomeFaxNumber As String, ByVal HomeTelephoneNumber As String, ByVal IMAddress As String, ByVal Importance As String, ByVal Initials As String, ByVal InternetFreeBusyAddress As String, ByVal JobTitle As String, ByVal Journal As String, ByVal Language As String, ByVal LastModificationTime As String, ByVal LastName As String, ByVal LastNameAndFirstName As String, ByVal MailingAddress As String, ByVal MailingAddressCity As String, ByVal MailingAddressCountry As String, ByVal MailingAddressPostalCode As String, ByVal MailingAddressPostOfficeBox As String, ByVal MailingAddressState As String, ByVal MailingAddressStreet As String, ByVal ManagerName As String, ByVal MiddleName As String, ByVal Mileage As String, ByVal MobileTelephoneNumber As String, ByVal NetMeetingAlias As String, ByVal NetMeetingServer As String, ByVal NickName As String, ByVal Title As String, ByVal Body As String, ByVal OfficeLocation As String, ByVal Subject As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim myOutlook As Outlook.Application
        Dim myItem As Outlook.ContactItem

        myOutlook = CreateObject("Outlook.Application")
        myItem = myOutlook.CreateItem(Outlook.OlItemType.olContactItem)
        Try
            With myItem
                .Account = Account
                .Anniversary = Anniversary
                '.Application = Application
                .AssistantName = AssistantName
                .AssistantTelephoneNumber = AssistantTelephoneNumber
                .BillingInformation = BillingInformation
                .Birthday = Birthday
                .Business2TelephoneNumber = Business2TelephoneNumber
                .BusinessAddress = BusinessAddress
                .Save()
                .BusinessAddressCity = BusinessAddressCity
                .BusinessAddressCountry = BusinessAddressCountry
                .BusinessAddressPostalCode = BusinessAddressPostalCode
                .BusinessAddressPostOfficeBox = BusinessAddressPostOfficeBox
                .BusinessAddressState = BusinessAddressState
                .Save()
                .BusinessAddressStreet = BusinessAddressStreet
                '.BusinessCardType = BusinessCardType
                .BusinessFaxNumber = BusinessFaxNumber
                .BusinessHomePage = BusinessHomePage
                .BusinessTelephoneNumber = BusinessTelephoneNumber
                .CallbackTelephoneNumber = CallbackTelephoneNumber
                .CarTelephoneNumber = CarTelephoneNumber
                .Categories = Categories
                .Save()
                .Children = Children
                '.xClass = xClass
                .Companies = Companies
                .CompanyName = CompanyName
                .ComputerNetworkName = ComputerNetworkName
                '.Conflicts = Conflicts
                '.ConversationTopic = ConversationTopic
                '.CreationTime = CreationTime
                .CustomerID = CustomerID
                .Save()
                .Department = Department
                .Email1Address = Email1Address
                .Email1AddressType = Email1AddressType
                .Email1DisplayName = Email1DisplayName
                '.Email1EntryID = Email1EntryID
                .Email2Address = Email2Address
                .Email2AddressType = Email2AddressType
                .Email2DisplayName = Email2DisplayName
                '.Email2EntryID = Email2EntryID
                .Save()
                .Email3Address = Email3Address
                .Email3AddressType = Email3AddressType
                .Email3DisplayName = Email3DisplayName
                '.Email3EntryID = Email3EntryID
                .FileAs = FileAs
                .FirstName = FirstName
                .FTPSite = FTPSite
                .FullName = FullName
                .Save()
                .Gender = Gender

                .GovernmentIDNumber = GovernmentIDNumber
                .Hobby = Hobby
                .Home2TelephoneNumber = Home2TelephoneNumber
                .HomeAddress = HomeAddress
                .HomeAddressCountry = HomeAddressCountry
                .HomeAddressPostalCode = HomeAddressPostalCode
                .HomeAddressPostOfficeBox = HomeAddressPostOfficeBox
                .HomeAddressState = HomeAddressState
                .HomeAddressStreet = HomeAddressStreet
                .HomeFaxNumber = HomeFaxNumber
                .Save()
                .HomeTelephoneNumber = HomeTelephoneNumber
                .IMAddress = IMAddress
                .Importance = Importance
                .Initials = Initials
                .InternetFreeBusyAddress = InternetFreeBusyAddress
                .JobTitle = JobTitle
                .Journal = Journal
                .Language = Language
                '.LastModificationTime = LastModificationTime
                .LastName = LastName
                .Save()
                '.LastNameAndFirstName = LastNameAndFirstName
                .MailingAddress = MailingAddress
                .MailingAddressCity = MailingAddressCity
                .MailingAddressCountry = MailingAddressCountry
                .MailingAddressPostalCode = MailingAddressPostalCode
                .MailingAddressPostOfficeBox = MailingAddressPostOfficeBox
                .MailingAddressState = MailingAddressState
                .Save()
                .MailingAddressStreet = MailingAddressStreet
                .ManagerName = ManagerName
                .MiddleName = MiddleName
                .Mileage = Mileage
                .Save()
                .MobileTelephoneNumber = MobileTelephoneNumber
                .Save()
                ''.NetMeetingAlias = NetMeetingAlias
                '.Save()
                '.NetMeetingServer = NetMeetingServer
                '.Save()
                .NickName = NickName
                .Save()
                .Title = Title
                .Body = Body
                .OfficeLocation = OfficeLocation
                .Subject = Subject

                .Save()
            End With
        Catch ex As Exception
            LOG.WriteToArchiveLog("AddContactDetail 1: " + ex.Message)
            LOG.WriteToArchiveLog("AddContactDetail 2: " + ex.StackTrace)
            LOG.WriteToArchiveLog("AddContactDetail 3: " + ex.InnerException.ToString)
            LOG.WriteToArchiveLog("AddContactDetail 4: " + ex.Data.ToString)
        End Try

        If Not myOutlook Is Nothing Then
            myOutlook = Nothing
        End If

        If Not myItem Is Nothing Then
            myItem = Nothing
        End If

    End Sub

    Sub AddEmailDetail(ByVal SenderEmailAddress As String, ByVal SUBJECT As String, ByVal Body As String, ByVal ReceivedByName As String, ByVal ReceivedTime As String, ByVal SentTO As String, ByVal SenderName As String, ByVal Bcc As String, ByVal BillingInformation As String, ByVal CC As String, ByVal Companies As String, ByVal CreationTime As String, ByVal ReadReceiptRequested As String, ByVal AllRecipients As String, ByVal Sensitivity As String, ByVal SentOn As String, ByVal MsgSize As String, ByVal DeferredDeliveryTime As String, ByVal ExpiryTime As String, ByVal LastModificationTime As String, ByVal EmailImage As String, ByVal Accounts As String, ByVal ShortSubj As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim myOutlook As Outlook.Application
        Dim myItem As Outlook.ContactItem

        myOutlook = CreateObject("Outlook.Application")
        myItem = myOutlook.CreateItem(Outlook.OlItemType.olMailItem)

        With myItem
            .SenderEmailAddress = SenderEmailAddress
            .Subject = SUBJECT
            .Body = Body
            .ReceivedByName = ReceivedByName
            .ReceivedTime = ReceivedTime
            .SentTO = SentTO
            .SenderName = SenderName
            .Bcc = Bcc
            .BillingInformation = BillingInformation
            .CC = CC
            .Companies = Companies
            '.CreationTime = CreationTime
            .ReadReceiptRequested = ReadReceiptRequested
            .AllRecipients = AllRecipients
            .Sensitivity = Sensitivity
            .SentOn = SentOn
            .MsgSize = MsgSize
            .DeferredDeliveryTime = DeferredDeliveryTime
            '.EntryID = EntryID
            .ExpiryTime = ExpiryTime
            '.LastModificationTime = LastModificationTime
            .EmailImage = EmailImage
            .Accounts = Accounts
            .ShortSubj = ShortSubj

            .Save()
        End With

        If Not myOutlook Is Nothing Then
            myOutlook = Nothing
        End If

        If Not myItem Is Nothing Then
            myItem = Nothing
        End If
        GC.Collect()
    End Sub

    Public Sub CreateEcmHistoryFolder()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim bAutoCreateRestoreFolder As Boolean = False

        Dim sDebug As String = getUserParm("user_CreateOutlookRestoreFolder")
        'If sDebug.Length = 0 Then
        '    bAutoCreateRestoreFolder = False
        'ElseIf sDebug.Equals("0") Then
        '    bAutoCreateRestoreFolder = False
        'Else
        '    bAutoCreateRestoreFolder = True
        'End If

        'If bAutoCreateRestoreFolder = False Then
        '    Return
        'End If

        Try
            Dim oOutlook As Outlook.Application
            Dim oMAPI As Outlook._NameSpace
            Dim oParentFolder As Outlook.MAPIFolder

            Dim i As Integer
            Dim iElement As Integer = 0

            oOutlook = New Outlook.Application()
            oMAPI = oOutlook.GetNamespace("MAPI")

            Dim A As ArrayList = getOutlookParentFolderNames()

            Dim MailboxName As String = A.Item(A.Count - 1)

            oParentFolder = oMAPI.Folders.Item(MailboxName)

            Dim oApp As New Outlook.Application
            Dim oNS As Outlook.NameSpace = oApp.GetNamespace("mapi")
            Dim B As Boolean = False

            If oParentFolder.Folders.Count <> 0 Then
                For i = 1 To oParentFolder.Folders.Count
                    If Trim(oParentFolder.Folders.Item(i).Name) <> "" Then
                        If oParentFolder.Folders.Item(i).Name.Equals("Restored Emails") Then
                            oHistoryEntryID = oParentFolder.Folders.Item(i).EntryID
                            oHistoryStoreID = oParentFolder.Folders.Item(i).StoreID
                            oEcmHistFolder = oParentFolder.Folders.Item(i)
                            B = True
                            Exit For
                        End If
                    End If
                Next i
            End If
            If Not B Then
                oParentFolder.Folders.Add("Restored Emails")
                For i = 1 To oParentFolder.Folders.Count
                    If Trim(oParentFolder.Folders.Item(i).Name) <> "" Then
                        If oParentFolder.Folders.Item(i).Name.Equals("Restored Emails") Then
                            oHistoryEntryID = oParentFolder.Folders.Item(i).EntryID
                            oHistoryStoreID = oParentFolder.Folders.Item(i).StoreID
                            oEcmHistFolder = oParentFolder.Folders.Item(i)
                            B = True
                            Exit For
                        End If
                    End If
                Next i
            End If
        Catch ex As Exception
            LOG.WriteToArchiveLog("Notice: clsArchiver:CreateRestoreFolder 100.11 - " + ex.Message)
            LOG.WriteToArchiveLog("Notice: clsArchiver:CreateRestoreFolder 100.11 - " + ex.StackTrace)
        End Try

    End Sub

    Private Sub ProcessFolders(ByVal directoryInfo As IO.DirectoryInfo,
                               ByVal recurseFolders As Boolean,
                               ByVal depth As Integer,
                               ByVal maxDepth As Integer,
                               ByRef folderCount As Integer,
                               ByRef fileCount As Integer)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Debug.WriteLine(String.Empty)
        Debug.WriteLine(directoryInfo.FullName)

        folderCount += 1

        ' Recurse to process subfolders if requested.
        If recurseFolders Then
            If depth < maxDepth Then
                depth += 1
                For Each folder As IO.DirectoryInfo In directoryInfo.GetDirectories
                    ProcessFolders(folder, recurseFolders, depth, maxDepth, folderCount, fileCount)
                Next
            End If
        End If

        ' Process file folders
        For Each file As IO.FileInfo In directoryInfo.GetFiles
            fileCount += 1
            With file
                Debug.WriteLine([String].Format("{0} {1}, Size {2}, Create {3}, Access {4}, Update {5}, {6}", .Name, .Extension, .Length, .CreationTime, .LastAccessTime, .LastWriteTime, .DirectoryName))
            End With
        Next
    End Sub 'ProcessFolders

#If Office2007 Then
    Private Function GetFolderByPath(ByVal folderPath As String) As Outlook.Folder
#Else

    Private Function GetFolderByPath(ByVal folderPath As String) As Outlook.Folders
#End If

#If Office2007 Then
        Dim returnFolder As Outlook.Folder = Nothing
#Else
        Dim returnFolder As Outlook.Folders = Nothing
#End If

        Try
            ' Remove leading "\" characters.
            folderPath = folderPath.TrimStart("\".ToCharArray())

            ' Split the folder path into individual folder names.
            Dim folders As String() = folderPath.Split("\".ToCharArray())

            ' Retrieve a reference to the root folder.

            Dim oMAPI As Outlook._NameSpace
            Dim MailboxName As String = folders(0)
#If Office2007 Then
            Dim oParentFolder As Outlook.Folder = oMAPI.Folders.Item(folders(0))
#Else
            Dim oParentFolder As Outlook.Folders = oMAPI.Folders.Item(folders(0))
#End If

            returnFolder = oParentFolder.Folders(0)
            'TryCast(Application.Session.Folders(folders(0)), Outlook.Folder)

            ' If the root folder exists, look in subfolders.
            If returnFolder IsNot Nothing Then
                Dim subFolders As Outlook.Folders = Nothing
                Dim folderName As String

                ' Look through folder names, skipping the first folder, which you already retrieved.
                For i As Integer = 1 To folders.Length - 1
                    folderName = folders(i)
                    subFolders = returnFolder.Folders
#If Office2007 Then
                    returnFolder = TryCast(subFolders(folderName), Outlook.Folder)
#Else
                    returnFolder = TryCast(subFolders(folderName), Outlook.Folders)
#End If
                Next
            End If
        Catch ex As Exception
            'messagebox.show(ex.Message)
            ' Do nothing at all -- just return a null reference.
            returnFolder = Nothing

        End Try
        Return returnFolder
    End Function

    Sub ArchiveEmailFoldersThreaded()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Dim T As New Thread(AddressOf ArchiveEmailFolders)
        T.IsBackground = True
        T.TrySetApartmentState(ApartmentState.STA)
        T.Start()
    End Sub

    Sub ArchiveEmailFolders(ByVal UID As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim isPublic As String = "N"

        Dim bUseQuickSearch As Boolean = False
        Dim ThreadingOn As Boolean = True
        Dim NbrOfIds As Integer = getCountStoreIdByFolder()

        Dim slStoreId As New SortedList

        If NbrOfIds <= 2000000 Then
            bUseQuickSearch = True
        Else
            bUseQuickSearch = False
        End If

        If bUseQuickSearch Then
            'LoadEntryIdByUserID(slStoreId)
            DBLocal.getCE_EmailIdentifiers(slStoreId)
        Else
            slStoreId.Clear()
        End If
        '#If EnableSingleSource Then
        '        Dim tMachineGuid As Guid = GE.AddItem(gMachineID, "GlobalMachine", False)
        '#End If
        If gRunMinimized = True Then
            frmNotify2.WindowState = FormWindowState.Minimized
        Else
            frmNotify2.Show()
        End If

        If gRunMinimized Then
            frmNotify2.WindowState = FormWindowState.Minimized
        End If
        frmNotify2.Location = New Point(25, 200)
        If gRunMode.Equals("M-END") Then
            frmNotify2.WindowState = FormWindowState.Minimized
        End If
        'If ThreadingOn Then 'FrmMDIMain.lblArchiveStatus.Text = "Archive Running"
        Dim L As Double = 1
        Dim iEmails As Integer = 0
        Try
            L = 1

            gEmailsBackedUp = 0
            'Dim FolderList As New SortedList(Of String, String)
            Dim DGV As New DataGridView
            L = 3
            '"Select FileDirectory, FolderName, FolderID, storeid, from EmailFolder
            Try
                L = 3
                getArchiveFolderIds(DGV)
                L = 4
            Catch ex As Exception
                L = 5
                LOG.WriteToArchiveLog("ERROR 101.331a ArchiveEmailFolders " + ex.Message)
                MessageBox.Show("Failed at ERROR 101.331a ArchiveEmailFolders " + ex.Message)
            End Try
            L = 6
            Dim FID As String = ""
            Dim SID As String = ""
            Dim FileDirectory As String = ""
            L = 7

            Dim FolderName As String = ""
            Dim ArchiveEmails As String = ""
            Dim RemoveAfterArchive As String = ""
            Dim SetAsDefaultFolder As String = ""
            Dim ArchiveAfterXDays As String = ""
            Dim RemoveAfterXDays As String = ""
            Dim RemoveXDays As String = ""
            Dim ArchiveXDays As String = ""
            Dim DB_ID As String = ""
            Dim DeleteFile As Boolean = False
            Dim ArchiveOnlyIfRead As String = ""
            L = 8

            Dim BX As Boolean = UTIL.isOutLookRunning
            If BX = True Then
                frmOutlookNotice.Show()
            End If

            Dim oOutlook As Outlook.Application
            oOutlook = New Outlook.Application()
            L = 9

            frmOutlookNotice.Close()
            frmOutlookNotice.Hide()

            Dim oMAPI As Outlook._NameSpace = Nothing
            Try
                oMAPI = oOutlook.GetNamespace("MAPI")
            Catch ex As Exception
                MessageBox.Show(ex.Message)
            End Try
            L = 10
            Dim TopFolder As String = ""
            Dim FolderFQN As String = ""
            Dim SubFolderName As String = ""
            L = 11
            Dim iProcessed As Integer = 0
            L = 12
            LOG.WriteToArchiveLog("Archive of " + DGV.Rows.Count.ToString + " folders by " + gCurrLoginID)
            For IX As Integer = 0 To DGV.Rows.Count - 1
                iEmails += 1
                Application.DoEvents()
                Try
                    SID = DGV.Rows(IX).Cells("storeid").Value.ToString
                Catch ex As Exception
                    LOG.WriteToArchiveLog("Info: DVG @1 IX = " + IX.ToString + " : " + ex.Message)
                    GoTo SKIPTHISONE
                End Try
                L = 14.1
                Try
                    FID = DGV.Rows(IX).Cells("FolderID").Value.ToString
                Catch ex As Exception
                    'log.WriteToArchiveLog("Info: DVG @2 Line = " + L.ToString)
                    LOG.WriteToArchiveLog("Informational: DVG @2 IX = " + IX.ToString + " : " + ex.Message)
                    GoTo SKIPTHISONE
                End Try

                L = 15.2
                Try
                    FileDirectory = DGV.Rows(IX).Cells("FileDirectory").Value.ToString
                Catch ex As Exception
                    'log.WriteToArchiveLog("Info: DVG @3 Line = " + L.ToString)
                    LOG.WriteToArchiveLog("Info: DVG @3 IX = " + IX.ToString + " : " + ex.Message)
                    GoTo SKIPTHISONE
                End Try
                L = 16.3
                Try
                    FolderName = DGV.Rows(IX).Cells("FolderName").Value.ToString
                Catch ex As Exception
                    'log.WriteToArchiveLog("Info: DVG4 @ Line = " + L.ToString)
                    LOG.WriteToArchiveLog("Info: DVG4 @ IX = " + IX.ToString + " : " + ex.Message)
                    GoTo SKIPTHISONE
                End Try
                'messagebox.show(FolderName )
                L = 17.4
                If gTerminateImmediately Then
                    'If ThreadingOn Then 'FrmMDIMain.lblArchiveStatus.Text = "Archive Quiet"
                    frmNotify2.Close()
                    gOutlookArchiving = False
                    My.Settings("LastArchiveEndTime") = Now
                    My.Settings.Save()
                    frmNotify2.Close()
                    Return
                End If
                L = 18.5
                iProcessed += 1
                gEmailsBackedUp = gEmailsBackedUp + iProcessed
                'FID = FolderID
                'SID = StoreID
                L = 18.9
                'TopFolder  = getParentFolderNameById(FID)
                TopFolder = getParentFolderNameById(FID)

                'log.WriteToArchiveLog("*** FOLDER NOTICE TopFolder  001x - : " + TopFolder )

                FolderFQN = getFolderNameById(FID)

                'log.WriteToArchiveLog("*** FOLDER NOTICE 001a - : " + FolderFQN )

                Dim FolderParms() As String = FolderFQN.Split("|")

                TopFolder = FolderParms(0)
                SubFolderName = FolderParms(1)
                frmNotify2.lblFolder.Text = SubFolderName
                frmNotify2.Refresh()

                L = 16
                Dim myOlApp As Outlook.Application
                Dim myFolder As Outlook.MAPIFolder
                Dim myEntryID As String
                Dim myStoreID As String
                myOlApp = CreateObject("Outlook.Application")

                myEntryID = FID
                myStoreID = SID

                Try
                    myFolder = myOlApp.Session.GetFolderFromID(myEntryID, myStoreID)
                Catch ex As Exception
                    LOG.WriteToArchiveLog("FATAL ERROR: ArchiveEmailFolders 900A - COULD NOT OPEN EMAIL FOLDER: " + ex.Message)
                    LOG.WriteToArchiveLog("FATAL ERROR: ArchiveEmailFolders 900B - COULD NOT OPEN EMAIL FOLDER: " + TopFolder + " : " + SubFolderName)
                    GoTo SKIPTHISONE
                End Try

                Dim iFolders As Integer = myFolder.Folders.Count
                Dim oFolder As Outlook.MAPIFolder = Nothing
                'L = 17

                Try
                    L = 18
                    Dim FolderID As String = FID
                    oFolder = oMAPI.GetFolderFromID(FolderID, SID)
                    L = 19

                    Dim tEmailFolderName As String = "EMAIL: " + oFolder.Name
                    Dim FolderBeingProcessed As String = oFolder.Name
                    '#If EnableSingleSource Then
                    '                    Dim tNewGuid As Guid = GE.AddItem(tEmailFolderName, "GlobalDirectory", False)
                    '#End If
                    Console.WriteLine(tEmailFolderName)
                    If Trim(oFolder.Name) <> "" Then
                        'If xDebug Then log.WriteToArchiveLog("Code 100 Processing email folder: " + oFolder.Name)
                        Dim ParentID As String = oFolder.EntryID
                        Dim ChildID As String = oFolder.EntryID
                        Dim tFolderName As String = oFolder.Name
                        Dim CurrentFolder = oFolder
                        Dim StoreID As String = oFolder.StoreID
                        L = 20
                        If InStr(tFolderName, "_2", CompareMethod.Text) > 0 Then
                            Console.WriteLine("Here")
                        End If
                        If InStr(tFolderName, "_system", CompareMethod.Text) > 0 Then
                            Console.WriteLine("Here")
                        End If

                        Dim EmailFolderFQN As String = FolderFQN

                        Dim RetentionCode As String = ""
                        Dim RetentionYears As Integer = 10

                        RetentionCode = getArchEmailFolderRetentionCode(ChildID, gCurrUserGuidID)
                        If RetentionCode.Length > 0 Then
                            RetentionYears = getRetentionPeriod(RetentionCode)
                        End If
                        L = 21
                        EMF.setFolderid(ChildID)
                        EMF.setFoldername(tFolderName)
                        EMF.setParentfolderid(ParentID)
                        Try
                            EMF.setParentfoldername(FolderFQN)
                        Catch ex As Exception
                            LOG.WriteToArchiveLog("WARNING Failed to set parent folder: " + FolderFQN)
                        End Try
                        L = 22
                        EMF.setUserid(gCurrUserGuidID)

                        'messagebox.show("TopFolder " + TopFolder  + " : " + "SubFolderName " + " : " + SubFolderName )
                        Dim BB As Boolean = GetEmailFolderParms(TopFolder, gCurrUserGuidID, SubFolderName, ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, DB_ID, ArchiveOnlyIfRead)

                        'If xDebug Then log.WriteToArchiveLog("Code 200 Processing email folder: " + SubFolderName )

                        If BB Then
                            L = 23
                            'If xDebug Then log.WriteToArchiveLog("Code 200a: " + SubFolderName )
                            'Dim bUseQuickSearch As Boolean = False
                            'Dim NbrOfIds As Integer = getCountStoreIdByFolder(EmailFolderFQN)
                            'If NbrOfIds < 1000000 Then
                            '   bUseQuickSearch = True
                            'End If

                            'Dim slEntryId As New SortedList
                            'If bUseQuickSearch Then
                            '    '** 001
                            '    LoadEntryIdByFolder(EmailFolderFQN, slEntryId)
                            'Else
                            '    slEntryId.Clear()
                            'End If
                            L = 24
                            Try
                                DBLocal.setOutlookMissing()
                                '*************************************************************************************
                                ArchiveEmailsInFolder(UID, TopFolder,
                                      ArchiveEmails,
                                      RemoveAfterArchive,
                                      SetAsDefaultFolder,
                                      ArchiveAfterXDays,
                                      RemoveAfterXDays,
                                      RemoveXDays,
                                      ArchiveXDays,
                                      DB_ID,
                                      CurrentFolder,
                                      StoreID,
                                      ArchiveOnlyIfRead, RetentionYears, RetentionCode, EmailFolderFQN, slStoreId, isPublic)
                                '*************************************************************************************
                                If gTerminateImmediately Then
                                    'If ThreadingOn Then FrmMDIMain.lblArchiveStatus.Text = "Archive Quiet"
                                    frmNotify2.Close()
                                    gOutlookArchiving = False
                                    My.Settings("LastArchiveEndTime") = Now
                                    My.Settings.Save()
                                    frmNotify2.Close()
                                    Return
                                End If
                                L = 25
                            Catch ex As Exception
                                LOG.WriteToArchiveLog("ERROR 33.242.345 - " + ex.Message)
                                LOG.WriteToArchiveLog("ERROR 33.242.345 - " + ex.StackTrace)
                            End Try
                            L = 26
                        Else
                            LOG.WriteToArchiveLog("ERROR 33.242.3 - Did not find '" + TopFolder + "' / " + "'" + SubFolderName + ".")
                        End If
                        L = 27
                    End If
                    L = 28
                Catch ex As Exception
                    Dim Msg As String = "ERROR:ArchiveEmailFolders 100.876.5:  Check to see the folders are defined properly. (Deactivate and reactivate). "
                    Msg = Msg + "   Check to see the folders are defined properly. (Deactivate and reactivate)." + vbCrLf
                    Msg = Msg + "   There is a problem with TopFolder:'" + TopFolder + "'." + vbCrLf
                    Msg = Msg + "        SubFolderName:'" + SubFolderName + "'." + vbCrLf
                    Msg = Msg + "   Message: " + ex.Message
                    'frmHelp.MsgToDisplay  = Msg
                    'frmHelp.CallingScreenName  = "Archive Email Folders"
                    'frmHelp.CaptionName  = "EMAIL Archive Error"
                    'frmHelp.Timer1.Interval = 10000
                    'frmHelp.Show()
                    LOG.WriteToArchiveLog(Msg)
                End Try
                L = 29
SKIPTHISONE:
            Next
            L = 20
            DGV = Nothing
            GC.Collect()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: 100 ArchiveEmailFolders - " + ex.Message)
            LOG.WriteToArchiveLog("ERROR: 100 ArchiveEmailFolders - " + ex.StackTrace)
            LOG.WriteToArchiveLog("ERROR: 100 ArchiveEmailFolders - Line #" + L.ToString)
        Finally
            'If ThreadingOn Then FrmMDIMain.lblArchiveStatus.Text = "Archive Quiet"
        End Try

        'If ThreadingOn Then FrmMDIMain.lblArchiveStatus.Text = "Archive Quiet"
        UpdateAttachmentCounts()
        frmNotify2.Close()
        gOutlookArchiving = False

        My.Settings("LastArchiveEndTime") = Now
        My.Settings.Save()

    End Sub

    Public Sub ArchiveSelectedOutlookFolders(ByVal UID As String, ByVal TopFolder As String, ByVal slStoreId As SortedList)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Try
            EmailsBackedUp = 0
            FilesBackedUp = 0
            '********************************************************
            'PARAMETER: MailboxName = Name of Parent Outlook Folder for
            'the current user: Usually in the form of
            '"Mailbox - Doe, John" or
            '"Public Folders
            'RETURNS: Array of SubFolders in Current User's Mailbox
            'Or unitialized array if error occurs
            'Because it returns an array, it is for VB6 only.
            'Change to return a variant or a delimited list for
            'previous versions of vb
            'EXAMPLE:
            'Dim sArray() As String
            'Dim ictr As Integer
            'sArray = OutlookFolderNames("Mailbox - Doe, John")
            '            'On Error Resume Next
            'For ictr = 0 To UBound(sArray)
            ' if xDebug then log.WriteToArchiveLog sArray(ictr)
            'Next
            '*********************************************************
            Dim oOutlook As Outlook.Application
            Dim oMAPI As Outlook._NameSpace = Nothing
            Dim oParentFolder As Outlook.MAPIFolder = Nothing
            Dim oChildFolder As Outlook.MAPIFolder = Nothing
            'Dim sArray() As String
            Dim i As Integer
            Dim iElement As Integer = 0

            oOutlook = New Outlook.Application()
            Try
                oMAPI = oOutlook.GetNamespace("MAPI")
            Catch ex As Exception
                MessageBox.Show(ex.Message)
            End Try

            Dim MailboxName As String = TopFolder
            Try
                oParentFolder = oMAPI.GetFolderFromID(MailboxName)
            Catch ex As Exception
                'messagebox.show("ERROR 3421.45.a: could not open '" + MailboxName  + "' " + vbCrLf + ex.Message)
                LOG.WriteToArchiveLog("ERROR 3421.45.a: could not open '" + MailboxName + "' " + vbCrLf + ex.Message)
                LOG.WriteToArchiveLog("ERROR 3421.45.a:" + vbCrLf + ex.StackTrace)
                frmNotify2.Close()
                Return
            End Try

            'AddChildFolders(LB, MailboxName )

            Dim FolderName As String = ""
            Dim ArchiveEmails As String = ""
            Dim RemoveAfterArchive As String = ""
            Dim SetAsDefaultFolder As String = ""
            Dim ArchiveAfterXDays As String = ""
            Dim RemoveAfterXDays As String = ""
            Dim RemoveXDays As String = ""
            Dim ArchiveXDays As String = ""
            Dim DB_ID As String = ""
            Dim DeleteFile As Boolean = False
            Dim ARCH As New clsArchiver
            Dim ArchiveOnlyIfRead As String = ""

            '************************************
            Dim isPublic As String = "N"

            If oParentFolder.Folders.Count <> 0 Then
                If xDebug Then LOG.WriteToArchiveLog("** : " + TopFolder + " folder count = " + oParentFolder.Folders.Count.ToString + ".")
                For i = 1 To oParentFolder.Folders.Count
                    If i > oParentFolder.Folders.Count Then
                        Exit For
                    End If
                    If Trim(oParentFolder.Folders.Item(i).Name) <> "" Then
                        If xDebug Then LOG.WriteToArchiveLog("100 Processing email folder: " + oParentFolder.Folders.Item(i).Name)
                        Dim ParentID As String = oParentFolder.EntryID
                        Dim ChildID As String = oParentFolder.Folders.Item(i).EntryID
                        Dim tFolderName As String = oParentFolder.Folders.Item(i).Name
                        Dim CurrentFolder = oParentFolder.Folders(i)
                        Dim StoreID As String = oParentFolder.StoreID

                        If InStr(tFolderName, "_2", CompareMethod.Text) > 0 Then
                            Console.WriteLine("Here")
                        End If
                        If InStr(tFolderName, "_system", CompareMethod.Text) > 0 Then
                            Console.WriteLine("Here")
                        End If

                        Dim EmailFolderFQN As String = TopFolder + "|" + tFolderName

                        Dim BB As Integer = ckArchEmailFolder(EmailFolderFQN, gCurrUserGuidID)
                        If xDebug Then LOG.WriteToArchiveLog("** EmailFolderFQN : " + EmailFolderFQN + ".")

                        If BB > 0 Then
                            Dim RetentionCode As String = ""
                            Dim RetentionYears As Integer = 10

                            RetentionCode = getArchEmailFolderRetentionCode(ChildID, gCurrUserGuidID)
                            If RetentionCode.Length > 0 Then
                                RetentionYears = getRetentionPeriod(RetentionCode)
                            End If

                            EMF.setFolderid(ChildID)
                            EMF.setFoldername(tFolderName)
                            EMF.setParentfolderid(ParentID)
                            EMF.setParentfoldername(oParentFolder.Name)
                            EMF.setUserid(gCurrUserGuidID)
                            BB = GetEmailFolderParms(TopFolder, gCurrUserGuidID, tFolderName, ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, DB_ID, ArchiveOnlyIfRead)

                            If BB Then

                                'Dim bUseQuickSearch As Boolean = False
                                'Dim NbrOfIds As Integer = getCountStoreIdByFolder(EmailFolderFQN)
                                'If NbrOfIds < 1000000 Then
                                '    bUseQuickSearch = True
                                'End If

                                'Dim slEntryId As New SortedList
                                'If bUseQuickSearch Then
                                '    '** 003
                                '    LoadEntryIdByFolder(EmailFolderFQN, slEntryId, NbrOfIds)
                                'Else
                                '    slEntryId.Clear()
                                'End If

                                '*************************************************************************************
                                DBLocal.setOutlookMissing()

                                ARCH.ArchiveEmailsInFolder(UID, TopFolder, ArchiveEmails,
                                      RemoveAfterArchive,
                                      SetAsDefaultFolder,
                                      ArchiveAfterXDays,
                                      RemoveAfterXDays,
                                      RemoveXDays,
                                      ArchiveXDays,
                                      DB_ID,
                                      CurrentFolder,
                                      StoreID,
                                      ArchiveOnlyIfRead, RetentionYears, RetentionCode, EmailFolderFQN, slStoreId, isPublic)
                                '*************************************************************************************
                            End If
                        End If
                    End If
GetNextParentFolder:
                Next i
            End If

            For Each oChildFolder In oParentFolder.Folders
                Dim K As Integer = 0
                K = oChildFolder.Folders.Count
                Dim pFolder As String = oParentFolder.Name.ToString
                Dim cFolder As String = oChildFolder.Name.ToString
                Dim EmailFolderFQN As String = TopFolder + "|" + cFolder
                Console.WriteLine(pFolder + " / " + cFolder + " : " + K.ToString)
                If xDebug Then LOG.WriteToArchiveLog("Examine Child Folder: " + pFolder + " / " + cFolder + " : " + K.ToString)
                If InStr(cFolder, "_2", CompareMethod.Text) > 0 Then
                    Console.WriteLine("Here")
                End If
                If InStr(cFolder, "_system", CompareMethod.Text) > 0 Then
                    Console.WriteLine("Here")
                End If
                Dim II As Integer = ckArchEmailFolder(EmailFolderFQN, gCurrUserGuidID)
                If II > 0 Then
                    If K > 0 Then
                        ListChildFolders(UID, EmailFolderFQN, TopFolder, cFolder, oChildFolder, cFolder, slStoreId, isPublic)
                    End If
                End If
            Next
            oMAPI = Nothing
            GC.Collect()
        Catch ex As Exception
            LOG.WriteToArchiveLog("Error processing '" + TopFolder + "' 653.21b: " + ex.Message)
            LOG.WriteToArchiveLog("Error processing 653.21b: " + vbCrLf + ex.StackTrace)
            'messagebox.show("Error processing '" + TopFolder  + "' 653.21b: " + ex.Message)
        End Try

    End Sub

    Public Function getCurrentOutlookFolders(ByVal TopFolder As String, ByRef ChildFoldersList As SortedList(Of String, String)) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        If ddebug Then LOG.WriteToArchiveLog("getCurrentOutlookFolders : Step 1")

        If TopFolder.Trim.Length = 0 Then
            frmNotify2.Close()
            Return True
        End If

        If ddebug Then LOG.WriteToArchiveLog("getCurrentOutlookFolders : Step 2")

        Dim B As Boolean = False

        Try
            '********************************************************
            'PARAMETER: MailboxName = Name of Parent Outlook Folder for
            'the current user: Usually in the form of
            '"Mailbox - Doe, John" or
            '"Public Folders
            'RETURNS: Array of SubFolders in Current User's Mailbox
            'Or unitialized array if error occurs
            'Because it returns an array, it is for VB6 only.
            'Change to return a variant or a delimited list for
            'previous versions of vb
            'EXAMPLE:
            'Dim sArray() As String
            'Dim ictr As Integer
            'sArray = OutlookFolderNames("Mailbox - Doe, John")
            '            'On Error Resume Next
            'For ictr = 0 To UBound(sArray)
            ' if xDebug then log.WriteToArchiveLog sArray(ictr)
            'Next
            '*********************************************************

            If ddebug Then LOG.WriteToArchiveLog("getCurrentOutlookFolders : Step 3")

            Dim oOutlook As Outlook.Application
            If ddebug Then LOG.WriteToArchiveLog("getCurrentOutlookFolders : Step 4")
            Dim oMAPI As Outlook.NameSpace = Nothing
            If ddebug Then LOG.WriteToArchiveLog("getCurrentOutlookFolders : Step 5")
            Dim oParentFolder As Outlook.MAPIFolder = Nothing
            Dim oChildFolder As Outlook.MAPIFolder = Nothing
            'Dim sArray() As String
            Dim i As Integer
            Dim iElement As Integer = 0

            If ddebug Then LOG.WriteToArchiveLog("getCurrentOutlookFolders : Step 6")
            oOutlook = New Outlook.Application
            If ddebug Then LOG.WriteToArchiveLog("getCurrentOutlookFolders : Step 7")
            Try
                oMAPI = oOutlook.GetNamespace("MAPI")
            Catch ex As Exception
                LOG.WriteToArchiveLog("ERROR: getCurrentOutlookFolders 100  : " + ex.Message)
                LOG.WriteToArchiveLog("ERROR: getCurrentOutlookFolders 100a : " + ex.StackTrace)
                oParentFolder = Nothing
                oMAPI = Nothing
                oOutlook = Nothing
                Return False
            End Try

            Dim MailboxName As String = TopFolder
            Dim iFolderCnt As Integer = oMAPI.Folders.Count
            If (iFolderCnt > 0) Then
                MailboxName = oMAPI.Folders(1).Name.ToString
            End If

            Try
                oParentFolder = oMAPI.Folders.Item(MailboxName)
            Catch ex As Exception
                LOG.WriteToArchiveLog("NOTICE: getCurrentOutlookFolders 200  : " + ex.Message)
                LOG.WriteToArchiveLog("NOTICE: getCurrentOutlookFolders 200a : " + ex.StackTrace)
                oParentFolder = Nothing
                oMAPI = Nothing
                oOutlook = Nothing
                Return False
            End Try

            'AddChildFolders(LB, MailboxName )
            Dim UID As String = ""
            Dim FolderName As String = ""
            Dim ArchiveEmails As String = ""
            Dim RemoveAfterArchive As String = ""
            Dim SetAsDefaultFolder As String = ""
            Dim ArchiveAfterXDays As String = ""
            Dim RemoveAfterXDays As String = ""
            Dim RemoveXDays As String = ""
            Dim ArchiveXDays As String = ""
            Dim DB_ID As String = ""
            Dim DeleteFile As Boolean = False
            Dim ARCH As New clsArchiver
            Dim ArchiveOnlyIfRead As String = ""

            If ddebug Then LOG.WriteToArchiveLog("getCurrentOutlookFolders : Step 8")

            ChildFoldersList.Clear()

            If oParentFolder.Folders.Count > 0 Then
                For i = 1 To oParentFolder.Folders.Count
                    If Trim(oParentFolder.Folders.Item(i).Name) <> "" Then
                        Dim ParentID As String = oParentFolder.EntryID
                        Dim ChildID As String = oParentFolder.Folders.Item(i).EntryID
                        Dim tFolderName As String = oParentFolder.Folders.Item(i).Name
                        Dim CurrentFolder = oParentFolder.Folders(i)
                        Dim StoreID As String = oParentFolder.StoreID

                        If ChildFoldersList.IndexOfKey(tFolderName) > 0 Then
                        ElseIf ChildFoldersList.ContainsKey(tFolderName) Then
                        Else
                            Try
                                ChildFoldersList.Add(tFolderName, ChildID)
                            Catch ex As Exception
                                LOG.WriteToArchiveLog("Warning No Load: getCurrentOutlookFolders - Name: " + tFolderName)
                                LOG.WriteToArchiveLog("Warning No Load: getCurrentOutlookFolders - ChildFoldersList.Add: " + ex.Message)
                            End Try
                        End If

                    End If
                Next i
            End If

            For Each oChildFolder In oParentFolder.Folders
                Dim K As Integer = 0
                K = oChildFolder.Folders.Count
                Dim cFolder As String = oChildFolder.Name.ToString
                'Console.WriteLine("Child Folder: " + cFolder)
                If K > 0 Then
                    ListChildFolders(oChildFolder, cFolder)
                End If
            Next
            If ddebug Then LOG.WriteToArchiveLog("getCurrentOutlookFolders : Step 9")
            oMAPI = Nothing
            GC.Collect()
            B = True
        Catch ex As Exception
            If ddebug Then LOG.WriteToArchiveLog("getCurrentOutlookFolders : Step 10")
            Dim bOfficeInstalled As Boolean = UTIL.isOfficeInstalled
            If bOfficeInstalled = False Then
                LOG.WriteToArchiveLog("Error 653.20c: clsArchiver : getCurrentOutlookFolders - OFFICE appears not to be installed.")
                Try
                    ChildFoldersList.Add("* MS Office not found", "* MS Office not found")
                Catch ex2 As Exception

                End Try

            End If
            Try
                ChildFoldersList.Add("* Folders not found", "* Folders not found")
            Catch ex3 As Exception

            End Try
            LOG.WriteToArchiveLog("Error 653.21c: clsArchiver : getCurrentOutlookFolders - Outlook appears to be unavailable, " + ex.Message)
            B = False
        End Try
        If ddebug Then LOG.WriteToArchiveLog("getCurrentOutlookFolders : Step 11")
        Return B
    End Function

    Private Sub DeleteMessage(ByVal sStoreID As String, ByVal sMessageID As String)
        ' Create Outlook application.
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Dim oApp As Outlook.Application
        oApp = New Outlook.Application
        ' Get Mapi NameSpace.
        Dim oNS As Outlook.NameSpace
        oNS = oApp.GetNamespace("mapi")
        oNS.Logon("Outlook", , False, True)
        'Dim oMsg As MailItem
        Dim oMsg As Outlook.MailItem

        oMsg = oNS.GetItemFromID(sMessageID, sStoreID)
        oMsg.Delete()

        LOG.WriteToArchiveLog("clsArchiver : DeleteMessage : Delete Performed 12")

        ' Log off.
        oNS.Logoff()

        ' Clean up.
        oApp = Nothing
        oNS = Nothing
        'oItems = Nothing
        oMsg = Nothing
    End Sub

    Sub DeleteOutlookMessages(ByVal UserID As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Try
            If UserID.Length = 0 Then
                If gCurrLoginID.Length > 0 Then
                    gCurrUserGuidID = Me.getUserGuidID(gCurrLoginID)
                    If gCurrUserGuidID.Length = 0 Then
                        LOG.WriteToArchiveLog("ERROR: DeleteOutlookMessages - UserID missing and CUrrent User Login ID could not be used to find it.")
                        Return
                    End If
                Else
                    Return
                End If
            End If
            Dim S As String = "Select [EmailGuid],[StoreID],[UserID], [MessageID] FROM [EmailToDelete] where userid = '" + UserID + "'"

            Dim b As Boolean = True
            Dim i As Integer = 0
            Dim id As Integer = -1
            Dim II As Integer = 0
            Dim table_name As String = ""
            Dim column_name As String = ""
            Dim data_type As String = ""
            Dim character_maximum_length As String = ""

            ' Create Outlook application.
            Dim oApp As Outlook.Application
            oApp = New Outlook.Application
            ' Get Mapi NameSpace.
            Dim oNS As Outlook.NameSpace
            oNS = oApp.GetNamespace("mapi")
            oNS.Logon("Outlook", , False, True)
            'Dim oMsg As MailItem
            Dim oMsg As Outlook.MailItem

            Dim oDeletedItems As Outlook.MAPIFolder = oNS.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderDeletedItems)

            Dim rsdata As SqlDataReader = Nothing
            Dim CS As String = setConnStr()   ' getGateWayConnStr(gGateWayID)
            Dim CONN As New SqlConnection(CS)
            CONN.Open()
            Dim command As New SqlCommand(S, CONN)
            rsdata = command.ExecuteReader()

            If rsdata.HasRows Then
                Do While rsdata.Read()
                    Application.DoEvents()
                    Dim MessageID As String = rsdata.GetValue(3).ToString.Trim
                    Dim StoreID As String = rsdata.GetValue(1).ToString.Trim
                    Try
                        oMsg = oNS.GetItemFromID(MessageID, StoreID)
                        If Not oMsg Is Nothing Then
                            II += 1
                            'frmReconMain.SB.Text = "Processing Expired Email from Outlook# " & II
                            'frmReconMain.SB.Refresh()
                            Application.DoEvents()
                            'oMsg.Delete()
                            oMsg.Move(oDeletedItems)
                            If xDebug Then LOG.WriteToArchiveLog("EXPIRATION: clsArchiver:DeleteOutlookMessages : Delete Performed 15 - Message# " + II.ToString)
                            Application.DoEvents()
                        End If
                    Catch ex As Exception
                        If InStr(ex.Message, "cannot be found", CompareMethod.Text) > 0 Then
                        Else
                            LOG.WriteToArchiveLog("ERROR 054.31: Failed to delete msg " + ex.Message.ToString)
                        End If
                    End Try
                Loop
            Else
                id = -1
            End If

            If Not rsdata.IsClosed Then
                rsdata.Close()
            End If
            rsdata = Nothing
            command.Dispose()
            command = Nothing

            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()

            oApp = Nothing
            oNS = Nothing
            oMsg = Nothing

            ZeroizeEmailToDelete(UserID)
            'frmReconMain.SB.Text = "Done..."
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: DeleteOutlookMessages - " + ex.Message)
        End Try

    End Sub

    Sub UpdateMessageStoreID(ByVal UserID As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Dim A(0) As String
        Dim S As String = "Select [EmailGuid],[StoreID],[UserID], [MessageID] FROM  [EmailToDelete] where userid = '" + UserID + "'"

        Dim b As Boolean = True
        Dim i As Integer = 0
        Dim id As Integer = -1
        Dim II As Integer = 0
        Dim table_name As String = ""
        Dim column_name As String = ""
        Dim data_type As String = ""
        Dim character_maximum_length As String = ""

        Dim RSData As SqlDataReader = Nothing
        Dim CS As String = setConnStr()   ' getGateWayConnStr(gGateWayID) :
        Dim CONN As New SqlConnection(CS)
        CONN.Open()
        Dim command As New SqlCommand(S, CONN)
        RSData = command.ExecuteReader()

        If RSData.HasRows Then
            Do While RSData.Read()
                Dim EmailGuid = RSData.GetValue(0).ToString.Trim
                Dim StoreID As String = RSData.GetValue(1).ToString.Trim
                Dim MySql As String = "UPDATE  [Email] SET [StoreID] = '" + StoreID + "' WHERE [EmailGuid] = '" + EmailGuid + "'"
                ReDim Preserve A((UBound(A) + 1))
                A(UBound(A)) = MySql
            Loop
        Else
            id = -1
        End If

        RSData.Close()
        RSData = Nothing
        GC.Collect()

        For II = 0 To UBound(A) - 1
            frmMain.SB.Text = "Setting SourceID: " & II
            frmMain.SB.Refresh()
            S = A(II)
            If Not S Is Nothing Then
                b = ExecuteSqlNewConn(S, False)
            End If
            If Not b Then
                If xDebug Then LOG.WriteToArchiveLog("Failed to update: " + S)
            End If
        Next

    End Sub

    Function RestoreEmail(ByVal EmailGuid As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Const olByValue = 1
        Dim BccList As String = ""
        Dim CcList As String = ""
        Dim SendToAddr As String = ""
        Dim SubjLong As String = ""
        Dim Body As String = ""
        Dim SourceName As String = ""
        Dim AttachmentFQN As String = ""

        Dim oApp As Outlook.Application
        Dim oEmail As Outlook.MailItem
        oApp = New Outlook.Application
        oEmail = oApp.CreateItem(Outlook.OlItemType.olMailItem)

        With oEmail
            .To = SendToAddr
            .CC = CcList
            .BCC = BccList
            .Subject = SubjLong
            .BodyFormat = Outlook.OlBodyFormat.olFormatUnspecified
            .Body = Body
            .Importance = Outlook.OlImportance.olImportanceNormal
            .ReadReceiptRequested = False
            MessageBox.Show("Get each attachment here")
            .Attachments.Add(AttachmentFQN, olByValue, SourceName)
            .Recipients.ResolveAll()
            .Save()
            .Display() 'Show the email message and allow for editing before sending
            '.Send 'You can automatically send the email without displaying it.
        End With

        oEmail = Nothing
        oApp.Quit()
        oApp = Nothing
    End Function

    Function SendEmail() As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Const olByValue = 1
        Dim BccList As String = ""
        Dim CcList As String = ""
        Dim SendToAddr As String = ""
        Dim SubjLong As String = ""
        Dim Body As String = ""
        Dim SourceName As String = ""
        Dim AttachmentFQN As String = ""

        Dim oApp As Outlook.Application
        Dim oEmail As Outlook.MailItem
        oApp = New Outlook.Application
        oEmail = oApp.CreateItem(Outlook.OlItemType.olMailItem)
        With oEmail
            .To = SendToAddr
            .CC = CcList
            .BCC = BccList
            .Subject = SubjLong
            .BodyFormat = Outlook.OlBodyFormat.olFormatUnspecified
            .Body = Body
            .Importance = Outlook.OlImportance.olImportanceNormal
            .ReadReceiptRequested = False
            MessageBox.Show("Get each attachment here")
            .Attachments.Add(AttachmentFQN, olByValue, SourceName)
            .Recipients.ResolveAll()
            .Save()
            .Send() 'You can automatically send the email without displaying it.
        End With
        oEmail = Nothing
        oApp.Quit()
        oApp = Nothing
    End Function

    Public Sub ShellFile(ByVal File As String)
        ShellExecute(0&, "open", File, 0&, 0&, 1)
    End Sub

    Sub OSDisplayFile()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Dim sFile As String = "C:\Users\wmiller\Documents\Documents on Dale's PDA\RENT REH.doc"
        ShellFile(sFile)
        Dim ln As Long
        Dim hWndDesk As Long = GetDesktopWindow()

        sFile = "c:\hpfr3420.xml"
        Return

        Dim Scr_hDC As Long
        Scr_hDC = GetDesktopWindow()
        ln = ShellExecute(0&, "", sFile, "", "", 1)

        ln = ShellExecute(0&, vbNullString, "notepad", sFile, vbNullString, vbNormalFocus)

        If xDebug Then LOG.WriteToArchiveLog("LN = " + ln.ToString)
        'ShellExecute 0&, vbNullString, "notepad", "c:\test.doc", vbNullString, vbNormalFocus
        ln = ShellExecute(0&, vbNullString, sFile, vbNullString, vbNullString, vbNormalFocus)
        If ln < 32 Then
            Call Shell("rundll32.exe shell32.dll,OpenAs_RunDLL " & sFile, vbNormalFocus)
        End If
        'opens C:\test.doc with its default viewer. Note that if the path you pass contains spaces, you need to surround it by quotes:
    End Sub

    Sub XXX()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim hWndDesk As Long = GetDesktopWindow()
        Dim oApp As New Outlook.Application

        Dim sBuild As String = Left(oApp.Version, InStr(1, oApp.Version, ".") + 1)
        Dim oNS As Outlook.NameSpace = oApp.GetNamespace("mapi")

        Dim oItem As Outlook.MailItem
        oApp = CreateObject("Outlook.Application")
        oNS = oApp.GetNamespace("MAPI")

        'oItem = oApp.ActiveInspector.CurrentItem

        'Private Sub Command1_Click()
        Dim sFile As String = gTempDir + "\Enterprise Business Alert  March Toward Mobilization.eml"
        Dim ln As Long
        ln = ShellExecute(hWndDesk, "Open", sFile, "", "", 1)

        If ln < 32 Then
            Call Shell("rundll32.exe shell32.dll,OpenAs_RunDLL " & sFile, vbNormalFocus)
        End If

        While oApp.ActiveInspector Is Nothing
            Application.DoEvents()
        End While

        oItem = oApp.CopyFile(sFile, "Restored Emails")

        oItem = oApp.ActiveInspector.CurrentItem
        oItem.Copy()

    End Sub

    Public Sub SendNow()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim oApp As Outlook.Application
        'Dim oCtl As Office.CommandBarControl
        'Dim oPop As Office.CommandBarPopup
        'Dim oCB As Office.CommandBar
        Dim oNS As Outlook.NameSpace
        Dim oItem As Object

        'First find and send the current item to the Outbox
        oApp = CreateObject("Outlook.Application")
        oNS = oApp.GetNamespace("MAPI")
        oItem = oApp.ActiveInspector.CurrentItem
        Try
            oItem.Send()
        Catch ex As Exception
            If xDebug Then LOG.WriteToArchiveLog(ex.Message)
        End Try

        oApp = Nothing
        'oCtl = Nothing
        'oPop = Nothing
        'oCB = Nothing
        oNS = Nothing
        oItem = Nothing
    End Sub

    Sub ArchiveRSS(UserID As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim isPublic As Boolean = True
        Dim CaptureLink As Boolean = True
        Dim RssFQN As String = ""
        Dim RssName As String = ""
        Dim RssUrl As String = ""
        Dim OwnerID As String = ""
        Dim RetentionCode As String = ""
        Dim RowGuid As String = ""
        Dim KeyWords As String
        Dim WhereClause As String = ""
        Dim MySql As String = ""
        Dim RC As Boolean = False

        Dim RssTitle As String = ""
        Dim pubdate As String = ""
        Dim rlink As String = ""
        Dim desc As String = ""
        Dim listOfRssPages As New List(Of rssChannelItem)

        If UserID.Equals("*") Then
            WhereClause = ""
        ElseIf UserID.Length > 0 Then
            WhereClause = " where UserID = '" + UserID + "'"
        End If

        Dim ListOfUrls As New List(Of String)
        ListOfUrls = GET_RssPullData(gGateWayID, WhereClause, RC)

        Dim RssInfo As New frmNotify2
        RssInfo.Show()
        RssInfo.Text = "RSS Archive"
        '** We have all of the registered RSS feeds
        Dim K As Integer = 0
        For Each xStr In ListOfUrls
            K += 1
            Dim S() As String = xStr.Split("|")
            'Dim strItems = RssName + "|" + RssUrl + "|" + UserID
            RssName = S(0)
            RssUrl = S(1)
            OwnerID = S(2)
            RetentionCode = S(3)
            RowGuid = S(4)

            RssInfo.lblEmailMsg.Text = RssName
            RssInfo.lblMsg2.Text = RssUrl
            RssInfo.lblFolder.Text = K.ToString + " of " + ListOfUrls.Count.ToString
            RssInfo.Refresh()
            Application.DoEvents()

            Dim ChannelItems As New List(Of rssChannelItem)
            Dim RSS As New clsRSS
            'ChannelItems = ReadRssDataFromSite(RssUrl As String, CaptureLink As Boolean) As List(Of rssChannelItem)
            ChannelItems = RSS.ReadRssDataFromSite(RssUrl, True)
            RSS = Nothing
            GC.Collect()
            GC.WaitForPendingFinalizers()

            Dim I As Integer = 0
            For Each ChannelItem As rssChannelItem In ChannelItems
                I += 1
                RssTitle = ChannelItem.title
                pubdate = ChannelItem.pubDate
                rlink = ChannelItem.link
                desc = ChannelItem.description
                RssFQN = ChannelItem.webFqn
                KeyWords = ChannelItem.keyWords

                RssInfo.lblMsg2.Text = RssTitle
                RssInfo.lblFolder.Text = I.ToString + " of " + ChannelItems.Count.ToString
                RssInfo.Refresh()
                Application.DoEvents()

                If RssFQN.Trim.Length > 0 Then
                    'We may want to use a CE database here to speed thing up
                    ArchiveRssFeed(RowGuid, RssTitle, rlink, desc, KeyWords, RssFQN, RetentionCode, CDate(pubdate), isPublic)
                End If
            Next

        Next
        GC.Collect()
        GC.WaitForPendingFinalizers()
        RssInfo.Close()
        RssInfo.Dispose()
    End Sub

    Sub ArchiveRssFeed(RssRowGuid As String, RssName As String, RssLink As String, RssDesc As String, KeyWords As String, RssFQN As String, RetentionCode As String, RssPublishDate As Date, isPublic As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        If Not File.Exists(RssFQN) Then
            MessageBox.Show("RSS Feed could not be processed: " + vbCrLf + RssFQN)
            Return
        End If

        Dim FileText As String = ReadFileIntoString(RssFQN)
        Dim CrcHash As String = ENC.getSha1HashKey(FileText)

        Dim RssDescription As String = RssDesc.Replace("'", "''")
        Dim file_SourceName = RssFQN
        Dim SourceGuid As String = Guid.NewGuid.ToString

        Dim RSSProcessingDir As String = System.Configuration.ConfigurationManager.AppSettings("RSSProcessingDir")

        If Not Directory.Exists(RSSProcessingDir) Then
            Directory.CreateDirectory(RSSProcessingDir)
        End If

        Dim ckMetaData As String = "N"
        Dim LastVerNbr As Integer = 0

        Dim FI As New FileInfo(RssFQN)
        Dim OriginalFileType As String = FI.Extension
        Dim file_SourceTypeCode As String = FI.Extension
        Dim file_FullName As String = FI.Name
        'Dim file_LastAccessDate As String = FI.LastAccessTime.ToString
        Dim file_LastAccessDate As String = FI.LastAccessTime.ToString
        Dim file_CreateDate As String = FI.CreationTime
        Dim file_LastWriteTime As String = RssPublishDate.ToString
        Dim file_Length As String = FI.Length.ToString
        FI = Nothing

        If CInt(file_Length) = 0 Then
            MessageBox.Show("Bad file: " + RssFQN)
            Return
        End If

        GC.Collect()
        GC.WaitForPendingFinalizers()

        'Dim iDatasourceCnt As Integer = getCountDataSourceFiles(file_FullName, CrcHash)
        Dim iDatasourceCnt As Integer = getCountRssFile(file_FullName, RssPublishDate.ToString)
        If (iDatasourceCnt = 0) Then
            saveContentOwner(SourceGuid, gCurrUserGuidID, "C", RSSProcessingDir, gMachineID, gNetworkID)
        End If

        Dim ListOfGuids As New List(Of String)
        ListOfGuids = ckFileExistInRepo(Environment.MachineName, file_FullName)
        If ListOfGuids.Count > 0 Then
            Dim FI2 As New FileInfo(file_FullName)
            file_LastAccessTime = FI2.LastAccessTime
            file_CreationTime = FI2.CreationTime
            file_LastWriteTime = FI2.LastWriteTime
            FI2 = Nothing

            LastVerNbr = 0
            Dim FileHash As String = ENC.GenerateSHA512HashFromFile(file_FullName)
            For Each SourceGuid In ListOfGuids
                bSuccessExecution = UpdateSourceImageInRepo(file_FullName,
                                                gCurrLoginID,
                                                Environment.MachineName,
                                                SourceGuid,
                                                file_LastAccessTime,
                                                file_CreationTime,
                                                file_LastWriteTime,
                                                LastVerNbr,
                                                file_FullName,
                                                RetentionCode,
                                                isPublic,
                                                FileHash)
                'bSuccessExecution = DBARCH.UpdateSouceImage(MachineID, file_FullName, FileHash)
                If Not bSuccessExecution Then
                    LOG.WriteToArchiveLog("ERROR UpdateSouceImage 0X1: Failed to update ImageHash: " + file_FullName)
                End If
            Next

        End If


        If iDatasourceCnt = 0 Then

            Dim StartInsert As Date = Now
            LOG.WriteToTimerLog("Start ArchiveRssFeed", "InsertRSSFeed:" + file_FullName, "START")

            Dim BB As Boolean = AddSourceToRepo(gCurrUserGuidID, gMachineID, gNetworkID, SourceGuid, RssFQN, file_FullName, file_SourceTypeCode, file_LastAccessDate, file_CreateDate, file_LastWriteTime, gCurrUserGuidID, LastVerNbr, RetentionCode, isPublic, CrcHash, RSSProcessingDir)

            If BB Then
                LOG.WriteToTimerLog("END ArchiveRssFeed", "AddSourceToRepo" + file_FullName, "STOP", StartInsert)
            Else
                LOG.WriteToTimerLog("FAIL ArchiveRssFeed", "AddSourceToRepo" + file_FullName, "STOP", StartInsert)
            End If

            If BB Then

                Dim VersionNbr As String = "0"
                Dim UpdateInsert As Date = Now
                LOG.WriteToTimerLog("ArchiveRssFeed", "UpdateInsert:" + file_FullName, "STOP")

                If xDebug Then LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 1000 inserted new file " + file_FullName)
                If OcrText.Trim.Length > 0 Then
                    Dim SS As String = ""
                    AppendOcrText(SourceGuid, OcrText)
                End If

                insertrSSChild(RssRowGuid, SourceGuid)
                UpdateSourceCRC(SourceGuid, CrcHash)
                UpdateRssLinkFlgToTrue(SourceGuid)
                UpdateContentDescription(SourceGuid, RssDescription)
                UpdateContentKeyWords(SourceGuid, KeyWords)
                UpdateWebPageUrlRef(SourceGuid, RssLink)
                UpdateDocFqn(SourceGuid, file_FullName)
                UpdateDocSize(SourceGuid, file_Length)
                UpdateDocDir(SourceGuid, file_FullName)
                UpdateDocOriginalFileType(SourceGuid, OriginalFileType)

                UpdateWebPageUrlRef(SourceGuid, RssLink)
                UpdateWebPageHash(SourceGuid, ENC.getSha1HashKey(RssLink))
                UpdateWebPagePublishDate(SourceGuid, RssPublishDate.ToString)

                setRetentionDate(SourceGuid, RetentionCode, OriginalFileType)

                InsertSrcAttrib(SourceGuid, "FILENAME", file_SourceName, OriginalFileType)
                InsertSrcAttrib(SourceGuid, "CreateDate", file_CreateDate, OriginalFileType)
                InsertSrcAttrib(SourceGuid, "FILESIZE", file_Length, OriginalFileType)
                InsertSrcAttrib(SourceGuid, "ChangeDate", file_LastAccessDate, OriginalFileType)
                InsertSrcAttrib(SourceGuid, "WriteDate", file_LastWriteTime, OriginalFileType)

                If Not file_SourceTypeCode.Equals(OriginalFileType) Then
                    InsertSrcAttrib(SourceGuid, "IndexAs", file_LastWriteTime, file_SourceTypeCode)
                End If

                LOG.WriteToTimerLog("ArchiveRssFeed", "InsertRSSFeed" + file_FullName, "STOP", UpdateInsert)
            End If

        End If
        Try
            File.Delete(RssFQN)
        Catch ex As Exception
            Console.WriteLine("Failed to delete 0A " + RssFQN)
        End Try

    End Sub

    Sub ArchiveRssFeedWebPage(RssSourceGuid As String, WebPageURL As String, WebPageFQN As String, RetentionCode As String, isPublic As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim CrcHash As String = ENC.GenerateSHA512HashFromFile(WebPageFQN)
        Dim ImageHash As String = ENC.GenerateSHA512HashFromFile(WebPageFQN)

        Dim file_SourceName = WebPageFQN
        Dim SourceGuid As String = Guid.NewGuid.ToString

        Dim WEBProcessingDir As String = System.Configuration.ConfigurationManager.AppSettings("WEBProcessingDir")
        If Not Directory.Exists(WEBProcessingDir) Then
            Directory.CreateDirectory(WEBProcessingDir)
        End If

        Dim ckMetaData As String = "N"
        Dim LastVerNbr As Integer = 0

        Dim FI As New FileInfo(WebPageFQN)
        Dim OriginalFileType As String = FI.Extension
        Dim file_SourceTypeCode As String = FI.Extension
        Dim file_FullName As String = FI.Name
        Dim file_LastAccessDate As String = FI.LastAccessTime.ToString
        Dim file_CreateDate As String = FI.CreationTime.ToString
        Dim file_LastWriteTime As String = FI.LastWriteTime.ToString
        Dim file_Length As String = FI.Length.ToString
        FI = Nothing

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Dim iDatasourceCnt As Integer = getCountDataSourceFiles(file_SourceName, CrcHash)
        If (iDatasourceCnt = 0) Then
            saveContentOwner(SourceGuid, gCurrUserGuidID, "C", WEBProcessingDir, gMachineID, gNetworkID)
        End If

        If iDatasourceCnt = 0 Then

            Dim StartInsert As Date = Now
            LOG.WriteToTimerLog("Start ArchiveRssFeedWebPage", "InsertRSSFeed:" + file_FullName, "START")

            Dim BB As Boolean = AddSourceToRepo(gCurrUserGuidID, gMachineID, gNetworkID, SourceGuid, file_FullName, file_SourceName, file_SourceTypeCode, file_LastAccessDate, file_CreateDate, file_LastWriteTime, gCurrUserGuidID, LastVerNbr, RetentionCode, isPublic, CrcHash, WEBProcessingDir)

            If BB Then
                insertSourceChild(RssSourceGuid, SourceGuid)
                LOG.WriteToTimerLog("END ArchiveRssFeedWebPage", "AddSourceToRepo" + file_FullName, "STOP", StartInsert)
            Else
                LOG.WriteToTimerLog("FAIL ArchiveRssFeedWebPage", "AddSourceToRepo" + file_FullName, "STOP", StartInsert)
            End If

            If BB Then

                Dim VersionNbr As String = "0"
                Dim UpdateInsert As Date = Now
                LOG.WriteToTimerLog("ArchiveRssFeedWebPage", "UpdateInsert:" + file_FullName, "STOP")

                If xDebug Then LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 1000 inserted new file " + file_FullName)
                If OcrText.Trim.Length > 0 Then
                    Dim SS As String = ""
                    AppendOcrText(SourceGuid, OcrText)
                End If

                UpdateDocFqn(SourceGuid, file_FullName)
                UpdateDocSize(SourceGuid, file_Length)
                UpdateDocDir(SourceGuid, file_FullName)
                UpdateDocOriginalFileType(SourceGuid, OriginalFileType)
                setRetentionDate(SourceGuid, RetentionCode, OriginalFileType)

                MessageBox.Show("Mark as a WEB page here." + WebPageURL)

                'delFileParms(SourceGuid )
                InsertSrcAttrib(SourceGuid, "FILENAME", file_SourceName, OriginalFileType)
                InsertSrcAttrib(SourceGuid, "CreateDate", file_CreateDate, OriginalFileType)
                InsertSrcAttrib(SourceGuid, "FILESIZE", file_Length, OriginalFileType)
                InsertSrcAttrib(SourceGuid, "ChangeDate", file_LastAccessDate, OriginalFileType)
                InsertSrcAttrib(SourceGuid, "WriteDate", file_LastWriteTime, OriginalFileType)

                If Not file_SourceTypeCode.Equals(OriginalFileType) Then
                    InsertSrcAttrib(SourceGuid, "IndexAs", file_LastWriteTime, file_SourceTypeCode)
                End If

                LOG.WriteToTimerLog("ArchiveRssFeedWebPage", "InsertRSSFeed" + file_FullName, "STOP", UpdateInsert)
            End If

        End If
        File.Delete(WebPageFQN)
    End Sub

    Sub ArchiveWebSites(UserID As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim WEB As New clsWebPull

        Dim isPublic As Boolean = True
        Dim CaptureLink As Boolean = True
        Dim SiteFQN As String = ""
        Dim WebSite As String = ""
        Dim WebUrl As String = ""
        Dim Depth As String = ""
        Dim Width As String = ""
        Dim OwnerID As String = ""
        Dim RetentionCode As String = ""
        Dim RowGuid As String = ""
        Dim WhereClause As String = ""
        Dim RC As Boolean = False

        Dim RssTitle As String = ""
        Dim pubdate As String = ""
        Dim rlink As String = ""
        Dim desc As String = ""
        Dim listOfWebSites As New List(Of dsWebSite)

        If UserID.Equals("*") Then
            WhereClause = ""
        ElseIf UserID.Length > 0 Then
            WhereClause = " where UserID = '" + UserID + "'"
        End If

        Dim ListOfUrls As New List(Of String)
        ListOfUrls = GET_WebSiteData(gGateWayID, WhereClause, RC)

        Dim WebInfo As New frmNotify2
        WebInfo.Show()
        WebInfo.Text = "RSS Archive"
        '** We have all of the registered RSS feeds
        Dim K As Integer = 0
        For Each xStr In ListOfUrls
            K += 1
            Dim S() As String = xStr.Split("|")
            'Dim strItems = WebSite + "|" + WebUrl + "|" + UserID + "|" + Depth + "|" + Width + "|" + RetentionCode + "|" + RowGuid
            WebSite = S(0)
            WebUrl = S(1)
            OwnerID = S(2)
            Depth = S(3)
            Width = S(4)
            RetentionCode = S(5)
            RowGuid = S(6)

            WebInfo.lblEmailMsg.Text = WebSite
            WebInfo.lblMsg2.Text = WebUrl
            WebInfo.lblFolder.Text = K.ToString + " of " + ListOfUrls.Count.ToString
            WebInfo.Refresh()
            Application.DoEvents()

            spiderWeb(WebUrl, CInt(Depth), CInt(Width), isPublic, RetentionCode)

        Next
        WEB = Nothing
        GC.Collect()
        GC.WaitForPendingFinalizers()
        WebInfo.Close()
        WebInfo.Dispose()
        GC.Collect()
        GC.WaitForPendingFinalizers()

    End Sub

    Sub ArchiveSingleWebPage(UserID As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim WEB As New clsWebPull

        Dim isPublic As Boolean = True
        Dim CaptureLink As Boolean = True
        Dim SiteFQN As String = ""
        Dim WebSite As String = ""
        Dim WebUrl As String = ""
        Dim Depth As String = ""
        Dim Width As String = ""
        Dim OwnerID As String = ""
        Dim RetentionCode As String = ""
        Dim RowGuid As String = ""
        Dim WhereClause As String = ""
        Dim RC As Boolean = False

        Dim RssTitle As String = ""
        Dim pubdate As String = ""
        Dim rlink As String = ""
        Dim desc As String = ""
        Dim listOfWebSites As New List(Of dsWebSite)

        If UserID.Length > 0 Then
            WhereClause = " where UserID = '" + UserID + "'"
        End If

        Dim ListOfUrls As New List(Of String)
        ListOfUrls = GET_WebPageData(gGateWayID, WhereClause, RC)

        Dim WebInfo As New frmNotify2
        WebInfo.Show()
        WebInfo.Text = "WEB Page Archive"
        '** We have all of the registered RSS feeds
        Dim K As Integer = 0
        For Each xStr In ListOfUrls
            K += 1
            Dim S() As String = xStr.Split("|")
            'Dim strItems = WebSite + "|" + WebUrl + "|" + UserID + "|" + Depth + "|" + Width + "|" + RetentionCode + "|" + RowGuid
            WebSite = S(0)
            WebUrl = S(1)
            OwnerID = S(2)
            Depth = S(3)
            Width = S(4)
            RetentionCode = S(5)
            RowGuid = S(6)

            WebInfo.lblEmailMsg.Text = WebSite
            WebInfo.lblMsg2.Text = WebUrl
            WebInfo.lblFolder.Text = K.ToString + " of " + ListOfUrls.Count.ToString
            WebInfo.Refresh()
            Application.DoEvents()

            spiderWeb(WebUrl, CInt(Depth), CInt(Width), isPublic, RetentionCode)

        Next
        WEB = Nothing
        GC.Collect()
        GC.WaitForPendingFinalizers()
        WebInfo.Close()
        WebInfo.Dispose()
        GC.Collect()
        GC.WaitForPendingFinalizers()

    End Sub

    Function ArchiveWebPage(ParentSourceGuid As String, WebpageTitle As String, WebpageUrl As String, WebPageFQN As String, RetentionCode As String, isPublic As String, LastAccessTime As Date) As String
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        If Not File.Exists(WebPageFQN) Then
            MessageBox.Show("WEB Page could not be found: " + vbCrLf + WebPageFQN)
            Return ""
        End If

        Dim FileText As String = ReadFileIntoString(WebPageFQN)
        Dim CrcHash As String = ENC.getSha1HashKey(FileText)

        Dim file_SourceName = WebPageFQN
        Dim SourceGuid As String = Guid.NewGuid.ToString

        Dim WEBProcessingDir As String = System.Configuration.ConfigurationManager.AppSettings("WEBProcessingDir")

        If Not Directory.Exists(WEBProcessingDir) Then
            Directory.CreateDirectory(WEBProcessingDir)
        End If

        Dim ckMetaData As String = "N"
        Dim LastVerNbr As Integer = 0
        Dim FI As New FileInfo(WebPageFQN)
        Dim OriginalFileType As String = FI.Extension
        Dim file_SourceTypeCode As String = FI.Extension
        Dim file_FullName As String = FI.Name
        Dim file_LastAccessDate As String = FI.LastAccessTime.ToString
        Dim file_CreateDate As String = FI.CreationTime.ToString
        'Dim file_LastWriteTime As String = FI.LastWriteTime.ToString
        Dim file_LastWriteTime As String = LastAccessTime.ToString
        Dim file_Length As String = FI.Length.ToString
        FI = Nothing
        GC.Collect()
        GC.WaitForPendingFinalizers()

        If CInt(file_Length) < 10 Then
            Console.WriteLine("File " + file_FullName + " is only " + file_Length + " bytes long, skipping.")
            Return ""
        End If

        Dim iDatasourceCnt As Integer = getCountDataSourceFiles(file_FullName, CrcHash)
        'Dim iDatasourceCnt As Integer = getCountDataSourceFiles(file_SourceName, LastAccessTime)
        If (iDatasourceCnt > 0) Then
            Dim sGuid As String = getSourceGuidBySourcenameCRC(file_FullName, CrcHash)
            If sGuid.Length > 0 Then
                saveContentOwner(sGuid, gCurrUserGuidID, "C", WEBProcessingDir, gMachineID, gNetworkID)
                Return sGuid
            Else
                iDatasourceCnt = 0
            End If
        End If

        If iDatasourceCnt = 0 Then

            Dim StartInsert As Date = Now
            LOG.WriteToTimerLog("Start ArchiveWebPage", "InsertWebPage:" + file_FullName, "START")

            Dim BB As Boolean = AddSourceToRepo(gCurrUserGuidID, gMachineID, gNetworkID, SourceGuid, file_SourceName, file_FullName, file_SourceTypeCode, file_LastAccessDate, file_CreateDate, file_LastWriteTime, gCurrUserGuidID, LastVerNbr, RetentionCode, isPublic, CrcHash, WEBProcessingDir)

            If BB Then
                If ParentSourceGuid.Length > 0 Then
                    insertSourceChild(ParentSourceGuid, SourceGuid)
                End If
                LOG.WriteToTimerLog("END ArchiveWebPage", "AddSourceToRepo" + file_FullName, "STOP", StartInsert)
            Else
                LOG.WriteToTimerLog("FAIL ArchiveWebPage", "AddSourceToRepo" + file_FullName, "STOP", StartInsert)
            End If

            If BB Then

                Dim VersionNbr As String = "0"
                Dim UpdateInsert As Date = Now
                LOG.WriteToTimerLog("ArchiveWebPage", "UpdateInsert:" + file_FullName, "STOP")

                If xDebug Then LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 1000 inserted new file " + file_FullName)
                If OcrText.Trim.Length > 0 Then
                    Dim SS As String = ""
                    AppendOcrText(SourceGuid, OcrText)
                End If

                UpdateSourceCRC(SourceGuid, CrcHash)
                UpdateWebLinkFlgToTrue(SourceGuid)
                UpdateContentDescription(SourceGuid, WebpageTitle)
                UpdateWebPageUrlRef(SourceGuid, WebpageUrl)
                UpdateWebPageHash(SourceGuid, ENC.getSha1HashKey(WebpageUrl))

                UpdateDocFqn(SourceGuid, file_FullName)
                UpdateDocSize(SourceGuid, file_Length)
                If CInt(file_Length) < 10 Then
                    Console.WriteLine("File " + file_FullName + " is only " + file_Length + " bytes long, skipping.")

                End If
                UpdateDocDir(SourceGuid, file_FullName)
                UpdateDocOriginalFileType(SourceGuid, OriginalFileType)
                setRetentionDate(SourceGuid, RetentionCode, OriginalFileType)

                'delFileParms(SourceGuid )
                InsertSrcAttrib(SourceGuid, "FILENAME", file_SourceName, OriginalFileType)
                InsertSrcAttrib(SourceGuid, "CreateDate", file_CreateDate, OriginalFileType)
                InsertSrcAttrib(SourceGuid, "FILESIZE", file_Length, OriginalFileType)
                InsertSrcAttrib(SourceGuid, "ChangeDate", file_LastAccessDate, OriginalFileType)
                InsertSrcAttrib(SourceGuid, "WriteDate", file_LastWriteTime, OriginalFileType)

                If Not file_SourceTypeCode.Equals(OriginalFileType) Then
                    InsertSrcAttrib(SourceGuid, "IndexAs", file_LastWriteTime, file_SourceTypeCode)
                End If

                LOG.WriteToTimerLog("ArchiveWebPage", "InsertWebPage" + file_FullName, "STOP", UpdateInsert)
            End If
        Else
            SourceGuid = ""
        End If
        Try
            File.Delete(WebPageFQN)
        Catch ex As Exception
            Console.WriteLine("Failed to delete 0B " + WebPageFQN)
        End Try

        Return SourceGuid
    End Function

    Sub ArchiveContent(ByVal MachineID As String, ByVal InstantArchive As Boolean, ByVal UID As String, ByVal FQN As String, ByVal Author As String,
                       ByVal Description As String, ByVal Keywords As String,
                       ByVal isEmailAttachment As Boolean,
                       Optional ByVal EmailGuid As String = "")
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        If xDebug Then LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 100")

        Dim versionNumber As String = Application.ProductVersion.ToString
        Dim AttachmentCode As String = ""
        Dim ImageHash As String = ENC.GenerateSHA512HashFromFile(FQN)

        If (isEmailAttachment = True) Then
            AttachmentCode = "A"
        Else
            AttachmentCode = "C"
        End If

        Dim isPublic As String = "N"

        Dim FolderName As String = DMA.GetFilePath(FQN)
        Dim cFolder As String = ""
        Dim pFolder As String = "XXX"
        Dim DirFiles As New List(Of String)
        Dim ActiveFolders(0) As String

        If InstantArchive = True Then
            DirFiles.Clear()
            ActiveFolders(0) = FolderName
            DirFiles.Add(FQN)
            GoTo ProcessOneFileOnly
        End If

        FQN = UTIL.RemoveSingleQuotes(FQN)

        'Dim IncludedTypes As New ArrayList
        'Dim ExcludedTypes As New ArrayList

        Dim a() As String = Split("0|0", "|")

        Dim DeleteFile As Boolean = False
        ActiveFolders(0) = FolderName
        Dim FileName As String = DMA.getFileName(FQN)

        Dim iCnt As Integer = QDIR.cnt_PKII2QD(FolderName, UID)
        If xDebug Then LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 200 iCnt = " + iCnt.ToString)
        If iCnt = 0 Then
            QDIR.setCkdisabledir("N")
            QDIR.setCkmetadata("N")
            QDIR.setCkpublic("N")
            QDIR.setDb_id("ECM.Library")
            QDIR.setFqn(FolderName)
            QDIR.setIncludesubdirs("N")
            QDIR.setUserid(UID)
            QDIR.setVersionfiles("Y")
            QDIR.setQuickrefentry("1")
            QDIR.Insert()
            If xDebug Then LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 300 inserted qDir")
        End If

        Dim StepTimer As Date = Now
        LOG.WriteToTimerLog("ArchiveContent01", "GetQuickArchiveFileFolders", "START")

        GetQuickArchiveFileFolders(UID, ActiveFolders, FolderName)

        LOG.WriteToTimerLog("ArchiveContent01", "GetQuickArchiveFileFolders", "STOP", StepTimer)

ProcessOneFileOnly:

        For i As Integer = 0 To UBound(ActiveFolders)

            Dim FolderParmStr As String = ActiveFolders(i).ToString.Trim
            Dim FolderParms() As String = FolderParmStr.Split("|")

            Dim FOLDER_FQN As String = FolderParms(0)
            Dim FOLDER_IncludeSubDirs As String = FolderParms(1)
            Dim FOLDER_DBID As String = FolderParms(2)
            Dim FOLDER_VersionFiles As String = FolderParms(3)
            Dim DisableDir As String = FolderParms(4)
            Dim RetentionCode As String = FolderParms(5)

            If xDebug Then LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 400: " + FOLDER_FQN)

            FOLDER_FQN = UTIL.RemoveSingleQuotes(FOLDER_FQN)

            If Not Directory.Exists(FOLDER_FQN) Then
                MessageBox.Show(FOLDER_FQN + " does not exist, returning.")
                Return
            End If
            If (DisableDir.Equals("Y")) Then
                GoTo NextFolder
            End If

            'GetIncludedFiletypes(FOLDER_FQN , IncludedTypes)
            'GetExcludedFiletypes(FOLDER_FQN , ExcludedTypes)

            IncludedTypes = GetAllIncludedFiletypes(FOLDER_FQN, FOLDER_IncludeSubDirs)
            ExcludedTypes = GetAllExcludedFiletypes(FOLDER_FQN, FOLDER_IncludeSubDirs)

            Dim bChanged As Boolean = False

            Dim LibraryList As New List(Of String)

            If FOLDER_FQN <> pFolder Then

                Dim ParentDirForLib As String = ""
                Dim bLikToLib As Boolean = False
                bLikToLib = isDirInLibrary(FOLDER_FQN, ParentDirForLib)

                FolderName = FOLDER_FQN

                Dim ThisDirIsDisabled As Boolean = False
                ThisDirIsDisabled = isParentDirDisabled(FOLDER_FQN)

                If ThisDirIsDisabled = True Then
                    LOG.WriteToArchiveLog("NOTICE: " + FOLDER_FQN + " disabled from archive.")
                    GoTo NextFolder
                End If

                If bLikToLib Then
                    GetDirectoryLibraries(ParentDirForLib, LibraryList)
                Else
                    GetDirectoryLibraries(FOLDER_FQN, LibraryList)
                End If

                If xDebug Then LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 500: " + FolderName)

                Application.DoEvents()
                '** Verify that the DIR still exists
                If (Directory.Exists(FolderName)) Then
                Else
                    Return
                End If

                Dim FoundDir As Boolean = getDirectoryParms(a, FolderName, gCurrUserGuidID)
                If Not FoundDir Then
                    LOG.WriteToArchiveLog("clsArchiver : ArchiveContent : 00 : " + "ERROR: Folder'" + FolderName + "' was not registered, using default archive parameters.")
                End If

                Dim IncludeSubDirs As String = a(0)
                Dim VersionFiles As String = a(1)
                Dim ckMetaData As String = a(2)
                Dim OcrDirectory As String = a(3)
                Dim RetenCode As String = a(4)
                If RetenCode.Equals("?") Then
                    RetenCode = getFirstRetentionCode()
                End If
                '** Get all of the files in this folder

                Try
                    If InstantArchive = True Then
                    Else
                        Dim ii As Integer = DMA.getFilesInDir(FOLDER_FQN, DirFiles, FileName)
                        If ii = 0 Then
                            If xDebug Then LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 600 NO FILES IN FOLDER: " + FolderName)
                            GoTo NextFolder
                        End If
                    End If
                Catch ex As Exception
                    GoTo NextFolder
                End Try

                '** Process all of the files
                For K As Integer = 0 To DirFiles.Count - 1
                    StepTimer = Now
                    LOG.WriteToTimerLog("ArchiveContent01", "ProcessFile", "STOP")
                    Dim SourceGuid As String = getGuid()
                    Dim FileAttributes As String() = DirFiles(K).Split("|")
                    Dim file_FullName As String = FileAttributes(1)
                    If xDebug Then LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 700 processing file: " + file_FullName)
                    Dim file_SourceName As String = FileAttributes(0)
                    If xDebug Then LOG.WriteToArchiveLog("    File: " + file_SourceName)
                    Dim file_Length As String = FileAttributes(2)

                    If gMaxSize > 0 Then
                        If Val(file_Length) > gMaxSize Then
                            LOG.WriteToArchiveLog("Notice: file '" + file_FullName + "' exceed the allowed file upload size, skipped.")
                            GoTo NextFile
                        End If
                    End If

                    Dim file_DirName As String = DMA.GetFilePath(file_FullName)
                    Dim file_SourceTypeCode As String = FileAttributes(3)
                    Dim file_LastAccessDate As String = FileAttributes(4)
                    Dim file_CreateDate As String = FileAttributes(5)
                    Dim file_LastWriteTime As String = FileAttributes(6)
                    Dim OriginalFileType As String = file_SourceTypeCode

                    ckSourceTypeCode(file_SourceTypeCode)

                    Dim StoredExternally As String = "N"
                    Dim FileNeedsUpdating As Boolean = False
                    Dim iDatasourceCnt As Integer = getCountDataSourceFiles(file_SourceName, ImageHash)

                    Dim ListOfGuids As New List(Of String)
                    ListOfGuids = ckFileExistInRepo(Environment.MachineName, file_FullName)
                    If ListOfGuids.Count > 0 Then
                        Dim FI2 As New FileInfo(file_FullName)
                        file_LastAccessTime = FI2.LastAccessTime
                        file_CreationTime = FI2.CreationTime
                        file_LastWriteTime = FI2.LastWriteTime
                        FI2 = Nothing

                        LastVerNbr = 0
                        Dim filehash As String = ENC.GenerateSHA512HashFromFile(file_FullName)
                        For Each SourceGuid In ListOfGuids
                            bSuccessExecution = UpdateSourceImageInRepo(file_FullName,
                                                gCurrLoginID,
                                                Environment.MachineName,
                                                SourceGuid,
                                                file_LastAccessTime,
                                                file_CreationTime,
                                                file_LastWriteTime,
                                                LastVerNbr,
                                                file_FullName,
                                                RetentionCode,
                                                isPublic,
                                                filehash)
                            'bSuccessExecution = DBARCH.UpdateSouceImage(MachineID, file_FullName, FileHash)
                            If Not bSuccessExecution Then
                                setRetentionDate(SourceGuid, RetentionCode, OriginalFileType)
                                LOG.WriteToArchiveLog("ERROR UpdateSouceImage 0X1: Failed to update ImageHash: " + file_FullName)
                            End If
                        Next
                    End If

                    If (iDatasourceCnt = 0) Then
                        saveContentOwner(SourceGuid, gCurrUserGuidID, "C", file_DirName, gMachineID, gNetworkID)
                    End If

                    OcrText = ""
                    Dim isGraphic As String = "N"

                    If iDatasourceCnt = 0 Then
                        '********************************************************************************
                        '* The file DOES NOT exist in the reporsitory, add it now.
                        '********************************************************************************
                        Application.DoEvents()
                        LastVerNbr = 0

                        '********************************************************************************
                        Dim StartInsert As Date = Now
                        LOG.WriteToTimerLog("Start ArchiveContent01", "AddSourceToRepo:" + file_FullName, "START")

                        '****************************************************************************************************************************************************************
                        '****************************************************************************************************************************************************************
                        Dim BB As Boolean = AddSourceToRepo(UID, MachineID, gNetworkID, SourceGuid, file_FullName, file_SourceName, file_SourceTypeCode, file_LastAccessDate, file_CreateDate, file_LastWriteTime, gCurrUserGuidID, LastVerNbr, RetentionCode, isPublic, ImageHash, file_DirName)
                        '****************************************************************************************************************************************************************
                        '****************************************************************************************************************************************************************
                        If BB Then
                            setRetentionDate(SourceGuid, RetentionCode, OriginalFileType)
                            LOG.WriteToDBUpdatesLog("UPDATED/ADDED FILE: " + SourceGuid + " : " + file_FullName)
                        Else
                            LOG.WriteToDBUpdatesLog("ERROR FAILED- FILE: " + SourceGuid + " : " + file_FullName)
                        End If

                        Dim fExt As String = DMA.getFileExtension(file_FullName)
                        If FQN.ToUpper.Equals("ZIP") Then
                            DBLocal.addZipFile(file_FullName, False, SourceGuid)
                            Dim StackLevel As Integer = 0
                            Dim ListOfFiles As New Dictionary(Of String, Integer)
                            ZF.UploadZipFile(gCurrUserGuidID, gMachineID, file_FullName, SourceGuid, True, False, RetentionCode, isPublic, StackLevel, ListOfFiles)
                            ListOfFiles = Nothing
                            GC.Collect()
                        End If

                        If BB Then
                            LOG.WriteToTimerLog("END ArchiveContent01", "AddSourceToRepo" + file_FullName, "STOP", StartInsert)
                        Else
                            LOG.WriteToTimerLog("FAIL ArchiveContent01", "AddSourceToRepo" + file_FullName, "STOP", StartInsert)
                        End If

                        '********************************************************************************

                        If BB Then

                            Dim bApplied As Boolean = Exec_spUpdateLongNameHash(SourceGuid, file_FullName)
                            If Not bApplied Then
                                LOG.WriteToArchiveLog("ERROR 12Q1: (Exec_spUpdateLongNameHash) : Failed to update the long file names cross references: ")
                                LOG.WriteToArchiveLog("HOW TO TEST in Sql Server: " + vbCrLf + "    exec spUpdateLongNameHash '" + file_FullName + "', '" + SourceGuid + "' ")
                            End If

                            Dim VersionNbr As String = "0"
                            Dim UpdateInsert As Date = Now
                            LOG.WriteToTimerLog("ArchiveContent01", "UpdateInsert:" + file_FullName, "STOP")

                            If xDebug Then LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 1000 inserted new file " + file_FullName)
                            If OcrText.Trim.Length > 0 Then
                                Dim SS As String = ""
                                AppendOcrText(SourceGuid, OcrText)
                            End If

                            UpdateRetentionCode(SourceGuid, RetentionCode)
                            UpdateDocFqn(SourceGuid, file_FullName)
                            UpdateDocSize(SourceGuid, file_Length)
                            UpdateDocDir(SourceGuid, file_FullName)
                            UpdateDocOriginalFileType(SourceGuid, OriginalFileType)
                            setRetentionDate(SourceGuid, RetentionCode, OriginalFileType)

                            'delFileParms(SourceGuid )
                            InsertSrcAttrib(SourceGuid, "FILENAME", file_SourceName, OriginalFileType)
                            InsertSrcAttrib(SourceGuid, "CreateDate", file_CreateDate, OriginalFileType)
                            InsertSrcAttrib(SourceGuid, "FILESIZE", file_Length, OriginalFileType)
                            InsertSrcAttrib(SourceGuid, "ChangeDate", file_LastAccessDate, OriginalFileType)
                            InsertSrcAttrib(SourceGuid, "WriteDate", file_LastWriteTime, OriginalFileType)

                            If Not file_SourceTypeCode.Equals(OriginalFileType) Then
                                InsertSrcAttrib(SourceGuid, "IndexAs", file_LastWriteTime, file_SourceTypeCode)
                            End If
                            If (file_SourceTypeCode.Equals(".doc") Or file_SourceTypeCode.Equals(".docx")) And ckMetaData.Equals("Y") Then
                                If gOfficeInstalled = True Then
                                    'EXTRACT WORD IMAGES HERE WDMXX
                                    GetWordDocMetadata(file_FullName, SourceGuid, OriginalFileType)
                                Else
                                    LOG.WriteToArchiveLog("WARNING 101xa: Metadata requested but office not installed.")
                                End If
                            End If
                            If (file_SourceTypeCode.Equals(".xls") _
                                        Or file_SourceTypeCode.Equals(".xlsx") Or file_SourceTypeCode.Equals(".xlsm")) And ckMetaData.Equals("Y") Then
                                If gOfficeInstalled = True Then
                                    GetExcelMetaData(file_FullName, SourceGuid, OriginalFileType)
                                Else
                                    LOG.WriteToArchiveLog("WARNING 101xb: Metadata requested but office not installed.")
                                End If
                            End If
                            LOG.WriteToTimerLog("ArchiveContent01", "UpdateInsert" + file_FullName, "STOP", UpdateInsert)
                        End If
                    Else
                        Dim bApplied As Boolean = Exec_spUpdateLongNameHash(SourceGuid, file_FullName)
                        If Not bApplied Then
                            LOG.WriteToArchiveLog("ERROR QX221: (Exec_spUpdateLongNameHash) : Failed to update the long file names cross references: ")
                            LOG.WriteToArchiveLog("HOW TO TEST in Sql Server: " + vbCrLf + "    exec spUpdateLongNameHash '" + file_FullName + "', '" + SourceGuid + "' ")
                        End If

                    End If

NextFile:
                    'Me.SB.Text = "Processing document #" + K.ToString
                    Application.DoEvents()
                    LOG.WriteToTimerLog("ArchiveContent01", "ProcessFile", "STOP", StepTimer)
                Next
            Else
                If xDebug Then LOG.WriteToArchiveLog("Duplicate Folder: " + FolderName)
            End If
NextFolder:
            pFolder = FolderName
        Next

    End Sub

    Overloads Sub InsertSrcAttrib(ByVal SGUID As String, ByVal aName As String, ByVal aVal As String, ByVal SourceType As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        SRCATTR.setSourceguid(SGUID)
        SRCATTR.setAttributename(aName)
        SRCATTR.setAttributevalue(aVal)
        SRCATTR.setDatasourceowneruserid(gCurrUserGuidID)
        SRCATTR.setSourcetypecode(SourceType)
        SRCATTR.Insert()
    End Sub

    Sub GetWordDocMetadata(ByVal FQN As String, ByVal SourceGUID As String, ByVal OriginalFileType As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim TempDir As String = System.IO.Path.GetTempPath
        Dim fName As String = DMA.getFileName(FQN)
        Dim NewFqn As String = TempDir + fName

        File.Copy(FQN, NewFqn, True)

        Dim WDOC As New clsMsWord
        WDOC.initWordDocMetaData(NewFqn, SourceGUID, OriginalFileType)

        '** THIS MAY NEED TO BE REMOVED
        File.Delete(NewFqn)

    End Sub

    Sub GetExcelMetaData(ByVal FQN As String, ByVal SourceGUID As String, ByVal OriginalFileType As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim TempDir As String = System.IO.Path.GetTempPath
        Dim fName As String = DMA.getFileName(FQN)
        Dim NewFqn As String = TempDir + fName

        File.Copy(FQN, NewFqn, True)

        Dim WDOC As New clsMsWord
        WDOC.initExcelMetaData(NewFqn, SourceGUID, OriginalFileType)

        ISO.saveIsoFile(" FilesToDelete.dat", NewFqn + "|")
        'File.Delete(NewFqn )

    End Sub

    Sub setDataSourceRestoreHistoryParms()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim s As String = ""
        Dim B As Boolean = False

        s = s + " update DataSourceRestoreHistory  "
        s = s + " set  DocumentName = (select SourceName from DataSource "
        s = s + " where DataSource.SourceGuid = DataSourceRestoreHistory.SourceGuid) "
        s = s + " where VerifiedData = 'N' "
        s = s + " and TypeContentCode <> '.msg' "
        s = s + " and DataSourceRestoreHistory.DataSourceOwnerUserID = '" + gCurrUserGuidID + "'"
        B = ExecuteSqlNewConn(s, False)

        s = " update DataSourceRestoreHistory  "
        s = s + " set  FQN = (select FQN from DataSource "
        s = s + " where DataSource.SourceGuid = DataSourceRestoreHistory.SourceGuid) "
        s = s + " where VerifiedData = 'N' "
        s = s + " and TypeContentCode <> '.msg' "
        s = s + " and DataSourceRestoreHistory.DataSourceOwnerUserID = '" + gCurrUserGuidID + "'"
        B = ExecuteSqlNewConn(s, False)

        s = " update DataSourceRestoreHistory "
        s = s + " set  DocumentName = (select ShortSubj from Email where Email.EmailGuid = DataSourceRestoreHistory.SourceGuid)"
        s = s + " where VerifiedData = 'N' and TypeContentCode = '.msg' and DataSourceRestoreHistory.DataSourceOwnerUserID = '" + gCurrUserGuidID + "'"
        B = ExecuteSqlNewConn(s, False)

        s = "update DataSourceRestoreHistory "
        s = s + " set  FQN = (select 'EMAIL' from Email where Email.EmailGuid = DataSourceRestoreHistory.SourceGuid)"
        s = s + " where VerifiedData = 'N' and TypeContentCode = '.msg'  and DataSourceRestoreHistory.DataSourceOwnerUserID = '" + gCurrUserGuidID + "'"
        B = ExecuteSqlNewConn(s, False)

        s = "update DataSourceRestoreHistory "
        s = s + " set  FQN = (select 'EMAIL' from Email where Email.EmailGuid = DataSourceRestoreHistory.SourceGuid)"
        s = s + " where VerifiedData = 'N' and TypeContentCode = '.eml'  and DataSourceRestoreHistory.DataSourceOwnerUserID = '" + gCurrUserGuidID + "'"
        B = ExecuteSqlNewConn(s, False)

        s = " update DataSourceRestoreHistory "
        s = s + " set  VerifiedData = (select 'Y' from Email where Email.EmailGuid = DataSourceRestoreHistory.SourceGuid)"
        s = s + " where VerifiedData = 'N'  and TypeContentCode = '.msg' and DataSourceRestoreHistory.DataSourceOwnerUserID = '" + gCurrUserGuidID + "'"
        B = ExecuteSqlNewConn(s, False)

        s = " update DataSourceRestoreHistory "
        s = s + " set  VerifiedData = (select 'Y' from Email where Email.EmailGuid = DataSourceRestoreHistory.SourceGuid)"
        s = s + " where VerifiedData = 'N'  and TypeContentCode = '.eml' and DataSourceRestoreHistory.DataSourceOwnerUserID = '" + gCurrUserGuidID + "'"
        B = ExecuteSqlNewConn(s, False)

        s = " Update DataSourceRestoreHistory "
        s = s + " set  VerifiedData = (select 'Y' from DataSource where DataSource.SourceGuid = DataSourceRestoreHistory.SourceGuid)"
        s = s + " where VerifiedData = 'N'  and TypeContentCode <> '.msg' and DataSourceRestoreHistory.DataSourceOwnerUserID = '" + gCurrUserGuidID + "'"
        B = ExecuteSqlNewConn(s, False)

    End Sub

    Sub ArchiveQuickRefItems(ByVal UID As String, ByVal MachineID As String, ByVal SkipIfArchiveBitIsOn As Boolean,
                             ByVal rbPublic As Boolean,
                             ByVal rbPrivate As Boolean,
                             ByVal rbMstrYes As Boolean,
                             ByVal rbMstrNot As Boolean,
                             ByVal SB As TextBox,
                             ByVal MetadataTag As String,
                             ByVal MetadataValue As String,
                             ByVal LibraryName As String,
                             ByRef ZipFilesQuick As ArrayList)

        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Try
            If xDebug Then LOG.WriteToArchiveLog("clsArchiver:ArchiveQuickRefItems 100")

            Dim UserGuid As String = gCurrUserGuidID

            Dim S As String = ""
            S = S + " SELECT "
            S = S + " [FQN]"
            S = S + " ,[DataSourceOwnerUserID]"
            S = S + " ,[Author]"
            S = S + " ,[Description]"
            S = S + " ,[Keywords]"
            S = S + " ,[FileName]"
            S = S + " ,[DirName], [QuickRefItemGuid], MetadataTag, MetadataValue, Library "
            S = S + " FROM [QuickRefItems] "
            S = S + " where [DataSourceOwnerUserID] = '" + UserGuid + "' "

            Dim FQN As String = ""
            Dim DataSourceOwnerUserID As String = ""
            Dim Author As String = ""
            Dim Description As String = ""
            Dim Keywords As String = ""
            Dim FileName As String = ""
            Dim DirName As String = ""
            Dim sourceguid As String = ""
            Dim tMetadataTag As String = ""
            Dim tMetadataValue As String = ""
            Dim tLibraryName As String = ""
            Dim QuickRefItemGuid As String = ""

            If xDebug Then LOG.WriteToArchiveLog("clsArchiver:ArchiveQuickRefItems 200")

            Dim rsQuickArch As SqlDataReader = Nothing
            rsQuickArch = SqlQryNewConn(S)

            If xDebug Then LOG.WriteToArchiveLog("clsArchiver:ArchiveQuickRefItems 300")
            If rsQuickArch Is Nothing Then
                Return
            End If
            If rsQuickArch.HasRows Then
                Do While rsQuickArch.Read()
                    Try
                        FQN = rsQuickArch.GetValue(0).ToString
                        LOG.WriteToUploadLog("ArchiveQuickRefItems: File: " + FQN)
                        If xDebug Then LOG.WriteToArchiveLog("clsArchiver:ArchiveQuickRefItems 400" + FQN)
                        DataSourceOwnerUserID = rsQuickArch.GetValue(1).ToString
                        Author = rsQuickArch.GetValue(2).ToString
                        Description = rsQuickArch.GetValue(3).ToString
                        Keywords = rsQuickArch.GetValue(4).ToString
                        FileName = rsQuickArch.GetValue(5).ToString
                        DirName = rsQuickArch.GetValue(6).ToString
                        QuickRefItemGuid = rsQuickArch.GetValue(7).ToString
                        tMetadataTag = rsQuickArch.GetValue(8).ToString
                        tMetadataValue = rsQuickArch.GetValue(9).ToString
                        tLibraryName = rsQuickArch.GetValue(10).ToString

                        If MetadataTag.Trim.Length > 0 Then
                            tMetadataTag = MetadataTag
                        End If
                        If MetadataValue.Trim.Length > 0 Then
                            tMetadataValue = MetadataValue
                        End If
                        If LibraryName.Trim.Length > 0 Then
                            tLibraryName = LibraryName
                        End If

                        LibraryName = tLibraryName
                        MetadataValue = tMetadataValue
                        MetadataTag = tMetadataTag

                        'FrmMDIMain.SB.Text = DirName

                        FQN = UTIL.RemoveSingleQuotes(FQN)

                        If File.Exists(FQN) Then
                            If xDebug Then LOG.WriteToArchiveLog("clsArchiver:ArchiveQuickRefItems 500 File exists")

                            Dim bArch As Boolean = DMA.isArchiveBitOn(FQN)
                            'If SkipIfArchiveBitIsOn = False Then
                            '    If xDebug Then LOG.WriteToArchiveLog("clsArchiver:ArchiveQuickRefItems 600 archive bit on, processing anyway")
                            '    bArch = True
                            'End If
                            If bArch = False Then

                                ArchiveContent(MachineID, False, DataSourceOwnerUserID, FQN, Author, Description, Keywords, False)

                                sourceguid = getSourceGuidByFqn(FQN, UserGuid)
                                S = "Update [QuickRefItems] set [SourceGuid] = '" + sourceguid + "' where QuickRefItemGuid = '" + QuickRefItemGuid + "' "
                                TgtGuid = sourceguid
                                gTgtGuid = sourceguid
                                Dim BB As Boolean = ExecuteSqlNewConn(S, True)
                                gTgtGuid = ""

                                If Not BB Then
                                    LOG.WriteToArchiveLog("Notice update skipped on Quick Reference : '" + S + "'.")
                                Else

                                    UpdateDataSourceDesc(QuickRefItemGuid, sourceguid)
                                    UpdateDataSourceKeyWords(QuickRefItemGuid, sourceguid)
                                    'MetadataTag , MetadataValue , Library
                                    If MetadataTag.Trim.Length > 0 Then
                                        UpdateDataSourceMetadata(tMetadataTag, tMetadataValue, sourceguid)
                                    End If
                                    If LibraryName.Trim.Length > 0 Then
                                        UpdateDataSourceLibrary(tLibraryName, sourceguid)
                                    End If
                                    SetSourceGlobalAccessFlags(sourceguid, "SRC", rbPublic, rbPrivate, rbMstrYes, rbMstrNot, SB)
                                End If
                                'DMA.ToggleArchiveBit(FQN )
                                DMA.setArchiveBitOff(FQN)
                                If xDebug Then LOG.WriteToArchiveLog("clsArchiver:ArchiveQuickRefItems 800 processed: " + FQN)
                                'log.WriteToArchiveLog("Notice 5543.21.2b : clsArchiver:ArchiveQuickRefItems 800 processed: " + FQN )
                            End If
                        Else
                            'xTrace(102375, "File " + FQN + " does not exist on this machine.", "clsArchiver:ArchiveQuickRefItems")
                            '** DO NOTHING - The file has been removed from the machine.
                        End If
                    Catch ex As Exception
                        Console.WriteLine("Error: " + ex.Message)
                    End Try
                    Application.DoEvents()
                    If xDebug Then LOG.WriteToArchiveLog("clsArchiver:ArchiveQuickRefItems 900 Next file.")
                    If xDebug Then LOG.WriteToArchiveLog("--------------------------------------------------------------")
                Loop
            End If
            'FrmMDIMain.SB.Text = "Done..."
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR 5543.21.2a : ArchiveQuickRefItems - " + ex.Message)
            'FrmMDIMain.SB.Text = "Failed to capture Quick Archive Items, please check the log file."
        End Try

    End Sub

    Sub UpdateDataSourceDesc(ByVal QuickRefItemGuid As String, ByVal SourceGuid As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Dim S As String = "update DataSource set description = "
        S = S + " (select Description from [QuickRefItems] where [QuickRefItemGuid] = '" + QuickRefItemGuid + "')"
        S = S + " where SourceGuid = '" + SourceGuid + "'"

        TgtGuid = SourceGuid
        Dim B As Boolean = ExecuteSqlNewConn(S, True)

    End Sub

    Sub UpdateDataSourceKeyWords(ByVal QuickRefItemGuid As String, ByVal SourceGuid As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Dim S As String = "update DataSource set KeyWords = "
        S = S + " (select KeyWords from [QuickRefItems] where [QuickRefItemGuid] = '" + QuickRefItemGuid + "')"
        S = S + " where SourceGuid = '" + SourceGuid + "'"
        TgtGuid = SourceGuid
        Dim B As Boolean = ExecuteSqlNewConn(S, True)

    End Sub

    Sub UpdateDataSourceMetadata(ByVal Attribute As String, ByVal Attributevalue As String, ByVal SourceGuid As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Dim SRCATTR As New clsSOURCEATTRIBUTE

        Dim WC As String = ""
        Dim iCnt As Integer = 0
        Dim B As Boolean = False

        Dim Itemtitle As String = getFqnFromGuid(SourceGuid)
        Dim Itemtype As String = UTIL.getFileSuffix(Itemtitle)
        Dim Datasourceowneruserid As String = getOwnerGuid(SourceGuid)
        Itemtype = "." + Itemtype

        iCnt = SRCATTR.cnt_PK35(Attribute, gCurrUserGuidID, SourceGuid)
        If iCnt = 0 Then
            SRCATTR.setAttributename(Attribute)
            SRCATTR.setAttributevalue(Attributevalue)
            SRCATTR.setSourceguid(SourceGuid)
            SRCATTR.setDatasourceowneruserid(gCurrUserGuidID)
            SRCATTR.setSourcetypecode(Itemtype)
            B = SRCATTR.Insert()
            If Not B Then
                LOG.WriteToArchiveLog("clsArchiver:UpdateDataSourceMetadata - Failed to add metadata '" + Attribute + ":" + Attributevalue + " to '" + SourceGuid + "'.")
            End If
        Else
            SRCATTR.setAttributename(Attribute)
            SRCATTR.setAttributevalue(Attributevalue)
            SRCATTR.setSourceguid(SourceGuid)
            SRCATTR.setDatasourceowneruserid(gCurrUserGuidID)
            SRCATTR.setSourcetypecode(Itemtype)
            WC = SRCATTR.wc_PK35(Attribute, gCurrUserGuidID, SourceGuid)
            B = SRCATTR.Update(WC)
            If Not B Then
                LOG.WriteToArchiveLog("clsArchiver:UpdateDataSourceMetadata - Failed to UPDATE metadata '" + Attribute + ":" + Attributevalue + " to '" + SourceGuid + "'.")
            End If
        End If

        SRCATTR = Nothing

    End Sub

    Sub UpdateDataSourceLibrary(ByVal LibraryName As String, ByVal SourceGuid As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Dim LI As New clsLIBRARYITEMS

        Dim Libraryowneruserid As String = GetLibOwnerByName(LibraryName)
        Dim Itemtitle As String = getFqnFromGuid(SourceGuid)
        Dim Itemtype As String = UTIL.getFileSuffix(Itemtitle)
        Dim Datasourceowneruserid As String = getOwnerGuid(SourceGuid)
        Dim NewGuid As String = System.Guid.NewGuid.ToString()
        Itemtype = "." + Itemtype

        If Libraryowneruserid.Trim.Length = 0 Then
            LOG.WriteToArchiveLog("ERROR - clsArchiver:UpdateDataSourceLibrary: Could not find owner of library " + LibraryName + " - userd current user ID.")
            Libraryowneruserid = gCurrUserGuidID
        End If

        Dim WC As String = ""
        Dim iCnt As Integer = 0
        Dim B As Boolean = False

        iCnt = LI.cnt_UI_LibItems(LibraryName, SourceGuid)
        If iCnt = 0 Then
            LI.setAddedbyuserguidid(gCurrUserGuidID)
            LI.setDatasourceowneruserid(Datasourceowneruserid)
            LI.setItemtitle(Itemtitle)
            LI.setItemtype(Itemtype)
            LI.setLibraryitemguid(NewGuid)
            LI.setLibraryname(LibraryName)
            LI.setLibraryowneruserid(Libraryowneruserid)
            LI.setSourceguid(SourceGuid)
            B = LI.Insert
            If Not B Then
                LOG.WriteToArchiveLog("clsArchiver:UpdateDataSourceMetadata - Failed to add Library Items '" + LibraryName + ".")
            End If
        Else
            LI.setAddedbyuserguidid(gCurrUserGuidID)
            LI.setDatasourceowneruserid(Datasourceowneruserid)
            LI.setItemtitle(Itemtitle)
            LI.setItemtype(Itemtype)
            LI.setLibraryitemguid(NewGuid)
            LI.setLibraryname(LibraryName)
            LI.setLibraryowneruserid(Libraryowneruserid)
            LI.setSourceguid(SourceGuid)

            WC = LI.wc_UI_LibItems(LibraryName, SourceGuid)

            B = LI.Update(WC)
            If Not B Then
                LOG.WriteToArchiveLog("clsArchiver:UpdateDataSourceMetadata - Failed to UPDATE Library Items '" + LibraryName + "'.")
            End If
        End If

        LI = Nothing

    End Sub

    Public Sub ckSourceTypeCode(ByRef file_SourceTypeCode As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim bcnt As Integer = iGetRowCount("SourceType", "where SourceTypeCode = '" + file_SourceTypeCode + "'")
        Dim SubstituteFileType As String = getProcessFileAsExt(file_SourceTypeCode)

        If bcnt = 0 And SubstituteFileType = "" Then

            If SubstituteFileType = Nothing Then
                Dim MSG As String = "The file type '" + file_SourceTypeCode + "' is undefined." + vbCrLf + "DO YOU WISH TO AUTOMATICALLY DEFINE IT?" + vbCrLf + "This will allow content to be archived, but not searched."
                'Dim dlgRes As DialogResult = MessageBox.Show(MSG, "Filetype Undefined", MessageBoxButtons.YesNo)

                UNASGND.setApplied("0")
                UNASGND.setFiletype(file_SourceTypeCode)
                Dim iCnt As Integer = UNASGND.cnt_PK_AFTU(file_SourceTypeCode)
                If iCnt = 0 Then
                    UNASGND.Insert()
                End If

                Dim ST As New clsSOURCETYPE
                ST.setSourcetypecode(file_SourceTypeCode)
                ST.setSourcetypedesc("NO SEARCH - AUTO ADDED by Pgm")
                ST.setIndexable("0")
                ST.setStoreexternal(0)

                Dim B As Boolean = ST.Insert()
                If Not B Then
                    LOG.WriteToArchiveLog("clsArchiver : ckSourceTypeCode : 01")
                    LOG.WriteToArchiveLog("clsArchiver : ckSourceTypeCode : 02 : " + "ERROR: An unknown file '" + file_SourceTypeCode + "' type was NOT inserted.")
                End If
            Else
                file_SourceTypeCode = SubstituteFileType
            End If
        Else
            If SubstituteFileType.Trim.Length > 0 Then
                file_SourceTypeCode = SubstituteFileType
            End If
        End If

    End Sub

    '** WDM 7/6/2009
    '** This function is not used at this time.
    Sub ArchiveAllFolderContent(ByVal UID As String, ByVal MachineID As String, ByVal FolderName As String,
                                ByVal ckSkipIfArchBitTrue As Boolean,
                                ByVal VersionFiles As String,
                                ByVal EmailGuid As String, ByVal RetentionCode As String, ByVal isPublic As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim LastVerNbr As Integer = 0
        Dim NextVersionNbr As Integer = 0
        Dim CRC As String = ""
        Dim ImageHash As String = ""
        Dim OcrDirectory As String = "Y"
        Dim IncludeSubDirs As String = "N"
        Dim ckMetaData As String = "Y"

        Dim bAddThisFileAsNewVersion As Boolean = False

        If EmailGuid.Trim.Length > 0 Then
            VersionFiles = "Y"
        End If

        '** Designed to archive ALL files of ALL type contained within the passed in folder.
        If xDebug Then LOG.WriteToArchiveLog("clsArchiver: ArchiveFolderContent :8000 : trace log.")

        Dim rightNow As Date = Now
        Dim RetentionYears As Integer = Val(getSystemParm("RETENTION YEARS"))
        rightNow = rightNow.AddYears(RetentionYears)
        Dim RetentionExpirationDate As String = rightNow.ToString

        Dim ExpiryTime As Date = rightNow

        ZipFiles.Clear()
        Dim a(0) As String

        Dim ActiveFolders(0) As String
        Dim DeleteFile As Boolean = False

        'GetContentArchiveFileFolders(gCurrUserGuidID, ActiveFolders)

        ActiveFolders(0) = FolderName

        Dim cFolder As String = ""
        Dim pFolder As String = "XXX"
        Dim DirFiles As New List(Of String)

        If xDebug Then LOG.WriteToArchiveLog("clsArchiver: ArchiveFolderContent :8001 : trace log.")

        FilesBackedUp = 0
        FilesSkipped = 0

        Dim LibraryList As New List(Of String)

        For i As Integer = 0 To UBound(ActiveFolders)

            Dim FolderParmStr As String = ActiveFolders(i).ToString.Trim
            'Dim FolderParms() As String = FolderParmStr.Split("|")

            Dim FOLDER_FQN As String = FolderName

            If xDebug Then LOG.WriteToArchiveLog("clsArchiver: ArchiveFolderContent :8002 :FOLDER_FQN : " + FOLDER_FQN)

            If InStr(FOLDER_FQN, gTempDir + "", CompareMethod.Text) > 0 Then
                LOG.WriteToArchiveLog("XXX3234v here")
                Application.DoEvents()
            End If

            Dim FOLDER_IncludeSubDirs As String = "X"
            Dim FOLDER_DBID As String = "X"
            Dim FOLDER_VersionFiles As String = VersionFiles
            Dim DisableDir As String = "N"

            FOLDER_FQN = UTIL.RemoveSingleQuotes(FOLDER_FQN)

            If (Directory.Exists(FOLDER_FQN)) Then
                'FrmMDIMain.SB.Text = "Processing Dir: " + FOLDER_FQN
                If xDebug Then LOG.WriteToArchiveLog("clsArchiver: ArchiveFolderContent :8003 :FOLDER Exists: " + FOLDER_FQN)
                If xDebug Then LOG.WriteToArchiveLog("Archive Folder: " + FOLDER_FQN)
            Else
                'FrmMDIMain.SB.Text = FOLDER_FQN  + " does not exist, skipping."
                If xDebug Then LOG.WriteToArchiveLog("clsArchiver: ArchiveFolderContent :8004 :FOLDER DOES NOT Exist: " + FOLDER_FQN)
                If xDebug Then LOG.WriteToArchiveLog("Archive Folder FOUND MISSING: " + FOLDER_FQN)
                GoTo NextFolder
            End If
            If (DisableDir.Equals("Y")) Then
                GoTo NextFolder
            End If

            'GetIncludedFiletypes(FOLDER_FQN , IncludedTypes)
            'GetExcludedFiletypes(FOLDER_FQN , ExcludedTypes)
            If xDebug Then LOG.WriteToArchiveLog("clsArchiver: ArchiveFolderContent :8005 : Trace: " + FOLDER_FQN)
            Dim bChanged As Boolean = False

            If FOLDER_FQN <> pFolder Then

                Dim ParentDirForLib As String = ""
                Dim bLikToLib As Boolean = False
                bLikToLib = isDirInLibrary(FOLDER_FQN, ParentDirForLib)

                Dim iCount As Integer = Directory.GetFiles(FOLDER_FQN).Count
                If iCount = 0 Then
                    GoTo NextFolder
                End If

                If xDebug Then LOG.WriteToArchiveLog("clsArchiver: ArchiveFolderContent :8006 : Folder Changed: " + FOLDER_FQN + ", " + pFolder)
                FolderName = FOLDER_FQN
                Application.DoEvents()
                '** Verify that the DIR still exists
                If (Directory.Exists(FolderName)) Then
                    'FrmMDIMain.SB.Text = "Processing Dir: " + FolderName
                Else
                    'FrmMDIMain.SB.Text = FolderName + " does not exist, skipping."
                    LOG.WriteToArchiveLog("clsArchiver: ArchiveFolderContent :8007 : Folder DOES NOT EXIT: " + FOLDER_FQN)
                    GoTo NextFolder
                End If

                If bLikToLib Then
                    GetDirectoryLibraries(ParentDirForLib, LibraryList)
                Else
                    GetDirectoryLibraries(FOLDER_FQN, LibraryList)
                End If

                ''getDirectoryParms(a , FolderName, gCurrUserGuidID)
                ''Dim IncludeSubDirs  = a(0)
                '''Dim VersionFiles  = a(1)
                ''Dim ckMetaData  = a(2)
                ''OcrDirectory  = a(3)

                '** Get all of the files in this folder
                Try
                    DirFiles.Clear()
                    Dim ii As Integer = DMA.getFilesInDir(FOLDER_FQN, DirFiles, IncludedTypes, ExcludedTypes, ckSkipIfArchBitTrue)
                    If ii = 0 Then
                        If xDebug Then LOG.WriteToArchiveLog("Archive Folder HAD NO FILES: " + FOLDER_FQN)
                        GoTo NextFolder
                    End If
                    ckFilesNeedUpdate(DirFiles, ckSkipIfArchBitTrue)
                Catch ex As Exception
                    GoTo NextFolder
                End Try

                '** Process all of the files
                For K As Integer = 0 To DirFiles.Count - 1
                    Dim sDir As String = DirFiles(K)
                    sDir = DMA.getFileName(sDir)

                    frmNotify.lblFileSpec.Text = "Processing: " + sDir
                    frmNotify.Refresh()

                    ' [SourceGuid] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
                    ' [CreateDate] [datetime] NULL CONSTRAINT [CURRDATE_04012008185318003] DEFAULT
                    ' (getdate()), [SourceName] [nvarchar](254) COLLATE SQL_Latin1_General_CP1_CI_AS
                    ' NULL, [SourceImage] [image] NULL, [SourceTypeCode] [nvarchar](50) COLLATE
                    ' SQL_Latin1_General_CP1_CI_AS NOT NULL, [FQN] [nvarchar](254) COLLATE
                    ' SQL_Latin1_General_CP1_CI_AS NULL, [VersionNbr] [int] NULL CONSTRAINT
                    ' [DF_DataSource_VersionNbr] DEFAULT ((0)), [LastAccessDate] [datetime] NULL,
                    ' [FileLength] [int] NULL, [LastWriteTime] [datetime] NULL,

                    CRC = ""

                    Dim SourceGuid As String = getGuid()
                    Dim FileAttributes As String() = DirFiles(K).Split("|")
                    Dim file_FullName As String = FileAttributes(1)
                    Dim file_SourceName As String = FileAttributes(0)
                    Dim file_DirName As String = DMA.GetFilePath(file_FullName)

                    If xDebug Then LOG.WriteToArchiveLog("    File: " + file_SourceName)

                    Dim file_Length As String = FileAttributes(2)
                    If gMaxSize > 0 Then
                        If Val(file_Length) > gMaxSize Then
                            LOG.WriteToArchiveLog("Notice: file '" + file_FullName + "' exceed the allowed file upload size, skipped.")
                            GoTo NextFile
                        End If
                    End If

                    '**************************************************************************************************

                    Dim CrcHash As String = ENC.GenerateSHA512HashFromFile(FQN)
                    ImageHash = ENC.GenerateSHA512HashFromFile(FQN)

                    Dim AttachmentCode As String = "C"
                    Dim iDatasourceCnt As Integer = getCountDataSourceFiles(file_SourceName, CrcHash)
                    If (iDatasourceCnt = 0) Then
                        saveContentOwner(SourceGuid, gCurrUserGuidID, "C", file_DirName, gMachineID, gNetworkID)
                    End If

                    '**************************************************************************************************

                    If K = 0 Or K Mod 100 = 0 Then
                        If xDebug Then LOG.WriteToArchiveLog("clsArchiver: ArchiveFolderContent :8010 : Processing files in folder: " + file_SourceName)
                    End If

                    Dim bIsArchivedAlready As Boolean = DMA.isFileArchiveAttributeSet(file_FullName)

                    If bIsArchivedAlready = True And ckSkipIfArchBitTrue = True Then
                        If xDebug Then LOG.WriteToArchiveLog("File : " + file_FullName + " archive bit was found to set TRUE, skipped file.")
                        GoTo NextFile
                    End If

                    Dim file_SourceTypeCode As String = FileAttributes(3)
                    If file_SourceTypeCode.Equals(".msg") Then
                        LOG.WriteToArchiveLog("File : " + file_FullName + " was found to be a message file, skipped file.")

                        Dim DisplayMsg As String = "A message file was encounted in a backup directory." + vbCrLf
                        DisplayMsg = DisplayMsg + "It has been moved to the EMAIL Working directory." + vbCrLf
                        DisplayMsg = DisplayMsg + "To archive a MSG file, it must be imported into outlook." + vbCrLf
                        DisplayMsg = DisplayMsg + "This file has not been added to the CONTENT repository." + vbCrLf

                        frmHelp.MsgToDisplay = DisplayMsg
                        frmHelp.CallingScreenName = "ECM Archive"
                        frmHelp.CaptionName = "MSG File Encounted in Content Archive"
                        frmHelp.Timer1.Interval = 10000
                        frmHelp.Show()

                        Dim EmailWorkingDirectory As String = getWorkingDirectory(gCurrUserGuidID, "EMAIL WORKING DIRECTORY")
                        Dim EmailFQN = EmailWorkingDirectory + "\" + file_SourceName.Trim
                        Dim F As File
                        If File.Exists(EmailFQN) Then
                            Dim tMsg As String = "Email Encountered, already in EMAIL WORKING DIRECTORY: " + EmailFQN
                            LOG.WriteToArchiveLog(tMsg)
                            xTrace(965, "ArchiveFolderContent", tMsg)
                            FilesSkipped += 1
                        Else
                            File.Copy(file_FullName, EmailFQN)
                            Dim tMsg As String = "Email Encountered, copied to EMAIL WORKING DIRECTORY: " + EmailFQN
                            LOG.WriteToArchiveLog(tMsg)
                            xTrace(966, "ArchiveFolderContent", tMsg)
                            FilesSkipped += 1
                        End If
                        GoTo NextFile
                    End If
                    FixFileExtension(file_SourceTypeCode)
                    Dim file_LastAccessDate As String = FileAttributes(4)
                    Dim file_CreateDate As String = FileAttributes(5)
                    Dim file_LastWriteTime As String = FileAttributes(6)
                    Dim OriginalFileType As String = file_SourceTypeCode

                    If LCase(file_SourceTypeCode).Equals(".exe") Then
                        LOG.WriteToArchiveLog(file_FullName)
                    End If

                    Dim isZipFile As Boolean = ZF.isZipFile(file_FullName)
                    If isZipFile = True Then
                        Dim StackLevel As Integer = 0
                        Dim ListOfFiles As New Dictionary(Of String, Integer)
                        Dim ExistingParentZipGuid As String = GetGuidByFqn(file_FullName, 0)
                        If ExistingParentZipGuid.Length > 0 Then
                            'ZipFiles.Add(file_FullName .Trim + "|" + ExistingParentZipGuid)
                            DBLocal.addZipFile(file_FullName, ExistingParentZipGuid, False)
                            ZF.UploadZipFile(UID, MachineID, file_FullName, ExistingParentZipGuid, True, False, RetentionCode, isPublic, StackLevel, ListOfFiles)
                            DBLocal.updateFileArchiveInfoLastArchiveDate(file_FullName)
                        Else
                            'ZipFiles.Add(file_FullName .Trim + "|" + SourceGuid )
                            DBLocal.addZipFile(file_FullName, SourceGuid, False)
                            ZF.UploadZipFile(UID, MachineID, file_FullName, SourceGuid, True, False, RetentionCode, isPublic, StackLevel, ListOfFiles)
                            DBLocal.updateFileArchiveInfoLastArchiveDate(file_FullName)
                        End If
                        ListOfFiles = Nothing
                        GC.Collect()
                    End If
                    Application.DoEvents()
                    If Not isZipFile Then
                        Dim bExt As Boolean = isExtExcluded(file_SourceTypeCode, True)
                        If bExt Then
                            If xDebug Then LOG.WriteToArchiveLog("A file of type '" + file_SourceTypeCode + "' has been encountered and is defined as NOT allowable. It will NOT be stored in the repository.")
                            If xDebug Then LOG.WriteToArchiveLog(" ")
                            FilesSkipped += 1
                            GoTo NextFile
                        End If
                        '** See if the STAR is in the INCLUDE list, if so, all files are included
                        bExt = isExtIncluded(file_SourceTypeCode, False)
                        If Not bExt Then
                            If xDebug Then LOG.WriteToArchiveLog("A file of type '" + file_SourceTypeCode + "' has been encountered and is not defined as allowable. It will NOT be stored in the repository.")
                            If xDebug Then LOG.WriteToArchiveLog(" ")
                            FilesSkipped += 1
                            GoTo NextFile
                        End If
                    Else
                        If xDebug Then LOG.WriteToArchiveLog("clsArchiver: ArchiveFolderContent :8011 : Zip file encountered: " + file_SourceName)
                        If xDebug Then LOG.WriteToArchiveLog("File : " + file_FullName + " was found to be a ZIP file.")
                    End If

                    Dim SubstituteFileType As String = getProcessFileAsExt(file_SourceTypeCode)
                    Dim bcnt As Integer = iGetRowCount("SourceType", "where SourceTypeCode = '" + file_SourceTypeCode + "'")

                    If bcnt = 0 And SubstituteFileType = "" Then
                        If SubstituteFileType = Nothing Then
                            Dim MSG As String = "The file type '" + file_SourceTypeCode + "' is undefined." + vbCrLf + "DO YOU WISH TO AUTOMATICALLY DEFINE IT?" + vbCrLf + "This will allow content to be archived, but not searched."
                            'Dim dlgRes As DialogResult = MessageBox.Show(MSG, "Filetype Undefined", MessageBoxButtons.YesNo)

                            If xDebug Then LOG.WriteToArchiveLog(MSG)

                            UNASGND.setApplied("0")
                            UNASGND.setFiletype(file_SourceTypeCode)
                            Dim iCnt As Integer = UNASGND.cnt_PK_AFTU(file_SourceTypeCode)
                            If iCnt = 0 Then
                                UNASGND.Insert()
                            End If

                            Dim ST As New clsSOURCETYPE
                            ST.setSourcetypecode(file_SourceTypeCode)
                            ST.setSourcetypedesc("NO SEARCH - AUTO ADDED by Pgm")
                            ST.setIndexable("0")
                            ST.setStoreexternal(0)
                            ST.Insert()

                        ElseIf SubstituteFileType.Trim.Length > 0 Then
                            file_SourceTypeCode = SubstituteFileType
                        End If
                    ElseIf SubstituteFileType.Trim.Length > 0 Then
                        file_SourceTypeCode = SubstituteFileType
                    End If

                    Dim StoredExternally As String = "N"

                    Application.DoEvents()
                    '***********************************************************************'
                    '** New file
                    '***********************************************************************'
                    If iDatasourceCnt = 0 Then
                        Application.DoEvents()
                        AttachmentCode = "C"

                        Dim BB As Boolean = AddSourceToRepo(UID, MachineID, gNetworkID, SourceGuid, file_FullName, file_SourceName, file_SourceTypeCode, file_LastAccessDate, file_CreateDate, file_LastWriteTime, gCurrUserGuidID, LastVerNbr, RetentionCode, isPublic, CrcHash, file_DirName)
                        DBLocal.updateFileArchiveInfoLastArchiveDate(file_FullName)

                        If BB Then

                            'Dim VersionNbr As String = "0"
                            'Dim CRC As String = DMA.CalcCRC(file_FullName)
                            'addContentHashKey(SourceGuid, "0", file_CreateDate , file_FullName, OriginalFileType, file_Length , CRC, MachineID)

                            saveContentOwner(SourceGuid, gCurrUserGuidID, "C", FOLDER_FQN, MachineID, gNetworkID)

                            FilesBackedUp += 1
                            If xDebug Then LOG.WriteToArchiveLog("File : " + file_FullName + " was found to be NEW and was ADDED the repository.")
                            If xDebug Then LOG.WriteToArchiveLog("clsArchiver: AddSourceToRepo : Loading: 8012: " + file_SourceName)

                            Dim bIsImageFile As Boolean = isImageFile(file_FullName)

                            UpdateCurrArchiveStats(file_FullName, file_SourceTypeCode)

                            Dim sSql As String = "Update DataSource set RetentionExpirationDate = '" + RetentionExpirationDate + "' where SourceGuid = '" + SourceGuid + "'"
                            Dim bbExec As Boolean = ExecuteSqlNewConn(sSql, False)
                            If Not bbExec Then
                                LOG.WriteToArchiveLog("ERROR: 1234.99c")
                            End If
                        Else
                            FilesSkipped += 1
                            If xDebug Then LOG.WriteToArchiveLog("ERROR File 66921x: clsArchiver : " + file_FullName + " was found to be NEW and was NOT ADDED to the repository.")
                            LOG.WriteToArchiveLog("FAILED TO LOAD: " + file_FullName)
                            If xDebug Then LOG.WriteToArchiveLog("clsArchiver: AddSourceToRepo :FAILED TO LOAD: 8013b: " + file_SourceName)
                        End If

                        If Val(file_Length) > 1000000 Then
                            'FrmMDIMain.SB.Text = "Large file Load completed..."
                            ''FrmMDIMain.SB.Refresh()
                            ''DisplayActivity = False
                            ''If Not ActivityThread Is Nothing Then
                            ''    ActivityThread.Abort()
                            ''    ActivityThread = Nothing
                            ''End If
                            frmMain.PBx.Value = 0
                            Application.DoEvents()
                        End If
                        If BB Then
                            If xDebug Then LOG.WriteToArchiveLog("File : " + file_FullName + " metadata updated.")
                            If xDebug Then LOG.WriteToArchiveLog("clsArchiver: AddSourceToRepo :Success: 8014")
                            Application.DoEvents()
                            UpdateDocFqn(SourceGuid, file_FullName)
                            UpdateDocSize(SourceGuid, file_Length)
                            UpdateDocDir(SourceGuid, file_FullName)
                            UpdateDocOriginalFileType(SourceGuid, OriginalFileType)
                            UpdateZipFileIndicator(SourceGuid, isZipFile)

                            If EmailGuid.Trim.Length > 0 Then
                                'VersionFiles  = "Y"
                                UpdateEmailIndicator(SourceGuid, EmailGuid)
                            End If

                            Application.DoEvents()
                            If xDebug Then LOG.WriteToArchiveLog("clsArchiver: AddSourceToRepo :Success: 8015")
                            If Not isZipFile Then
                                'Dim TheFileIsArchived As Boolean = True
                                'DMA.setFileArchiveAttributeSet(file_FullName , TheFileIsArchived)
                                DMA.ToggleArchiveBit(file_FullName)
                            End If

                            UpdateDocCrc(SourceGuid, CrcHash)
                            InsertSrcAttrib(SourceGuid, "CRC", CrcHash, OriginalFileType)
                            InsertSrcAttrib(SourceGuid, "FILENAME", file_SourceName, OriginalFileType)
                            InsertSrcAttrib(SourceGuid, "CreateDate", file_CreateDate, OriginalFileType)
                            InsertSrcAttrib(SourceGuid, "FILESIZE", file_Length, OriginalFileType)
                            InsertSrcAttrib(SourceGuid, "ChangeDate", file_LastAccessDate, OriginalFileType)
                            InsertSrcAttrib(SourceGuid, "WriteDate", file_LastWriteTime, OriginalFileType)
                            If Not file_SourceTypeCode.Equals(OriginalFileType) Then
                                InsertSrcAttrib(SourceGuid, "IndexAs", file_LastWriteTime, file_SourceTypeCode)
                            End If
                            If EmailGuid.Trim.Length > 0 Then
                                'VersionFiles  = "Y"
                                InsertSrcAttrib(SourceGuid, "EMAIL_ATTACH", file_LastWriteTime, OriginalFileType)
                            End If

                            If xDebug Then LOG.WriteToArchiveLog("clsArchiver: AddSourceToRepo :Success: 8016")

                            If Val(file_Length) > 1000000000 Then
                                'FrmMDIMain.SB4.Text = "Extreme File: " + file_Length  + " bytes - standby"
                            ElseIf Val(file_Length) > 2000000 Then
                                'FrmMDIMain.SB4.Text = "Large File: " + file_Length  + " bytes"
                                ''FrmMDIMain.SB.Refresh()
                            End If

                            If InStr(file_SourceTypeCode, "wma", CompareMethod.Text) > 0 Or InStr(file_SourceTypeCode, "mp3", CompareMethod.Text) > 0 Then
                                Console.WriteLine("Recording here 06")
                            End If
                            If (LCase(file_SourceTypeCode).Equals(".mp3") Or LCase(file_SourceTypeCode).Equals(".wma") Or LCase(file_SourceTypeCode).Equals("wma")) Then
                                MP3.getRecordingMetaData(file_FullName, SourceGuid, file_SourceTypeCode)
                                Application.DoEvents()
                            ElseIf (LCase(file_SourceTypeCode).Equals(".tiff") Or LCase(file_SourceTypeCode).Equals(".jpg")) Then
                                '** This functionality will be added at a later time
                                'KAT.getXMPdata(file_FullName)
                                Application.DoEvents()
                            ElseIf (LCase(file_SourceTypeCode).Equals(".png") Or LCase(file_SourceTypeCode).Equals(".gif")) Then
                                '** This functionality will be added at a later time
                                'KAT.getXMPdata(file_FullName)
                                Application.DoEvents()
                            ElseIf LCase(file_SourceTypeCode).Equals(".wav") Then
                                MP3.getRecordingMetaData(file_FullName, SourceGuid, file_SourceTypeCode)
                            ElseIf LCase(file_SourceTypeCode).Equals(".tif") Then
                                '** This functionality will be added at a later time
                                'KAT.getXMPdata(file_FullName)
                                Application.DoEvents()
                            End If
                            Application.DoEvents()
                            If (LCase(file_SourceTypeCode).Equals(".doc") _
                                    Or LCase(file_SourceTypeCode).Equals(".docx")) _
                                    And ckMetaData.Equals("Y") Then
                                GetWordDocMetadata(file_FullName, SourceGuid, OriginalFileType)
                            End If
                            If (file_SourceTypeCode.Equals(".xls") _
                                        Or file_SourceTypeCode.Equals(".xlsx") _
                                        Or file_SourceTypeCode.Equals(".xlsm")) _
                                        And ckMetaData.Equals("Y") Then
                                GetExcelMetaData(file_FullName, SourceGuid, OriginalFileType)
                            End If
                        End If

                    End If
NextFile:
                    'Me.'FrmMDIMain.SB.Text = "Processing document #" + K.ToString
                    'FrmMDIMain.SB.Text = "Processing Dir: " + FolderName + " # " + K.ToString
                    If xDebug Then LOG.WriteToArchiveLog("clsArchiver: AddSourceToRepo :Success: 8032")
                    Application.DoEvents()
                    If xDebug Then LOG.WriteToArchiveLog("============== File : " + file_FullName + " Was processed as above.")
                Next
            Else
                If xDebug Then LOG.WriteToArchiveLog("Duplicate Folder: " + FolderName)
                If xDebug Then LOG.WriteToArchiveLog("clsArchiver: AddSourceToRepo :Success: 8034")
            End If
NextFolder:
            If xDebug Then LOG.WriteToArchiveLog("+++++++++++++++ Getting Next Folder")
            pFolder = FolderName
        Next
        If xDebug Then LOG.WriteToArchiveLog("@@@@@@@@@@@@@@  Done with FOLDER Archive.")

    End Sub

    Sub ProcessZipFilesX(ByVal UID As String, ByVal MachineID As String, ByVal ckSkipIfArchived As Boolean, ByVal bThisIsAnEmail As Boolean, ByVal RetentionCode As String, ByVal isPublic As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        For i As Integer = 0 To ZipFiles.Count - 1
            Dim cData As String = ZipFiles(i).ToString
            Dim ParentGuid As String = ""
            Dim FQN As String = ""
            Dim K As Integer = InStr(cData, "|")
            FQN = Mid(cData, 1, K - 1)
            ParentGuid = Mid(cData, K + 1)

            Dim StackLevel As Integer = 0
            Dim ListOfFiles As New Dictionary(Of String, Integer)
            ZF.UploadZipFile(UID, MachineID, FQN, ParentGuid, ckSkipIfArchived, bThisIsAnEmail, RetentionCode, isPublic, StackLevel, ListOfFiles)
            ListOfFiles = Nothing
            GC.Collect()
        Next
    End Sub

    Sub FixFileExtension(ByRef Extension As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Extension = Extension.Trim
        Extension = Extension.ToLower
        If InStr(1, Extension, ".") = 0 Then
            Extension = "." + Extension
        End If
        Do While InStr(1, Extension, ",") > 0
            Mid(Extension, InStr(1, Extension, ","), 1) = "."
        Loop
        Return
    End Sub

    Function isExtExcluded(ByVal fExt As String, ByVal ExcludeAll As Boolean) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        If ExcludeAll = False Then
            Return ExcludeAll
        End If

        fExt = UCase(fExt)
        If fExt.Length > 1 Then
            fExt = UCase(fExt)
            If Mid(fExt, 1, 1) = "." Then
                Mid(fExt, 1, 1) = " "
                fExt = fExt.Trim
            End If
        End If

        Dim B As Boolean = False
        For i As Integer = 0 To ExcludedTypes.Count - 1
            Dim tExtension As String = ExcludedTypes.Item(i).ToString
            If UCase(tExtension).Equals(UCase(fExt)) Then
                B = True
                Exit For
            ElseIf UCase(tExtension).Equals("*") Then
                B = True
                Exit For
            End If
        Next
        Return B

    End Function

    Function isExtIncluded(ByVal fExt As String, ByVal IncludeAll As Boolean) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        If IncludeAll = True Then
            Return IncludeAll
        End If

        fExt = UCase(fExt)
        If fExt.Length > 1 Then
            fExt = UCase(fExt)
            If Mid(fExt, 1, 1) = "." Then
                Mid(fExt, 1, 1) = " "
                fExt = fExt.Trim
            End If
        End If

        Dim B As Boolean = False
        For i As Integer = 0 To IncludedTypes.Count - 1
            Dim tExtension As String = IncludedTypes.Item(i).ToString
            If UCase(tExtension).Equals(UCase(fExt)) Then
                B = True
                Exit For
            ElseIf UCase(tExtension).Equals("*") Then
                B = True
                Exit For
            End If
        Next
        Return B

    End Function

    Sub UpdateSrcAttrib(ByVal SGUID As String, ByVal aName As String, ByVal aVal As String, ByVal SourceType As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Dim iCnt As Integer = SRCATTR.cnt_PK35(aName, gCurrUserGuidID, SGUID)
        If iCnt = 0 Then
            SRCATTR.setSourceguid(SGUID)
            SRCATTR.setAttributename(aName)
            SRCATTR.setAttributevalue(aVal)
            SRCATTR.setDatasourceowneruserid(gCurrUserGuidID)
            SRCATTR.setSourcetypecode(SourceType)
            SRCATTR.Insert()
        Else
            Dim WC As String = SRCATTR.wc_PK35(aName, gCurrUserGuidID, SGUID)
            SRCATTR.setSourceguid(SGUID)
            SRCATTR.setAttributename(aName)
            SRCATTR.setAttributevalue(aVal)
            SRCATTR.setDatasourceowneruserid(gCurrUserGuidID)
            SRCATTR.setSourcetypecode(SourceType)
            SRCATTR.Update(WC)
        End If

    End Sub

    Public Function OutlookFolderNames(ByVal MailboxName As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        '********************************************************
        'PARAMETER: MailboxName = Name of Parent Outlook Folder for
        'the current user: Usually in the form of
        '"Mailbox - Doe, John" or
        '"Public Folders
        'RETURNS: Array of SubFolders in Current User's Mailbox
        'Or unitialized array if error occurs
        'Because it returns an array, it is for VB6 only.
        'Change to return a variant or a delimited list for
        'previous versions of vb
        'EXAMPLE:
        'Dim sArray() As String
        'Dim ictr As Integer
        'sArray = OutlookFolderNames("Mailbox - Doe, John")
        '        'On Error Resume Next
        'For ictr = 0 To UBound(sArray)
        ' log.WriteToArchiveLog sArray(ictr)
        'Next
        '*********************************************************
        Dim oOutlook As Outlook.Application
        Dim oMAPI As Outlook._NameSpace
        Dim oParentFolder As Outlook.MAPIFolder
        Dim sArray() As String
        Dim i As Integer
        Dim iElement As Integer

        Try
            If xDebug Then LOG.WriteToArchiveLog("Entry OutlookFolderNames 001")
            oOutlook = New Outlook.Application()
            If xDebug Then LOG.WriteToArchiveLog("Entry OutlookFolderNames 002")
            oMAPI = oOutlook.GetNamespace("MAPI")
            If xDebug Then LOG.WriteToArchiveLog("Entry OutlookFolderNames 003")
            oParentFolder = oMAPI.Folders.Item(MailboxName)
            If xDebug Then LOG.WriteToArchiveLog("Entry OutlookFolderNames 004")

            ReDim Preserve sArray(0)
            frmMsg.Show()
            frmMsg.txtMsg.Text = "Loading Outlook Folders"
            If oParentFolder.Folders.Count <> 0 Then
                If xDebug Then LOG.WriteToArchiveLog("Found Outlook Folders 005 Start: Count = " + oParentFolder.Folders.Count.ToString + ".")
                For i = 1 To oParentFolder.Folders.Count

                    Application.DoEvents()
                    Try
                        Dim tName As String = oParentFolder.Folders.Item(i).Name.ToString
                        If xDebug Then LOG.WriteToArchiveLog("Entry OutlookFolderNames 005 Loop: " + tName + ".")
                        If tName.Trim.Length > 0 Then
                            If xDebug Then LOG.WriteToArchiveLog("Entry OutlookFolderNames 005a: " + tName + ".")
                            'If Trim(oMAPI.GetDefaultFolder(oParentFolder.olFolderInbox).Folders.Item(i).Name) <> "" Then
                            If tName <> "" Then
                                If xDebug Then LOG.WriteToArchiveLog("Entry OutlookFolderNames 005b: " + tName + ".")
                                If sArray(0) = "" Then
                                    If xDebug Then LOG.WriteToArchiveLog("Entry OutlookFolderNames 005c: " + tName + ".")
                                    iElement = 0
                                Else
                                    If xDebug Then LOG.WriteToArchiveLog("Entry OutlookFolderNames 005d: " + tName + ".")
                                    iElement = UBound(sArray) + 1
                                End If
                                If xDebug Then LOG.WriteToArchiveLog("Entry OutlookFolderNames 005e: " + tName + ".")
                                ReDim Preserve sArray(iElement)
                                If xDebug Then LOG.WriteToArchiveLog("Entry OutlookFolderNames 005f: " + tName + ".")
                                sArray(iElement) = oParentFolder.Folders.Item(i).Name
                                If xDebug Then LOG.WriteToArchiveLog("Entry OutlookFolderNames 005g: " + tName + ".")
                            End If
                        End If
                    Catch ex As Exception
                        LOG.WriteToArchiveLog("NOTICE:OutlookFolderNames 005x: Item #" + i.ToString + vbCrLf + ex.Message)
                    End Try
                Next i
            Else
                If xDebug Then LOG.WriteToArchiveLog("Entry OutlookFolderNames 006")
                sArray(0) = oParentFolder.Name
            End If
            If xDebug Then LOG.WriteToArchiveLog("Entry OutlookFolderNames 007")
            oMAPI = Nothing
        Catch ex As Exception
            LOG.WriteToArchiveLog("NOTICE 5692.13a OutlookFolderNames - Could not access Outlook. ")
            LOG.WriteToArchiveLog("NOTICE 5692.13b -" + ex.Message)
            LOG.WriteToArchiveLog("NOTICE 5692.13c -" + ex.StackTrace)
            frmMsg.Close()
            frmMsg.Hide()
            Return False
        End Try

        If xDebug Then LOG.WriteToArchiveLog("Entry OutlookFolderNames 008")
        frmMsg.Close()
        frmMsg.Hide()

        Return True

    End Function

    Sub ArchiveAllEmail(ByVal UID As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim PROC As New clsProcess

        Dim TopLevelOutlookFolder As String = ""

        If isArchiveDisabled("EMAIL") = True Then
            Return
        End If

        Dim ActiveEmailFolders As New ArrayList

        ActiveEmailFolders = getOutlookParentFolderNames()

        ActiveEmailFolders = getOutlookParentFolderNames()

        Dim LastEmailArchRunDate As Date = Now
        'getOutlookParentFolderNames(Me.cbParentFolders)
        Dim EmailFolder As String = ""
        For XX As Integer = 0 To ActiveEmailFolders.Count - 1

            EmailFolder = ActiveEmailFolders.Item(XX).ToString

            If EmailFolder.Trim.Length = 0 Then
                GoTo NextFolder
            End If

            ZeroizeEmailToDelete(gCurrUserGuidID)
            Dim subFoldersToProcessCnt As Integer = setActiveEmailFolders(EmailFolder, gCurrUserGuidID)
            If subFoldersToProcessCnt = 0 Then
                GoTo NextFolder
            End If
            '***************************************************************
            Dim bUseQuickSearch As Boolean = False
            Dim DBARCH As New clsDatabaseARCH
            Dim NbrOfIds As Integer = DBARCH.getCountStoreIdByFolder()
            Dim slStoreId As New SortedList
            If NbrOfIds <= 5000000 Then
                bUseQuickSearch = True
            Else
                bUseQuickSearch = False
            End If
            If bUseQuickSearch Then
                DBLocal.getCE_EmailIdentifiers(slStoreId)
            Else
                slStoreId.Clear()
            End If
            '***************************************************************

            ArchiveSelectedOutlookFolders(UID, EmailFolder, slStoreId)
            If xDebug Then LOG.WriteToArchiveLog("** Completed Processing folder: " + EmailFolder)
            '*********************************************************************************
            UserParmInsertUpdate("LastEmailArchRunDate", gCurrUserGuidID, LastEmailArchRunDate)

            'UpdateMessageStoreID(gCurrUserGuidID)
            Try
                DeleteOutlookMessages(gCurrUserGuidID)
            Catch ex As Exception
                LOG.WriteToArchiveLog("WARNING 2005.32.1 - call DEleteOutlookMessages failed.")
            End Try

            GC.Collect()

            PROC.getProcessesToKill()
            PROC.KillOrphanProcesses()
NextFolder:
        Next
        PROC = Nothing
    End Sub

    Sub SetNewPST(ByVal strFileName As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Dim objOL As Outlook.Application
        Dim objNS As Outlook.NameSpace
        Dim objFolder As Outlook.MAPIFolder

        objOL = CreateObject("Outlook.Application")
        objNS = objOL.GetNamespace("MAPI")
        objNS.AddStore(strFileName)
        objFolder = objNS.Folders.GetFirst
        Do While Not objFolder Is Nothing
            Console.WriteLine(objFolder.Name)
            'For i As Integer = 0 To objFolder.Items.Count - 1
            '    For Each EMAIL In
            '    Next
            '    objFolder = objNS.Folders.GetNext
        Loop

        objOL = Nothing
        objNS = Nothing
        objFolder = Nothing
    End Sub

    'Public Function AddLibraryItem(ByVal SourceGuid , ByVal ItemTitle , ByVal FileExt , ByVal LibraryName ) As Boolean

    ' ItemTitle = UTIL.RemoveSingleQuotes(ItemTitle ) LibraryName =
    ' UTIL.RemoveSingleQuotes(LibraryName )

    ' Dim LibraryOwnerUserID = gCurrUserGuidID Dim DataSourceOwnerUserID = gCurrUserGuidID Dim
    ' LibraryItemGuid = Guid.NewGuid.ToString Dim AddedByUserGuidId = gCurrUserGuidID

    ' Dim SS = "Select count(*) from LibraryItems where LibraryName = '" + LibraryName + "' and
    ' SourceGuid = '" + SourceGuid + "'" Dim iCnt As Integer = iCount(SS) If iCnt > 0 Then Return
    ' True End If

    ' Dim b As Boolean = False Dim s As String = "" s = s + " INSERT INTO LibraryItems(" s = s +
    ' "SourceGuid," s = s + "ItemTitle," s = s + "ItemType," s = s + "LibraryItemGuid," s = s +
    ' "DataSourceOwnerUserID," s = s + "LibraryOwnerUserID," s = s + "LibraryName," s = s +
    ' "AddedByUserGuidId) values (" s = s + "'" + SourceGuid + "'" + "," s = s + "'" + ItemTitle +
    ' "'" + "," s = s + "'" + FileExt + "'" + "," s = s + "'" + LibraryItemGuid + "'" + "," s = s +
    ' "'" + DataSourceOwnerUserID + "'" + "," s = s + "'" + LibraryOwnerUserID + "'" + "," s = s +
    ' "'" + LibraryName + "'" + "," s = s + "'" + AddedByUserGuidId + "'" + ")"
    ' Application.DoEvents() Return ExecuteSqlNewConn(s, False)

    'End Function

    Function ReduceDirByOne(ByVal DirName As String) As String
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim CH As String = ""
        Dim I As Integer = 0

        For I = DirName.Length To 1 Step -1
            CH = Mid(DirName, I, 1)
            If CH = "\" Then
                Return Mid(DirName, 1, I - 1)
            End If
        Next
        Return ""
    End Function

    Function SendHelpRequest(ByVal CompanyID As String, ByVal RequestorName As String, ByVal RequestorEmail As String, ByVal RequestorPhone As String, ByVal RequestDesc As String, ByVal FQN As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        ' Create an Outlook application. Create a new MailItem.
        Dim oApp As Outlook._Application
        oApp = New Outlook.Application()
        Dim oMsg As Outlook._MailItem
        Dim oAttach As Outlook.Attachment
        Dim oAttachs As Outlook.Attachments = Nothing

        Dim CCAddr As String = ""
        Dim HelpEmails As String = getHelpEmail()
        Dim Emails As String() = HelpEmails.Split("|")
        For I As Integer = 0 To UBound(Emails)
            If Emails(I).Trim.Length > 0 Then
                If InStr(Emails(I), "support@ecmlibrary", CompareMethod.Text) = 0 Then
                    CCAddr = CCAddr + "; " + Emails(I)
                End If
            End If
        Next
        Try
            If CCAddr.Trim.Length > 0 Then
                CCAddr = CCAddr.Trim
                If Mid(CCAddr, 1, 1).Equals(";") Then
                    Mid(CCAddr, 1, 1) = " "
                    CCAddr = CCAddr.Trim
                End If
            End If

            oMsg = oApp.CreateItem(Outlook.OlItemType.olMailItem)
            oMsg.Subject = "HELP Request"
            oMsg.Body = "From Name: " & RequestorName & vbCr & vbCr + "Phone Number: " & RequestorPhone & vbCr & vbCr + "Problem description: " & RequestDesc

            ' TODO: Replace with a valid e-mail address.
            oMsg.To = "support@EcmLibrary.com"

            oMsg.CC = CCAddr

            ' Add an attachment
            ' TODO: Replace with a valid attachment path.

            Dim sSource As String = FQN
            ' TODO: Replace with attachment name
            Dim sDisplayName As String = CompanyID + " : " + RequestorName

            Dim sBodyLen As String = RequestDesc.Length
            oAttachs = oMsg.Attachments
            oAttach = oAttachs.Add(sSource, , sBodyLen + 1, sDisplayName)

            ' Send
            oMsg.Send()

            Return True
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR SendHelpRequest 100 - " + ex.Message)
        Finally
            ' Clean up
            oApp = Nothing
            oMsg = Nothing
            oAttach = Nothing
            oAttachs = Nothing
        End Try

        Return False

    End Function

    Function ArchiveSingleFile(ByVal UID As String, ByVal FQN As String) As Boolean

        Dim B As Boolean = True

        Dim DOCS As New clsDataSource_V2
        Dim bSuccess As Boolean = True
        Dim RowData As New Dictionary(Of String, String)

        Dim BPS As Double = 0
        Dim CompressedSize As Integer = 0
        Dim ContainedWithin As String = ""
        Dim CRC As String = ""
        Dim CreateDate As DateTime = Now
        Dim CreationDate As DateTime = Now
        Dim DataSourceOwnerUserID As String = ""
        Dim DataVerified As Boolean = True
        Dim Description As String = ""
        Dim FileAttached As Boolean = True
        Dim FileDirectory As String = ""
        Dim FileDirectoryName As String = ""
        Dim FileLength As Integer = 0
        Dim FqnHASH As String = ""
        Dim GraphicContainsText As Char = ""
        Dim HashFile As String = ""
        Dim HashName As String = ""
        Dim HiveActive As Boolean = True
        Dim HiveConnectionName As String = ""
        Dim Imagehash As String = ""
        Dim ImageHiddenText As String = ""
        Dim ImageLen As Integer = 0
        Dim isAvailable As Char = ""
        Dim isContainedWithinZipFile As Char = ""
        Dim isGraphic As Char = ""
        Dim isMaster As Char = ""
        Dim isPerm As Char = ""
        Dim isPublic As Char = ""
        Dim IsPublicPreviousState As Char = ""
        Dim isWebPage As Char = ""
        Dim IsZipFile As Boolean = False
        Dim KeyWords As String = ""
        Dim LastAccessDate As DateTime = Now
        Dim LastWriteTime As DateTime = Now
        Dim MachineID As String = ""
        Dim Notes As String = ""
        Dim OcrPending As Char = ""
        Dim OcrPerformed As Char = ""
        Dim OcrSuccessful As Char = ""
        Dim OcrText As String = ""
        Dim OriginalFileType As String = ""
        Dim OriginalSize As Integer = 0
        Dim PageURL As String = ""
        Dim ParentGuid As String = ""
        Dim PdfImages As Integer = 0
        Dim PdfIsSearchable As Char = ""
        Dim PdfOcrRequired As Char = ""
        Dim PdfOcrSuccess As Char = ""
        Dim PdfOcrTextExtracted As Char = ""
        Dim PdfPages As Integer = 0
        Dim RecHash As String = ""
        Dim RecLen As Decimal = 0
        Dim RecTimeStamp As DateTime = Now
        Dim RepoName As String = ""
        Dim RepoSvrName As String = ""
        Dim RequireOcr As Boolean = True
        Dim RetentionCode As String = ""
        Dim RetentionDate As DateTime = Now
        'Dim RetentionExpirationDate As DateTime = Now
        Dim RowCreationDate As DateTime = Now
        Dim RowGuid As String = Guid.NewGuid.ToString
        Dim RowGuid2 As String = Guid.NewGuid.ToString
        Dim RowID As Integer = 0
        Dim RowLastModDate As DateTime = Now
        Dim RssLinkFlg As Boolean = True
        Dim RssLinkGuid As String = ""
        Dim SapData As Boolean = True
        Dim SharePoint As Boolean = True
        Dim SharePointDoc As Boolean = True
        Dim SharePointList As Boolean = True
        Dim SharePointListItem As Boolean = True
        Dim SourceGuid As String = Guid.NewGuid.ToString
        Dim SourceImage As Byte() = Nothing
        Dim SourceImageOrigin As String = ""
        Dim SourceName As String = ""
        Dim SourceTypeCode As String = ""
        Dim StructuredData As Boolean = True
        Dim TransmitTime As Decimal = 0
        Dim txEndTime As DateTime = Now
        Dim txStartTime As DateTime = Now
        Dim txTotalTime As Decimal = 0
        Dim URLHash As String = ""
        Dim UserID As String = ""
        Dim VersionNbr As Integer = 0
        Dim WebPagePublishDate As String = ""
        Dim ZipFileFQN As String = ""
        Dim ZipFileGuid As String = Guid.NewGuid.ToString

        Dim FI As New FileInfo(FQN)

        RowData.Add("RowGuid", RowGuid)
        RowData.Add("SourceGuid", SourceGuid)
        RowData.Add("CreateDate", FI.CreationTime.ToString)
        RowData.Add("SourceName", FI.Name)
        RowData.Add("SourceTypeCode", "")
        RowData.Add("FQN", FQN.ToString)
        RowData.Add("VersionNbr", VersionNbr.ToString)
        RowData.Add("LastAccessDate", FI.LastAccessTime.ToLongDateString)
        RowData.Add("FileLength", FI.Length)
        RowData.Add("LastWriteTime", FI.LastWriteTime.ToString)
        RowData.Add("UserID", gCurrLoginID)
        RowData.Add("DataSourceOwnerUserID", gCurrLoginID)
        RowData.Add("isPublic", isPublic.ToString)
        RowData.Add("FileDirectory", FI.DirectoryName)
        RowData.Add("OriginalFileType", FI.Extension)
        'RowData.Add("RetentionExpirationDate", RetentionExpirationDate.ToString)
        RowData.Add("IsPublicPreviousState", IsPublicPreviousState.ToString)
        RowData.Add("isAvailable", isAvailable.ToString)
        RowData.Add("isContainedWithinZipFile", isContainedWithinZipFile.ToString)
        RowData.Add("IsZipFile", IsZipFile.ToString)
        RowData.Add("DataVerified", DataVerified.ToString)

        If FI.Extension.ToLower.Equals(".zip") Then
            RowData.Add("ZipFileGuid", Guid.NewGuid.ToString)
            RowData.Add("ZipFileFQN", FI.FullName)
        Else
            RowData.Add("ZipFileGuid", "")
            RowData.Add("ZipFileFQN", "")
        End If

        Dim crchash As String = ENC.GenerateSHA512HashFromFile(FI.FullName)

        RowData.Add("Description", Description.ToString)
        RowData.Add("KeyWords", KeyWords.ToString)
        RowData.Add("Notes", Notes.ToString)
        RowData.Add("isPerm", isPerm.ToString)
        RowData.Add("isMaster", isMaster.ToString)
        RowData.Add("CreationDate", FI.CreationTime.ToString)
        RowData.Add("OcrPerformed", OcrPerformed.ToString)
        RowData.Add("isGraphic", isGraphic.ToString)
        RowData.Add("GraphicContainsText", GraphicContainsText.ToString)
        RowData.Add("OcrText", OcrText.ToString)
        RowData.Add("ImageHiddenText", ImageHiddenText.ToString)
        RowData.Add("isWebPage", isWebPage.ToString)
        RowData.Add("ParentGuid", ParentGuid.ToString)
        RowData.Add("RetentionCode", RetentionCode.ToString)
        RowData.Add("MachineID", Environment.MachineName)
        RowData.Add("CRC", ENC.GenerateSHA256HashFromFile(FI.FullName))
        RowData.Add("SharePoint", SharePoint.ToString)
        RowData.Add("SharePointDoc", SharePointDoc.ToString)
        RowData.Add("SharePointList", SharePointList.ToString)
        RowData.Add("SharePointListItem", SharePointListItem.ToString)
        RowData.Add("StructuredData", StructuredData.ToString)
        RowData.Add("HiveConnectionName", HiveConnectionName.ToString)
        RowData.Add("HiveActive", HiveActive.ToString)
        RowData.Add("RepoSvrName", RepoSvrName.ToString)
        RowData.Add("RowCreationDate", Now.ToLongDateString)
        RowData.Add("RowLastModDate", Now.ToLongDateString)
        RowData.Add("ContainedWithin", ContainedWithin.ToString)
        RowData.Add("RecLen", RecLen.ToString)
        RowData.Add("RecHash", RecHash.ToString)
        RowData.Add("OriginalSize", FI.Length.ToString)
        RowData.Add("CompressedSize", CompressedSize.ToString)
        RowData.Add("txStartTime", Now.ToLongDateString)
        RowData.Add("txEndTime", txEndTime.ToString)
        RowData.Add("txTotalTime", Now.ToLongDateString)
        RowData.Add("TransmitTime", TransmitTime.ToString)
        RowData.Add("FileAttached", FileAttached.ToString)
        RowData.Add("BPS", BPS.ToString)
        RowData.Add("RepoName", RepoName.ToString)
        RowData.Add("HashFile", HashFile.ToString)
        RowData.Add("HashName", ENC.SHA512SqlServerHash(FI.FullName.ToLower))
        RowData.Add("OcrSuccessful", OcrSuccessful.ToString)
        RowData.Add("OcrPending", OcrPending.ToString)
        RowData.Add("PdfIsSearchable", PdfIsSearchable.ToString)
        RowData.Add("PdfOcrRequired", PdfOcrRequired.ToString)
        RowData.Add("PdfOcrSuccess", PdfOcrSuccess.ToString)
        RowData.Add("PdfOcrTextExtracted", PdfOcrTextExtracted.ToString)
        RowData.Add("PdfPages", PdfPages.ToString)
        RowData.Add("PdfImages", PdfImages.ToString)
        RowData.Add("RequireOcr", RequireOcr.ToString)
        RowData.Add("RssLinkFlg", RssLinkFlg.ToString)
        RowData.Add("RssLinkGuid", RssLinkGuid.ToString)
        RowData.Add("PageURL", PageURL.ToString)
        RowData.Add("RetentionDate", RetentionDate.ToString)
        RowData.Add("URLHash", URLHash.ToString)
        RowData.Add("WebPagePublishDate", WebPagePublishDate.ToString)
        RowData.Add("SapData", SapData.ToString)
        'RowData.Add("RowID", RowID.ToString)
        RowData.Add("Imagehash", ENC.GenerateSHA256HashFromFile(FI.FullName))
        RowData.Add("ImageLen", FI.Length.ToString)
        RowData.Add("FileDirectoryName", FI.DirectoryName)
        RowData.Add("FqnHASH", FqnHASH.ToString)
        RowData.Add("SourceImageOrigin", SourceImageOrigin.ToString)
        RowData.Add("RecTimeStamp", RecTimeStamp.ToString)
        'RowData.Add("SourceImage", SourceImage.ToString)
        RowData.Add("RowGuid2", Guid.NewGuid.ToString)

        Dim Successful As Boolean = True

        RetentionCode = getRetentionCode(gCurrLoginID, FI.DirectoryName)
        Dim RetentionYears As Integer = getRetentionPeriod(RetentionCode)
        Dim rightNow As Date = Now
        If RetentionYears = 0 Then
            RetentionYears = Val(getSystemParm("RETENTION YEARS"))
        End If
        rightNow = rightNow.AddYears(RetentionYears)
        Dim RetentionExpirationDate As String = rightNow.ToString

        bSuccessExecution = DOCS.Insert(SourceGuid, Imagehash, RetentionYears, RetentionExpirationDate)

        If bSuccessExecution Then
            LOG.WriteToListenLog("ArchiveSingleFile : FILE added to repo 100: " + FI.FullName)
            Successful = True
            saveContentOwner(SourceGuid, gCurrUserGuidID, "C", FI.DirectoryName, MachineID, gNetworkID)

            'Dim WC  = DOCS.wc_UKI_Documents(SourceGuid)
            'DOCS.ImageUpdt_SourceImage(WC, fi.fullname)
            '****************************************************************************************************************************************************************************************************************
            bSuccessExecution = UpdateSourceImageInRepo(FI.FullName, UID, MachineID, SourceGuid, FI.LastWriteTime, FI.CreationTime, FI.LastWriteTime, 0, FI.FullName, RetentionCode, isPublic, crchash)
            '****************************************************************************************************************************************************************************************************************
            If Not bSuccessExecution Then
                Dim MySql As String = "Delete from DataSource where SourceGuid = '" + SourceGuid + "'"
                ExecuteSqlNewConn(90214, MySql)
                LOG.WriteToErrorLog("Unrecoverable Error - removed file '" + FI.FullName + "' from the repository.")

                Dim DisplayMsg As String = "A source file failed to load. Review ERROR log." + vbCrLf + FI.FullName
                frmHelp.MsgToDisplay = DisplayMsg
                frmHelp.CallingScreenName = "ECM Archive"
                frmHelp.CaptionName = "Fatal Load Error"
                frmHelp.Timer1.Interval = 10000
                frmHelp.Show()
            Else
                Dim DBARCH As New clsDatabaseARCH
                SourceImage = IO.File.ReadAllBytes(FI.FullName)
                Dim bGood As Boolean = DBARCH.UpdateSourceImage(SourceGuid, SourceImage)
                If bGood Then
                    LOG.WriteToListenLog("** Added source Image for :" + FI.FullName)
                Else
                    LOG.WriteToListenLog("ERROR: failed to add source Image for :" + FI.FullName)
                End If
                SourceImage = Nothing
                Successful = True
                DBARCH = Nothing
            End If

            If bSuccessExecution Then
                FilesBackedUp += 1
                FullyQualifiedName = UTIL.RemoveSingleQuotes(FI.FullName)
                UpdateDocCrc(SourceGuid, crchash)
                Dim bIsImageFile As Boolean = isImageFile(FI.FullName)
                UpdateCurrArchiveStats(FI.FullName, FI.Extension)
            Else
                FilesSkipped += 1
                LOG.WriteToArchiveLog("ERROR FAILED TO LOAD: " + FI.FullName)
            End If

            If bSuccessExecution Then
                Successful = True
                Application.DoEvents()
                UpdateDocFqn(SourceGuid, FI.FullName)
                UpdateDocSize(SourceGuid, FI.Length)
                UpdateDocDir(SourceGuid, FI.FullName)
                UpdateDocOriginalFileType(SourceGuid, OriginalFileType)
                UpdateZipFileIndicator(SourceGuid, IsZipFile)
                Application.DoEvents()
                If ddebug Then LOG.WriteToListenLog("ArchiveSingleFile : AddSourceToRepo :Success: 8015")
                If Not IsZipFile Then
                    'Dim TheFileIsArchived As Boolean = True
                    'DMA.setFileArchiveAttributeSet(fi.fullname , TheFileIsArchived)
                    DMA.setArchiveBitOff(FI.FullName)
                End If

                'delFileParms(SourceGuid )

                UpdateDocCrc(SourceGuid, crchash)

                '** Removed Attribution Classification by WDM 9/10/2009
                UpdateSrcAttrib(SourceGuid, "CRC", crchash, OriginalFileType)
                UpdateSrcAttrib(SourceGuid, "FILENAME", FI.FullName, OriginalFileType)
                UpdateSrcAttrib(SourceGuid, "CreateDate", FI.CreationTime, OriginalFileType)
                UpdateSrcAttrib(SourceGuid, "FILESIZE", FI.Length, OriginalFileType)
                UpdateSrcAttrib(SourceGuid, "ChangeDate", FI.LastWriteTime, OriginalFileType)
                UpdateSrcAttrib(SourceGuid, "WriteDate", FI.LastWriteTime, OriginalFileType)

                If (LCase(FI.Extension).Equals(".mp3") Or LCase(FI.Extension).Equals(".wma") Or LCase(FI.Extension).Equals("wma")) Then
                    MP3.getRecordingMetaData(FI.FullName, SourceGuid, FI.Extension)
                    Application.DoEvents()
                ElseIf (LCase(FI.Extension).Equals(".tiff") Or LCase(FI.Extension).Equals(".jpg")) Then
                    '** This functionality will be added at a later time
                    'KAT.getXMPdata(fi.fullname)
                    Application.DoEvents()
                ElseIf (LCase(FI.Extension).Equals(".png") Or LCase(FI.Extension).Equals(".gif")) Then
                    '** This functionality will be added at a later time
                    'KAT.getXMPdata(fi.fullname)
                    Application.DoEvents()
                    'ElseIf LCase(fi.Extension).Equals(".wav") Then
                    '    MP3.getRecordingMetaData(fi.fullname, SourceGuid, fi.Extension)
                ElseIf LCase(FI.Extension).Equals(".wma") Then
                    MP3.getRecordingMetaData(FI.FullName, SourceGuid, FI.Extension)
                ElseIf LCase(FI.Extension).Equals(".tif") Then
                    '** This functionality will be added at a later time
                    'KAT.getXMPdata(fi.fullname)
                    Application.DoEvents()
                End If
                Application.DoEvents()
                If (LCase(FI.Extension).Equals(".doc") Or LCase(FI.Extension).Equals(".docx")) Then
                    GetWordDocMetadata(FI.FullName, SourceGuid, OriginalFileType)
                    GC.Collect()
                End If
                If (FI.Extension.Equals(".xls") Or FI.Extension.Equals(".xlsx") Or FI.Extension.Equals(".xlsm")) Then
                    GetExcelMetaData(FI.FullName, SourceGuid, OriginalFileType)
                    GC.Collect()
                End If
            End If
NextFile:
            If Successful = True Then
                FQN = UTIL.RemoveSingleQuotes(FI.FullName)
                Dim tFqn As String = FI.FullName
                tFqn = UTIL.RemoveSingleQuotes(tFqn)
                S = ""      '" update DirectoryListenerFiles set Archived =  1 where DirGuid = '" + DirGuid + "' and MachineID = '" + MachineID + "' and sourceFile = '" + FQN + "' "
                DBLocal.MarkListenersProcessed(FQN)
            End If
            Application.DoEvents()

            FullyQualifiedName = UTIL.RemoveSingleQuotes(FI.FullName)

            If gTerminateImmediately Then
                DOCS = Nothing
                PROC = Nothing
                Return False
            End If

            If Successful = True Then
                LOG.WriteToListenLog("SUCCCESS: ArchiveSingleFile: 01 " + FI.DirectoryName + " \ " + FQN)
                Dim tFqn As String = FI.FullName
                tFqn = UTIL.RemoveSingleQuotes(tFqn)
                S = ""         ' " update DirectoryListenerFiles set Archived =  1 where DirGuid = '" + DirGuid + "' and MachineID = '" + MachineID + "' and sourceFile = '" + FQN + "' "
                S = "update [DirectoryListenerFiles] set Archived = 1 where sourcefile = '" + FI.FullName + "' and MachineName = '" + MachineID + "'"
                B = ExecuteSqlNewConn(90218, S)
                If Not B Then
                    LOG.WriteToListenLog("ERROR: ArchiveSingleFile: failed to archive: " + FI.DirectoryName + " \ " + FQN)
                End If
            End If
        Else
            If ddebug Then Debug.Print("Duplicate Folder: " + FI.DirectoryName)
            If ddebug Then LOG.WriteToListenLog("ArchiveSingleFile : AddSourceToRepo :Success: 8034")
        End If
NextFolder:

        If gTerminateImmediately Then
            DOCS = Nothing
            PROC = Nothing
            Return False
        End If
        If B = True Then
            LOG.WriteToListenLog("SUCCCESS: ArchiveSingleFile: 02 " + FI.DirectoryName + " \ " + FQN)
            FQN = UTIL.RemoveSingleQuotes(FQN)
            Dim tFqn As String = FI.DirectoryName + "\" + FQN
            tFqn = UTIL.RemoveSingleQuotes(tFqn)
            S = ""             ' " update DirectoryListenerFiles set Archived =  1 where DirGuid = '" + DirGuid + "' and MachineID = '" + MachineID + "' and sourceFile = '" + FQN + "' "
            S = "update [DirectoryListenerFiles] set Archived = 1 where sourcefile = '" + FQN + "' and MachineName = '" + MachineID + "'"
            B = ExecuteSqlNewConn(90219, S)
            If Not B Then
                LOG.WriteToListenLog("ERROR: ArchiveSingleFile: failed to archive: " + FI.DirectoryName + "\" + FQN)
            End If
        End If


        DOCS = Nothing
        PROC = Nothing
SKIPOUT:
        'If Successful = True Then
        '    Dim S  = " update DirectoryListenerFiles set Archived =  1 where DirGuid = '" + DirGuid + "' and MachineID = '" + MachineID + "' and sourceFile = '" + FQN + "' "
        '    Dim B As Boolean = ExecuteSqlNewConn(90220,S)
        '    If Not B Then
        '        LOG.WriteToListenLog("ERROR: ArchiveSingleFile: failed to archive: " + fi.DirectoryName + " \ " + FQN)
        '    End If
        'End If
        Return True
        frmNotify.lblPdgPages.Text = "*"
    End Function

    Function isDirInLibrary(ByVal DirFQN As String, ByRef ParentDirLibName As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim TgtLib As String = ""
        Dim TempDir As String = ""
        Dim SS As String = ""
        If DirFQN.Trim.Length > 2 Then
            If Mid(DirFQN, 1, 2) = "\\" Then
                SS = "\\"
            Else
                SS = ""
            End If
        End If

        Dim DirList As New List(Of String)
        Dim A As String() = DirFQN.Split("\")

        For I As Integer = 0 To UBound(A)
            TempDir = SS + TempDir + A(I)
            DirList.Add(TempDir)
            TempDir = TempDir + "\"
        Next

        For II As Integer = DirList.Count - 1 To 0 Step -1

            TempDir = DirList(II)
            TempDir = UTIL.RemoveSingleQuotes(TempDir)

            'Dim iCnt As Integer = iCount("Select COUNT(*) from LibDirectory where DirectoryName = '" + TempDir + "' and UserID = '" + gCurrUserGuidID + "'")
            Dim S As String = "Select COUNT(*) from LibDirectory where DirectoryName = '" + TempDir + "'"
            Dim iCnt As Integer = iCount(S)
            If iCnt > 0 Then
                ParentDirLibName = TempDir
                Return True
            End If
            TempDir = TempDir + "\"
        Next

        ParentDirLibName = ""
        Return False

    End Function

    Function ExtractWinmail(ByVal FQN As String, ByRef AttachedFiles As List(Of String)) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Try
            Dim iCnt As Integer = 0

            Dim AppPath As String = System.AppDomain.CurrentDomain.BaseDirectory()
            Dim WinMail As String = AppPath + "WINMAIL"
            Dim ConversionDir As String = LOG.getEnvVarSpecialFolderLocalApplicationData + "\WMCONVERT"

            If Not Directory.Exists(ConversionDir) Then
                Directory.CreateDirectory(ConversionDir)
            End If

            If Not File.Exists(FQN) Then
                Return False
            End If

            Dim P As New Process
            Process.Start(WinMail + "\wmopener.exe", Chr(34) + FQN + Chr(34) + " " + Chr(34) + ConversionDir + Chr(34))
            P.WaitForExit()

            'ShellandWait(WinMail, ConversionDir)

            getDirFiles(ConversionDir, AttachedFiles)

            If AttachedFiles.Count > 0 Then
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: ExtractWinmail - " + ex.Message)
        End Try

    End Function

    Public Sub ShellandWait(ByVal WinMail As String, ByVal ConversionDir As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim Executable As String = WinMail + "\wmopener.exe"

        Dim objProcess As System.Diagnostics.Process
        Try
            objProcess = New System.Diagnostics.Process()
            'objProcess.StartInfo.FileName = ProcessPath
            objProcess.StartInfo.WindowStyle = ProcessWindowStyle.Minimized
            System.Diagnostics.Process.Start(Executable, Chr(34) + FQN + Chr(34) + " " + Chr(34) + ConversionDir + Chr(34))

            'Wait until the process passes back an exit code
            objProcess.WaitForExit()

            'Free resources associated with this process
            objProcess.Close()
        Catch
            If gRunUnattended = False Then MessageBox.Show("Could not start process " & WinMail + "\wmopener.exe", "Error")
            LOG.WriteToArchiveLog("ERROR ShellandWait " + "Could not start process " & Executable)
        Finally
            objProcess = Nothing
        End Try
    End Sub

    Sub getDirFiles(ByVal dirFqn As String, ByRef AttachedFiles As List(Of String))
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Dim myFile As String = ""
        For Each myFile In Directory.GetFiles(dirFqn, "*.*")
            AttachedFiles.Add(myFile)
        Next
    End Sub

    Private Sub MoveItemsToFolder(ByVal oMsg As Outlook.MailItem)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Dim targetFolder As Outlook.Folder
        Dim oMAPI As Outlook._NameSpace

        Try
            targetFolder = oMAPI.GetFolderFromID(oHistoryEntryID, oHistoryStoreID)
            oMsg.Move(targetFolder)
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR MoveItemsToFolder 100 " + oMsg.Subject.ToString)
        Finally
            targetFolder = Nothing
            oMAPI = Nothing
        End Try

    End Sub

    ' If the folder doesn't exist, there will be an error in the next line. That error will cause the
    ' error handler to go to :handleError and skip the True return value
    Function HistoryFolderExists() As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim LL As Integer = 0

        Try
            Dim FolderName As String = "ECM_History" : LL = 1
            Dim oApp = New Outlook.Application : LL = 1
            Dim oNS As Outlook.NameSpace = oApp.GetNamespace("MAPI") : LL = 1
            Dim myInbox As Outlook.MAPIFolder = oNS.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderInbox) : LL = 1

            myInbox = myInbox.Folders(FolderName) : LL = 1

            oApp = Nothing
            oNS = Nothing
            myInbox = Nothing
        Catch ex As Exception
            LOG.WriteToArchiveLog("NOTICE: HistoryFolderExists - " + LL.ToString + " : " + ex.Message)
        End Try

    End Function

    Function MoveToHistoryFolder(ByVal oMsg As Outlook.MailItem) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim FolderName As String = "ECM_History"
        Dim currentMessage As Outlook.MailItem
        Dim errorReport As String

        Dim oApp = New Outlook.Application
        Dim oNS As Outlook.NameSpace = oApp.GetNamespace("MAPI")
        Dim myInbox As Outlook.MAPIFolder = oNS.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderInbox)

        Try
            oMsg.Move(myInbox.Folders(FolderName))
            LOG.WriteToArchiveLog("Notification: Moved email to history - Subject '" + oMsg.Subject + "' sent on " + oMsg.SentOn.ToString)
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR MoveToFolder 100 " + oMsg.Subject.ToString)
        Finally
            oApp = Nothing
            oNS = Nothing
            myInbox = Nothing
        End Try

    End Function

    Function getLastContactArchiveDate() As Date
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim LastWriteDate As Date = #1/1/1900#

        Try

            Dim cPath As String = LOG.getTempEnvironDir()
            Dim TempFolder As String = cPath + "\LastContactDate"

            If Directory.Exists(TempFolder) Then
            Else
                Directory.CreateDirectory(TempFolder)
            End If

            Dim FName As String = "LastContactArchiveDate.TXT"
            Dim FQN As String = TempFolder + "\" + FName

            If Not File.Exists(FQN) Then
                ' Create an instance of StreamWriter to write text to a file.
                Using sw As StreamWriter = New StreamWriter(FQN, False)
                    sw.WriteLine(LastWriteDate.ToString)
                    sw.Close()
                End Using
            Else
                Using SR As StreamReader = New StreamReader(FQN)
                    Dim sLastWriteDate As String = ""
                    sLastWriteDate = SR.ReadLine
                    LastWriteDate = CDate(sLastWriteDate)
                    SR.Close()
                End Using

            End If
        Catch ex As Exception
            If ddebug Then Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message)
            LastWriteDate = #1/1/1900#
        End Try
        Return LastWriteDate
    End Function

    Sub saveLastContactArchiveDate(ByVal LastArchiveDate As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Try

            Dim cPath As String = LOG.getTempEnvironDir()
            Dim TempFolder As String = cPath + "\LastContactDate"

            If Directory.Exists(TempFolder) Then
            Else
                Directory.CreateDirectory(TempFolder)
            End If

            Dim FName As String = "LastContactArchiveDate.TXT"
            Dim FQN As String = TempFolder + "\" + FName

            Using sw As StreamWriter = New StreamWriter(FQN, False)
                sw.WriteLine(LastArchiveDate)
                sw.Close()
            End Using
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR clsArchiver : Failed to save last Contact Archive Date: 688 : " + ex.Message)
        End Try

    End Sub

    Sub PullRssData(ByVal RssUrl As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim ds As New DataSet
        ds.ReadXml(RssUrl)

        Dim dgRss As DataGrid = Nothing
        'Dim ds As DataSet = New DataSet()
        'ds.ReadXml(RssUrl, XmlReadMode.Auto)

        'Put it in a datagrid
        dgRss.DataSource = ds.Tables(0)
        dgRss.Refresh()

        GC.Collect()

    End Sub

    Private Function SQLString(ByVal strSQL As String,
                ByVal intLength As Integer) As String
        strSQL = Replace(strSQL, "'", "''")
        If strSQL.Length > intLength Then
            strSQL = strSQL.Substring(0, intLength)
        End If
        Return strSQL
    End Function

    ''' <summary>
    ''' Gets a RSS feed.
    ''' </summary>
    ''' <param name="strURL">The URL of the RSS feed to be rchived.</param>
    Public Sub getRssFeed(ByVal strURL As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim client As New System.Net.WebClient
        Dim RssText As String = ""
        Dim rss As New Chilkat.Rss()

        Dim success As Boolean

        '  Download from the feed URL:
        'success = rss.DownloadRss("http://blog.chilkatsoft.com/?feed=rss2")
        success = rss.DownloadRss(strURL)
        If (success <> True) Then
            MsgBox(rss.LastErrorText)
            Exit Sub
        End If

        ' Get the 1st channel.
        Dim rssChannel As Chilkat.Rss

        rssChannel = rss.GetChannel(0)
        If (rssChannel Is Nothing) Then
            MsgBox("No channel found in RSS feed.")
            Exit Sub
        End If

        ' Display the various pieces of information about the channel:
        RssText = RssText & "Title: " & rssChannel.GetString("title") & vbCrLf
        RssText = RssText & "Link: " & rssChannel.GetString("link") & vbCrLf
        RssText = RssText & "Description: " _
             & rssChannel.GetString("description") & vbCrLf

        ' For each item in the channel, display the title, link, publish date, and categories
        ' assigned to the post.
        Dim numItems As Long
        numItems = rssChannel.NumItems
        Dim i As Long

        For i = 0 To numItems - 1

            Dim rssItem As Chilkat.Rss
            rssItem = rssChannel.GetItem(i)

            Dim sTitle As String = rssItem.GetString("title")
            Dim sLink As String = rssItem.GetString("link")
            Dim sPubDate As String = rssItem.GetString("pubDate")

            Console.WriteLine("sTitle: " + sTitle)
            Console.WriteLine("sLink: " + sLink)
            Console.WriteLine("sPubDate: " + sPubDate)

            Dim ScrappedData As String = client.DownloadString(sLink)
            'Console.WriteLine("ScrappedData: " + ScrappedData)

            Dim numCategories As Long
            numCategories = rssItem.GetCount("category")
            Dim j As Long
            If (numCategories > 0) Then
                For j = 0 To numCategories - 1
                    Dim SCategory As String = rssItem.MGetString("category", j)
                    Console.WriteLine("SCategory: " + SCategory)
                Next
            End If

        Next
    End Sub

    Public Sub spiderWeb(uriString As String, MaxUrlsToSpider As Integer, MaxOutboundLinks As Integer, isPublic As String, retentionCode As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim SpiderInfo As New frmNotify2
        SpiderInfo.Show()
        SpiderInfo.Text = "WEB Archiver"

        Dim spider As New Chilkat.Spider()

        Dim seenDomains As New Chilkat.StringArray()
        Dim seedUrls As New Chilkat.StringArray()

        Dim currProcessedUrl As String = ""
        Dim allProcessedUrl As String = ""

        Dim ParentSourceGuidSet As Boolean = False
        Dim ParentSourceGuid As String = ""
        Dim ChildSourceGuid As String = ""
        Dim WebpageTitle As String = ""
        Dim WebpageUrl As String = ""
        Dim WebPageFQN As String = ""

        seenDomains.Unique = True
        seedUrls.Unique = True

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

        Dim CacheDir As String = LOG.getEnvVarSpecialFolderApplicationData + "\SpiderCache".Replace("\\", "\")
        Dim WEBProcessingDir As String = System.Configuration.ConfigurationManager.AppSettings("WEBProcessingDir")

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

            ' Spider 5 URLs of this domain. but first, save the base domain in seenDomains
            Dim domain As String
            domain = spider.GetDomain(url)
            seenDomains.Append(spider.GetBaseDomain(domain))

            Dim i As Long
            Dim success As Boolean
            For i = 0 To MaxUrlsToSpider - 1
                success = spider.CrawlNext()
                If (success <> True) Then
                    Exit For
                End If

                ' Display the URL we just crawled.
                currProcessedUrl = spider.LastUrl
                allProcessedUrl += currProcessedUrl + " | "

                Application.DoEvents()
                Dim kw As String = spider.LastHtmlKeywords
                Dim LastModDate As String = spider.LastModDateStr
                If LastModDate.Length = 0 Then
                    LastModDate = "01/01/1970 12:01 AM"
                Else
                    Console.WriteLine(LastModDate)
                End If
                Dim LastDesc As String = spider.LastHtmlDescription
                Dim PageTitle As String = spider.LastHtmlTitle
                Dim FQN As String = domain + "@" + PageTitle + ".HTML"
                Dim WebFQN As String = ""
                Dim idx As Integer = currProcessedUrl.IndexOf("//")
                If idx > 0 Then
                    WebFQN = currProcessedUrl.Substring(idx + 2)
                End If
                Dim PageHtml As String = spider.LastHtml
                Dim iLen As Integer = PageHtml.Trim.Length

                SpiderInfo.lblEmailMsg.Text = domain
                SpiderInfo.lblMsg2.Text = currProcessedUrl
                Dim DBL As Double = iLen / 1000
                SpiderInfo.lblFolder.Text = "Size: " + DBL.ToString + " Kb - " + i.ToString + " of " + MaxUrlsToSpider.ToString
                SpiderInfo.Refresh()
                Application.DoEvents()

                If Directory.Exists(WEBProcessingDir) Then
                    Console.WriteLine(WEBProcessingDir + " created and ready.")
                Else
                    Directory.CreateDirectory(WEBProcessingDir)
                End If

                If iLen > 0 Then
                    WebFQN = ""
                    WebFQN = UTIL.ConvertUrlToFQN(WEBProcessingDir, currProcessedUrl, ".HTML") + WebFQN

                    Dim outfile As New StreamWriter(WebFQN, False)
                    outfile.Write(PageHtml)
                    outfile.Close()
                    outfile.Dispose()

                    If ChildSourceGuid.Trim.Length > 0 And Not ParentSourceGuidSet Then
                        ParentSourceGuid = ChildSourceGuid
                        ParentSourceGuidSet = True
                    End If

                    If isPublic.ToLower.Equals("true") Then
                        isPublic = "Y"
                    End If

                    ChildSourceGuid = ArchiveWebPage(ParentSourceGuid, PageTitle, currProcessedUrl, WebFQN, retentionCode, isPublic, CDate(LastModDate))

                    Try
                        File.Delete(FQN)
                    Catch ex As Exception
                        LOG.WriteToArchiveLog("DELETE FAILURE 06|" + FQN)
                        Console.WriteLine("Failed to delete 0C: " + FQN)
                    End Try

                End If

                ' If the last URL was retrieved from cache, we won't wait. Otherwise we'll wait 1
                ' second before fetching the next URL.
                If (spider.LastFromCache <> True) Then
                    spider.SleepMs(500)
                End If

            Next

            ' Add the outbound links to seedUrls, except for the domains we've already seen.
            For i = 0 To spider.NumOutboundLinks - 1
                url = spider.GetOutboundLink(i)
                domain = spider.GetDomain(url)
                Dim baseDomain As String
                baseDomain = spider.GetBaseDomain(domain)
                If (Not seenDomains.Contains(baseDomain)) Then
                    seedUrls.Append(url)
                End If

                ' Don't let our list of seedUrls grow too large.
                If (seedUrls.Count > MaxOutboundLinks) Then
                    Exit For
                End If
            Next

        End While

        SpiderInfo.Close()
        SpiderInfo = Nothing
        GC.Collect()
        GC.WaitForPendingFinalizers()

    End Sub

    Function ReadFileIntoString(FQN As String) As String
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim S As String = ""
        Dim tr As IO.TextReader = New IO.StreamReader(FQN)
        S = tr.ReadToEnd
        tr.Dispose()
        GC.Collect()
        GC.WaitForPendingFinalizers()
        Return S
    End Function

End Class