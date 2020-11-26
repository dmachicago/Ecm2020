Imports System.Windows.Forms
Imports System
Imports System.IO
Imports System.Diagnostics

Public Class FrmListenerTest

    Dim watchfolder As New System.IO.FileSystemWatcher()

    Sub New()
        InitializeComponent()

        If File.Exists("C:\_ChangeLogs\FileChanges.dat") Then
            File.Delete("C:\_ChangeLogs\FileChanges.dat")
        End If

    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Dim dlg As New FolderBrowserDialog
        If (dlg.ShowDialog() = DialogResult.OK) Then
            txtDir.Text = dlg.SelectedPath
        End If
    End Sub

    Private Sub Button2_Click(sender As Object, e As EventArgs) Handles Button2.Click
        StartLIstener2()
    End Sub

    Public Sub StartLIstener2()

        'Dim watchfolder As = New System.IO.FileSystemWatcher()

        'this is the path we want to monitor
        watchfolder.Path = txtdir.Text

        'Add a list of Filter we want to specify
        'make sure you use OR for each Filter as we need to
        'all of those 

        'watchfolder.NotifyFilter = IO.NotifyFilters.DirectoryName
        watchfolder.NotifyFilter = watchfolder.NotifyFilter Or IO.NotifyFilters.FileName
        watchfolder.NotifyFilter = watchfolder.NotifyFilter Or IO.NotifyFilters.Attributes

        ' add the handler to each event
        AddHandler watchfolder.Changed, AddressOf logchange
        AddHandler watchfolder.Created, AddressOf logchange
        AddHandler watchfolder.Deleted, AddressOf logchange

        ' add the rename handler as the signature is different
        AddHandler watchfolder.Renamed, AddressOf logrename

        'Set this property to true to start watching
        watchfolder.EnableRaisingEvents = True

        Button2.Enabled = False
        ckStop.Enabled = True

        'End of code for btn_start_click
    End Sub

    Sub StopListener()
        If ckStop.Checked.Equals(True) Then
            watchfolder.EnableRaisingEvents = False
            Button2.Enabled = True
            ckStop.Enabled = False
        End If
    End Sub

    Private Sub logchange(ByVal source As Object, ByVal e As System.IO.FileSystemEventArgs)

        Dim Msg As String = ""
        If e.ChangeType = IO.WatcherChangeTypes.Changed Then
            Msg = "U|" & e.FullPath & "|"
            SaveChanges(Msg)
        End If
        If e.ChangeType = IO.WatcherChangeTypes.Created Then
            Msg = "C|" & e.FullPath & "|"
            SaveChanges(Msg)
        End If
        If e.ChangeType = IO.WatcherChangeTypes.Deleted Then
            Msg = "D|" & e.FullPath & "|"
            SaveChanges(Msg)
        End If

    End Sub
    Public Sub logrename(ByVal source As Object, ByVal e As System.IO.RenamedEventArgs)
        Dim Msg As String = ""
        Msg = "R|" & e.OldName & "|" & e.Name
        SaveChanges(Msg)
    End Sub

    Private Sub SaveChanges(Msg As String)

        Dim TS As String = Now.Ticks.ToString
        Dim T As String = Now.ToLongDateString.ToString
        Msg = T + "|" + TS + "|" + Msg

        If Not Directory.Exists("C:\_ChangeLogs") Then
            Directory.CreateDirectory("C:\_ChangeLogs")
        End If

        Dim FQN As String = "C:\_ChangeLogs\FileChanges.dat"
        Try

            Using SW As New IO.StreamWriter(FQN, True)
                SW.WriteLine(Msg)
            End Using

        Catch ex As Exception
            MessageBox.Show("Could not store data into file " & FQN & Environment.NewLine + ex.Message & ". Program terminating.", "Error", MessageBoxButtons.OK)
        End Try

    End Sub

    Private Sub btnViewLog_Click(sender As Object, e As EventArgs) Handles btnViewLog.Click

        Dim FQN As String = "C:\_ChangeLogs\FileChanges.dat"
        Try
            lbOutput.Items.Clear()
            Dim reader As StreamReader = My.Computer.FileSystem.OpenTextFileReader(FQN)
            Dim a As String
            Do
                a = reader.ReadLine
                lbOutput.Items.Add(a)
            Loop Until a Is Nothing
            reader.Close()
        Catch ex As Exception
            MessageBox.Show("Could not store data into file " & FQN &
                      ". Program terminating.", "Error", MessageBoxButtons.OK)
        End Try

    End Sub
End Class