' ***********************************************************************
' Assembly         : EcmArchiver
' Author           : wdale
' Created          : 11-25-2020
'
' Last Modified By : wdale
' Last Modified On : 11-26-2020
' ***********************************************************************
' <copyright file="clsDbLocal.vb" company="ECM Library">
'     Copyright © ECM Library 2011, all rights reserved
' </copyright>
' <summary></summary>
' ***********************************************************************
Imports System.Configuration
Imports System.Data.SqlClient
Imports System.Data.SqlServerCe
Imports System.IO
Imports ECMEncryption
'Imports Microsoft.Data.Sqlite
Imports System.Data.SQLite

''' <summary>
''' Class clsDbLocal.
''' Implements the <see cref="System.IDisposable" />
''' </summary>
''' <seealso cref="System.IDisposable" />
Public Class clsDbLocal : Implements IDisposable

    ''' <summary>
    ''' The listerner connection
    ''' </summary>
    Public ListernerConn As New SQLiteConnection()

    ''' <summary>
    ''' The enc
    ''' </summary>
    Dim ENC As New ECMEncrypt
    ''' <summary>
    ''' The log
    ''' </summary>
    Dim LOG As New clsLogging

    ''' <summary>
    ''' The b sq lite c onnected
    ''' </summary>
    Public bSQLiteCOnnected As Boolean = False
    ''' <summary>
    ''' The sq lite connection
    ''' </summary>
    Public SQLiteCONN As New SQLiteConnection()

    ''' <summary>
    ''' The contact cs
    ''' </summary>
    Private ContactCS As String = ""
    ''' <summary>
    ''' The zip cs
    ''' </summary>
    Private ZipCS As String = ""
    ''' <summary>
    ''' The file cs
    ''' </summary>
    Private FileCS As String = ""
    ''' <summary>
    ''' The dir cs
    ''' </summary>
    Private DirCS As String = ""
    ''' <summary>
    ''' The inv cs
    ''' </summary>
    Private InvCS As String = ""
    ''' <summary>
    ''' The outlook cs
    ''' </summary>
    Private OutlookCS As String = ""
    ''' <summary>
    ''' The exchange cs
    ''' </summary>
    Private ExchangeCS As String = ""
    ''' <summary>
    ''' The listener cs
    ''' </summary>
    Private ListenerCS As String = ""
    ''' <summary>
    ''' The curr domain
    ''' </summary>
    Dim currDomain As AppDomain = AppDomain.CurrentDomain

    ''' <summary>
    ''' The sq lite listener database
    ''' </summary>
    Public SQLiteListenerDB As String = System.Configuration.ConfigurationManager.AppSettings("SQLiteListenerDB")
    ''' <summary>
    ''' The dir listener file path
    ''' </summary>
    Public DirListenerFilePath As String = System.Configuration.ConfigurationManager.AppSettings("DirListenerFilePath")

    ''' <summary>
    ''' Initializes a new instance of the <see cref="clsDbLocal"/> class.
    ''' </summary>
    Sub New()

        AddHandler currDomain.UnhandledException, AddressOf MYExnHandler
        AddHandler Application.ThreadException, AddressOf MYThreadHandler

        setSLConn()

    End Sub

    ''' <summary>
    ''' Res the inventory.
    ''' </summary>
    Sub ReInventory()

        Try
            Dim FRM As New frmNotify
            FRM.Show()
            FRM.Title = "RE-INVENTORY"
            Dim DictOfDirs As New Dictionary(Of String, String)

            Dim Arr() As String = Nothing
            Dim DB As New clsDatabaseARCH
            Dim aFolders As String() = Nothing
            Dim bUseArchiveBit = False
            Dim FI As FileInfo = Nothing
            Dim di As DirectoryInfo = Nothing
            Dim hash As String = ""
            Dim iCnt As Integer = 0
            Dim iTot As Integer = 0

            Dim DirName As String = ""
            Dim IncludeSubDirs As String = ""
            Dim DB_ID As String = ""
            Dim VersionFiles As String = ""
            Dim DisableFolder As String = ""
            Dim OcrDirectory As String = ""
            Dim RetentionCode As String = ""
            Dim DirID As Integer = 0
            Dim FileID As Integer = 0

            Dim EXT As String = ""
            Dim FQN As String = ""
            Dim FSize As Int64 = 0
            Dim LastWriteTime As DateTime = Nothing
            Dim CreationTime As DateTime = Nothing
            Dim B As Boolean = True
            Dim CurrDir As String = ""

            'WDM COMMENTED OUT Nov-01-2020
            'Dim AllowedExts As List(Of String) = DB.getUsersAllowedFileExt(gCurrUserGuidID)

            'truncateDirs()
            'truncateFiles()
            'truncateInventory()
            ''DBLocal.truncateOutlook()
            ''DBLocal.truncateExchange()
            ''DBLocal.truncateContacts()
            'truncateDirFiles()

            'aFolders(0) = FQN + "|" + IncludeSubDirs + "|" + DB_ID + "|" + VersionFiles + "|" + DisableFolder + "|" + OcrDirectory + "|" + RetentionCode
            'DB.GetContentArchiveFileFolders(gCurrLoginID, aFolders)
            DictOfDirs = DB.GetUserDirectories(gCurrLoginID)
            Dim ExtCnt As Integer = 0
            Dim LastIdx As Integer = 0
            Dim DirWhereInClause As New Dictionary(Of String, String)
            Dim DictDirID As New Dictionary(Of String, Integer)
            Dim WC As String = ""

            For Each DKey As String In DictOfDirs.Keys
                addDir(DKey, bUseArchiveBit)
                DirID = GetDirID(DKey)
                DictDirID.Add(DKey, DirID)
                'WDM Commented out the below 11-02-2020 The day before we DUMP TRUMP
                'WC = DB.getIncludedFileTypeWhereIn(gCurrLoginID, DKey)
                'If WC.Length > 0 Then
                '    If Not DirWhereInClause.Keys.Contains(DKey) Then
                '        DirWhereInClause.Add(DKey, WC)
                '    End If
                'End If
            Next

            Dim DictOfWC As New Dictionary(Of String, String)
            DictOfWC = DB.getIncludedFileTypeWhereIn(gCurrLoginID)

            For Each str As String In DictOfDirs.Keys
                Try
                    DirName = str
                    '********************************
                    'WDM Commented out 11-02-2020 Reight before we cast trump into a lake of fire and brimstone
                    'WC = DirWhereInClause(str)
                    WC = getAllowedExtension(str, 0, DictOfWC)
                    '********************************
                    If Directory.Exists(DirName) Then
                        IncludeSubDirs = DictOfDirs(str)
                        Application.DoEvents()

                        ExtCnt = 0
                        LastIdx = 0

                        '** WDM Commented out Nov-01-2020
                        'addDir(DirName, bUseArchiveBit)
                        'DirID = GetDirID(DirName)

                        DirID = DictDirID(str)

                        If IncludeSubDirs.ToUpper.Equals("Y") Then
                            iCnt = 0
                            di = New DirectoryInfo(DirName)
                            For Each FI In di.GetFiles("*", SearchOption.AllDirectories)
                                Try
                                    iCnt += 1
                                    FQN = FI.FullName
                                    FSize = FI.Length
                                    LastWriteTime = FI.LastWriteTime
                                    CreationTime = FI.CreationTime
                                    EXT = FI.Extension.ToLower
                                    CurrDir = FI.DirectoryName
                                    FRM.Label1.Text = CurrDir

                                    If Not FQN.Contains(".git") And Not FQN.Contains("\git\") Then
                                        If WC.Contains(EXT + ",") Then
                                            FRM.lblPdgPages.Text = FI.Name + " @ " + FI.Length.ToString()
                                            FRM.lblFileSpec.Text = iCnt.ToString
                                            hash = ENC.SHA512SqlServerHash(FI.FullName.ToLower)
                                            B = addFile(FI.Name, hash)
                                            FileID = GetFileID(FI.Name, hash)
                                            'hash = ENC.SHA512SqlServerHash(FI.FullName)
                                            B = addInventory(DirID, FileID, FI.Length, LastWriteTime, False, hash)
                                        End If
                                    Else
                                        Console.Write("*")
                                    End If
                                Catch ex As Exception
                                    LOG.WriteToArchiveLog("ERROR 01 Reinventory: " + ex.Message)
                                End Try

                                Application.DoEvents()
                            Next
                        Else
                            di = New DirectoryInfo(DirName)
                            For Each FI In di.GetFiles("*.*", SearchOption.TopDirectoryOnly)
                                Try
                                    iCnt += 1
                                    FQN = FI.FullName
                                    FSize = FI.Length
                                    LastWriteTime = FI.LastWriteTime
                                    CreationTime = FI.CreationTime
                                    EXT = FI.Extension
                                    If Not FQN.Contains(".git") And Not FQN.Contains("\git\") Then
                                        CurrDir = FI.DirectoryName
                                        FRM.Label1.Text = CurrDir
                                        If WC.Contains(EXT + ",") Then
                                            FRM.lblPdgPages.Text = FI.Name + " @ " + FI.Length.ToString()
                                            FRM.lblFileSpec.Text = iCnt.ToString
                                            hash = ENC.SHA512SqlServerHash(FI.FullName.ToLower)
                                            B = addFile(FI.Name, hash)
                                            FileID = GetFileID(FI.Name, hash)
                                            'hash = ENC.SHA512SqlServerHash(FI.FullName)
                                            B = addInventory(DirID, FileID, FI.Length, LastWriteTime, False, hash)
                                        End If
                                    Else
                                        Console.WriteLine("-")
                                    End If
                                Catch ex As Exception
                                    LOG.WriteToArchiveLog("ERROR 02 Reinventory: " + ex.Message)
                                End Try
                            Next
                            Application.DoEvents()
                        End If
                    Else
                        LOG.WriteToArchiveLog("ERROR Missing Directory on this machine: " + DirName)
                    End If
                Catch ex As Exception
                    LOG.WriteToArchiveLog("ERROR X03 Reinventory: " + ex.Message)
                End Try
            Next

            FRM.Close()
            FRM = Nothing
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR 00 Reinventory: " + ex.Message)
        End Try
    End Sub

    ''' <summary>
    ''' Gets the allowed extension.
    ''' </summary>
    ''' <param name="DirName">Name of the dir.</param>
    ''' <param name="Level">The level.</param>
    ''' <param name="tDict">The t dictionary.</param>
    ''' <returns>System.String.</returns>
    Public Function getAllowedExtension(DirName As String, Level As Integer, tDict As Dictionary(Of String, String)) As String

        DirName = DirName.ToLower

        Dim TempDir As String = DirName
        Dim FoundIt As Boolean = False
        Dim WC As String = ""
        Dim iLoc As Integer = 0

        Try
            Do While Not FoundIt And TempDir.Length >= 3
                If tDict.Keys.Contains(TempDir) Then
                    FoundIt = True
                    WC = tDict(TempDir)
                    Exit Do
                Else
                    iLoc = TempDir.LastIndexOf("\")
                    TempDir = TempDir.Substring(0, iLoc)
                End If
            Loop
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR getAllowedExtension: Level = " + Level.ToString + Environment.NewLine + ex.Message)
        End Try

        Return WC

    End Function

    ''' <summary>
    ''' Gets the allowed extension.
    ''' </summary>
    ''' <param name="DirName">Name of the dir.</param>
    ''' <param name="Level">The level.</param>
    ''' <returns>List(Of System.String).</returns>
    Public Function getAllowedExtension(DirName As String, Level As Integer) As List(Of String)

        Dim DB As New clsDatabaseARCH
        Dim L As New List(Of String)
        Dim LB As New ListBox

        DB.LoadIncludedFileTypes(LB, gCurrLoginID, DirName)

        For Each strext As String In LB.Items
            If Not L.Contains(strext) Then
                L.Add(strext)
            End If
        Next

        LB = Nothing
        DB.Dispose()

        If L.Count.Equals(0) Then
            Level += 1
            Dim I As Integer = DirName.LastIndexOf("\")
            DirName = DirName.Substring(0, I)
            If DirName.Length < 4 Then
                Return L
            End If
            L = getAllowedExtension(DirName, Level)
        End If

        Return L

    End Function

    ''' <summary>
    ''' Gets the allowed extension.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getAllowedExtension() As String

        Dim DB As New clsDatabaseARCH
        Dim EXTS As String = ""
        Dim LB As New ListBox
        Dim AR() As String = Nothing

        EXTS = DB.GetIncludedFiletypesByUserID(gCurrLoginID)

        Return EXTS

    End Function


    ''' <summary>
    ''' Cks the listenerfile processed.
    ''' </summary>
    ''' <param name="ListenerFileName">Name of the listener file.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function ckListenerfileProcessed(ListenerFileName As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim bProcessed As Boolean = False
        Dim S As String = "Select count(*) from ProcessedListenerFiles where ListenerFileName = '" + ListenerFileName + "' "
        Dim iCnt As Integer = 0
        Dim bConnSet As Boolean = False

        bConnSet = setListenerConn()

        Using CMD As New SQLiteCommand(S, ListernerConn)
            CMD.CommandText = S
            Dim rdr As SQLiteDataReader = CMD.ExecuteReader()
            Using rdr
                While (rdr.Read())
                    iCnt = rdr.GetInt32(0)
                End While
            End Using
        End Using

        If iCnt > 0 Then
            B = True
        Else
            B = False
        End If


        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return bProcessed

    End Function

    ''' <summary>
    ''' Gets the listenerf top dir.
    ''' </summary>
    ''' <returns>List(Of System.String).</returns>
    Public Function getListenerfTopDir() As List(Of String)

        bConnSet = setListenerConn()

        Dim FilesToProcess As New List(Of String)
        Dim sql As String = "select FQN from FileNeedProcessing limit 1 ;"
        Dim FQN As String = ""
        Dim DirName As String = ""
        Dim i As Integer = 0

        Using CMD As New SQLiteCommand(sql, ListernerConn)
            CMD.CommandText = sql
            Dim rdr As SQLiteDataReader = CMD.ExecuteReader()
            Using rdr
                While (rdr.Read())
                    FQN = rdr.GetValue(0).ToString()
                    DirName = Path.GetDirectoryName(FQN)
                    If Not FilesToProcess.Contains(DirName) Then
                        FilesToProcess.Add(DirName)
                        Exit While
                    End If
                End While
            End Using
        End Using

        If FilesToProcess.Count.Equals(0) Then
            FilesToProcess.Add("C:\temp")
        End If


        Return FilesToProcess
    End Function

    ''' <summary>
    ''' Gets the listenerfiles.
    ''' </summary>
    ''' <returns>List(Of System.String).</returns>
    Public Function getListenerfiles() As List(Of String)

        Dim FilesToProcess As New List(Of String)
        Dim DB As New clsDatabaseARCH
        Dim FRM As New frmNotify
        FRM.Show()
        FRM.Title = "Getting LISTENER Files"
        FRM.Text = "Getting LISTENER Files"
        Dim SQL As String = ""
        Dim ListenerDIR As String = ""

        Dim LConn As New SQLiteConnection()
        Dim cs As String = ""

        Try
            cs = "data source=" + SQLiteListenerDB
            LConn.ConnectionString = cs
            LConn.Open()

            SQL = "select distinct FQN, ListenerDIR from FileNeedProcessing where FileApplied = 0 order by FQN ;"
            Dim FQN As String = ""
            Dim ext As String = ""
            Dim DIR As String = ""
            Dim AllowedExts As List(Of String) = Nothing
            'C:\Users\wdale\Documents\Outlook Files
            Dim ExtCnt As Integer = 0
            Dim LastIdx As Integer = 0
            Dim Len As Int64 = 0
            Dim Level As Int64 = 0

            Dim DictOfExtensions As New Dictionary(Of String, String)
            DictOfExtensions = DB.getIncludedFileTypeWhereIn(gCurrLoginID)
            'LOG.WriteToArchiveLog("REMOVE LATER 3029 getListenerfiles: DictOfExtensions cnt = " + DictOfExtensions.Count.ToString)

            Dim SpecificDirExts As String = ""
            Dim DirExts As String = ""
            DirExts = getAllowedExtension()

            Using CMD As New SQLiteCommand(SQL, LConn)
                CMD.CommandText = SQL
                Dim iCnt As Integer = 0
                Dim rdr As SQLiteDataReader = CMD.ExecuteReader()
                Using rdr
                    'LOG.WriteToArchiveLog("REMOVE LATER 3030 getListenerfiles: opening reader")
                    While (rdr.Read())
                        iCnt += 1

                        FQN = rdr.GetValue(0).ToString()
                        ListenerDIR = rdr.GetValue(1).ToString()
                        FRM.lblFileSpec.Text = iCnt.ToString

                        'LOG.WriteToArchiveLog("REMOVE LATER 3010: getListenerfiles FQN: <" + FQN + ">")

                        If Not FQN.Contains("\.git") Then
                            Try
                                Dim FI As New FileInfo(FQN)
                                ext = FI.Extension
                                DIR = FI.DirectoryName
                                Len = FI.Length

                                Dim WC As String = ""
                                Dim wcMethod As Integer = 1

                                WC = gWhereInDict(ListenerDIR)

                                If WC.Length <= 2 Then
                                    GetParentWC(Level, DIR, gWhereInDict, WC)
                                End If

                                WC = WC.Replace("'", "")

                                If WC.Length.Equals(0) Then
                                    WC = DirExts
                                End If

                                If ext.Length > 0 Then
                                    'WDM Commented Out the below Nov-02-2020 (day before we get rid of trump)
                                    'AllowedExts = getAllowedExtension(DIR, 0)
                                    'DirExts = getAllowedExtension(DIR, 0, DictOfExtensions)
                                    If WC.Contains(ext.ToLower + ",") Then
                                        If Not FilesToProcess.Contains(FQN) Then
                                            FRM.lblPdgPages.Text = "Processing: " + FQN
                                            'LOG.WriteToArchiveLog("REMOVE LATER 650.4 getListenerfiles Processing = <" + FQN + ">")
                                            FilesToProcess.Add(FQN)
                                        Else
                                            'LOG.WriteToArchiveLog("REMOVE LATER 650.5 getListenerfiles SKIPPING = <" + FQN + ">")
                                        End If
                                    Else
                                        Dim xmsg As String = ""
                                        xmsg = "NOTICE: Looking for extension <" + ext + "> And did Not find it." + Environment.NewLine
                                    End If
                                End If
                            Catch ex As Exception
                                LOG.WriteToArchiveLog("Error getListenerFiles 02: " + ex.Message)
                            End Try
                        End If
                        FRM.Refresh()
                        Application.DoEvents()

                    End While
                End Using
            End Using
        Catch ex As Exception
            LOG.WriteToArchiveLog("error getListenerfiles 00: " + ex.Message)
        End Try

        FRM.Close()
        FRM.Dispose()
        'LOG.WriteToArchiveLog("REMOVE LATER 3010A: getListenerfiles FilesToProcess: " + FilesToProcess.Count.ToString + environment.NewLine + SQL)
        Return FilesToProcess
    End Function

    ''' <summary>
    ''' Gets WhereIN clause from the the parent dirtectory.
    ''' </summary>
    ''' <param name="Level">The level.</param>
    ''' <param name="path">The path.</param>
    ''' <param name="DirsOfWC">The dirs of wc.</param>
    ''' <param name="WC">The wc.</param>
    Sub GetParentWC(Level As Integer, path As String, DirsOfWC As Dictionary(Of String, String), ByRef WC As String)

        If DirsOfWC.Keys.Contains(path) Then
            WC = DirsOfWC(path)
        End If
        Try
            If WC.Length.Equals(0) Then
                Dim DirectoryInfo As DirectoryInfo = Directory.GetParent(path)
                If DirsOfWC.Keys.Contains(DirectoryInfo.FullName.ToLower) Then
                    WC = DirsOfWC(path)
                Else
                    Level += 1
                    Dim DI As DirectoryInfo = Directory.GetParent(path)
                    Dim NewPath As String = DI.FullName
                    GetParentWC(Level, NewPath, DirsOfWC, WC)
                End If
            End If
        Catch ex As Exception
            System.Console.WriteLine("Path: " + path + Environment.NewLine + ex.Message)
        End Try
    End Sub


    ''' <summary>
    ''' Gets the listenerfiles identifier.
    ''' </summary>
    ''' <returns>List(Of System.String).</returns>
    Public Function getListenerfilesID() As List(Of String)

        Dim LConn As New SQLiteConnection()
        cs = "data source=" + SQLiteListenerDB
        LConn.ConnectionString = cs
        LConn.Open()

        Dim FilesToProcess As New List(Of String)
        Dim sql As String = "select RowID from FileNeedProcessing where FileApplied = 0 ;"
        Dim id As String = ""

        Using LConn
            Using CMD As New SQLiteCommand(sql, LConn)
                CMD.CommandText = sql
                Dim rdr As SQLiteDataReader = CMD.ExecuteReader()
                Using rdr
                    While (rdr.Read())
                        id = rdr.GetValue(0).ToString
                        If Not FilesToProcess.Contains(id) Then
                            FilesToProcess.Add(id)
                        End If
                    End While
                End Using
            End Using
        End Using

        Return FilesToProcess
    End Function

    ''' <summary>
    ''' Sets the listenerfile processed.
    ''' </summary>
    ''' <param name="FQN">The FQN.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function setListenerfileProcessed(FQN As String) As Boolean

        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        FQN = FQN.Replace("''", "'")
        FQN = FQN.Replace("'", "''")

        Dim bProcessed As Boolean = False
        Dim S As String = "update FileNeedProcessing set FileApplied = 1 where FQN = '" + FQN + "'  ; "
        Dim iCnt As Integer = 0
        Dim bConnSet As Boolean = False

        bConnSet = setListenerConn()

        Dim CMD As New SQLiteCommand(S, ListernerConn)
        Try
            CMD.ExecuteNonQuery()
            bConnSet = True
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/setListenerfileProcessed 04 - " + ex.Message + Environment.NewLine + S)
            bConnSet = False
        Finally
            CMD.Dispose()
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try
        Return bConnSet
    End Function

    ''' <summary>
    ''' Removes the listenerfile processed.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function removeListenerfileProcessed() As Boolean

        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim B As Boolean = True
        Dim bProcessed As Boolean = False
        Dim S As String = "delete from FileNeedProcessing where FileApplied = 1 ; "
        Dim iCnt As Integer = 0
        Dim bConnSet As Boolean = False

        bConnSet = setListenerConn()

        Dim CMD As New SQLiteCommand(S, ListernerConn)
        Try
            CMD.ExecuteNonQuery()
            B = True
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/setListenerfileProcessed 04 - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

    End Function

    ''' <summary>
    ''' Removes the listenerfile processed.
    ''' </summary>
    ''' <param name="RowIDs">The row i ds.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function removeListenerfileProcessed(RowIDs As List(Of String)) As Boolean

        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        If RowIDs.Count.Equals(0) Then
            Return True
        End If

        Dim b As Boolean = True
        Dim WC As String = "("

        For Each ii As String In RowIDs
            WC += ii + ","
        Next
        WC = WC.Substring(0, WC.Length - 1) + ")"
        WC += " OR FileApplied= 1"

        Dim bProcessed As Boolean = False
        Dim S As String = "delete from FileNeedProcessing where RowID in " + WC
        'Dim S As String = "delete from FileNeedProcessing where FileApplied= 1"
        Dim iCnt As Integer = 0
        Dim bConnSet As Boolean = False

        bConnSet = setListenerConn()

        Dim CMD As New SQLiteCommand(S, ListernerConn)
        Try
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/removeListenerfileProcessed 8 - " + ex.Message + Environment.NewLine + S)
            b = False
        Finally
            CMD.Dispose()
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        Return b

    End Function

    ''' <summary>
    ''' Listeners the remove processed.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function ListenerRemoveProcessed() As Boolean

        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim bProcessed As Boolean = False
        Dim S As String = "delete from DirListener where FileCanBeDropped=1;"
        Dim iCnt As Integer = 0
        Dim bConnSet As Boolean = False

        bConnSet = setListenerConn()
        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/setListenerfileProcessed 04 - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

    End Function

    ''' <summary>
    ''' Recursives the search.
    ''' </summary>
    ''' <param name="strDirectory">The string directory.</param>
    ''' <param name="array">The array.</param>
    Private Sub RecursiveSearch(ByRef strDirectory As String, ByRef array As ArrayList)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim dirInfo As New IO.DirectoryInfo(strDirectory)
        ' Try to get the files for this directory
        Dim pFileInfo() As IO.FileInfo
        Try
            pFileInfo = dirInfo.GetFiles("*.sdf")
        Catch ex As UnauthorizedAccessException
            MessageBox.Show(ex.Message, "Exception!", MessageBoxButtons.OK, MessageBoxIcon.Error)
            Exit Sub
        End Try
        ' Add the file infos to the array
        array.AddRange(pFileInfo)
        If pFileInfo.Length > 0 Then
            For i As Integer = 0 To array.Count - 1
                Dim S As String = array(i).ToString
                If InStr(S, ":") > 0 Then
                Else
                    array(i) = strDirectory + "\" + array(i).ToString
                End If
            Next
        End If

        ' Try to get the subdirectories of this one
        Dim pdirInfo() As IO.DirectoryInfo
        Try
            pdirInfo = dirInfo.GetDirectories()
        Catch ex As UnauthorizedAccessException
            MessageBox.Show(ex.Message, "Exception!", MessageBoxButtons.OK, MessageBoxIcon.Error)
            Exit Sub
        End Try
        ' Iterate through each directory and recurse!
        Dim dirIter As IO.DirectoryInfo
        For Each dirIter In pdirInfo
            RecursiveSearch(dirIter.FullName, array)
        Next dirIter
    End Sub

    ''' <summary>
    ''' Allows an object to try to free resources and perform other cleanup operations before it is reclaimed by garbage collection.
    ''' </summary>
    Protected Overloads Overrides Sub Finalize()
        MyBase.Finalize()
        'If gTraceFunctionCalls.Equals(1) Then
        '    LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        'End If

        If Not IsNothing(SQLiteCONN) Then
            Try
                If SQLiteCONN.State = ConnectionState.Open Then
                    SQLiteCONN.Close()
                End If
                Try
                    SQLiteCONN.Dispose()
                Catch ex As Exception
                    Console.WriteLine("INFO: SQLiteConn Dispose" + ex.Message)
                    LOG.WriteToArchiveLog("INFO QA1: SQLiteConn Dispose" + ex.Message)
                End Try
            Catch ex As Exception
                If Not ex.Message.Contains("Cannot access a disposed object") Then
                    LOG.WriteToArchiveLog("NOTICE: SQLiteConn closed" + ex.Message)
                    'Else
                    '    Console.WriteLine("INFO: SQLiteConn Dispose" + ex.Message)
                End If
            End Try
        End If

    End Sub 'Finalize

    ''' <summary>
    ''' Inventories the dir.
    ''' </summary>
    ''' <param name="DirName">Name of the dir.</param>
    ''' <param name="bUseArchiveBit">if set to <c>true</c> [b use archive bit].</param>
    Sub InventoryDir(ByVal DirName As String, ByVal bUseArchiveBit As Boolean)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim B As Boolean = True
        Dim DirID As Integer = GetDirID(DirName)
        If DirID < 0 Then
            B = addDir(DirName, bUseArchiveBit)
            If Not B Then
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/InventoryDir - Failed to inventory directory '" + DirName + "'.")
            End If
        End If

    End Sub

    ''' <summary>
    ''' Inventories the file.
    ''' </summary>
    ''' <param name="FileName">Name of the file.</param>
    ''' <param name="FileHash">The file hash.</param>
    Sub InventoryFile(ByVal FileName As String, FileHash As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim B As Boolean = True
        Dim FileID As Integer = GetFileID(FileName, FileHash)
        If FileID < 0 Then
            B = addFile(FileName, FileHash)
            If Not B Then
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/InventoryDir - Failed to inventory file '" + FileName + "'.")
            End If
        End If

    End Sub

    ''' <summary>
    ''' Gets the dir identifier.
    ''' </summary>
    ''' <param name="DirName">Name of the dir.</param>
    ''' <returns>System.Int32.</returns>
    Function GetDirID(ByVal DirName As String) As Integer
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        If DirName.Contains("'") Then
            DirName = DirName.Replace("'", "''")
        End If

        Dim DirID As Integer = -1
        Dim S As String = "Select DirID from Directory where DirName = '" + DirName + "' "
        'Dim cn As New SqlCeConnection(DirCS)

        setSLConn()

        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 01: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If


        Dim CMD As SQLiteCommand = SQLiteCONN.CreateCommand()
        Try

            CMD.CommandText = S

            '** if you don’t set the result set to scrollable HasRows does not work
            'Dim rs As SqlCeResultSet = CMD.ExecuteReader()
            Dim rs As SQLiteDataReader = CMD.ExecuteReader()

            If rs.HasRows Then
                rs.Read()
                DirID = rs.GetInt32(0)
            Else
                DirID = -1
            End If

            If Not rs.IsClosed Then
                rs.Close()
            End If
            rs.Dispose()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR XX1: clsDbLocal/GetDirID - " + ex.Message + Environment.NewLine + S)
            DirID = -1
        Finally
            CMD.Dispose()
            'If cn IsNot Nothing Then
            '    If cn.State = ConnectionState.Open Then
            '        cn.Close()
            '    End If
            '    cn.Dispose()
            'End If
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return DirID

    End Function

    ''' <summary>
    ''' Gets the dir identifier.
    ''' </summary>
    ''' <param name="DirName">Name of the dir.</param>
    ''' <param name="UseArchiveBit">if set to <c>true</c> [use archive bit].</param>
    ''' <returns>System.Int32.</returns>
    Function GetDirID(ByVal DirName As String, ByRef UseArchiveBit As Boolean) As Integer

        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        UseArchiveBit = False
        Dim DirID As Integer = -1
        Dim S As String = "Select DirID,UseArchiveBit from Directory where DirName = '" + DirName + "' "

        Try
            If bSQLiteCOnnected.Equals(False) Then
                If Not setSLConn() Then
                    MessageBox.Show("NOTICE 02: The Local DB failed to open.: " + gLocalDBCS)
                    Return 0
                End If
            End If

            Dim CMD As New SQLiteCommand(S, SQLiteCONN)
            CMD.CommandType = CommandType.Text

            '** if you don’t set the result set to scrollable HasRows does not work
            Dim rs As SQLiteDataReader = CMD.ExecuteReader()

            If rs.HasRows Then
                rs.Read()
                DirID = CInt(rs.GetValue("DirID"))
                UseArchiveBit = rs.GetBoolean("UseArchiveBit")
            Else
                UseArchiveBit = False
                DirID = -1
            End If

            If Not rs.IsClosed Then
                rs.Close()
            End If
            rs.Dispose()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR XX2: clsDbLocal/GetDirID - " + ex.Message + Environment.NewLine + S)
            DirID = -1
        Finally

            'If cn IsNot Nothing Then
            '    If cn.State = ConnectionState.Open Then
            '        cn.Close()
            '    End If
            '    cn.Dispose()
            'End If
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return DirID

    End Function

    ''' <summary>
    ''' Adds the dir.
    ''' </summary>
    ''' <param name="FQN">The FQN.</param>
    ''' <param name="bUseArchiveBit">if set to <c>true</c> [b use archive bit].</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function addDir(ByVal FQN As String, ByVal bUseArchiveBit As Boolean) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        setSLConn()
        Dim B As Boolean = True
        Dim UseArchiveBit As Integer = 0
        If bUseArchiveBit Then
            UseArchiveBit = 1
        End If

        If FQN.Contains("'") Then
            FQN = FQN.Replace("'", "''")
        End If

        Dim S As String = "insert or ignore into Directory (DirName,UseArchiveBit) values ('" + FQN + "', " + UseArchiveBit.ToString + ") "
        'Dim S As String = "insert or ignore into Directory (DirName,UseArchiveBit) values (@DirName, @UseArchiveBit) "

        'Dim cn As New SqlCeConnection(DirCS)

        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 03: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If

        Dim DirHash As String = ENC.SHA512String(FQN)

        Dim CMD As SQLiteCommand = SQLiteCONN.CreateCommand()
        'CMD.CommandText = "insert or ignore into directory (DirName,UseArchiveBit,DirID) values (@DirName,@UseArchiveBit,@DirHash) "
        'CMD.CommandText = "insert or ignore into directory (DirName,UseArchiveBit,DirHash) values (?,?,?) "
        CMD.CommandText = "insert or ignore into directory (DirName,UseArchiveBit,DirHash) values ('" + FQN + "'," + UseArchiveBit.ToString + ", '" + DirHash + "') "

        Try
            'CMD.Parameters.AddWithValue("DirName", FQN)
            'CMD.Parameters.AddWithValue("UseArchiveBit", UseArchiveBit)
            'CMD.Parameters.AddWithValue("DirHash", DirHash)
            CMD.ExecuteNonQuery()

        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/addDir - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        Return B

    End Function

    ''' <summary>
    ''' Resets the extension.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function resetExtension() As Boolean

        Dim B As Boolean = True

        Try
            Dim SLConn As New SQLiteConnection()
            Dim S As String = "update Exts set Validated = 0"
            Dim slDatabase = System.Configuration.ConfigurationManager.AppSettings("SQLiteListenerDB")

            If Not File.Exists(slDatabase) Then
                MessageBox.Show("FATAL ERR SQLite DB MISSING: " + slDatabase)
            End If

            Dim ConnStr As String = "data source=" + slDatabase

            Using SLConn

                SLConn.ConnectionString = ConnStr
                SLConn.Open()

                Dim CMD As New SQLiteCommand(S, SLConn)
                Using CMD
                    Try
                        CMD.CommandText = S
                        CMD.ExecuteNonQuery()
                    Catch ex As Exception
                        LOG.WriteToArchiveLog("ERROR 01: clsDbLocal/resetExtension 01 - " + ex.Message + Environment.NewLine + S)
                        B = False
                    End Try
                End Using
            End Using
            B = True
        Catch ex As Exception
            B = False
            LOG.WriteToArchiveLog("ERROR 01: clsDbLocal/resetExtension 02 - " + ex.Message)
        End Try

        Return B

    End Function

    ''' <summary>
    ''' Adds the extension.
    ''' </summary>
    ''' <param name="AllowedExts">The allowed exts.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function addExtension(AllowedExts As List(Of String)) As Boolean

        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim WC As String = "("
        Dim WhereNotIN As String = "where Extension not in "
        Dim WhereIN As String = "where Extension in "
        Dim B As Boolean = True
        Dim S As String = ""
        Dim ext As String = ""

        For Each xt As String In AllowedExts
            WC += "'" + xt + "',"
        Next

        WC = WC.Substring(0, WC.Length - 1)
        WC = WC.Trim + ")"
        WhereNotIN += WC
        WhereIN += WC

        bConnSet = setListenerConn()

        If bConnSet.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 04: The Listener DB failed to open.: " + ListenerCS)
                Return 0
            End If
        End If

        Dim CMD As SQLiteCommand = ListernerConn.CreateCommand()
        Using CMD
            Try
                CMD.CommandText = "delete from Exts " + WhereNotIN
                CMD.ExecuteNonQuery()
                For Each xt As String In AllowedExts
                    CMD.CommandText = "insert or ignore into Exts (Extension,Validated) values ('" + ext + "',1)"
                    CMD.ExecuteNonQuery()
                Next
            Catch ex As Exception
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/addExtension - " + ex.Message + Environment.NewLine + S)
                B = False
            End Try
        End Using


        Return B

    End Function



    ''' <summary>
    ''' Deletes the dir.
    ''' </summary>
    ''' <param name="DirName">Name of the dir.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function delDir(ByVal DirName As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        setSLConn()
        Dim B As Boolean = True
        Dim S As String = "Delete from Directory where DirName = @DirName "

        'Dim cn As New SqlCeConnection(DirCS)
        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 05: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If


        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.Parameters.AddWithValue("@DirName", DirName)
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/delDir - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            'If cn IsNot Nothing Then
            '    If cn.State = ConnectionState.Open Then
            '        cn.Close()
            '    End If
            '    cn.Dispose()
            'End If
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        Return B

    End Function


    ''' <summary>
    ''' Gets the file identifier.
    ''' </summary>
    ''' <param name="FileName">Name of the file.</param>
    ''' <param name="FileHash">The file hash.</param>
    ''' <returns>System.Int32.</returns>
    Function GetFileID(ByVal FileName As String, FileHash As String) As Integer
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        setSLConn()
        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 06: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If

        If FileName.Contains("''") Then
            FileName = FileName.Replace("''", "'")
        End If
        If FileName.Contains("'") Then
            FileName = FileName.Replace("''", "'")
            FileName = FileName.Replace("'", "''")
        End If

        Dim FileID As Integer = -1

        Dim S As String = "Select FileID from Files where FileName = '" + FileName + "' and FileHash = '" + FileHash + "' "
        Try
            Using CMD As New SQLiteCommand(S, SQLiteCONN)
                CMD.CommandText = S
                Dim rdr As SQLiteDataReader = CMD.ExecuteReader()
                Using rdr
                    While (rdr.Read())
                        FileID = rdr.GetInt32(0)
                    End While
                End Using
            End Using
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR cbLocalDB/GetFileID: " + ex.Message + Environment.NewLine + S)
        End Try

        Return FileID
    End Function

    ''' <summary>
    ''' Adds the file.
    ''' </summary>
    ''' <param name="FileName">Name of the file.</param>
    ''' <param name="FileHash">The file hash.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function addFile(ByVal FileName As String, FileHash As String) As Boolean

        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        If FileName.Contains("'") Then
            FileName = FileName.Replace("''", "'")
            FileName = FileName.Replace("'", "''")
        End If

        Dim B As Boolean = True
        Dim UseArchiveBit As Integer = 0
        Dim S As String = "insert or ignore into Files (FileName, FileHash) values ('" + FileName + "', '" + FileHash + "') "
        'Dim S As String = "insert or ignore into Files (FileName, FileHash) values (?,?) "
        B = setSLConn()
        Try
            If SQLiteCONN.State = ConnectionState.Closed Then
                SQLiteCONN.Open()
                B = True
            End If
            If Not B Then
                SQLiteCONN.Open()
            End If
        Catch ex As Exception
            LOG.WriteToArchiveLog("NOTICE addfile 100: " + ex.Message)
        End Try
        If B.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 07: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If

        Using CMD As New SQLiteCommand(S, SQLiteCONN)
            Try
                'CMD.Parameters.AddWithValue("FileName", FileName)
                'CMD.Parameters.AddWithValue("FileHash", FileHash)
                CMD.ExecuteNonQuery()
            Catch ex As Exception
                LOG.WriteToArchiveLog("ERROR 20x: clsDbLocal/addFile - " + ex.Message + Environment.NewLine + S)
                B = False
            Finally
                CMD.Dispose()
                GC.Collect()
                GC.WaitForPendingFinalizers()
            End Try
        End Using

        Return B

    End Function

    ''' <summary>
    ''' Adds the directory.
    ''' </summary>
    ''' <param name="DictOfDirs">The dictionary of dirs.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function addDirectory(ByVal DictOfDirs As Dictionary(Of String, Integer)) As Boolean

        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim B As Boolean = True
        Dim UseArchiveBit As Integer = 0
        Dim S As String = "insert or ignore into Files (DirName, DirHash) values (?,?) "
        B = setSLConn()
        Try
            If SQLiteCONN.State = ConnectionState.Closed Then
                SQLiteCONN.Open()
                B = True
            End If
            If Not B Then
                SQLiteCONN.Open()
            End If
        Catch ex As Exception
            LOG.WriteToArchiveLog("NOTICE addDirectory 100: " + ex.Message)
        End Try
        If B.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 07: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If
        Dim ID As Integer = 0
        Using CMD As New SQLiteCommand(S, SQLiteCONN)
            Try
                'CMD.Parameters.AddWithValue("FileName", FileName)
                'CMD.Parameters.AddWithValue("FileHash", FileHash)
                For Each DIRName As String In DictOfDirs.Keys
                    Try
                        Application.DoEvents()
                        If DictOfDirs.Keys.Contains(DIRName) Then
                            ID = DictOfDirs(DIRName)
                        Else
                            ID = 0
                        End If

                        If ID.Equals(0) Then
                            Dim Hash As String = ENC.SHA512SqlServerHash(DIRName.ToLower)
                            CMD.Parameters.AddWithValue("DirName", DIRName)
                            CMD.Parameters.AddWithValue("DirHash", Hash)
                            'insert into Directory (DirName, DirHash, UseArchiveBit) values ('TEST','A0', 0) 
                            S = "insert or ignore into Directory (DirName, DirHash, UseArchiveBit) values (@DirName,@DirHash,0) "
                            CMD.CommandText = S
                            CMD.ExecuteNonQuery()
                        End If
                    Catch ex As Exception
                        LOG.WriteToArchiveLog("ERROR addInventory 00: " + ex.Message)
                    End Try
                Next
            Catch ex As Exception
                LOG.WriteToArchiveLog("ERROR 20x: clsDbLocal/addDirectory - " + ex.Message + Environment.NewLine + S)
                B = False
            Finally
                CMD.Dispose()
                GC.Collect()
                GC.WaitForPendingFinalizers()
            End Try
        End Using

        Return B

    End Function

    ''' <summary>
    ''' Adds the file.
    ''' </summary>
    ''' <param name="DictOfFiles">The dictionary of files.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function addFile(ByVal DictOfFiles As Dictionary(Of String, Integer)) As Boolean

        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim ID As Integer = 0
        Dim B As Boolean = True
        Dim UseArchiveBit As Integer = 0
        Dim S As String = "insert or ignore into Files (FileName, FileHash) values (?,?) "

        B = setSLConn()
        Try
            If SQLiteCONN.State = ConnectionState.Closed Then
                SQLiteCONN.Open()
                B = True
            End If
            If Not B Then
                SQLiteCONN.Open()
            End If
        Catch ex As Exception
            LOG.WriteToArchiveLog("NOTICE addfile 100: " + ex.Message)
        End Try
        If B.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 07: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If

        Using CMD As New SQLiteCommand(S, SQLiteCONN)
            Try
                'CMD.Parameters.AddWithValue("FileName", FileName)
                'CMD.Parameters.AddWithValue("FileHash", FileHash)
                For Each FName As String In DictOfFiles.Keys
                    Try
                        Application.DoEvents()
                        If DictOfFiles.Keys.Contains(FName) Then
                            ID = DictOfFiles(FName)
                        Else
                            ID = 0
                        End If
                        If ID.Equals(0) Then
                            Dim Hash As String = ENC.SHA512SqlServerHash(FName.ToLower)
                            CMD.Parameters.AddWithValue("FileName", FName)
                            CMD.Parameters.AddWithValue("FileHash", Hash)
                            S = "insert or ignore into Files (FileName, FileHash) values (@FileName,@FileHash) "
                            CMD.CommandText = S
                            CMD.ExecuteNonQuery()
                        End If
                    Catch ex As Exception
                        LOG.WriteToArchiveLog("ERROR addFile 12X: " + ex.Message)
                    End Try
                Next
            Catch ex As Exception
                LOG.WriteToArchiveLog("ERROR 20x: clsDbLocal/addFile - " + ex.Message + Environment.NewLine + S)
                B = False
            Finally
                CMD.Dispose()
                GC.Collect()
                GC.WaitForPendingFinalizers()
            End Try
        End Using

        Return B

    End Function

    ''' <summary>
    ''' Adds the inventory.
    ''' </summary>
    ''' <param name="DictLWD">The dictionary LWD.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function addInventory(ByVal DictLWD As Dictionary(Of String, String)) As Boolean

        Dim DictDirID As Dictionary(Of String, Integer) = LoadDirs()
        Dim DictFileID As Dictionary(Of String, Integer) = LoadFiles()

        Dim FQN As String = ""
        Dim FName As String = ""
        Dim DName As String = ""
        Dim B As Boolean = True
        Dim LastWriteDate As String = ""
        Dim UseArchiveBit As Integer = 0
        Dim S As String = "insert or ignore into Files (FileName, FileHash) values (?,?) "

        B = setSLConn()
        Try
            If SQLiteCONN.State = ConnectionState.Closed Then
                SQLiteCONN.Open()
                B = True
            End If
            If Not B Then
                SQLiteCONN.Open()
            End If
        Catch ex As Exception
            LOG.WriteToArchiveLog("NOTICE addfile 100: " + ex.Message)
        End Try
        If B.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 07: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If

        Dim DirID As Integer = 0
        Dim FileID As Integer = 0

        '  [InvID] Integer primary key autoincrement  
        ', [DirID] int Not NULL
        ', [FileID] int Not NULL
        ', [FileExist] bit DEFAULT (1) NULL
        Dim FileSize As Int64 = 0
        ', [CreateDate] datetime NULL
        ', [LastUpdate] datetime NULL
        ', [LastArchiveUpdate] datetime NULL
        ', [ArchiveBit] bit NULL
        ', [NeedsArchive] bit NULL
        ', [FileHash] nvarchar(512) NULL COLLATE NOCASE
        Dim Hash As String = ""
        Using CMD As New SQLiteCommand(S, SQLiteCONN)
            Try
                'CMD.Parameters.AddWithValue("FileName", FileName)
                'CMD.Parameters.AddWithValue("FileHash", FileHash)
                For Each FQN In DictLWD.Keys
                    Application.DoEvents()
                    Try
                        Dim FI As New FileInfo(FQN)
                        DName = FI.DirectoryName
                        FName = FI.Name
                        FileSize = FI.Length
                        LastWriteDate = FI.LastWriteTime.ToString
                        FI = Nothing

                        Try
                            DirID = DictDirID(DName)
                            FileID = DictFileID(FName)
                        Catch ex As Exception
                            LOG.WriteToArchiveLog("ERROR addInventory 12X: DID not find either the Dir '" + DName + "' or the File '" + FName + "' in the SQLite DB, skipping and not adding to inventory." + Environment.NewLine + ex.Message)
                            DirID = 0
                            FileID = 0
                        End Try

                        If DirID > 0 And FileID > 0 Then
                            Hash = ENC.SHA512SqlServerHash(FQN.ToLower)
                            CMD.Parameters.AddWithValue("DirID", DirID)
                            CMD.Parameters.AddWithValue("FileID", FileID)
                            CMD.Parameters.AddWithValue("FileSize", FileSize)
                            CMD.Parameters.AddWithValue("LastUpdate", LastWriteDate)
                            CMD.Parameters.AddWithValue("FileHash", Hash)
                            S = "insert or ignore into Inventory (DirID, FileID, FileSize, LastUpdate, FileHash) 
                                            values (@DirID, @FileID, @FileSize, '" + LastWriteDate + "', @FileHash) "
                            CMD.CommandText = S
                            CMD.ExecuteNonQuery()
                        End If
                    Catch ex As Exception
                        LOG.WriteToArchiveLog("ERROR addInventory 01: " + ex.Message)
                    End Try

                Next

            Catch ex As Exception
                LOG.WriteToArchiveLog("ERROR 20x: clsDbLocal/addFile - " + ex.Message + Environment.NewLine + S)
                B = False
            Finally
                CMD.Dispose()
                GC.Collect()
                GC.WaitForPendingFinalizers()
            End Try
        End Using

        Return B

    End Function


    ''' <summary>
    ''' Adds the contact.
    ''' </summary>
    ''' <param name="FullName">The full name.</param>
    ''' <param name="Email1Address">The email1 address.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function addContact(ByVal FullName As String, ByVal Email1Address As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        setSLConn()
        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 08: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If

        If Email1Address Is Nothing Then
            Email1Address = "NA"
        End If

        Dim B As Boolean = True
        Dim UseArchiveBit As Integer = 0

        FullName = FullName.Replace("'", "''")
        Dim S As String = "insert or ignore into ContactsArchive (Email1Address, FullName) values ('" + Email1Address + "', '" + FullName + "') "
        Using CMD As New SQLiteCommand(S, SQLiteCONN)
            Try
                'CMD.Parameters.AddWithValue("@Email1Address", Email1Address)
                'CMD.Parameters.AddWithValue("@FullName", FullName)
                'CMD.Parameters.AddWithValue("@RowID", "null")
                CMD.ExecuteNonQuery()
            Catch ex As Exception
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/addContact - " + ex.Message + Environment.NewLine + S)
                B = False
            Finally
                GC.Collect()
                GC.WaitForPendingFinalizers()
            End Try
        End Using
        Return B

    End Function

    ''' <summary>
    ''' Files the exists.
    ''' </summary>
    ''' <param name="FileName">Name of the file.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function fileExists(ByVal FileName As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim B As Boolean = False
        Dim S As String = "Select count(*) from Files where FileName = '" + FileName + "' "

        setSLConn()
        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 09: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If

        Dim iCnt As Integer = 0
        Using CMD As New SQLiteCommand(S, SQLiteCONN)
            CMD.CommandText = S
            Dim rdr As SQLiteDataReader = CMD.ExecuteReader()
            Using rdr
                While (rdr.Read())
                    iCnt = rdr.GetInt32(0)
                End While
            End Using
        End Using

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return iCnt

    End Function

    ''' <summary>
    ''' Contacts the exists.
    ''' </summary>
    ''' <param name="FullName">The full name.</param>
    ''' <param name="Email1Address">The email1 address.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function contactExists(ByVal FullName As String, ByVal Email1Address As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim B As Boolean = False
        Dim S As String = "Select count(*) from ContactsArchive where Email1Address = '" + Email1Address + "' and FullName = '" + FullName + "' "
        setSLConn()
        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 10: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If

        Dim iCnt As Integer = 0
        Using CMD As New SQLiteCommand(S, SQLiteCONN)
            CMD.CommandText = S
            Dim rdr As SQLiteDataReader = CMD.ExecuteReader()
            Using rdr
                While (rdr.Read())
                    iCnt = rdr.GetInt32(0)
                End While
            End Using
        End Using

        GC.Collect()
        GC.WaitForPendingFinalizers()

        If iCnt > 0 Then
            B = True
        Else
            B = False
        End If

        Return B

    End Function

    ''' <summary>
    ''' Deletes the file.
    ''' </summary>
    ''' <param name="FileName">Name of the file.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function delFile(ByVal FileName As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        setSLConn()
        Dim B As Boolean = True
        Dim S As String = "Delete from Files where FileName = '" + FileName + "' "

        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 11: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/delFile - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            'If cn IsNot Nothing Then
            '    If cn.State = ConnectionState.Open Then
            '        cn.Close()
            '    End If
            '    cn.Dispose()
            'End If
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        Return B

    End Function

    ''' <summary>
    ''' Adds the inventory force.
    ''' </summary>
    ''' <param name="FQN">The FQN.</param>
    ''' <param name="bArchiveBit">if set to <c>true</c> [b archive bit].</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function addInventoryForce(ByVal FQN As String, ByVal bArchiveBit As Boolean) As Boolean

        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        If FQN.Contains("''") Then
            FQN = FQN.Replace("''", "'")
        End If

        setSLConn()
        Dim iArchiveFlag As Integer = 0
        Dim FileExist As Integer = 1
        Dim NeedsArchive As Integer = 1
        Dim UseArchiveBit As Integer = 0
        Dim DirID As Integer = 0
        Dim FileID As Integer = 0
        Dim FileSize As Integer = 0
        Dim B As Boolean = True
        Dim FI As New FileInfo(FQN)
        Dim sDirName As String = ""
        Dim sFileName As String = ""
        Dim LastUpdate As Date = Nothing
        Dim ArchiveBit As Integer = 1
        Dim FileHash As String = ""

        If bArchiveBit Then
            ArchiveBit = 1
        Else
            ArchiveBit = 0
        End If

        FileHash = ENC.GenerateSHA512HashFromFile(FQN)
        Try
            sDirName = FI.DirectoryName
            sFileName = FI.Name
            FileSize = FI.Length
            LastUpdate = FI.LastWriteTime
        Catch ex As Exception
            B = False
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/addInventoryForce 00 - " + ex.Message)
            Return B
        End Try

        DirID = GetDirID(sDirName)
        FileID = GetFileID(sFileName, FileHash)

        If DirID < 0 Then
            B = addDir(sDirName, False)
            LOG.WriteToArchiveLog("NOTICE: clsDbLocal/setInventoryArchive 01 - Added directory " + sDirName + ".")
            DirID = GetDirID(sDirName)
        End If
        If FileID < 0 Then
            B = addFile(sFileName, FileHash)
            LOG.WriteToArchiveLog("NOTICE: clsDbLocal/setInventoryArchive 02 - Added file " + sFileName + ".")
            FileID = GetFileID(sFileName, FileHash)
        End If

        If InventoryExists(DirID, FileID, FileHash) Then
            Return True
        End If

        Dim S As String = "insert or ignore into Inventory (DirID,FileID,FileExist,FileSize,LastUpdate,ArchiveBit,NeedsArchive,FileHash) values "
        S += "(" + DirID.ToString + ", "
        S += "" + FileID.ToString + ", "
        S += "" + FileExist.ToString + ", "
        S += "" + FileSize.ToString + ", "
        S += "'" + LastUpdate.ToString + "', "
        S += "" + ArchiveBit.ToString + ", "
        S += "" + NeedsArchive.ToString + ", "
        S += "'" + FileHash + "') "

        ''LOG.WriteToArchiveLog("REMOVE after debug  SQL: " + environment.NewLine + S)

        'Dim cn As New SqlCeConnection(InvCS)
        If Not setSLConn() Then
            MessageBox.Show("NOTICE 12: The Local DB failed to open.: " + gLocalDBCS)
            Return 0
        End If

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.ExecuteNonQuery()
            B = True
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR 1A: clsDbLocal/addInventoryForce - " + ex.Message)
            LOG.WriteToArchiveLog("ERROR 1A: clsDbLocal/addInventoryForce SQL: " + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        Return B

    End Function

    ''' <summary>
    ''' Rebuilds the database.
    ''' </summary>
    Public Sub RebuildDB()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim S As String = ""

        S = "drop table  IF EXISTS ContactsArchive"
        ApplySQL(S)

        S = "CREATE table [ContactsArchive] ( 
            [RowID] Integer primary key autoincrement  
            , [Email1Address] nvarchar(100) Not NULL COLLATE NOCASE 
            , [FullName] nvarchar(100) Not NULL COLLATE NOCASE 
        )"
        ApplySQL(S)

        S = "create index PI_CA on ContactsArchive (Email1Address, FullName);"
        ApplySQL(S)

        S = "drop table  IF EXISTS Directory;"
        ApplySQL(S)

        S = "CREATE table [Directory] (
              [DirName] nvarchar(1000) Not NULL COLLATE NOCASE UNIQUE
            , [DirID] integer primary key autoincrement  
            , [UseArchiveBit] bit Not NULL
            , [DirHash] nvarchar(512) NULL COLLATE NOCASE
            )"
        ApplySQL(S)

        S = "create index PI_DirHash on Directory (DirHash);"
        ApplySQL(S)
        S = "create index PI_DirName on Directory (DirName);"
        ApplySQL(S)


        S = "drop table  IF EXISTS Exchange;"
        ApplySQL(S)

        S = "CREATE table [Exchange] ( 
              [sKey] nvarchar(200) Not NULL 
            , [RowID] integer primary key autoincrement  
            , [KeyExists] bit DEFAULT 1 NULL 
            )"
        ApplySQL(S)

        S = "create index PI_KEy on Exchange (KeyExists);"
        ApplySQL(S)

        S = "drop table  IF EXISTS Files;"
        ApplySQL(S)

        S = "CREATE table [Files] (
              [FileID] Integer primary key autoincrement  
            , [FileName] nvarchar(254) Not NULL COLLATE NOCASE
            , [FileHash] nvarchar(512) NULL COLLATE NOCASE
            )"
        ApplySQL(S)

        S = "create index PI_Hash on Files (FileHash);"
        ApplySQL(S)
        S = "create index PI_NameHash On Files (FileName, FileHash);"
        ApplySQL(S)
        S = "create index PI_FName on Files (FileName);"
        ApplySQL(S)

        S = "drop table  IF EXISTS Inventory;"
        ApplySQL(S)

        S = "CREATE table [Inventory] (
              [InvID] Integer primary key autoincrement  
            , [DirID] int Not NULL
            , [FileID] int Not NULL
            , [FileExist] bit DEFAULT (1) NULL
            , [FileSize] bigint NULL
            , [CreateDate] datetime NULL
            , [LastUpdate] datetime NULL
            , [LastArchiveUpdate] datetime NULL
            , [ArchiveBit] bit NULL
            , [NeedsArchive] bit NULL
            , [FileHash] nvarchar(512) NULL COLLATE NOCASE
            )"
        ApplySQL(S)

        S = "create index PI_InventoryHash on Inventory (FileHash);"
        ApplySQL(S)
        S = "create index PI_Archive on Inventory (NeedsArchive);"
        ApplySQL(S)
        S = "create index PI_DirFileID On Inventory (DirID, FileID);"
        ApplySQL(S)


        S = "drop table  IF EXISTS Listener;"
        ApplySQL(S)

        S = "CREATE table [Listener] ( 
              [FQN] nvarchar(2000) Not NULL 
            , [Uploaded] int DEFAULT 0 Not NULL 
            , CONSTRAINT Listener_pk PRIMARY KEY (FQN) 
            )"
        ApplySQL(S)

        S = "create index PI_ListenerFQN On Listener (FQN);"
        ApplySQL(S)
        S = "create index PI_ListenerUploaded On Listener (Uploaded);"
        ApplySQL(S)


        S = "drop table IF EXISTS MultiLocationFiles;"
        ApplySQL(S)

        S = "CREATE table [MultiLocationFiles] (
              [LocID] Integer primary key autoincrement  
            , [DirID] int Not NULL
            , [FileID] int Not NULL
            , [FileHash] nvarchar(512) Not NULL COLLATE NOCASE
            )"
        ApplySQL(S)

        S = "create index PI_MFHash on MultiLocationFiles (FileHash);"
        ApplySQL(S)
        S = "create index PI_MFDirFileID On Inventory (DirID, FileID);"
        ApplySQL(S)


        S = "drop table  IF EXISTS Outlook;"
        ApplySQL(S)

        S = "CREATE table [Outlook] ( 
  [RowID] Integer primary key autoincrement  
