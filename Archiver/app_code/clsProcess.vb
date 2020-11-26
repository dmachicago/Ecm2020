Imports System.Windows.Forms
Imports System.Security.Principal
Imports System.IO
Imports System.Web
Imports Microsoft.Win32


Public Class clsProcess

    Dim DMA As New clsDma
    Dim LOG As New clsLogging
    Dim UTIL As New clsUtility

    Dim ProcessesToKeep As New SortedList(Of Integer, String)
    Dim ProcessesAfterRunning As New SortedList(Of Integer, String)
    Dim ProcessesToTrack As New SortedList(Of String, String)
    Sub New()
        addProcessesToTrack()
    End Sub
    Sub StartProcessFromFilefqn(ByVal fqn As String)
        FilesToDelete.Add(fqn)
        Dim bSuccess As Boolean = False

        Try
            Process.Start(fqn)
            GC.Collect()
            GC.WaitForFullGCComplete()
        Catch ex As Exception
            log.WriteToArchiveLog("Warning StartProcessFromFilefqn 2006.23.1a - No file type associated with: '" + fqn + "'.")
            messagebox.show("Failed to open file for viewing, will attempt to open using Notepad.")
            System.Diagnostics.Process.Start("notepad.exe", fqn)
            bSuccess = False
        End Try

        'If Not bSuccess Then
        '    log.WriteToArchiveLog("Warning StartProcessFromFilefqn 2006.23.1b - No file type associated with: '" + fqn + "'.")
        '    System.Diagnostics.Process.Start("notepad.exe", fqn)
        'End If

    End Sub
    Sub addProcessesToTrack()
        ProcessesToTrack.Clear()
        ProcessesToTrack.Add("VISIO", "VISIO")
        ProcessesToTrack.Add("WINWORD", "WINWORD")
        ProcessesToTrack.Add("EXCEL", "EXCEL")
        ProcessesToTrack.Add("POWERPNT", "POWERPNT")
    End Sub
    Function countOutlookInstances() As Integer
        Dim AppCnt As Integer = 0
Dim pName AS String  = "" 
        For Each p As Process In Process.GetProcesses
            pName = p.ProcessName.ToUpper
            If pName.Equals("OUTLOOK") Then
                AppCnt += 1
            End If
        Next
        Return AppCnt
    End Function
    Sub getCurrentApplications()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        ZeroizeProcessArrays()
        Dim AppID As Integer = -1
        Dim pName As String = ""
        For Each p As Process In Process.GetProcesses
            AppID = p.Id
            'Console.WriteLine(p.ProcessName)
            pName = p.ProcessName.ToUpper
            If ProcessesToTrack.ContainsKey(pName) Then
                AddProcess(AppID, pName, True)
            End If
        Next
    End Sub
    Sub getProcessesToKill()
        ProcessesAfterRunning.Clear()
        Dim AppID As Integer = -1
Dim pName AS String  = "" 
        For Each p As Process In Process.GetProcesses
            AppID = p.Id
            'Console.WriteLine(p.ProcessName)
            pName = p.ProcessName.ToUpper
            If ProcessesToTrack.ContainsKey(pName) Then
                If ProcessesToKeep.ContainsKey(AppID) Then
                Else
                    AddProcess(AppID, pName , False)
                End If
            End If
        Next
    End Sub
    Sub KillOrphanProcesses()
Dim ProcessName AS String  = "" 
        Dim ProcessID As Integer = 0
        'Dim IDX As Integer
        Try
            Dim I As Integer = 0
            For I = 0 To ProcessesAfterRunning.Count - 1
                ProcessID = Val(ProcessesAfterRunning.Values(I))
                'ProcessName  = Val(ProcessesAfterRunning.Se)
                KillProcess(ProcessID)
            Next
        Catch ex As Exception
            LOG.WriteToArchiveLog("Warning 64.23.a: clsProcess:KillOrphanProcesses - tried to kill suspected orphan process and failed." + Environment.NewLine + ex.Message)
        End Try

    End Sub
    Sub AddProcess(ByVal ID As Integer, ByVal pName As String, ByVal bKeepProcess As Boolean)
        Try
            Dim B As Boolean = False
            If bKeepProcess = True Then
                B = ProcessesToKeep.ContainsKey(ID)
                If Not B Then
                    ProcessesToKeep.Add(ID, pName)
                End If
            Else
                B = ProcessesAfterRunning.ContainsKey(ID)
                If Not B Then
                    ProcessesAfterRunning.Add(ID, pName)
                End If
            End If
        Catch ex As Exception
            LOG.WriteToArchiveLog("Warning 64.23.a: clsProcess:AddProcess - tried to record running process and failed." + Environment.NewLine + ex.Message)
        End Try

    End Sub
    Sub ZeroizeProcessArrays()
        ProcessesToKeep.Clear()
        ProcessesAfterRunning.Clear()
    End Sub
    Sub getListOfRunningApplications(ByRef LB As ListBox)
        For Each p As Process In Process.GetProcesses
            Trace.WriteLine(p.ProcessName + ", " + p.Id.ToString)
            'Console.WriteLine(p.ProcessName)
            LB.Items.Add(p.ProcessName + " : " + p.Id.ToString)
        Next
    End Sub

    Function isProcessRunning(ByVal ProcessName As String) As Boolean
        Dim tgtProcess As String = ""
        For Each p As Process In Process.GetProcesses
            tgtProcess = p.ProcessName.ToUpper
            If tgtProcess.Equals(ProcessName.ToUpper) Then
                Return True
            End If
        Next
        Return False
    End Function
    Sub KillProcess(ByVal ProcessName As String)
        Dim pProcess() As Process = System.Diagnostics.Process.GetProcessesByName(ProcessName)
        For Each p As Process In pProcess
            p.Kill()
        Next
    End Sub
    Function KillProcess(ByVal Handle As Integer) As Boolean
        Dim pProcess As Process = System.Diagnostics.Process.GetProcessById(Handle)
        If pProcess Is Nothing Then
        Else
            Try
                pProcess.Kill()
                Return True
            Catch ex As Exception
                LOG.WriteToArchiveLog("Warning 0181.44 - Failed to drop process: " + Handle.ToString)
                Return False
            End Try
        End If
        Return False
    End Function
    Sub StartProcessFromFilefqnAndWait(ByVal fqn As String)
        'Dim objProcess As System.Diagnostics.Process
        Try
            Dim myProcess As Process = System.Diagnostics.Process.Start(fqn)
            ' wait until it exits
            myProcess.WaitForExit()
            ' display results
            MessageBox.Show("Process was closed at: " &
               myProcess.ExitTime & "." &
               System.Environment.NewLine & "Exit Code: " &
               myProcess.ExitCode)
            myProcess.Close()
            File.Delete(fqn)
        Catch ex As Exception
            MessageBox.Show("Could not start application for " & fqn & Environment.NewLine & ex.Message, "Error")
            LOG.WriteToArchiveLog("clsProcess : StartProcessFromFilefqnAndWait : 9 : " + ex.Message)
            LOG.WriteToArchiveLog("DELETE FAILURE 03|" + fqn)
        End Try
    End Sub
    Sub StartExplorer(ByVal DirName AS String )
        Dim procstart As New ProcessStartInfo("explorer")
        Dim winDir As String = System.IO.Path.GetDirectoryName(DirName)
        procstart.Arguments = DirName
        Process.Start(procstart)
    End Sub
End Class
