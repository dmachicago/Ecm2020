Imports System.IO

Public Class clsScheduler

    Dim LOG As New clsLogging

    Sub PopulateScheduleGrid(ByRef DG As DataGridView)
        'schtasks /query >c:\temp\X.txt
        Dim SchedDir As String = LOG.getTempEnvironDir + "\ScheduleProcessDir"
        Dim CmdFile As String = SchedDir + "\ProcessImage.bat"
        Dim ScheduleCommand As String = "schtasks /query >" + Chr(34) + SchedDir + "\ExistingSchedules.TXT" + Chr(34)
        Dim QueryFile As String = SchedDir + "\ExistingSchedules.TXT"
        Try

            If Not Directory.Exists(SchedDir) Then
                Directory.CreateDirectory(SchedDir)
            End If

            If File.Exists(CmdFile) Then
                File.Delete(CmdFile)
            End If

            Try
                Dim sw As New StreamWriter(CmdFile, False)
                ' Write ANSI strings to the file line by line...
                sw.WriteLine("CD\")
                sw.WriteLine(ScheduleCommand)
                sw.Close()

                ShellandWait(CmdFile)

                ParseScheduleQueryFile(QueryFile, DG)
            Catch ex As Exception
                LOG.WriteToArchiveLog("ERROR: ProcessImageAsBatch 200: " + ex.Message)
                frmMain.SB.Text = "Check Logs ERROR: ProcessImageAsBatch 200: " + ex.Message
            End Try
        Catch ex As Exception
        Finally
        End Try

    End Sub

    Public Sub ShellandWait(ByVal ProcessPath As String)
        Dim objProcess As System.Diagnostics.Process
        Try
            objProcess = New System.Diagnostics.Process()
            objProcess.StartInfo.FileName = ProcessPath
            Clipboard.Clear()
            Clipboard.SetText(ProcessPath)
            objProcess.StartInfo.WindowStyle = ProcessWindowStyle.Normal
            objProcess.Start()

            'Wait until the process passes back an exit code
            objProcess.WaitForExit()

            'Free resources associated with this process
            objProcess.Close()
            objProcess.Dispose()
            frmMain.SB.Text = "Command success."
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR ECMArchiver ShellandWait 100 - " + ex.Message + vbCrLf + "Could not start process " & ProcessPath)
            LOG.WriteToArchiveLog("ERROR: Stack Trace:" + vbCrLf + ex.StackTrace)
        End Try
    End Sub

    Sub ParseScheduleQueryFile(ByVal FQN As String, ByRef DG As DataGridView)

        DG.Rows.Clear()
        DG.Columns.Clear()
        DG.Columns.Add("Task Name", "Task Name")
        DG.Columns.Add("Next_Run_Time", "Next_Run_Time")
        DG.Columns.Add("Status", "Status")

        If Not File.Exists(FQN) Then
            LOG.WriteToArchiveLog("ERROR: ParseScheduleQueryFile 100: File '" + FQN + "' was not found.")

            Return
        End If

        Dim CH As String = ""
        Dim TaskName As String = ""
        Dim Next_Run_Time As String = ""
        Dim Status As String = ""
        Dim iTaskName As Integer = 0
        Dim iNext_Run_Time As Integer = 0
        Dim iStatus As Integer = 0
        Dim LineIn As String = ""
        Dim oFile As System.IO.File
        Dim oRead As System.IO.StreamReader

        'TaskName                                 Next Run Time          Status
        oRead = oFile.OpenText(FQN)
        While oRead.Peek <> -1
            LineIn = oRead.ReadLine()
            LineIn = LineIn.Trim
            If LineIn.Trim.Length > 0 Then
                'If InStr(LineIn, "ECM_", CompareMethod.Text) = 0 Then
                '    GoTo NextLine
                'End If
                If LineIn.Length > "TaskName".Length Then
                    CH = Mid(LineIn, 1, "TaskName".Length).ToUpper
                    If CH.Equals("TASKNAME") Then
                        GoTo NextLine
                    End If
                End If
                If InStr(LineIn, "Folder:", CompareMethod.Text) > 0 Then
                    '*Do nothing, skip it
                ElseIf InStr(LineIn, "INFO:", CompareMethod.Text) > 0 Then
                    '*Do nothing, skip it
                ElseIf InStr(LineIn, "==========", CompareMethod.Text) > 0 Then
                    'Get the processing column lengths
                    For i As Integer = 1 To LineIn.Length
                        CH = Mid(LineIn, i, 1)
                        If CH.Equals(" ") Then
                            If iTaskName = 0 Then
                                iTaskName = i + 1
                            ElseIf iNext_Run_Time = 0 Then
                                iNext_Run_Time = i + 1
                                iStatus = LineIn.Length
                            ElseIf iStatus = 0 Then
                                iStatus = i + 1
                            End If
                        End If
                    Next
                Else
                    TaskName = "-"
                    Next_Run_Time = "-"
                    Status = "-"
                    If LineIn.Length > iTaskName Then
                        TaskName = Mid(LineIn, 1, iTaskName - 1)
                        TaskName = TaskName.Trim
                    End If
                    If LineIn.Length > iNext_Run_Time - 2 Then
                        Next_Run_Time = Mid(LineIn, iTaskName, iNext_Run_Time - iTaskName)
                        Next_Run_Time = Next_Run_Time.Trim
                    End If
                    If LineIn.Length > iTaskName + 2 Then
                        Status = Mid(LineIn, iNext_Run_Time)
                        Status = Status.Trim
                    End If
                    Dim N As Integer = 0
                    Dim a() As String
                    ReDim a(2)

                    If Not TaskName Is Nothing Then
                    End If
                    If Not Next_Run_Time Is Nothing Then
                    End If
                    If Not Status Is Nothing Then
                    End If

                    'dg.Rows.Add()
                    'N = dg.Rows.Count - 1
                    'dg.Rows.Item(N).Cells(0).Value = TaskName
                    'dg.Rows.Item(N).Cells(1).Value = Next_Run_Time
                    'dg.Rows.Item(N).Cells(2).Value = Status

                    Dim dgvRow As New DataGridViewRow
                    Dim dgvCell As DataGridViewCell

                    dgvCell = New DataGridViewTextBoxCell()
                    dgvCell.Value = TaskName
                    dgvRow.Cells.Add(dgvCell)

                    dgvCell = New DataGridViewTextBoxCell()
                    dgvCell.Value = Next_Run_Time
                    dgvRow.Cells.Add(dgvCell)

                    dgvCell = New DataGridViewTextBoxCell()
                    dgvCell.Value = Status
                    dgvRow.Cells.Add(dgvCell)

                    DG.Rows.Add(dgvRow)

                End If
            End If
NextLine:
        End While

        oRead.Close()

        DG.Columns(0).Width = "320"
        DG.Columns(1).Width = "220"
        DG.Columns(2).Width = "120"

    End Sub

End Class