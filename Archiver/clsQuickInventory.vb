Imports System.IO

Public Class clsQuickInventory

    Public UTIL As New clsUtility
    Public LOG As New clsLogging
    Dim DBLocal As New clsDbLocal
    Dim DBA As New clsDatabaseARCH
    Dim DS As DataSet = Nothing
    Dim ArchiveList As New List(Of String)
    Dim ListOfDirs As New List(Of String)
    Dim ListOfAllowedExt As New Dictionary(Of String, String)
    Dim FRM As New frmNotify
    Dim DictOfDirs As Dictionary(Of String, String)
    Dim DictOfWC As New Dictionary(Of String, String)

    Function PerformFastInventory(MachineName As String, UserID As String) As List(Of String)

        FRM.Title = "QUICK Archive with Inventory"
        FRM.Show()
        Dim Recurse As String = ""

        Try
            getUserDIRS()
            FRM.Label1.Text = "Standby, pulling repo data... "
            FRM.Refresh()
            Application.DoEvents()

            DS = GetRepoInventory(MachineName, UserID)
            ListOfDirs = DBA.getListOf("select FQN from Directory where UserID = '" + gCurrLoginID + "' and IncludeSubDirs = 'Y' ;")

            FRM.Label1.Text = "Data Pulled"
            FRM.Refresh()
            Application.DoEvents()
            Dim K As Integer = 0

            For Each DirName As String In DictOfDirs.Keys
                Try
                    K += 1
                    Dim WhereIN As String = gWhereInDict(DirName)

                    If Not WhereIN.Equals("0") Then
                        If Directory.Exists(DirName) Then
                            Recurse = DictOfDirs(DirName).ToUpper
                            ProcessDirectory(DirName, Recurse, WhereIN)
                        Else
                            LOG.WriteToArchiveLog("NOTICE PerformFastInventory 020: Directory <" + DirName + ">, not found... skipping.")
                        End If
                    End If
                Catch ex As Exception
                    LOG.WriteToArchiveLog("ERROR PerformFastInventory 010: " + ex.Message)
                End Try
            Next
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR PerformFastInventory 00: " + ex.Message)
        End Try

        FRM.Dispose()
        FRM.Close()
        frmNotify.Close()

        Return ArchiveList

    End Function

    Function GetAllSubFolders(ByVal path As String) As IEnumerable(Of DirectoryInfo)
        Dim subFolders As New List(Of DirectoryInfo)

        Try
            subFolders.AddRange(New DirectoryInfo(path).GetDirectories())
        Catch ex As Exception
            'error handling code goes here'
            Console.WriteLine(ex.Message)
        End Try

        Dim innerSubFolders As New List(Of DirectoryInfo)
        For Each folder In subFolders
            innerSubFolders.AddRange(GetAllSubFolders(folder.FullName))
        Next

        'add the inner sub folders'
        subFolders.AddRange(innerSubFolders)

        'return the directories'
        Return subFolders
    End Function

    Public Function GetFilesWithoutErrors(ByVal sourceFolder As String, ByVal filter As String) As List(Of String)

        Dim list = New List(Of String)()

        For Each subfolder As String In Directory.GetDirectories(sourceFolder)

            Try
                list.AddRange(GetFilesWithoutErrors(subfolder, filter))
            Catch __unusedException1__ As Exception
            End Try
        Next

        list.AddRange(Directory.GetFiles(sourceFolder, filter))
        Return list

    End Function

    Function ProcessDirectory(DirName As String, Recurse As String, WhereIN As String) As Integer

        Dim watch As Stopwatch = Stopwatch.StartNew()

        If Not Directory.Exists(DirName) Then
            LOG.WriteToArchiveLog("ERROR: <" + DirName + "> no longer exists, skipping.")
            Return 0
        End If

        Dim AllowedExts As String = DBA.getIncludedFileTypeWhereIn(gCurrLoginID, DirName)
        AllowedExts = AllowedExts + ","
        'AllowedExts = WhereIN
        Dim FQN As String = ""
        Dim FileLEngth As Int64 = 0
        Dim LastWriteDate As DateTime = Now

        Dim Yr1 As String = ""
        Dim Mo1 As String = ""
        Dim Da1 As String = ""
        Dim Sec1 As String = ""
        Dim Yr2 As String = ""
        Dim Mo2 As String = ""
        Dim Da2 As String = ""
        Dim Sec2 As String = ""
        Dim iTotal = 0
        Dim LL As Integer = 0

        Dim directories As String() = Nothing
        Dim ListOfDirs As New List(Of String)

        Try
            LL = 1000
            If Recurse.ToUpper.Equals("Y") Then
                ListOfDirs.Add(DirName)
                directories = Directory.GetDirectories(DirName, "*.*", SearchOption.AllDirectories)
                For Each sitem As String In directories
                    If Not ListOfDirs.Contains(sitem) Then
                        ListOfDirs.Add(sitem)
                    End If
                Next
                directories = Nothing
            Else
                ListOfDirs.Add(DirName)
            End If

            ListOfDirs.Sort()

            Dim iDirCnt As Integer = 0
            LL = 900

            For Each CurrDir As String In ListOfDirs
                LL = 905
                Try
                    iDirCnt += 1
                    FRM.Label1.Text = "CurrDir: " + iDirCnt.ToString + " of " + ListOfDirs.Count.ToString
                    FRM.Refresh()
                    LL = 910
                    iTotal = 0

                    'If (CurrDir <> CurrDir + "/System Volume Information") Then
                    If Not CurrDir.ToLower.Contains("volume information") Then
                        Dim di As DirectoryInfo = New DirectoryInfo(CurrDir)
                        LL = 1
                        For Each fi As FileInfo In di.GetFiles("*.*", SearchOption.AllDirectories)

                            iTotal += 1
                            LL = 2

                            FRM.lblFileSpec.Text = fi.DirectoryName
                            FRM.lblPdgPages.Text = "Files #" + iTotal.ToString
                            Application.DoEvents()

                            Try
                                If fi.FullName.Contains(".") And Not fi.FullName.Contains(".git") And Not fi.FullName.Contains("\git\") Then
                                    LL = 3
                                    Application.DoEvents()
                                    LL = 4
                                    'Dim TgtExt As String = fi.Extension.ToLower + ","
                                    Dim TgtExt As String = fi.Extension.ToLower + ","
                                    Dim TgtDir As String = fi.DirectoryName
                                    LL = 5
                                    LastWriteDate = fi.LastWriteTime
                                    FQN = fi.FullName
                                    LL = 6
                                    If TgtExt.Equals(".zip,") Then
                                        Console.WriteLine("ZIP: " + fi.FullName)
                                    End If
                                    If AllowedExts.Contains(TgtExt) Then
                                        LL = 7
                                        If FQN.Contains("'") Then
                                            FQN = FQN.Replace("''", "'")
                                            FQN = FQN.Replace("'", "''")
                                        End If
                                        Dim Rows() As DataRow = DS.Tables(0).Select("FileLength > 0 And LastWriteTime > #01-01-1900# and  Fqn = '" + FQN + "' ")
                                        LL = 8
                                        If Rows.Count.Equals(1) Then
                                            Try
                                                LL = 9
                                                FileLEngth = Convert.ToInt64(Rows(0).Item("FileLEngth"))
                                                LastWriteDate = Convert.ToDateTime(Rows(0).Item("LastWriteTime"))
                                                LL = 10
                                                Dim CurrnoOfSeconds As Integer = (Now - fi.LastWriteTime).TotalMinutes
                                                Dim PrevnoOfSeconds As Integer = (Now - LastWriteDate).TotalMinutes
                                                LL = 11
                                                If CurrnoOfSeconds < PrevnoOfSeconds Or FileLEngth <> fi.Length Then
                                                    LL = 12
                                                    ArchiveList.Add(fi.FullName)
                                                End If
                                                LL = 13
                                            Catch ex As Exception
                                                LOG.WriteToArchiveLog("ERROR ProcessDirectory 100: LL=" + LL.ToString + Environment.NewLine + FQN + Environment.NewLine + ex.Message)
                                            End Try
                                        Else
                                            LL = 14
                                            Dim fext As String = Path.GetExtension(FQN)
                                            LL = 15
                                            ArchiveList.Add(fi.FullName)
                                        End If
                                        LL = 16
                                    End If
                                    LL = 17
                                End If
                                LL = 18
                            Catch ex As Exception
                                LOG.WriteToArchiveLog("ERROR ProcessDirectory 11: LL=" + LL.ToString + Environment.NewLine + FQN + Environment.NewLine + ex.Message)
                            End Try
                            LL = 19
                            di = Nothing
                        Next
                        LL = 20
                    Else
                        LOG.WriteToArchiveLog("Notice 01: skipping systems directory: LL=" + LL.ToString + " : " + CurrDir + "/System Volume Information")
                    End If
                Catch ex As Exception
                    LOG.WriteToArchiveLog("ERROR ProcessDirectory 22X1: LL=" + LL.ToString + " : " + "DIRNAME: " + CurrDir + Environment.NewLine + ex.Message)
                End Try
            Next
        Catch ex As Exception

            LOG.WriteToArchiveLog("ERROR Processdirectory 00: LL=" + LL.ToString + "Recurse <" + Recurse + ">" + Environment.NewLine + "DIRNAME: <" + DirName + ">" + Environment.NewLine + "FQN: <" + FQN + ">" + Environment.NewLine + ex.Message)
        End Try

        watch.Stop()

        'FRM.Close()
        'FRM.Dispose()

        Return iTotal


    End Function

    Sub getUserDIRS()

        DictOfDirs = DBA.GetUserDirectories(gCurrLoginID)

    End Sub

    Function getLIstOfAllowedEXtensions(DirName As String, AllowedExt As Dictionary(Of String, String)) As String
        Dim Level As Integer = 0
        Dim exts As String = DBLocal.getAllowedExtension(DirName, Level, AllowedExt)
        Return exts
    End Function

    Function getLIstOfAllowedEXtensions(DirName As String) As String
        Dim Level As Integer = 0
        Dim exts As String = DBLocal.getAllowedExtension(DirName, Level, DictOfWC)
        Return exts
    End Function

    Function GetRepoInventory(MachineName As String, UserID As String) As DataSet

        Dim DS As DataSet = Nothing
        Dim ListOfExts As New List(Of String)
        'Dim AllowedExtensions As String = ""

        Try
            'AllowedExtensions = AllowedExtensions.Trim
            'AllowedExtensions = AllowedExtensions.Substring(0, AllowedExtensions.Length - 1)
            Dim AllExts As String = ""
            ListOfExts = DBA.getListOf("select distinct LOWER(EXtcode) from IncludedFiles where UserID = '" + gCurrLoginID + "' ")
            For Each ext As String In ListOfExts
                AllExts = AllExts + "'" + ext + "',"
            Next
            AllExts = AllExts.Substring(0, AllExts.Length - 1)

            Dim MySql As String = "Select Fqn , RowGuid, MachineID, UserID, LastWriteTime, FileLength from datasource
                    where MachineID = '" + MachineName + "' and UserID = '" + UserID + "' " +
                    " AND OriginalFileType in (" + AllExts + ")"

            DS = DBA.getDataSet(MySql)

        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR GetRepoInventory: " + ex.Message)
        End Try

        Return DS
    End Function


End Class
