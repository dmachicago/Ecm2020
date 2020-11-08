Imports System.IO

Public Class clsQuickInventory

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

    Function PerformQuickInventory(MachineName As String, UserID As String) As List(Of String)

        FRM.Title = "QUICK Archive with Inventory"
        FRM.Show()
        Dim Recurse As String = ""

        Try
            getUserDIRS()

            DS = GetRepoInventory(MachineName, UserID)
            ListOfDirs = DBA.getListOf("select distinct FileDirectory from datasource where FileDirectory Is Not null And ltrim(rtrim(FileDirectory)) != '' order by FileDirectory ")

            For Each DirName As String In DictOfDirs.Keys
                Recurse = DictOfDirs(DirName).ToUpper
                ProcessDirectory(DirName, Recurse)
            Next
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR PerformQuickInventory 00: " + ex.Message)
        End Try


        FRM.Dispose()
        FRM.Close()

        Return ArchiveList

    End Function

    Function ProcessDirectory(DirName As String, Recurse As String) As Integer

        Dim watch As Stopwatch = Stopwatch.StartNew()

        If Not Directory.Exists(DirName) Then
            Return 0
        End If

        Dim AllowedExts As String = DBA.getIncludedFileTypeWhereIn(gCurrLoginID, DirName)
        AllowedExts = AllowedExts + ","
        Dim FQN As String = ""
        Dim FileLEngth As Int64 = 0
        Dim LastWriteDate As DateTime = Now
        Dim di As DirectoryInfo = New DirectoryInfo(DirName)
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

        Try
            If Recurse.ToUpper.Equals("Y") Then
                LL = 1
                For Each fi As FileInfo In di.GetFiles("*.*", SearchOption.AllDirectories)
                    iTotal += 1
                    LL = 2
                    FRM.lblFileSpec.Text = fi.DirectoryName
                    FRM.lblPdgPages.Text = "Files #" + iTotal.ToString
                    Application.DoEvents()

                    Try
                        If fi.FullName.Contains(".") And Not fi.FullName.Contains(".git") Then
                            LL = 3

                            Application.DoEvents()
                            LL = 4
                            Dim TgtExt As String = fi.Extension.ToLower + ","
                            Dim TgtDir As String = fi.DirectoryName
                            LL = 5
                            LastWriteDate = fi.LastWriteTime
                            FQN = fi.FullName
                            LL = 6
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
                                        LOG.WriteToArchiveLog("ERROR ProcessDirectory 100: LL=" + LL.ToString + vbCrLf + FQN + vbCrLf + ex.Message)
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
                        LOG.WriteToArchiveLog("ERROR ProcessDirectory 11: LL=" + LL.ToString + vbCrLf + FQN + vbCrLf + ex.Message)
                    End Try
                    LL = 19
                Next
                LL = 20
            Else
                LL = 21
                For Each fi As FileInfo In di.GetFiles("*.*", SearchOption.TopDirectoryOnly)
                    LL = 22
                    Try
                        If fi.FullName.Contains(".") And Not fi.FullName.Contains(".git") Then
                            LL = 23
                            Application.DoEvents()
                            LL = 24

                            'Dim AllowedExts As String = getLIstOfAllowedEXtensions(DirName)
                            Dim TgtExt As String = fi.Extension.ToLower + ","
                            Dim TgtDir As String = fi.DirectoryName
                            LL = 25
                            LastWriteDate = fi.LastWriteTime
                            FQN = fi.FullName
                            LL = 26
                            If AllowedExts.Contains(TgtExt) Then
                                LL = 27
                                If FQN.Contains("'") Then
                                    FQN = FQN.Replace("''", "'")
                                    FQN = FQN.Replace("'", "''")
                                End If
                                Dim Rows() As DataRow = DS.Tables(0).Select("FileLength > 0 And LastWriteTime > #01-01-1900# and  Fqn = '" + FQN + "' ")
                                LL = 28
                                If Rows.Count.Equals(1) Then
                                    Try
                                        LL = 29
                                        FileLEngth = Convert.ToInt64(Rows(0).Item("FileLEngth"))
                                        LastWriteDate = Convert.ToDateTime(Rows(0).Item("LastWriteTime"))
                                        LL = 30
                                        Dim CurrnoOfSeconds As Integer = (Now - fi.LastWriteTime).TotalMinutes
                                        Dim PrevnoOfSeconds As Integer = (Now - LastWriteDate).TotalMinutes
                                        LL = 31
                                        If CurrnoOfSeconds < PrevnoOfSeconds Or FileLEngth <> fi.Length Then
                                            LL = 32
                                            ArchiveList.Add(fi.FullName)
                                        End If
                                        LL = 34
                                    Catch ex As Exception
                                        LOG.WriteToArchiveLog("ERROR ProcessDirectory 100: LL=" + LL.ToString + vbCrLf + FQN + ex.Message)
                                    End Try
                                    LL = 34
                                Else
                                    LL = 35
                                    Dim fext As String = Path.GetExtension(FQN)
                                    LL = 36
                                    ArchiveList.Add(fi.FullName)
                                    LL = 37
                                End If
                                LL = 38
                            End If
                            LL = 39
                        End If
                        LL = 40
                    Catch ex As Exception
                        LOG.WriteToArchiveLog("ERROR ProcessDirectory 22: LL=" + LL.ToString + vbCrLf + FQN + vbCrLf + ex.Message)
                    End Try
                    LL = 41
                Next
                LL = 42
            End If
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR Processdirectory 00: LL=" + LL.ToString + vbCrLf + FQN + vbCrLf + ex.Message)
        End Try

        watch.Stop()

        FRM.Close()
        FRM.Dispose()

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
