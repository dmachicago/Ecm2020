Imports System.Data.SQLite
Imports System.IO

Public Class frmFti

    Dim CancelNow As Boolean = False
    Dim LOG As New clsLogging
    Dim DBArch As New clsDatabaseARCH
    Dim FTIAnalysisDB As String = System.Configuration.ConfigurationManager.AppSettings("FTIAnalysisDB")
    Dim DictSourceGuids As New Dictionary(Of Int64, String)
    Dim DictErrors As New Dictionary(Of String, String)
    Dim SourceKeys As New Dictionary(Of String, String)
    Dim SourceKeyCnt As New Dictionary(Of String, Integer)
    Dim FtiCONN As New SQLiteConnection()

    Private Sub frmFti_Load(sender As Object, e As EventArgs) Handles MyBase.Load

        getFtiLogs()


    End Sub

    Sub AnalyzeSelectedLogs()

    End Sub

    Sub getFtiLogs()

        Dim files() As String = IO.Directory.GetFiles(FTILogs)
        Dim FName As String = ""

        lbFtiLogs.Items.Clear()

        For Each file As String In files
            FName = Path.GetFileName(file)
            lbFtiLogs.Items.Add(FName)
            'Dim text As String = IO.File.ReadAllText(file)
        Next
    End Sub

    Private Sub btnSelectAll_Click(sender As Object, e As EventArgs) Handles btnSelectAll.Click

        Dim i As Integer
        For i = 0 To lbFtiLogs.Items.Count - 1
            lbFtiLogs.SetSelected(i, True)
        Next

    End Sub

    Private Sub btnScanGuids_Click(sender As Object, e As EventArgs) Handles btnScanGuids.Click

        If lbFtiLogs.SelectedItems.Count.Equals(0) Then
            MessageBox.Show("Please select at least one file to search, returning...")
            Return
        End If

        lbOutput.Items.Clear()

        Dim FQN As String = ""
        Dim TgtText = txtSourceGuid.Text
        Dim I As Integer = 0
        Dim IFound As Integer = 0

        Dim MaxCnt As Integer = Convert.ToInt32(txtMaxNbr.Text)
        SB.Text = "Starting Search"
        Dim K As Integer = 0
        For Each S As String In lbFtiLogs.SelectedItems
            FQN = FTILogs + "\" + S
            Dim reader As StreamReader = My.Computer.FileSystem.OpenTextFileReader(FQN)
            Dim line As String
            SBFqn.Text = S
            Me.Cursor = Cursors.WaitCursor
            Do
                Application.DoEvents()
                K += 1
                If I >= MaxCnt Then
                    Exit Do
                End If
                If K Mod 5 = 0 Then
                    SB.Text = K.ToString
                    SB.Refresh()
                End If
                line = reader.ReadLine
                If Not IsNothing(line) Then
                    If line.Contains(TgtText) Then
                        I += 1
                        lbOutput.Items.Add(line)
                        IFound += 1
                        lblMsg.Text = "Items Found: " + IFound.ToString
                    End If
                End If
            Loop Until line Is Nothing
            Me.Cursor = Cursors.Default
            reader.Close()
            reader.Dispose()
        Next
        SBFqn.Text = "Search Complete..."
    End Sub

    Function getSourceKey(line As String) As String
        Dim SourceKey As String = ""
        Dim I As Integer = 0
        Dim J As Integer = 0
        Try
            I = line.IndexOf("full-text key value")
            If I > 0 Then
                I = line.IndexOf("'", I + 1)
                If I >= 0 Then
                    J = line.IndexOf("'", I + 1)
                    If J >= 0 Then
                        SourceKey = line.Substring(I + 1, J - I - 1)
                    Else
                        Return ""
                    End If
                Else
                    Return ""
                End If
            Else
                Return ""
            End If
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR getSourceKey 00 : " + ex.Message + vbCrLf + line)
        End Try

        Return SourceKey
    End Function
    Function getErrorType(line As String) As String
        Dim ErrType As String = ""

        If line.Contains("Error '") Then
            ErrType = "Error"
        ElseIf line.Contains("Warning:") Then
            ErrType = "Warning"
        Else
            ErrType = ""
        End If
        Return ErrType

    End Function

    Function getErrorMsg(line As String) As String
        Dim ErrMsg As String = ""
        Dim I As Integer = 0
        Dim J As Integer = 0
        Dim len As Integer = 0
        Dim linelen As Integer = 0
        Try
            If line.Contains("Error '") Then
                I = line.IndexOf("Error '")
                I = line.IndexOf("'", I + 1)
                J = line.IndexOf(".'", I + 1)
                ErrMsg = line.Substring(I + 1, J - I - 1)
            ElseIf line.Contains("Warning:") Then
                'Warning: No appropriate filter was found during full-text index population for table or indexed view '[ECM.Library.FS].[dbo].[DataSource]' (table or indexed view ID '1634820886', database ID '9'), full-text key value 'DAF4BA6F-1BE7-4247-95B0-04F8D9F22A70'. Some columns of the row were not indexed.
                I = line.IndexOf("Warning:")
                I = line.IndexOf(":", I + 1)
                J = line.IndexOf("[", I + 1)
                len = J - I - 2
                linelen = line.Length
                ErrMsg = line.Substring(I + 1, len)
                ErrMsg = ErrMsg.Trim()
            End If
        Catch ex As Exception
            LOG.WriteToArchiveLog("Error 00 getErrorMsg: " + ex.Message + vbCrLf + line)
        End Try

        Return ErrMsg
    End Function

    Function getErrorTbl(line As String) As String
        Dim ErrTbl As String = ""
        Dim I As Integer = 0
        Dim J As Integer = 0
        Try
            If line.Contains("indexed view '") Then
                I = line.IndexOf("indexed view '")
                I = line.IndexOf("'", I + 1)
                J = line.IndexOf("'", I + 1)
                ErrTbl = line.Substring(I + 1, J - I - 1)
            ElseIf line.Contains("Warning: '") Then
                ErrTbl = ""
            End If
        Catch ex As Exception
            LOG.WriteToArchiveLog("Error 00 getErrorTbl: " + ex.Message + vbCrLf + line)
        End Try

        Return ErrTbl
    End Function

    Sub SummarizeLogs()
        Dim KT As New clsKeyTable
        Dim ER As New clsErrors

        Dim SourceName As String = ""
        Dim FQN As String = ""
        Dim line As String = ""
        Dim idx As Integer = 0
        Dim I As Integer = 0
        Dim J As Integer = 0
        Dim ErrorMsg As String = ""
        Dim TypeErr As String = ""
        Dim SourceKey As String = ""
        Dim ErrTbl As String = ""
        Dim ErrRowNbr As Int64 = 0
        Dim B As Boolean = True
        Dim iCnt As Int64 = 0

        Dim iTotal As Int64 = 0

        For Each LogFile As String In lbFtiLogs.SelectedItems
            FQN = FTILogs + "\" + LogFile
            SBFqn.Text = "Counting Rows: " + LogFile
            iTotal += File.ReadAllLines(FQN).Length
        Next
        PB.Maximum = iTotal
        EmptyTables()

        For Each LogFile As String In lbFtiLogs.SelectedItems
            FQN = FTILogs + "\" + LogFile
            SBFqn.Text = LogFile

            Dim AR() As String = Nothing
            Dim ReturnStr As String = ""
            Dim TypeCode As String = ""
            Dim OriginalExt As String = ""
            Using reader As StreamReader = My.Computer.FileSystem.OpenTextFileReader(FQN)
                Do
                    iCnt += 1
                    If iCnt Mod 5 = 0 Then
                        SB.Text = "Lines Processed: " + iCnt.ToString + " of " + iTotal.ToString
                        PB.Increment(5)
                        'PB.ref
                    End If
                    Application.DoEvents()
                    line = reader.ReadLine
                    If Not IsNothing(line) Then
                        '******************************
                        TypeCode = ""
                        OriginalExt = ""
                        ErrorMsg = getErrorMsg(line)
                        SourceKey = getSourceKey(line)
                        TypeErr = getErrorType(line)
                        ErrTbl = getErrorTbl(line)
                        '******************************
                        If ErrorMsg.Trim.Length > 0 And SourceKey.Trim.Length > 0 And TypeErr.Trim.Length > 0 And ErrTbl.Trim.Length > 0 Then
                            If Not SourceKeys.ContainsKey(SourceKey) Then
                                ReturnStr = DBArch.getSourceNameByGuid(SourceKey)
                                If ReturnStr.Trim.Length.Equals(0) Then
                                    SourceName = "Not Found"
                                    TypeCode = "?"
                                    OriginalExt = "?"
                                Else
                                    AR = ReturnStr.Split("|")
                                    SourceName = AR(0)
                                    TypeCode = AR(1)
                                    OriginalExt = AR(2)
                                End If
                                If SourceKey.Trim.Length > 0 Then
                                    SourceKeys.Add(SourceKey, SourceName)
                                End If
                                ErrRowNbr = saveFtiErr(ErrorMsg, TypeErr, ErrTbl, 1)
                                saveFtiSourceGuid(ErrRowNbr, SourceKey, SourceName, 0, TypeCode, OriginalExt)
                            Else
                                SourceName = SourceKeys(SourceKey)
                                ErrRowNbr = saveFtiErr(ErrorMsg, TypeErr, ErrTbl, 1)
                                saveFtiSourceGuid(ErrRowNbr, SourceKey, SourceName, 1, TypeCode, OriginalExt)
                            End If

                            If Not SourceKeyCnt.ContainsKey(SourceKey) Then
                                SourceKeyCnt.Add(SourceKey, 1)
                            Else
                                Dim kcnt As Integer = SourceKeyCnt(SourceKey)
                                kcnt += 1
                                SourceKeyCnt(SourceKey) = kcnt
                            End If
                        End If
                    End If
                    Application.DoEvents()
                Loop Until line Is Nothing Or CancelNow.Equals(True)
            End Using
            If CancelNow.Equals(True) Then
                Exit For
            End If
        Next
        CancelNow = False
        SBFqn.Text = "FINISHED..."
    End Sub

    Function saveFtiSourceGuid(ErrRowNbr As Int64, TableKey As String, SourceName As String, cnt As Integer, TypeCode As String, OriginalExt As String) As Boolean

        Dim B As Boolean = True
        'Dim FtiCONN As New SQLiteConnection()
        Dim CS As String = "data source= " + FTIAnalysisDB
        Dim MySql As String = ""
        Dim iCnt As Integer = 0

        SetDBConn()

        Try
            MySql = "Insert or ignore into KeyTable (ErrRowNbr, TableKey, SourceName, OccrCnt, TypeCode, OriginalExt) values (@ErrRowNbr, @TableKey, @SourceName, @OccrCnt, @TypeCode, @OriginalExt)"
            Using FtiCONN

                Dim CMD As New SQLiteCommand(FtiCONN)
                CMD.Parameters.AddWithValue("@ErrRowNbr", ErrRowNbr)
                CMD.Parameters.AddWithValue("@TableKey", TableKey)
                CMD.Parameters.AddWithValue("@SourceName", SourceName)
                CMD.Parameters.AddWithValue("@TypeCode", TypeCode)
                CMD.Parameters.AddWithValue("@OriginalExt", OriginalExt)

                CMD.CommandText = "select count(*) as CNT from KeyTable where TableKey = @TableKey "
                iCnt = Convert.ToInt32(CMD.ExecuteScalar())

                If iCnt > 0 Then
                    MySql = "update KeyTable set OccrCnt = OccrCnt+1 where TableKey = @TableKey"
                Else
                    cnt = 1
                    CMD.Parameters.AddWithValue("@OccrCnt", cnt)
                    MySql = "Insert into KeyTable (ErrRowNbr, TableKey, SourceName, OccrCnt,TypeCode, OriginalExt) values (@ErrRowNbr, @TableKey, @SourceName, @OccrCnt, @TypeCode, @OriginalExt)"
                End If

                Try
                    CMD.CommandText = MySql
                    CMD.ExecuteNonQuery()
                    B = True
                Catch ex As Exception
                    B = False
                    LOG.WriteToArchiveLog("ERROR: saveFtiSourceGuid 00 - " + ex.Message + vbCrLf + MySql)
                Finally
                    CMD.Dispose()
                    GC.Collect()
                    GC.WaitForPendingFinalizers()
                End Try
            End Using
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: saveFtiSourceGuid 01 - " + ex.Message)
            B = False
        End Try

        Return B
    End Function

    Sub EmptyTables()

        Dim ErrRowNbr As Int64 = -1
        Dim CS As String = "data source= " + FTIAnalysisDB
        Dim MySql As String = ""

        SetDBConn()

        MySql = "delete from Errors "
        Dim CMD As New SQLiteCommand(MySql, FtiCONN)

        Try
            Using FtiCONN
                Try
                    CMD.ExecuteNonQuery()
                    CMD.CommandText = "Delete from KeyTable"
                    CMD.ExecuteNonQuery()
                Catch ex As Exception
                    LOG.WriteToArchiveLog("ERROR: saveFtiErr 04 - " + ex.Message + vbCrLf + MySql)
                    bConnSet = False
                Finally
                    CMD.Dispose()
                    GC.Collect()
                    GC.WaitForPendingFinalizers()
                End Try
            End Using
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR SaveErr 00 : " + ex.Message)
        End Try

    End Sub

    Function saveFtiErr(ErrorMsg As String, TypeErr As String, ErrTbl As String, OccrCnt As Integer) As Int64

        Dim ErrRowNbr As Int64 = -1
        Dim CS As String = "data source= " + FTIAnalysisDB
        Dim MySql As String = "Insert or ignore into Errors (ErrorMsg, TypeErr, ErrTbl) values (@ErrorMsg, @TypeErr, @ErrTbl)"
        Dim iCnt As Integer = 0
        'FtiCONN.Open()
        SetDBConn()

        MySql = ""
        Try
            Using FtiCONN
                Dim CMD As New SQLiteCommand(FtiCONN)
                Try
                    CMD.Parameters.AddWithValue("@ErrorMsg", ErrorMsg)
                    CMD.Parameters.AddWithValue("@TypeErr", TypeErr)
                    CMD.Parameters.AddWithValue("@ErrTbl", ErrTbl)

                    CMD.CommandText = "select count(*) as CNT from Errors where ErrorMsg = @ErrorMsg and TypeErr = @TypeErr and ErrTbl = @ErrTbl "
                    iCnt = Convert.ToInt64(CMD.ExecuteScalar())
                    If iCnt.Equals(0) Then
                        MySql = "Insert into Errors (ErrorMsg, TypeErr, ErrTbl, OccrCnt) values (@ErrorMsg, @TypeErr, @ErrTbl, 1)"
                        CMD.CommandText = MySql
                        CMD.ExecuteNonQuery()

                        CMD.CommandText = "select last_insert_rowid()"
                        ErrRowNbr = Convert.ToInt64(CMD.ExecuteScalar())
                    Else
                        MySql = "Update Errors set OccrCnt = OccrCnt+1 where ErrorMsg = @ErrorMsg and TypeErr = @TypeErr and ErrTbl = @ErrTbl "
                        CMD.CommandText = MySql
                        CMD.ExecuteNonQuery()

                        CMD.CommandText = "select ErrRowNbr as CNT from Errors where ErrorMsg = @ErrorMsg and TypeErr = @TypeErr and ErrTbl = @ErrTbl "
                        ErrRowNbr = Convert.ToInt64(CMD.ExecuteScalar())
                        MySql = ""
                    End If
                Catch ex As Exception
                    LOG.WriteToArchiveLog("ERROR: saveFtiErr 04 - " + ex.Message + vbCrLf + MySql)
                    bConnSet = False
                Finally
                    CMD.Dispose()
                    GC.Collect()
                    GC.WaitForPendingFinalizers()
                End Try
            End Using
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR SaveErr 00 : " + ex.Message)
        End Try



        Return ErrRowNbr
    End Function

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Dim key As String = "SQLFT0001200010.LOG.4"
        Dim lbkey As String = ""
        Dim i As Integer

        For i = 0 To lbFtiLogs.Items.Count - 1
            lbFtiLogs.SetSelected(i, False)
        Next

        For i = 0 To lbFtiLogs.Items.Count - 1
            lbkey = lbFtiLogs.Items(i)
            If lbkey = key Then
                lbFtiLogs.SetSelected(i, True)
            End If
        Next
    End Sub

    Private Sub lbOutput_SelectedIndexChanged(sender As Object, e As EventArgs) Handles lbOutput.SelectedIndexChanged
        Dim s As String = lbOutput.SelectedItems(0)
        txtDetail.Text = s

        Dim tkey As String = ""
        Dim db As String = ""
        Dim i As Integer = 0
        Dim k As Integer = 0

        Try
            i = s.IndexOf("view")
            If i >= 0 Then
                i = s.IndexOf("'", i + 1)
                j = s.IndexOf("'", i + 1)
                db = s.Substring(i + 1, j - i - 1)
                txtDb.Text = db
            End If

            i = s.IndexOf("key value")
            If i >= 0 Then
                i = s.IndexOf("'", i + 1)
                j = s.IndexOf("'", i + 1)
                tkey = s.Substring(i + 1, j - i - 1)
                txtKeyGuid.Text = tkey
            End If
        Catch ex As Exception
            SB.Text = "ERROR: " + ex.Message
        End Try




    End Sub

    Private Sub btnFindItem_Click(sender As Object, e As EventArgs) Handles btnFindItem.Click

        Dim fqn As String = ""
        Dim db As String = txtDb.Text.ToUpper
        Dim i As Integer = db.IndexOf("EMAILATTACHMENT")
        Dim j As Integer = db.IndexOf("DataSource")

        If i >= 0 Then
            fqn = DBArch.getFqnFromGuid(txtSourceGuid.Text, "EmailAttachment")
            SBFqn.Text = fqn
            SB.Text = Path.GetFileName(fqn)
        ElseIf j >= 0 Then
            fqn = DBArch.getFqnFromGuid(txtSourceGuid.Text)
            SBFqn.Text = fqn
            SB.Text = Path.GetFileName(fqn)
        Else
            SB.Text = "NOTICE: Cannot retrieve data from this information."
        End If


    End Sub

    Function SetDBConn() As Boolean

        Dim bb As Boolean = True

        Dim cs As String = ""


        Try
            FtiCONN = New SQLiteConnection()
        Catch ex As Exception
            Console.WriteLine("WARNING: " + ex.Message)
        End Try


        If Not FtiCONN.State.Equals(FtiCONN.State.Open) Then
            Try
                FTIAnalysisDB = System.Configuration.ConfigurationManager.AppSettings("FTIAnalysisDB")
                If Not File.Exists(FTIAnalysisDB) Then
                    MessageBox.Show("FATAL ERR SQLite DB MISSING: " + FTIAnalysisDB)
                End If

                cs = "data source=" + FTIAnalysisDB
                gLocalDBCS = cs
                FtiCONN.ConnectionString = cs
                FtiCONN.Open()
                bb = True
                bSQLiteCOnnected = True
            Catch ex As Exception
                Dim LG As New clsLogging
                LG.WriteToArchiveLog("ERROR LOCALDB SetDBConn: " + ex.Message + vbCrLf + cs)
                LG = Nothing
                bb = False
                bSQLiteCOnnected = False
            End Try
        End If

        Return bb
    End Function


    Private Sub btnSummarize_Click(sender As Object, e As EventArgs) Handles btnSummarize.Click
        SummarizeLogs()
    End Sub

    Private Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        CancelNow = True
    End Sub
End Class

Public Class clsKeyTable
    Dim TableKey As String
    Dim SourceName As String
    Dim OccurCnt As Integer
End Class

Public Class clsErrors
    Dim ErrorMsg As String
    Dim ErrTbl As String
    Dim TypeErr As String
    Dim OccurCnt As Integer
End Class
