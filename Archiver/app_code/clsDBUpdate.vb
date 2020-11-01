Imports System.IO
Imports System.Data.SqlClient

Public Class clsDBUpdate

    Dim UpdateINfo As New List(Of FileInfo)
    Dim FilterList As New List(Of String)

    Dim DB As New clsDatabaseARCH
    Dim LOG As New clsLogging

    Public Function CheckForDBUpdates() As Boolean

        frmDBUpdates.Text = "Applying Database Updates"

        FilterList.Clear()
        FilterList.Add("*.sql")

        Dim FLDR As String = System.AppDomain.CurrentDomain.BaseDirectory()
        Dim UPDTFOLDER As String = FLDR + "\DBUpdates"

        Dim strFileSize As String = ""
        Dim di As New IO.DirectoryInfo(UPDTFOLDER)
        Dim aryFi As IO.FileInfo() = di.GetFiles("*.sql")
        Dim fi As IO.FileInfo
        Dim iline As Integer = 0

        For Each fi In aryFi

            Dim FName As String = fi.Name
            Dim FQN As String = fi.FullName
            Dim LastWriteTime As DateTime = fi.LastWriteTime
            Dim I As Integer = DB.getDBUpdateExists(FQN)

            frmDBUpdates.SB.Text = fi.Name
            frmDBUpdates.Refresh()
            Application.DoEvents()

            If I > 0 Then
                Dim DateApplied As DateTime = DB.getDBUpdateLastWriteDate(FQN)
                Dim secs As Integer = SecDiff(LastWriteTime, DateApplied)
                'If LastWriteTime > DateApplied Then
                If secs > 0 Then
                    Dim fn As String = Path.GetFileName(FQN)
                    LOG.WriteToArchiveLog("APPLYING DB UPDATE: " + fn)
                    frmDBUpdates.txtFile.Text = Path.GetFileName(FQN)
                    ApplyUpdate(FQN)
                    LOG.WriteToArchiveLog("COMPLETED DB UPDATE: " + fn)
                    Console.WriteLine("APPLIED")
                End If
            Else
                ApplyUpdate(FQN)
            End If
        Next

    End Function

    Function SecDiff(LastWriteTime As DateTime, DateApplied As DateTime) As Integer

        Dim secs As Integer = 0
        Dim span As TimeSpan = LastWriteTime.Subtract(DateApplied)

        Return span.Seconds

    End Function

    Function ApplyUpdate(FQN As String) As Integer


        Dim S As String = ""
        Dim Ifailures As Integer = 0

        Dim reader As StreamReader = My.Computer.FileSystem.OpenTextFileReader(FQN)
        Dim sline As String = ""
        Dim tline As String = ""
        Dim MySql As String = ""
        Dim cs As String = DB.getRepoConnStr
        Dim B As Boolean = False
        Dim iline As Integer = 0
        Using reader
            sline = reader.ReadLine
            Do
                iline += 1
                Application.DoEvents()
                sline = sline.Trim()
                tline = sline.ToUpper
                If tline.Equals("GO") Then
                    frmDBUpdates.txtSql.Text = Path.GetFileName(MySql)
                    frmDBUpdates.Refresh()
                    Application.DoEvents()
                    LOG.WriteToDBUpdatesLog("--************************************")
                    LOG.WriteToDBUpdatesLog("--Update File:" + FQN)
                    LOG.WriteToDBUpdatesLog(MySql)
                    B = DB.ExecuteSql(MySql, cs, False)
                    If B Then
                        B = DB.insertDBUpdate(FQN)
                        If B Then
                            LOG.WriteToArchiveLog("DB Update applied from " + FQN)
                            B = MarkFileAsApplied(FQN, cs)
                            If B Then
                                Dim FN As String = Path.GetFileName(FQN)
                                LOG.WriteToArchiveLog("Notice DB Update:" + FN + " marked as APPLIED.")
                                DB.updateDBUpdateLastwrite(FQN)
                            End If
                        End If
                    Else
                        LOG.WriteToArchiveLog("ERROR: DB Update FAILED from " + FQN + vbCrLf + MySql)
                    End If
                    MySql = ""
                Else
                    MySql += sline + Environment.NewLine
                End If
                sline = reader.ReadLine
            Loop Until sline Is Nothing
        End Using

        If MySql.Trim.Length > 0 Then
            frmDBUpdates.txtSql.Text = Path.GetFileName(MySql)
            LOG.WriteToDBUpdatesLog("--************************************")
            LOG.WriteToDBUpdatesLog("--Update File:" + FQN)
            LOG.WriteToDBUpdatesLog(MySql)
            B = DB.ExecuteSql(MySql, cs, False)
            If B Then
                B = DB.insertDBUpdate(FQN)
                If B Then
                    LOG.WriteToArchiveLog("DB Update applied from " + FQN)
                    B = MarkFileAsApplied(FQN, cs)
                    DB.updateDBUpdateLastwrite(FQN)
                    If B Then
                        Dim FN As String = Path.GetFileName(FQN)
                        LOG.WriteToArchiveLog("Notice DB  Update: " + FN + " marked as APPLIED.")
                    End If
                End If
            Else
                LOG.WriteToArchiveLog("ERROR: DB Update FAILED from " + FQN + vbCrLf + MySql)
            End If
        End If

        B = MarkFileAsApplied(FQN, cs)

        frmDBUpdates.txtSql.Text = ""

        Return Ifailures

    End Function

    Public Function MarkFileAsApplied(FQN As String, cs As String) As Boolean
        Dim b As Boolean = True
        FQN = FQN.Replace("'", "''")
        Dim MySql As String = "update DBUpdate set UpdateApplied = 1 where FileName = '" + FQN + "'"

        b = DB.ExecuteSql(MySql, cs, False)

        Return b

    End Function


    Public Function GetFiles(ByVal Path As String, ByVal FilterList As List(Of String)) As List(Of FileInfo)
        Dim d As New DirectoryInfo(Path)
        Dim files As List(Of FileInfo) = New List(Of FileInfo)
        For Each Filter As String In FilterList
            'the files are appended to the file array
            Application.DoEvents()
            files.AddRange(d.GetFiles(Filter))
        Next
        files.Sort(f >= f.LastWritetime)
        Return files
    End Function

End Class