, [sKey] nvarchar(500) Not NULL COLLATE NOCASE UNIQUE
, [KeyExists] bit DEFAULT 1 NULL 
)"
        ApplySQL(S)

        S = "create index PI_SKey on Outlook (sKey);"
        ApplySQL(S)
        S = "create index PI_KeyExists on Outlook (KeyExists);"
        ApplySQL(S)
        S = "create index PI_OutlookSKey on Outlook (sKey);"
        ApplySQL(S)


        S = "drop table  IF EXISTS ZipFile;"
        ApplySQL(S)

        S = "CREATE table [ZipFile] (
              [RowNbr] Integer primary key autoincrement  
            , [DirID] int NULL
            , [FileID] int NULL
            , [FQN] nvarchar(1000) Not NULL COLLATE NOCASE UNIQUE
            , [EmailAttachment] bit DEFAULT (0) NULL
            , [SuccessfullyProcessed] bit DEFAULT (0) NULL
            , [fSize] bigint NULL
            , [CreateDate] datetime Not NULL
            , [LastAccessDate] datetime NULL
            , [NumberOfZipFiles] int NULL
            , [ParentGuid] nvarchar(50) NULL COLLATE NOCASE
            , [InWork] bit DEFAULT (0) NULL
            , [FileHash] nvarchar(512) NULL COLLATE NOCASE
            )"
        ApplySQL(S)

        S = "create index PI_ZipFileHash on ZipFile (FileHash);"
        ApplySQL(S)
        S = "create index PI_ZipDirFileHash On ZipFile (DirID, FileHash);"
        ApplySQL(S)
        S = "create index PI_ZipFqn on ZipFile (FQN);"
        ApplySQL(S)



    End Sub

    ''' <summary>
    ''' Applies the SQL.
    ''' </summary>
    ''' <param name="S">The s.</param>
    Sub ApplySQL(S As String)

        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If


        setSLConn()

        LOG.WriteToArchiveLog("NOTICE: Executing SQL: " + Environment.NewLine + S)

        'Dim cn As New SqlCeConnection(InvCS)
        If Not setSLConn() Then
            MessageBox.Show("NOTICE 13: The Local DB failed to open.: " + gLocalDBCS)
            Return
        End If

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            MessageBox.Show("ERROR 1A: clsDbLocal/ApplySQL: " + ex.Message + Environment.NewLine + S)
            LOG.WriteToArchiveLog("ERROR 1A: clsDbLocal/ApplySQL: " + ex.Message)
            LOG.WriteToArchiveLog("ERROR 1A: clsDbLocal/ApplySQL: " + S)
            B = False
        Finally
            CMD.Dispose()
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

    End Sub

    ''' <summary>
    ''' Adds the inventory.
    ''' </summary>
    ''' <param name="DirID">The dir identifier.</param>
    ''' <param name="FileID">The file identifier.</param>
    ''' <param name="FileSize">Size of the file.</param>
    ''' <param name="LastUpdate">The last update.</param>
    ''' <param name="ArchiveBit">if set to <c>true</c> [archive bit].</param>
    ''' <param name="FileHash">The file hash.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function addInventory(ByVal DirID As Integer,
                          ByVal FileID As Integer,
                          ByVal FileSize As Long,
                          ByVal LastUpdate As Date,
                          ByVal ArchiveBit As Boolean,
                          ByVal FileHash As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim FileExist As Boolean = True
        Dim NeedsArchive As Boolean = True
        Dim B As Boolean = True
        Dim UseArchiveBit As Integer = 0
        setSLConn()
        'Dim S As String = "insert or ignore into Directory (DirName,UseArchiveBit) values ('" + FQN + "', " + UseArchiveBit.ToString + ") "
        Dim S As String = "insert or ignore into Inventory (DirID,FileID,FileExist,FileSize,LastUpdate,ArchiveBit,NeedsArchive,FileHash) values "
        S += "(" + DirID.ToString + ", "
        S += "" + FileID.ToString + ", "
        S += "" + FileExist.ToString + ", "
        S += "" + FileSize.ToString + ", "
        S += "'" + LastUpdate.ToString + "', "
        S += "" + ArchiveBit.ToString + ", "
        S += "" + NeedsArchive.ToString + ", "
        S += "'" + FileHash + "') "

        'Dim cn As New SqlCeConnection(InvCS)
        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 14: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            'CMD.Parameters.AddWithValue("@DirID", DirID)
            'CMD.Parameters.AddWithValue("@FileID", FileID)
            'CMD.Parameters.AddWithValue("@FileExist", FileExist)
            'CMD.Parameters.AddWithValue("@FileSize", FileSize)
            'CMD.Parameters.AddWithValue("@LastUpdate", LastUpdate)
            'CMD.Parameters.AddWithValue("@ArchiveBit", ArchiveBit)
            'CMD.Parameters.AddWithValue("@NeedsArchive", NeedsArchive)
            'CMD.Parameters.AddWithValue("@FileHash", FileHash)
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/addInventory - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            'If cn IsNot Nothing Then
            '    If cn.State = ConnectionState.Open Then
            '        cn.Close()
            '    End If
            '    cn.Dispose()
            'End If
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        Return B

    End Function

    ''' <summary>
    ''' Deletes the inventory.
    ''' </summary>
    ''' <param name="DirID">The dir identifier.</param>
    ''' <param name="FileID">The file identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function delInventory(ByVal DirID As Integer,
                          ByVal FileID As Integer) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        setSLConn()
        Dim FileExist As Integer = 1
        Dim NeedsArchive As Integer = 1
        Dim B As Boolean = True
        Dim UseArchiveBit As Integer = 0

        Dim S As String = "delete from Inventory where DirID = " + DirID.ToString + " and FileID = " + FileID.ToString

        'Dim cn As New SqlCeConnection(InvCS)
        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 15: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If


        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.Parameters.AddWithValue("@DirID", DirID)
            CMD.Parameters.AddWithValue("@FileID", FileID)
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/delInventory - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            'If cn IsNot Nothing Then
            '    If cn.State = ConnectionState.Open Then
            '        cn.Close()
            '    End If
            '    cn.Dispose()
            'End If
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        Return B

    End Function

    ''' <summary>
    ''' Inventories the exists.
    ''' </summary>
    ''' <param name="DirID">The dir identifier.</param>
    ''' <param name="FileID">The file identifier.</param>
    ''' <param name="CRC">The CRC.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function InventoryExists(ByVal DirID As Integer, ByVal FileID As Integer, CRC As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim B As Boolean = False
        Dim S As String = "Select FileHash from Inventory where DirID = " + DirID.ToString + " and FileID = " + FileID.ToString
        'Dim cn As New SqlCeConnection(InvCS)
        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 16: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If

        Dim iCnt As Integer = 0
        Try
            Dim CMD As New SQLiteCommand(S, SQLiteCONN)
            CMD.CommandType = CommandType.Text

            '** if you don’t set the result set to scrollable HasRows does not work
            Dim rs As SQLiteDataReader = CMD.ExecuteReader()

            If rs.HasRows Then
                rs.Read()
                CRC = rs.GetString(0)
                B = True
            Else
                CRC = ""
                B = False
            End If

            If Not rs.IsClosed Then
                rs.Close()
            End If
            rs.Dispose()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/InventoryExists - " + ex.Message + Environment.NewLine + S)
            CRC = ""
        Finally
            'If cn IsNot Nothing Then
            '    If cn.State = ConnectionState.Open Then
            '        cn.Close()
            '    End If
            '    cn.Dispose()
            'End If
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return B

    End Function

    ''' <summary>
    ''' Inventories the hash compare.
    ''' </summary>
    ''' <param name="DirID">The dir identifier.</param>
    ''' <param name="FileID">The file identifier.</param>
    ''' <param name="CurrHash">The curr hash.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function InventoryHashCompare(ByVal DirID As Integer,
                          ByVal FileID As Integer, ByVal CurrHash As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim B As Boolean = False
        Dim S As String = "Select FileHash from Inventory where DirID = X and FileID = X "
        'Dim cn As New SqlCeConnection(InvCS)
        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 17: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If


        Dim OldHash As String = ""
        Try
            Dim CMD As New SQLiteCommand(S, SQLiteCONN)
            CMD.CommandType = CommandType.Text

            Dim rs As SQLiteDataReader = CMD.ExecuteReader()

            If rs.HasRows Then
                rs.Read()
                OldHash = rs.GetInt32(0)
            Else
                OldHash = ""
            End If

            If Not rs.IsClosed Then
                rs.Close()
            End If
            rs.Dispose()

            If CurrHash.Equals(OldHash) Then
                B = True
            Else
                B = False
            End If
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/InventoryExists - " + ex.Message + Environment.NewLine + S)
            FileID = -1
        Finally
            'If cn IsNot Nothing Then
            '    If cn.State = ConnectionState.Open Then
            '        cn.Close()
            '    End If
            '    cn.Dispose()
            'End If
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return B

    End Function

    ''' <summary>
    ''' Sets the inventory archive.
    ''' </summary>
    ''' <param name="FQN">The FQN.</param>
    ''' <param name="ArchiveFlag">if set to <c>true</c> [archive flag].</param>
    ''' <param name="FileHash">The file hash.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function setInventoryArchive(ByVal FQN As String, ByVal ArchiveFlag As Boolean, FileHash As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim B As Boolean = True
        Dim FI As New FileInfo(FQN)
        Dim sDirName As String = ""
        Dim sFileName As String = ""
        Try
            sDirName = FI.DirectoryName
            sFileName = FI.Name
        Catch ex As Exception
            B = False
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/setInventoryArchive 00 - " + ex.Message)
            Return B
        End Try

        Dim iArchiveFlag As Integer = 0
        Dim FileExist As Integer = 1
        Dim NeedsArchive As Integer = 1
        Dim UseArchiveBit As Integer = 0
        Dim DirID As Integer = 0
        Dim FileID As Integer = 0

        DirID = GetDirID(sDirName)
        FileID = GetFileID(sFileName, FileHash)

        If DirID < 0 Then
            B = False
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/setInventoryArchive 01 - Could not get the directory id for " + sDirName + ".")
            Return B
        End If
        If FileID < 0 Then
            B = False
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/setInventoryArchive 02 - Could not get the file id for " + sFileName + ".")
            Return B
        End If

        If ArchiveFlag Then
            iArchiveFlag = 1
        Else
            iArchiveFlag = 0
        End If

        Dim S As String = "Update Inventory set NeedsArchive = " + iArchiveFlag.ToString
        S += " where DirID = " + DirID.ToString + " and FileId = " + FileID.ToString

        setSLConn()
        'Dim cn As New SqlCeConnection(InvCS)
        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 18: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.Parameters.AddWithValue("@DirID", DirID)
            CMD.Parameters.AddWithValue("@FileID", FileID)
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/setInventoryArchive 04 - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            'If cn IsNot Nothing Then
            '    If cn.State = ConnectionState.Open Then
            '        cn.Close()
            '    End If
            '    cn.Dispose()
            'End If
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        Return B

    End Function

    ''' <summary>
    ''' Sets the inventory archive.
    ''' </summary>
    ''' <param name="DirID">The dir identifier.</param>
    ''' <param name="FileID">The file identifier.</param>
    ''' <param name="ArchiveFlag">if set to <c>true</c> [archive flag].</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function setInventoryArchive(ByVal DirID As Integer, ByVal FileID As Integer, ByVal ArchiveFlag As Boolean) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim B As Boolean = True

        Dim iArchiveFlag As Integer = 0
        Dim FileExist As Integer = 1
        Dim NeedsArchive As Integer = 1
        Dim UseArchiveBit As Integer = 0

        If ArchiveFlag Then
            iArchiveFlag = 1
        Else
            iArchiveFlag = 0
        End If

        Dim S As String = "Update Inventory set NeedsArchive = " + iArchiveFlag.ToString
        S += " where DirID = " + DirID.ToString + " and FileId = " + FileID.ToString

        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 19: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.Parameters.AddWithValue("@DirID", DirID)
            CMD.Parameters.AddWithValue("@FileID", FileID)
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/setInventoryArchive 104 - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            'If cn IsNot Nothing Then
            '    If cn.State = ConnectionState.Open Then
            '        cn.Close()
            '    End If
            '    cn.Dispose()
            'End If
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        Return B

    End Function

    ''' <summary>
    ''' Fixes the single quotes.
    ''' </summary>
    ''' <param name="str">The string.</param>
    ''' <returns>System.String.</returns>
    Function fixSingleQuotes(str As String) As String
        str = str.Replace("''", "'")
        str = str.Replace("'", "''")
        Return str
    End Function

    ''' <summary>
    ''' Updates the file archive information last archive date.
    ''' </summary>
    ''' <param name="FQN">The FQN.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function updateFileArchiveInfoLastArchiveDate(FQN As String) As Boolean

        FQN = FQN.Replace("''", "'")

        Dim FI As New FileInfo(FQN)

        AddFileArchiveInfo(FQN)

        FQN = fixSingleQuotes(FQN)

        Dim B As Boolean = False
        Dim S As String = "update DirFilesID set LastArchiveDate = datetime(), FileLength = " + FI.Length.ToString + ", LastModDate = '" + FI.LastWriteTime.ToString + "'  where FQN = '" + FQN + "' ;"

        FI = Nothing

        setSLConn()

        Try
            Dim CMD As New SQLiteCommand(S, SQLiteCONN)
            CMD.CommandType = CommandType.Text
            CMD.ExecuteNonQuery()
            CMD.Dispose()
            B = True
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR UpdateFileArchiveInfo 00: " + ex.Message + Environment.NewLine + S)
            B = False
        End Try
        Return B

    End Function

    ''' <summary>
    ''' Cks the file exsists.
    ''' </summary>
    ''' <param name="fqn">The FQN.</param>
    ''' <returns>System.Int32.</returns>
    Function ckFileExsists(fqn As String) As Integer

        Dim I As Integer = 0
        Dim S As String = ""

        fqn = fixSingleQuotes(fqn)
        S = "Select count(*) From DirFilesID D  Where FQN = '" + fqn + "' "

        setSLConn()

        Try
            Dim CMD As New SQLiteCommand(S, SQLiteCONN)
            CMD.CommandType = CommandType.Text

            Dim rs As SQLiteDataReader = CMD.ExecuteReader()

            If rs.HasRows Then
                rs.Read()
                I = rs.GetInt64(0)
            Else
                I = 0
            End If

            If Not rs.IsClosed Then
                rs.Close()
            End If
            rs.Dispose()

        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/InventoryExists - " + ex.Message + Environment.NewLine + S)
            LOG.WriteToArchiveLog("ERROR 923A getFileArchiveInfo : " + ex.Message + Environment.NewLine + S)
        End Try

        Return I
    End Function

    ''' <summary>
    ''' Adds the file archive information.
    ''' </summary>
    ''' <param name="FQN">The FQN.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function AddFileArchiveInfo(FQN As String) As Boolean

        FQN = FQN.Replace("''", "'")

        Dim B As Boolean = False
        Dim FI As New FileInfo(FQN)
        Dim L As String = ""
        Dim LastWriteTime As String = ""

        Try
            L = FI.Length.ToString
            LastWriteTime = FI.LastWriteTime.ToString

            FQN = FQN.Replace("''", "'")
            Dim I As Integer = ckFileExsists(FQN)
            If I > 0 Then
                Return True
            End If

            FQN = FQN.Replace("''", "'")
            FQN = FQN.Replace("'", "''")

            Dim S As String = "Insert into DirFilesID (FQN, LastArchiveDate, FileLength, LastModDate) values ('" + FQN + "', '01/01/1970', " + L + ", '" + LastWriteTime + "' );"

            FI = Nothing

            setSLConn()

            Try
                Dim CMD As New SQLiteCommand(S, SQLiteCONN)
                CMD.CommandType = CommandType.Text
                CMD.ExecuteNonQuery()
                CMD.Dispose()
                B = True
            Catch ex As Exception
                LOG.WriteToDirFileLog("ERROR addFileArchiveInfo 00: " + ex.Message + Environment.NewLine + S)
                LOG.WriteToArchiveLog("ERROR addFileArchiveInfo 00: " + ex.Message + Environment.NewLine + S)
                B = False
            End Try
        Catch ex As Exception
            LOG.WriteToDirFileLog("ERROR AddFileArchiveInfo 01a: " + ex.Message)
            LOG.WriteToDirFileLog("ERROR AddFileArchiveInfo 02a: skipping file : " + FQN)
            LOG.WriteToArchiveLog("ERROR AddFileArchiveInfo 01b: " + ex.Message)
            LOG.WriteToArchiveLog("ERROR AddFileArchiveInfo 02b: skipping file : " + FQN)
            B = False
        End Try

        Return B
    End Function

    ''' <summary>
    ''' Gets the sq lite files.
    ''' </summary>
    ''' <returns>Dictionary(Of System.String, System.String).</returns>
    Function getSQLiteFiles() As Dictionary(Of String, String)

        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim INFO As New Dictionary(Of String, String)

        Try

            Dim val As Object = ""
            Dim FileSize As Int64 = 0
            Dim LastUpdate As DateTime = Nothing
            Dim LastArchiveDate As DateTime = Nothing

            Dim S As String = ""

            FQN = fixSingleQuotes(FQN)
            S = "Select LastArchiveDate, FileLength, LastModDate From DirFilesID D  Where FQN = '" + FQN + "' "
            S = "Select cast(LastArchiveDate as text) as LAD, FileLength, cast(LastModDate as text) as LMD From DirFilesID   Where FQN = '" + FQN + "' "
            setSLConn()

            Try
                Dim CMD As New SQLiteCommand(S, SQLiteCONN)
                CMD.CommandType = CommandType.Text

                Dim rs As SQLiteDataReader = CMD.ExecuteReader()

                If rs.HasRows Then
                    rs.Read()
                    Try
                        Dim LAD As String = ""
                        LAD = rs.GetString(0)
                        LastArchiveDate = Convert.ToDateTime(LAD)
                    Catch ex As Exception
                        LastArchiveDate = Convert.ToDateTime("01-01-1970")
                    End Try

                    FileSize = rs.GetInt64(1)

                    Try
                        Dim LAD As String = ""
                        LAD = rs.GetString(2)
                        LastUpdate = Convert.ToDateTime(LAD)
                    Catch ex As Exception
                        LastUpdate = Convert.ToDateTime("01-01-1970")
                    End Try

                    If LastUpdate < Convert.ToDateTime("01-01-1970") Then
                        LastUpdate = Convert.ToDateTime("01-01-1970")
                    End If

                    INFO.Add("FileSize", FileSize.ToString)
                    INFO.Add("LastUpdate", LastUpdate.ToString)
                    INFO.Add("LastArchiveDate", LastArchiveDate.ToString)
                    INFO.Add("AddNewRec", "N")
                Else
                    INFO.Add("AddNewRec", "Y")
                End If

                If Not rs.IsClosed Then
                    rs.Close()
                End If
                rs.Dispose()

            Catch ex As Exception
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/InventoryExists - " + ex.Message + Environment.NewLine + S)
                LOG.WriteToArchiveLog("ERROR 923A getFileArchiveInfo : " + ex.Message + Environment.NewLine + S)
            End Try
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR 923b getFileArchiveInfo : " + ex.Message)
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()


        Return INFO
    End Function


    ''' <summary>
    ''' Gets the file archive information.
    ''' </summary>
    ''' <param name="FQN">The FQN.</param>
    ''' <returns>Dictionary(Of System.String, System.String).</returns>
    Function getFileArchiveInfo(FQN As String) As Dictionary(Of String, String)

        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim INFO As New Dictionary(Of String, String)

        Try

            Dim val As Object = ""
            Dim FileSize As Int64 = 0
            Dim LastUpdate As DateTime = Nothing
            Dim LastArchiveDate As DateTime = Nothing

            Dim S As String = ""

            FQN = fixSingleQuotes(FQN)
            S = "Select LastArchiveDate, FileLength, LastModDate From DirFilesID D  Where FQN = '" + FQN + "' "
            S = "Select cast(LastArchiveDate as text) as LAD, FileLength, cast(LastModDate as text) as LMD From DirFilesID   Where FQN = '" + FQN + "' "
            setSLConn()

            Try
                Dim CMD As New SQLiteCommand(S, SQLiteCONN)
                CMD.CommandType = CommandType.Text

                Dim rs As SQLiteDataReader = CMD.ExecuteReader()

                If rs.HasRows Then
                    rs.Read()
                    Try
                        Dim LAD As String = ""
                        LAD = rs.GetString(0)
                        LastArchiveDate = Convert.ToDateTime(LAD)
                    Catch ex As Exception
                        LastArchiveDate = Convert.ToDateTime("01-01-1970")
                    End Try

                    FileSize = rs.GetInt64(1)

                    Try
                        Dim LAD As String = ""
                        LAD = rs.GetString(2)
                        LastUpdate = Convert.ToDateTime(LAD)
                    Catch ex As Exception
                        LastUpdate = Convert.ToDateTime("01-01-1970")
                    End Try

                    If LastUpdate < Convert.ToDateTime("01-01-1970") Then
                        LastUpdate = Convert.ToDateTime("01-01-1970")
                    End If

                    INFO.Add("FileSize", FileSize.ToString)
                    INFO.Add("LastUpdate", LastUpdate.ToString)
                    INFO.Add("LastArchiveDate", LastArchiveDate.ToString)
                    INFO.Add("AddNewRec", "N")
                Else
                    INFO.Add("AddNewRec", "Y")
                End If

                If Not rs.IsClosed Then
                    rs.Close()
                End If
                rs.Dispose()

            Catch ex As Exception
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/InventoryExists - " + ex.Message + Environment.NewLine + S)
                LOG.WriteToArchiveLog("ERROR 923A getFileArchiveInfo : " + ex.Message + Environment.NewLine + S)
            End Try
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR 923b getFileArchiveInfo : " + ex.Message)
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()


        Return INFO
    End Function

    ''' <summary>
    ''' Cks the needs archive.
    ''' </summary>
    ''' <param name="FQN">The FQN.</param>
    ''' <param name="SkipIfArchiveBitOn">if set to <c>true</c> [skip if archive bit on].</param>
    ''' <param name="FileHash">The file hash.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function ckNeedsArchive(ByVal FQN As String, ByVal SkipIfArchiveBitOn As Boolean, ByRef FileHash As String) As Boolean

        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim iArchiveFlag As Integer = 0
        Dim FileExist As Integer = 1
        Dim NeedsArchive As Integer = 1
        Dim UseArchiveBit As Integer = 0
        Dim DirID As Integer = 0
        Dim FileID As Integer = 0
        Dim FileSize As Integer = 0
        Dim B As Boolean = True
        Dim sDirName As String = ""
        Dim sFileName As String = ""
        Dim LastUpdate As Date = Nothing
        Dim ArchiveBit As Integer = 1

        If FileHash.Length = 0 Then
            FileHash = ENC.GenerateSHA512HashFromFile(FQN)
        End If

        Dim fileAttributes As System.IO.FileAttributes = New System.IO.FileInfo(FQN).Attributes
        Dim ArchBit As Boolean = fileAttributes And IO.FileAttributes.Archive

        fileAttributes = Nothing

        If Not ArchBit And SkipIfArchiveBitOn Then
            Return False
        End If

        If Not File.Exists(FQN) Then
            LOG.WriteToArchiveLog("Notice: clsDbLocal/ckNeedsArchive 00 - could not find file " + FQN + ", skipping...")
            Return False
        End If

        Dim FI As New FileInfo(FQN)

        Try
            sDirName = FI.DirectoryName
            sFileName = FI.Name
            FileSize = FI.Length
            LastUpdate = FI.LastWriteTime
        Catch ex As Exception
            B = False
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/ckNeedsArchive 00.A - " + ex.Message)
            Return B
        End Try

        DirID = GetDirID(sDirName)
        FileID = GetFileID(sFileName, FileHash)

        If DirID < 0 Then
            B = addDir(sDirName, False)
            LOG.WriteToArchiveLog("Notice: clsDbLocal/ckNeedsArchive 01 - Added directory " + sDirName + ".")
            DirID = GetDirID(sDirName)
        End If
        If FileID < 0 Then
            sFileName = sFileName.Replace("'", "''")
            B = addFile(sFileName, FileHash)
            LOG.WriteToArchiveLog("Notice: clsDbLocal/ckNeedsArchive 02 - Added file " + sFileName + ".")
            FileID = GetFileID(sFileName, FileHash)
        End If

        Dim bNeedsArchive As Boolean = True
        Dim NeedsToBeArchived As Boolean = True
        Dim FileExistsInInventory As Boolean = True

        FileExistsInInventory = InventoryExists(DirID, FileID, FileHash)

        If Not FileExistsInInventory Then
            addInventory(DirID, FileID, FileSize, LastUpdate, ArchiveBit, FileHash)
            NeedsToBeArchived = True
            Return NeedsToBeArchived
        End If

        setSLConn()
        Dim S As String = "Select FileSize, LastUpdate, NeedsArchive from Inventory where DirID = " + DirID.ToString + " and FileID = " + FileID.ToString

        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 20: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If

        Dim iCnt As Integer = 0

        Dim prevFileSize As Integer = 0
        Dim prevLastUpdate As Date = Nothing
        Dim prevNeedsArchive As Boolean = False

        Try
            Dim CMD As New SQLiteCommand(S, SQLiteCONN)
            CMD.CommandType = CommandType.Text

            '** if you don’t set the result set to scrollable HasRows does not work
            Dim rs As SQLiteDataReader = CMD.ExecuteReader()

            If rs.HasRows Then
                rs.Read()
                prevFileSize = rs.GetInt64(0)
                prevLastUpdate = rs.GetDateTime(1)
                prevNeedsArchive = rs.GetBoolean(2)
            End If

            If Not rs.IsClosed Then
                rs.Close()
            End If
            rs.Dispose()

            If prevFileSize <> FileSize Then
                B = True
            ElseIf Not prevLastUpdate.ToString.Equals(LastUpdate.ToString) Then
                B = True
            Else
                B = False
            End If
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/InventoryExists - " + ex.Message + Environment.NewLine + S)
            FileID = -1
        Finally
            'If cn IsNot Nothing Then
            '    If cn.State = ConnectionState.Open Then
            '        cn.Close()
            '    End If
            '    cn.Dispose()
            'End If
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return B

    End Function

    ''' <summary>
    ''' Truncates the dirs.
    ''' </summary>
    Sub truncateDirs()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim S As String = "delete from Directory"
        setSLConn()

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Using CMD
            Try
                CMD.ExecuteNonQuery()
            Catch ex As Exception
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/truncateDirs 104 - " + ex.Message + Environment.NewLine + S)
            Finally
                GC.Collect()
            End Try
        End Using
    End Sub

    ''' <summary>
    ''' Truncates the dir files.
    ''' </summary>
    Sub truncateDirFiles()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim S As String = "delete from DirFilesID"
        setSLConn()

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/truncateContacts 104 - " + ex.Message + Environment.NewLine + S)
        Finally
            CMD.Dispose()
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try
    End Sub

    ''' <summary>
    ''' Truncates the contacts.
    ''' </summary>
    Sub truncateContacts()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim S As String = "delete from ContactsArchive"
        setSLConn()

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/truncateContacts 104 - " + ex.Message + Environment.NewLine + S)
        Finally
            CMD.Dispose()
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try
    End Sub

    ''' <summary>
    ''' Truncates the exchange.
    ''' </summary>
    Sub truncateExchange()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim S As String = "delete from Exchange"
        setSLConn()

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/truncateExchange 104 - " + ex.Message + Environment.NewLine + S)
        Finally
            CMD.Dispose()
            'If cn IsNot Nothing Then
            '    If cn.State = ConnectionState.Open Then
            '        cn.Close()
            '    End If
            '    cn.Dispose()
            'End If
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try
    End Sub

    ''' <summary>
    ''' Truncates the outlook.
    ''' </summary>
    Sub truncateOutlook()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim S As String = "delete from Outlook"
        setSLConn()

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/truncateOutlook 104 - " + ex.Message + Environment.NewLine + S)
        Finally
            CMD.Dispose()
            'If cn IsNot Nothing Then
            '    If cn.State = ConnectionState.Open Then
            '        cn.Close()
            '    End If
            '    cn.Dispose()
            'End If
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try
    End Sub

    ''' <summary>
    ''' Truncates the files.
    ''' </summary>
    Sub truncateFiles()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim S As String = "delete from Files"

        setSLConn()

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/truncateFiles 104 - " + ex.Message + Environment.NewLine + S)
        Finally
            CMD.Dispose()
            'If cn IsNot Nothing Then
            '    If cn.State = ConnectionState.Open Then
            '        cn.Close()
            '    End If
            '    cn.Dispose()
            'End If
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try
    End Sub

    ''' <summary>
    ''' Truncates the inventory.
    ''' </summary>
    Sub truncateInventory()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim S As String = "delete from Inventory"
        setSLConn()

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/truncateInventory 104 - " + ex.Message + Environment.NewLine + S)
        Finally
            CMD.Dispose()
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try
    End Sub

    ''' <summary>
    ''' Backups the dir table.
    ''' </summary>
    Sub BackupDirTbl()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        setSLConn()
        Dim Dirname As String = Nothing
        Dim DirID As Integer = Nothing
        Dim UseArchiveBit As Boolean = Nothing

        Dim S As String = "Select Dirname,DirID,UseArchiveBit from Directory"

        Dim tPath As String = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData)
        Dim SavePath As String = tPath + "\ECM\QuickRefData"
        Dim SaveFQN As String = SavePath + "\Directory.dat"

        If Not Directory.Exists(SavePath) Then
            Directory.CreateDirectory(SavePath)
        End If

        Dim fOut As StreamWriter = New StreamWriter(SaveFQN, False)
        Dim msg As String = ""

        Try

            Dim CMD As New SQLiteCommand(S, SQLiteCONN)
            CMD.CommandType = CommandType.Text

            '** if you don’t set the result set to scrollable HasRows does not work
            Dim rs As SQLiteDataReader = CMD.ExecuteReader()
            If rs.HasRows Then
                Do While rs.Read()
                    Dirname = rs.GetString(0)
                    DirID = rs.GetInt32(1)
                    UseArchiveBit = rs.GetBoolean(2)

                    fOut.WriteLine(Dirname + "|" + DirID.ToString + "|" + UseArchiveBit.ToString)
                Loop
            End If

            If Not rs.IsClosed Then
                rs.Close()
            End If
            rs.Dispose()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/BackupDirTbl - " + ex.Message + Environment.NewLine + S)
        Finally
            fOut.Close()
            fOut.Dispose()
            If SQLiteCONN IsNot Nothing Then
                If SQLiteCONN.State = ConnectionState.Open Then
                    SQLiteCONN.Close()
                End If
                SQLiteCONN.Dispose()
            End If
        End Try
        GC.Collect()
        GC.WaitForPendingFinalizers()
    End Sub



    ''' <summary>
    ''' Backs up sq lite.
    ''' </summary>
    Sub BackUpSQLite()

        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim BackupSQLiteHrs As Integer = System.Configuration.ConfigurationManager.AppSettings("BackupSQLiteHrs")
        If BackupSQLiteHrs.Equals(0) Then
            Return
        End If

        Dim strPath As String = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().CodeBase)
        slDatabase = System.Configuration.ConfigurationManager.AppSettings("SQLiteLocalDB")

        sSource = slDatabase + ".bak"
        If Not File.Exists(sSource) Then
            BackupSQLiteDB()
        Else
            Dim cd As DateTime = File.GetCreationTime(sSource)
            Dim fileage As Integer = DateDiff(DateInterval.Hour, cd, Now)
            If fileage >= BackupSQLiteHrs Then
                BackupSQLiteDB()
            End If
        End If

    End Sub

    ''' <summary>
    ''' Backups the sq lite database.
    ''' </summary>
    Sub BackupSQLiteDB()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim strPath As String = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().CodeBase)

        slDatabase = System.Configuration.ConfigurationManager.AppSettings("SQLiteLocalDB")
        sSource = slDatabase
        sTarget = slDatabase + ".bak"

        If File.Exists(sSource) Then
            File.Copy(sSource, sTarget, True)
        End If

    End Sub

    ''' <summary>
    ''' Restores the sq lite.
    ''' </summary>
    Sub RestoreSQLite()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim strPath As String = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().CodeBase)

        slDatabase = System.Configuration.ConfigurationManager.AppSettings("SQLiteLocalDB")
        sSource = slDatabase + ".bak"
        sTarget = slDatabase

        If File.Exists(sSource) Then
            File.Copy(sSource, sTarget, True)
        End If
    End Sub


    ''' <summary>
    ''' Backups the outlook table.
    ''' </summary>
    Sub BackupOutlookTbl()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        setSLConn()
        Dim sKey As String = Nothing
        Dim RowID As Integer = Nothing

        Dim S As String = "Select sKey,RowID from Outlook"

        Dim tPath As String = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData)
        Dim SavePath As String = tPath + "\ECM\QuickRefData"
        Dim SaveFQN As String = SavePath + "\Outlook.dat"

        If Not Directory.Exists(SavePath) Then
            Directory.CreateDirectory(SavePath)
        End If

        Dim fOut As StreamWriter = New StreamWriter(SaveFQN, False)
        Dim msg As String = ""

        Try
            Dim CMD As New SQLiteCommand(S, SQLiteCONN)
            CMD.CommandType = CommandType.Text

            '** if you don’t set the result set to scrollable HasRows does not work
            Dim rs As SQLiteDataReader = CMD.ExecuteReader()

            If rs.HasRows Then
                Do While rs.Read()
                    sKey = rs.GetString(0)
                    RowID = rs.GetInt32(1)
                    fOut.WriteLine(sKey + "|" + RowID.ToString)
                Loop
            End If

            If Not rs.IsClosed Then
                rs.Close()
            End If
            rs.Dispose()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/BackupOutlookTbl - " + ex.Message + Environment.NewLine + S)
        Finally
            fOut.Close()
            fOut.Dispose()
            If SQLiteCONN IsNot Nothing Then
                If SQLiteCONN.State = ConnectionState.Open Then
                    SQLiteCONN.Close()
                End If
                SQLiteCONN.Dispose()
            End If
        End Try
        GC.Collect()
        GC.WaitForPendingFinalizers()
    End Sub

    ''' <summary>
    ''' Backups the exchange table.
    ''' </summary>
    Sub BackupExchangeTbl()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        setSLConn()
        Dim sKey As String = Nothing
        Dim RowID As Integer = Nothing

        Dim S As String = "Select sKey,RowID from Exchange"
        setSLConn()
        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 21: The Local DB failed to open.: " + gLocalDBCS)
                Return
            End If
        End If

        Dim tPath As String = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData)
        Dim SavePath As String = tPath + "\ECM\QuickRefData"
        Dim SaveFQN As String = SavePath + "\Exchange.dat"

        If Not Directory.Exists(SavePath) Then
            Directory.CreateDirectory(SavePath)
        End If

        Dim fOut As StreamWriter = New StreamWriter(SaveFQN, False)
        Dim msg As String = ""

        Try
            Dim CMD As New SQLiteCommand(S, SQLiteCONN)
            CMD.CommandType = CommandType.Text

            '** if you don’t set the result set to scrollable HasRows does not work
            Dim rs As SQLiteDataReader = CMD.ExecuteReader()

            If rs.HasRows Then
                Do While rs.Read()
                    sKey = rs.GetString(0)
                    RowID = rs.GetInt32(1)
                    fOut.WriteLine(sKey + "|" + RowID.ToString)
                Loop
            End If

            If Not rs.IsClosed Then
                rs.Close()
            End If
            rs.Dispose()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/BackupOutlookTbl - " + ex.Message + Environment.NewLine + S)
        Finally
            fOut.Close()
            fOut.Dispose()
            If SQLiteCONN IsNot Nothing Then
                If SQLiteCONN.State = ConnectionState.Open Then
                    SQLiteCONN.Close()
                End If
                SQLiteCONN.Dispose()
            End If
        End Try
        GC.Collect()
        GC.WaitForPendingFinalizers()
    End Sub

    ''' <summary>
    ''' Adds the outlook.
    ''' </summary>
    ''' <param name="sKey">The s key.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function addOutlook(ByVal sKey As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        setSLConn()
        Dim B As Boolean = False
        Dim UseArchiveBit As Integer = 0

        B = OutlookExists(sKey)
        If B Then
            Return True
        End If

        Dim S As String = "insert or ignore into Outlook (sKey, RowID) values (@sKey,@RowID) "


        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 22: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.Parameters.AddWithValue("@sKey", sKey)
            CMD.Parameters.AddWithValue("@RowID", "null")
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/addOutlook - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        Return B
    End Function

    ''' <summary>
    ''' Adds the exchange.
    ''' </summary>
    ''' <param name="sKey">The s key.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function addExchange(ByVal sKey As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        setSLConn()
        Dim B As Boolean = True
        Dim UseArchiveBit As Integer = 0

        Dim S As String = "insert or ignore into Exchange (sKey,RowID) values (@sKey,@RowID) "

        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 23: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.Parameters.AddWithValue("@sKey", sKey)
            CMD.Parameters.AddWithValue("@RowID", "null")
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/addExchange - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        Return B
    End Function

    ''' <summary>
    ''' Outlooks the exists.
    ''' </summary>
    ''' <param name="sKey">The s key.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function OutlookExists(ByVal sKey As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim B As Boolean = False
        Dim S As String = "Select count(*) from Outlook where sKey = '" + sKey + "'"
        'Dim cn As New SqlCeConnection(InvCS)

        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 24: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If

        Dim iCnt As Integer = 0
        Try
            Dim CMD As New SQLiteCommand(S, SQLiteCONN)
            CMD.CommandType = CommandType.Text

            '** if you don’t set the result set to scrollable HasRows does not work
            Dim rs As SQLiteDataReader = CMD.ExecuteReader()

            If rs.HasRows Then
                rs.Read()
                iCnt = rs.GetInt32(0)
            Else
                iCnt = 0
            End If

            If Not rs.IsClosed Then
                rs.Close()
            End If
            rs.Dispose()

            If iCnt > 0 Then
                B = True
            Else
                B = False
            End If
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/OutlookExists - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            'If cn IsNot Nothing Then
            '    If cn.State = ConnectionState.Open Then
            '        cn.Close()
            '    End If
            '    cn.Dispose()
            'End If
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return B

    End Function

    ''' <summary>
    ''' Exchanges the exists.
    ''' </summary>
    ''' <param name="sKey">The s key.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function ExchangeExists(ByVal sKey As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        setSLConn()
        Dim B As Boolean = False
        Dim S As String = "Select count(*) from Exchange where sKey = '" + sKey + "'"
        'Dim cn As New SqlCeConnection(InvCS)

        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 25: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If

        Dim iCnt As Integer = 0
        Try

            Dim CMD As New SQLiteCommand(S, SQLiteCONN)
            CMD.CommandType = CommandType.Text

            '** if you don’t set the result set to scrollable HasRows does not work
            Dim rs As SQLiteDataReader = CMD.ExecuteReader()

            If rs.HasRows Then
                rs.Read()
                iCnt = rs.GetInt32(0)
            Else
                iCnt = 0
            End If

            If Not rs.IsClosed Then
                rs.Close()
            End If
            rs.Dispose()

            If iCnt > 0 Then
                B = True
            Else
                B = False
            End If
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/OutlookExists - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            'If cn IsNot Nothing Then
            '    If cn.State = ConnectionState.Open Then
            '        cn.Close()
            '    End If
            '    cn.Dispose()
            'End If
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return B

    End Function

    ''' <summary>
    ''' Marks the exchange found.
    ''' </summary>
    ''' <param name="sKey">The s key.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function MarkExchangeFound(ByVal sKey As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        setSLConn()
        Dim B As Boolean = True
        Dim S As String = "Update exchange set KeyExists = @B where sKey = @sKey "


        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 26: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.Parameters.AddWithValue("@B", True)
            CMD.Parameters.AddWithValue("@sKey", sKey)
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/MarkExchangeFound - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            'If cn IsNot Nothing Then
            '    If cn.State = ConnectionState.Open Then
            '        cn.Close()
            '    End If
            '    cn.Dispose()
            'End If
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        Return B

    End Function

    ''' <summary>
    ''' Marks the outlook found.
    ''' </summary>
    ''' <param name="sKey">The s key.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function MarkOutlookFound(ByVal sKey As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim B As Boolean = True
        Dim S As String = "Update Outlook set KeyExists = @B where sKey = @sKey "

        setSLConn()
        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 27: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.Parameters.AddWithValue("@B", True)
            CMD.Parameters.AddWithValue("@sKey", sKey)
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/MarkOutlookFound - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            'If cn IsNot Nothing Then
            '    If cn.State = ConnectionState.Open Then
            '        cn.Close()
            '    End If
            '    cn.Dispose()
            'End If
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        Return B

    End Function

    ''' <summary>
    ''' Deletes the outlook.
    ''' </summary>
    ''' <param name="sKey">The s key.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function delOutlook(ByVal sKey As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        setSLConn()
        Dim B As Boolean = True
        Dim S As String = "Delete from Outlook where sKey = @sKey "

        'Dim cn As New SqlCeConnection(FileCS)

        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 28: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.Parameters.AddWithValue("@sKey", sKey)
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/delOutlook - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            'If cn IsNot Nothing Then
            '    If cn.State = ConnectionState.Open Then
            '        cn.Close()
            '    End If
            '    cn.Dispose()
            'End If
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        Return B

    End Function

    ''' <summary>
    ''' Deletes the exchange.
    ''' </summary>
    ''' <param name="sKey">The s key.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function delExchange(ByVal sKey As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        setSLConn()
        Dim B As Boolean = True
        Dim S As String = "Delete from Exchange where sKey = @sKey "

        'Dim cn As New SqlCeConnection(FileCS)

        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 29: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.Parameters.AddWithValue("@sKey", sKey)
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/delExchange - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            'If cn IsNot Nothing Then
            '    If cn.State = ConnectionState.Open Then
            '        cn.Close()
            '    End If
            '    cn.Dispose()
            'End If
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        Return B

    End Function

    ''' <summary>
    ''' Deletes the outlook missing.
    ''' </summary>
    ''' <param name="sKey">The s key.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function delOutlookMissing(ByVal sKey As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim B As Boolean = True
        Dim S As String = "Delete from Outlook where not keyExists  "

        setSLConn()
        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 30: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/delOutlookMissing - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            'If cn IsNot Nothing Then
            '    If cn.State = ConnectionState.Open Then
            '        cn.Close()
            '    End If
            '    cn.Dispose()
            'End If
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        Return B

    End Function

    ''' <summary>
    ''' Deletes the exchange missing.
    ''' </summary>
    ''' <param name="sKey">The s key.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function delExchangeMissing(ByVal sKey As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        setSLConn()
        Dim B As Boolean = True
        Dim S As String = "Delete from Exchange where not keyExists  "


        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 31: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/delExchangeMissing - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            'If cn IsNot Nothing Then
            '    If cn.State = ConnectionState.Open Then
            '        cn.Close()
            '    End If
            '    cn.Dispose()
            'End If
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        Return B

    End Function

    ''' <summary>
    ''' Sets the outlook missing.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function setOutlookMissing() As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim B As Boolean = True
        Dim S As String = "Update Outlook set keyExists = 0 "

        setSLConn()
        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 32: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/setOutlookMissing - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            'If cn IsNot Nothing Then
            '    If cn.State = ConnectionState.Open Then
            '        cn.Close()
            '    End If
            '    cn.Dispose()
            'End If
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        Return B

    End Function

    ''' <summary>
    ''' Sets the exchange missing.
    ''' </summary>
    ''' <param name="sKey">The s key.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function setExchangeMissing(ByVal sKey As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim B As Boolean = True
        Dim S As String = "Update Exchange set KeyExists = false "
        setSLConn()
        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 33: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/setExchangeMissing - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            'If cn IsNot Nothing Then
            '    If cn.State = ConnectionState.Open Then
            '        cn.Close()
            '    End If
            '    cn.Dispose()
            'End If
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        Return B

    End Function

    ''' <summary>
    ''' Sets the outlook key found.
    ''' </summary>
    ''' <param name="sKey">The s key.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function setOutlookKeyFound(ByVal sKey As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        If sKey.Length > 500 Then
            sKey = sKey.Substring(0, 499)
        End If

        Dim B As Boolean = True
        Dim S As String = "Udpate Outlook set keyExists = true where sKey = '" + sKey + "'  "

        setSLConn()
        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 34: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            'CMD.Parameters.AddWithValue("@sKey", sKey)
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("WARNING: clsDbLocal/setOutlookKeyFound - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        Return B

    End Function

    ''' <summary>
    ''' Sets the exchange key found.
    ''' </summary>
    ''' <param name="sKey">The s key.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function setExchangeKeyFound(ByVal sKey As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim B As Boolean = True
        Dim S As String = "Udpate Exchange set keyExists = true where sKey = @sKey  "

        setSLConn()
        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 35: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.Parameters.AddWithValue("@sKey", sKey)
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/setExchangeKeyFound - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        Return B

    End Function

    ''' <summary>
    ''' Loads the exchange keys.
    ''' </summary>
    ''' <param name="L">The l.</param>
    Sub LoadExchangeKeys(ByRef L As SortedList(Of String, String))
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim S As String = "Select sKey from Exchange"

        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 36: The Local DB failed to open.: " + gLocalDBCS)
                Return
            End If
        End If


        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Dim sKey As String = ""

        Try

            CMD.CommandType = CommandType.Text
            Using CMD
                '** if you don’t set the result set to scrollable HasRows does not work
                Dim rs As SQLiteDataReader = CMD.ExecuteReader()
                Dim iKey As Integer = 0
                Using rs
                    If rs.HasRows Then
                        Do While rs.Read()
                            sKey = rs.GetString(0)
                            If L.IndexOfKey(sKey) < 0 Then
                                Try
                                    L.Add(sKey, iKey.ToString)
                                Catch ex2 As System.Exception
                                    Console.WriteLine(ex2.Message)
                                End Try
                            End If
                            iKey += 1
                        Loop
                    End If
                End Using
            End Using
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/BackupDirTbl - " + ex.Message + Environment.NewLine + S)
        Finally

        End Try
        GC.Collect()
        GC.WaitForPendingFinalizers()

    End Sub

    ''' <summary>
    ''' Adds the listener.
    ''' </summary>
    ''' <param name="FQN">The FQN.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function addListener(ByVal FQN As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        setSLConn()
        Dim B As Boolean = True
        Dim S As String = "insert or ignore into Listener (FQN) values (@FQN) "

        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 37: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If


        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Using CMD
            Try
                CMD.Parameters.AddWithValue("@FQN", FQN)
                CMD.ExecuteNonQuery()
            Catch ex As Exception
                LOG.WriteToArchiveLog("ERROR: clsDbLocal/addListener - " + ex.Message + Environment.NewLine + S)
                B = False
            End Try
        End Using
        Return B
    End Function

    ''' <summary>
    ''' Deletes the listeners processed.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function DelListenersProcessed() As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim B As Boolean = True
        Dim S As String = "delete from Listener where Uploaded = 1"
        setSLConn()
        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 38: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            'CMD.Parameters.AddWithValue("@FQN", FQN)
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/addListener - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        Return B
    End Function

    ''' <summary>
    ''' Marks the listeners processed.
    ''' </summary>
    ''' <param name="FQN">The FQN.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function MarkListenersProcessed(ByVal FQN As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim B As Boolean = True
        Dim S As String = "Update Listener set Uploaded = 1 where FQN = @FQN"
        setSLConn()
        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 39: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If


        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.Parameters.AddWithValue("@FQN", FQN)
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/addListener - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        Return B
    End Function

    ''' <summary>
    ''' Removes the listener file.
    ''' </summary>
    ''' <param name="FQN">The FQN.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function removeListenerFile(ByVal FQN As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim B As Boolean = True
        Dim S As String = "Delete from Listener where FQN = @FQN"
        setSLConn()
        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 40: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.Parameters.AddWithValue("@FQN", FQN)
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/addListener - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        Return B
    End Function

    ''' <summary>
    ''' Gets the listener files.
    ''' </summary>
    ''' <param name="L">The l.</param>
    Sub getListenerFiles(ByRef L As SortedList(Of String, Integer))

        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        setSLConn()
        Dim FQN As String = Nothing

        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 41: The Local DB failed to open.: " + gLocalDBCS)
                Return
            End If
        End If

        Dim S As String = "Select FQN from Listener"

        Try

            Dim CMD As New SQLiteCommand(S, SQLiteCONN)
            '** if you don’t set the result set to scrollable HasRows does not work
            Dim rs As SQLiteDataReader = CMD.ExecuteReader()

            If rs.HasRows Then
                Do While rs.Read()
                    FQN = rs.GetString(0)
                    If L.ContainsKey(FQN) Then
                    Else
                        L.Add(FQN, L.Count)
                    End If
                Loop
            End If

            If Not rs.IsClosed Then
                rs.Close()
            End If
            rs.Dispose()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/getListenerFiles - " + ex.Message + Environment.NewLine + S)
        End Try
        GC.Collect()
        GC.WaitForPendingFinalizers()
    End Sub

    ''' <summary>
    ''' Actives the listener files.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function ActiveListenerFiles() As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim B As Boolean = False
        Dim S As String = "Select count(*) from Listener "
        'Dim cn As New SqlCeConnection(InvCS)

        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 42: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If

        Dim iCnt As Integer = 0
        Try
            Dim CMD As New SQLiteCommand(S, SQLiteCONN)
            '** if you don’t set the result set to scrollable HasRows does not work
            Dim rs As SQLiteDataReader = CMD.ExecuteReader()

            If rs.HasRows Then
                rs.Read()
                iCnt = rs.GetInt32(0)
            Else
                iCnt = 0
            End If

            If Not rs.IsClosed Then
                rs.Close()
            End If
            rs.Dispose()

            If iCnt > 0 Then
                B = True
            Else
                B = False
            End If
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/ActiveListenerFiles - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            'If cn IsNot Nothing Then
            '    If cn.State = ConnectionState.Open Then
            '        cn.Close()
            '    End If
            '    cn.Dispose()
            'End If
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return B

    End Function

    ''' <summary>
    ''' Adds the zip file.
    ''' </summary>
    ''' <param name="FQN">The FQN.</param>
    ''' <param name="ParentGuid">The parent unique identifier.</param>
    ''' <param name="bThisIsAnEmail">if set to <c>true</c> [b this is an email].</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function addZipFile(ByVal FQN As String, ByVal ParentGuid As String, ByVal bThisIsAnEmail As Boolean) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim EmailAttachment As Integer = 0
        Dim B As Boolean = True
        Dim UseArchiveBit As Integer = 0
        Dim fSize As Int64 = 0

        If bThisIsAnEmail Then
            EmailAttachment = 1
        End If

        Dim FI As New FileInfo(FQN)
        fSize = FI.Length
        FI = Nothing

        If FQN.Contains("'") Then
            FQN = FQN.Replace("''", "'")
            FQN = FQN.Replace("'", "''")
        End If

        If IsNothing(ParentGuid) Then
            ParentGuid = ""
        End If

        Dim S As String = ""
        S = S + "insert or ignore into ZipFile (FQN, fSize, EmailAttachment, ParentGuid) values ('" + FQN + "', " + fSize.ToString + ", " + EmailAttachment.ToString + ", '" + ParentGuid + "' ) "

        Try
            SQLiteCONN.Open()
        Catch ex As Exception
            LOG.WriteToArchiveLog("NOTICE addZipfile 100: " + ex.Message)
        End Try


        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 44: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            If InStr(ex.Message, "duplicate value cannot") > 0 Then
            Else
                LOG.WriteToArchiveLog("ERROR 100H: clsDbLocal/addZipFile - " + ex.Message + Environment.NewLine + S)
            End If
            B = False
        Finally
            CMD.Dispose()
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        Return B

    End Function

    ''' <summary>
    ''' Sets the zip file processed.
    ''' </summary>
    ''' <param name="FileName">Name of the file.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function setZipFileProcessed(ByVal FileName As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim B As Boolean = True
        Dim UseArchiveBit As Integer = 0
        Dim fSize As Double = 0

        Dim FI As New FileInfo(FileName)
        fSize = FI.Length
        FI = Nothing

        Dim S As String = "Update ZipFile set SuccessfullyProcessed = 1 where FQN = @FileName) "

        setSLConn()
        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 46: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If


        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.Parameters.AddWithValue("@FileName", FileName)
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/setZipFileProcessed - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        Return B

    End Function

    ''' <summary>
    ''' Sets the zip NBR of files.
    ''' </summary>
    ''' <param name="FileName">Name of the file.</param>
    ''' <param name="NumberOfZipFiles">The number of zip files.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function setZipNbrOfFiles(ByVal FileName As String, ByVal NumberOfZipFiles As Integer) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim B As Boolean = True
        Dim UseArchiveBit As Integer = 0
        Dim fSize As Double = 0

        Dim S As String = "Update ZipFile set NumberOfZipFiles = " + NumberOfZipFiles.ToString + " where FQN = @FileName) "

        setSLConn()
        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 47: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.Parameters.AddWithValue("@FileName", FileName)
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/setZipNbrOfFiles - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        Return B

    End Function

    ''' <summary>
    ''' Sets the zip in work.
    ''' </summary>
    ''' <param name="FileName">Name of the file.</param>
    ''' <param name="NumberOfZipFiles">The number of zip files.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function setZipInWork(ByVal FileName As String, ByVal NumberOfZipFiles As Integer) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim B As Boolean = True
        Dim UseArchiveBit As Integer = 0
        Dim fSize As Double = 0

        Dim S As String = "Update ZipFile set InWork = 1 where FQN = @FileName) "

        setSLConn()
        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 48: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If


        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.Parameters.AddWithValue("@FileName", FileName)
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/setZipInWork - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        Return B

    End Function

    ''' <summary>
    ''' Cleans the zip files.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function cleanZipFiles() As Boolean

        Dim B As Boolean = True
        Dim S As String = ""

        Try
            If gTraceFunctionCalls.Equals(1) Then
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
            End If


            Dim UseArchiveBit As Integer = 0
            Dim fSize As Double = 0
            S = "delete from ZipFile where SuccessfullyProcessed = 1 "
            Dim db = System.Configuration.ConfigurationManager.AppSettings("SQLiteLocalDB")

            If Not File.Exists(db) Then
                MessageBox.Show("FATAL ERR 44 SQLite DB MISSING: " + db)
            End If

            Dim cs As String = "data source=" + db
            Dim SQLiteCONN As New SQLiteConnection

            Using SQLiteCONN
                SQLiteCONN.ConnectionString = cs
                SQLiteCONN.Open()
                Dim CMD As New SQLiteCommand(S, SQLiteCONN)
                Using CMD
                    Try
                        CMD.ExecuteNonQuery()
                    Catch ex As Exception
                        LOG.WriteToArchiveLog("ERROR 00: clsDbLocal/cleanZipFiles - " + ex.Message + Environment.NewLine + S)
                        B = False
                    Finally
                        GC.Collect()
                        GC.WaitForPendingFinalizers()
                    End Try
                End Using
            End Using
            B = True
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR 01: clsDbLocal/cleanZipFiles - " + ex.Message + Environment.NewLine + S)
            B = False
        End Try

        Return B

    End Function

    ''' <summary>
    ''' Zeroizes the zip files.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function zeroizeZipFiles() As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim B As Boolean = True
        Dim UseArchiveBit As Integer = 0
        Dim fSize As Double = 0

        Dim S As String = "delete from ZipFile "

        setSLConn()
        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 50: The Local DB failed to open.: " + gLocalDBCS)
                Return 0
            End If
        End If


        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/zeroizeZipFiles - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        Return B

    End Function

    ''' <summary>
    ''' Gets the zip files.
    ''' </summary>
    ''' <param name="L">The l.</param>
    Sub getZipFiles(ByRef L As SortedList(Of String, Integer))
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        setSLConn()
        Dim FQN As String = Nothing

        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 51: The Local DB failed to open.: " + gLocalDBCS)
                Return
            End If
        End If


        Dim S As String = "Select FQN from ZipFile where InWork = 0"

        Try

            Dim CMD As New SQLiteCommand(S, SQLiteCONN)
            '** if you don’t set the result set to scrollable HasRows does not work
            Dim rs As SQLiteDataReader = CMD.ExecuteReader()

            If rs.HasRows Then
                Do While rs.Read()
                    FQN = rs.GetString(0)
                    If L.ContainsKey(FQN) Then
                    Else
                        L.Add(FQN, L.Count)
                    End If
                Loop
            End If

            If Not rs.IsClosed Then
                rs.Close()
            End If
            rs.Dispose()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/getZipFiles - " + ex.Message + Environment.NewLine + S)
        Finally
            'If SQLiteCONN IsNot Nothing Then
            '    If SQLiteCONN.State = ConnectionState.Open Then
            '        SQLiteCONN.Close()
            '    End If
            '    SQLiteCONN.Dispose()
            'End If
        End Try
        GC.Collect()
        GC.WaitForPendingFinalizers()
    End Sub

    ''' <summary>
    ''' Gets the ce email identifiers.
    ''' </summary>
    ''' <param name="L">The l.</param>
    Sub getCE_EmailIdentifiers(ByRef L As SortedList)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If


        Dim sKey As String = Nothing
        Dim RowID As Integer = Nothing

        Dim S As String = "Select sKey,RowID from Outlook"

        If bSQLiteCOnnected.Equals(False) Then
            setSLConn()
        End If

        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 52: The Local DB failed to open.: " + gLocalDBCS)
                Return
            End If
        End If


        Try
            Dim CMD As New SQLiteCommand(S, SQLiteCONN)
            CMD.CommandType = CommandType.Text

            '** if you don’t set the result set to scrollable HasRows does not work
            Dim rs As SQLiteDataReader = CMD.ExecuteReader()

            If rs.HasRows Then
                Do While rs.Read()
                    sKey = rs.GetString(0)
                    RowID = rs.GetInt32(1)
                    Try
                        If Not L.ContainsKey(sKey) Then
                            L.Add(sKey, RowID)
                        End If
                    Catch ex As Exception
                        Console.WriteLine(ex.Message)
                    End Try
                Loop
            End If

            If Not rs.IsClosed Then
                rs.Close()
            End If
            rs.Dispose()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/BackupOutlookTbl - " + ex.Message + Environment.NewLine + S)
        Finally
            If SQLiteCONN IsNot Nothing Then
                If SQLiteCONN.State = ConnectionState.Open Then
                    SQLiteCONN.Close()
                End If
            End If
        End Try
        GC.Collect()
        GC.WaitForPendingFinalizers()
    End Sub

    ''' <summary>
    ''' Sets the listener connection.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function setListenerConn() As Boolean

        If Not File.Exists(SQLiteListenerDB) Then
            LOG.WriteToArchiveLog("FATAL ERROR: Listener SQLite DB does not exist: " + SQLiteListenerDB)
            MessageBox.Show("FATAL ERROR: Listener SQLite DB does not exist: " + SQLiteListenerDB)
            Return False
        End If

        Dim cs As String = ""
        Dim bb As Boolean = True

        If Not ListernerConn.State.Equals(ListernerConn.State.Open) Then
            Try
                cs = "data source=" + SQLiteListenerDB
                ListernerConn.ConnectionString = cs
                ListernerConn.Open()
                bb = True
                'bSQLiteCOnnected = True
            Catch ex As Exception
                bb = False
                LOG.WriteToArchiveLog("ERROR setListenerConn: CS=" + cs + Environment.NewLine + ex.Message)
            End Try
        End If

        Return bb

    End Function

    ''' <summary>
    ''' Sets the sl connection.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function setSLConn() As Boolean

        Dim bb As Boolean = True

        Dim cs As String = ""

        If Not SQLiteCONN.State.Equals(SQLiteCONN.State.Open) Then
            Try
                Dim slDatabase = System.Configuration.ConfigurationManager.AppSettings("SQLiteLocalDB")

                If Not File.Exists(slDatabase) Then
                    MessageBox.Show("FATAL ERR SQLite DB MISSING: " + slDatabase)
                End If

                cs = "data source=" + slDatabase
                gLocalDBCS = cs
                SQLiteCONN.ConnectionString = cs
                SQLiteCONN.Open()
                bb = True
                bSQLiteCOnnected = True
            Catch ex As Exception
                Dim LG As New clsLogging
                LG.WriteToArchiveLog("ERROR LOCALDB setSLConn: " + ex.Message + Environment.NewLine + cs)
                LG = Nothing
                bb = False
                bSQLiteCOnnected = False
            End Try
        End If

        Return bb
    End Function

    ''' <summary>
    ''' Gets the sl connection.
    ''' </summary>
    ''' <returns>System.Object.</returns>
    Public Function getSLConn() As Object

        Dim NewConn As New SQLiteConnection()
        Dim slDatabase = System.Configuration.ConfigurationManager.AppSettings("SQLiteLocalDB")
        Dim cs As String = "data source=" + slDatabase

        Try
            NewConn.ConnectionString = cs
            NewConn.Open()
        Catch ex As Exception
            Dim LG As New clsLogging
            LG.WriteToArchiveLog("ERROR LOCALDB getSLConn: " + ex.Message + Environment.NewLine + cs)
            LG = Nothing
            NewConn = Nothing
        End Try

        Return NewConn

    End Function

    ''' <summary>
    ''' Closes the sl connection.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function closeSLConn() As Boolean
        Dim bb As Boolean = False

        If SQLiteCONN.State.Equals(SQLiteCONN.State.Open) Then

            Try
                SQLiteCONN.Close()
                bb = True
            Catch ex As Exception
                bb = False
            Finally
                SQLiteCONN.Dispose()
            End Try
        End If
        Return bb
    End Function



#Region "IDisposable Support"
    ''' <summary>
    ''' The disposed value
    ''' </summary>
    Private disposedValue As Boolean ' To detect redundant calls

    ' IDisposable
    ''' <summary>
    ''' Releases unmanaged and - optionally - managed resources.
    ''' </summary>
    ''' <param name="disposing"><c>true</c> to release both managed and unmanaged resources; <c>false</c> to release only unmanaged resources.</param>
    Protected Overridable Sub Dispose(disposing As Boolean)
        If Not disposedValue Then
            If disposing Then
                ' TODO: dispose managed state (managed objects).
                RemoveHandler currDomain.UnhandledException, AddressOf MYExnHandler
                RemoveHandler Application.ThreadException, AddressOf MYThreadHandler
            End If

            ' TODO: free unmanaged resources (unmanaged objects) and override Finalize() below.
            ' TODO: set large fields to null.
        End If
        disposedValue = True
    End Sub

    ''' <summary>
    ''' Gets the use last archive date active.
    ''' </summary>
    Sub getUseLastArchiveDateActive()

        Dim S As String = "select cast(LastArchiveDate as text), LastArchiveDateActive from LastArchive"

        setSLConn()

        If bSQLiteCOnnected.Equals(False) Then
            If Not setSLConn() Then
                MessageBox.Show("NOTICE 52 isUseLastArchiveDateActive: The Local DB failed to open.: " + gLocalDBCS)
                Return
            End If
        End If

        Dim sDate As String = ""
        Dim LWD As DateTime = Nothing
        Dim ArchiveFlg As String = ""

        Try
            Dim CMD As New SQLiteCommand(S, SQLiteCONN)
            CMD.CommandType = CommandType.Text

            '** if you don’t set the result set to scrollable HasRows does not work
            Dim rs As SQLiteDataReader = CMD.ExecuteReader()

            If rs.HasRows Then
                rs.Read()
                sDate = rs.GetString(0)
                LWD = Convert.ToDateTime(sDate)
                ArchiveFlg = rs.GetString(1)
                Try
                    If ArchiveFlg.Equals("1") Then
                        gUseLastArchiveDate = "1"
                        gLastArchiveDate = LWD
                    Else
                        gUseLastArchiveDate = "0"
                    End If
                Catch ex As Exception
                    Console.WriteLine(ex.Message)
                End Try

            End If

            If Not rs.IsClosed Then
                rs.Close()
            End If
            rs.Dispose()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/getUseLastArchiveDateActive - " + ex.Message + Environment.NewLine + S)
        Finally
            If SQLiteCONN IsNot Nothing Then
                If SQLiteCONN.State = ConnectionState.Open Then
                    SQLiteCONN.Close()
                End If
            End If
        End Try

    End Sub

    ''' <summary>
    ''' Sets the use last archive date active.
    ''' </summary>
    Sub setUseLastArchiveDateActive()

        Dim S As String = "update LastArchive set LastArchiveDate = '" + Now + "';"

        setSLConn()

        Dim LWD As DateTime = Nothing
        Dim ArchiveFlg As String = ""

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/zeroizeZipFiles - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

    End Sub

    ''' <summary>
    ''' Turns the off use last archive date active.
    ''' </summary>
    Sub TurnOffUseLastArchiveDateActive()

        Dim S As String = "update LastArchive set LastArchiveDateActive = '0' "

        setSLConn()

        Dim LWD As DateTime = Nothing
        Dim ArchiveFlg As String = ""

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/zeroizeZipFiles - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        getUseLastArchiveDateActive()

    End Sub

    ''' <summary>
    ''' Gets the count use last archive date active.
    ''' </summary>
    ''' <returns>System.Int32.</returns>
    Function getCountUseLastArchiveDateActive() As Integer

        Dim I As Integer
        Dim S As String = "select count(*) from LastArchive "

        setSLConn()

        Dim CNT As DateTime = Nothing
        Try
            Dim CMD As New SQLiteCommand(S, SQLiteCONN)
            CMD.CommandType = CommandType.Text

            '** if you don’t set the result set to scrollable HasRows does not work
            Dim rs As SQLiteDataReader = CMD.ExecuteReader()

            If rs.HasRows Then
                Do While rs.Read()
                    I = rs.GetInt32(0)
                Loop
            End If

            If Not rs.IsClosed Then
                rs.Close()
            End If
            rs.Dispose()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/BackupOutlookTbl - " + ex.Message + Environment.NewLine + S)
        Finally
            If SQLiteCONN IsNot Nothing Then
                If SQLiteCONN.State = ConnectionState.Open Then
                    SQLiteCONN.Close()
                End If
            End If
        End Try

        Return I
    End Function

    ''' <summary>
    ''' Sets the first use last archive date active.
    ''' </summary>
    Sub setFirstUseLastArchiveDateActive()

        Dim I As Integer = getCountUseLastArchiveDateActive()
        Dim S As String = ""
        If I.Equals(0) Then
            S = "insert into LastArchive (LastArchiveDate,LastArchiveDateActive) values ('01/01/1960', '0')"
        Else
            Return
        End If

        setSLConn()

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/InitUseLastArchiveDateActive - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        getUseLastArchiveDateActive()

    End Sub

    ''' <summary>
    ''' Zeroizes the last archive date.
    ''' </summary>
    Sub ZeroizeLastArchiveDate()
        Dim S As String = "Delete from LastArchive "

        setSLConn()

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/ZeroizeLastArchiveDate - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

    End Sub

    ''' <summary>
    ''' Initializes the use last archive date active.
    ''' </summary>
    ''' <param name="InitDate">The initialize date.</param>
    Sub InitUseLastArchiveDateActive(InitDate As String)

        Dim today As DateTime = DateTime.Now
        Dim Day_7 As DateTime = today.AddDays(-5)
        Dim I As Integer = getCountUseLastArchiveDateActive()
        Dim S As String = ""
        If I.Equals(0) And InitDate.Length.Equals(0) Then
            S = "insert into LastArchive (LastArchiveDate,LastArchiveDateActive) values ('" + Day_7.ToString + "', '1')"
        ElseIf I.Equals(1) Then
            S = "update LastArchive set LastArchiveDate = '" + InitDate + "' "
        ElseIf I > 1 Then
            ZeroizeLastArchiveDate()
            S = "insert into LastArchive (LastArchiveDate,LastArchiveDateActive) values ('" + InitDate + "', '1')"
        ElseIf I.Equals(0) Then
            S = "insert into LastArchive (LastArchiveDate,LastArchiveDateActive) values ('" + InitDate + "', '1')"
        End If

        setSLConn()

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/InitUseLastArchiveDateActive - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        getUseLastArchiveDateActive()

    End Sub

    ''' <summary>
    ''' Turns the on use last archive date active.
    ''' </summary>
    Sub TurnOnUseLastArchiveDateActive()

        Dim S As String = "update LastArchive set LastArchiveDateActive = '1' "

        setSLConn()

        Dim LWD As DateTime = Nothing
        Dim ArchiveFlg As String = ""

        Dim CMD As New SQLiteCommand(S, SQLiteCONN)
        Try
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: clsDbLocal/zeroizeZipFiles - " + ex.Message + Environment.NewLine + S)
            B = False
        Finally
            CMD.Dispose()
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        getUseLastArchiveDateActive()

    End Sub

    ''' <summary>
    ''' Validates the databases.
    ''' </summary>
    Sub ValidateDatabases()

        Dim SQLiteListenerDB As String = System.Configuration.ConfigurationManager.AppSettings("SQLiteListenerDB")
        Dim SQLiteLocalDB As String = System.Configuration.ConfigurationManager.AppSettings("SQLiteLocalDB")
        Dim FTIAnalysisDB As String = System.Configuration.ConfigurationManager.AppSettings("FTIAnalysisDB")
        Dim DB As String = ""
        Dim FName As String = ""

        FName = Path.GetFileName(SQLiteListenerDB)
        Dim AppPath As String = My.Application.Info.DirectoryPath
        Dim tgtDB As String() = Directory.GetFiles(AppPath, FName, SearchOption.AllDirectories)

        If Not File.Exists(SQLiteListenerDB) Then
            Try
                DB = tgtDB(0)
                If File.Exists(DB) Then
                    File.Copy(DB, SQLiteListenerDB)
                End If
            Catch ex As Exception
                MessageBox.Show("Failed to create SQLiteListenerDB")
            End Try
        End If

        FName = Path.GetFileName(SQLiteLocalDB)
        If Not File.Exists(SQLiteLocalDB) Then
            tgtDB = Directory.GetFiles(AppPath, FName, SearchOption.AllDirectories)
            Try
                DB = tgtDB(0)
                If File.Exists(DB) Then
                    File.Copy(DB, SQLiteLocalDB)
                End If
            Catch ex As Exception
                MessageBox.Show("Failed to create SQLiteLocalDB")
            End Try
        End If

        FName = Path.GetFileName(FTIAnalysisDB)
        If Not File.Exists(FTIAnalysisDB) Then
            tgtDB = Directory.GetFiles(AppPath, FName, SearchOption.AllDirectories)
            Try
                DB = tgtDB(0)
                If File.Exists(DB) Then
                    File.Copy(DB, FTIAnalysisDB)
                End If
            Catch ex As Exception
                MessageBox.Show("Failed to create FTIAnalysisDB")
            End Try
        End If

    End Sub

    ''' <summary>
    ''' Gets the file inventory.
    ''' </summary>
    ''' <returns>Dictionary(Of System.String, DateTime).</returns>
    Function getFileInventory() As Dictionary(Of String, DateTime)

        Dim DICT As New Dictionary(Of String, DateTime)

        bConnSet = setListenerConn()

        Dim FilesToProcess As New List(Of String)
        Dim sql As String = "select FQN, RowCreateDate from FileNeedProcessing;"
        Dim FQN As String = ""
        Dim DirName As String = ""
        Dim i As Integer = 0

        Using CMD As New SQLiteCommand(sql, ListernerConn)
            CMD.CommandText = sql
            Dim rdr As SQLiteDataReader = CMD.ExecuteReader()
            Using rdr
                While (rdr.Read())
                    FQN = rdr.GetValue(0).ToString()
                    DirName = Path.GetDirectoryName(FQN)
                    If Not FilesToProcess.Contains(DirName) Then
                        FilesToProcess.Add(DirName)
                        Exit While
                    End If
                End While
            End Using
        End Using

        If FilesToProcess.Count.Equals(0) Then
            FilesToProcess.Add("C:\temp")
        End If

        Return DICT

    End Function

    ''' <summary>
    ''' Loads the dirs.
    ''' </summary>
    ''' <returns>Dictionary(Of System.String, System.Int32).</returns>
    Function LoadDirs() As Dictionary(Of String, Integer)

        Dim DIRS As New Dictionary(Of String, Integer)
        Dim sql As String = "select DirName, DirID from [Directory] order by DirID  desc;"
        Dim FQN As String = ""
        Dim DirName As String = ""
        Dim DirID As Integer = 0
        Dim i As Integer = 0

        setSLConn()
        Dim CMD As New SQLiteCommand(sql, SQLiteCONN)

        Try
            Using CMD
                CMD.CommandText = sql
                Dim rdr As SQLiteDataReader = CMD.ExecuteReader()
                Using rdr
                    While (rdr.Read())
                        DirName = rdr.GetValue(0).ToString()
                        DirID = rdr.GetInt32(1)
                        If Not DIRS.Keys.Contains(DirName) Then
                            DIRS.Add(DirName, DirID)
                        End If
                    End While
                End Using
            End Using
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR DBLOCAL/LoadDirs: " + ex.Message)
        End Try

        Return DIRS

    End Function

    ''' <summary>
    ''' Loads the files from the SQLite database.
    ''' </summary>
    ''' <returns>Dictionary(Of System.String, System.Int32).</returns>
    Function LoadFiles() As Dictionary(Of String, Integer)

        Dim FILES As New Dictionary(Of String, Integer)
        Dim sql As String = "select FileName, FileID from [Files] order by FileID desc;"
        Dim FQN As String = ""
        Dim FileName As String = ""
        Dim FileID As Integer = 0
        Dim i As Integer = 0

        setSLConn()
        Dim CMD As New SQLiteCommand(sql, SQLiteCONN)

        Try
            Using CMD
                CMD.CommandText = sql
                Dim rdr As SQLiteDataReader = CMD.ExecuteReader()
                Using rdr
                    While (rdr.Read())
                        FileName = rdr.GetValue(0).ToString()
                        FileID = rdr.GetInt32(1)
                        If Not FILES.Keys.Contains(FileName) Then
                            FILES.Add(FileName, FileID)
                        End If
                    End While
                End Using
            End Using
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR DBLOCAL/LoadFiles : " + ex.Message)
        End Try

        Return FILES

    End Function


    ' TODO: override Finalize() only if Dispose(disposing As Boolean) above has code to free unmanaged resources.
    'Protected Overrides Sub Finalize()
    '    ' Do not change this code.  Put cleanup code in Dispose(disposing As Boolean) above.
    '    Dispose(False)
    '    MyBase.Finalize()
    'End Sub

    ' This code added by Visual Basic to correctly implement the disposable pattern.
    ''' <summary>
    ''' Performs application-defined tasks associated with freeing, releasing, or resetting unmanaged resources.
    ''' </summary>
    Public Sub Dispose() Implements IDisposable.Dispose
        ' Do not change this code.  Put cleanup code in Dispose(disposing As Boolean) above.
        Dispose(True)
        SQLiteCONN.Dispose()
        ListernerConn.Dispose()
        ' TODO: uncomment the following line if Finalize() is overridden above.
        ' GC.SuppressFinalize(Me)
    End Sub
#End Region

End Class