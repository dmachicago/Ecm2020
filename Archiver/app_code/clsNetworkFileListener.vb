Imports System
Imports System.IO

Public Class clsNetworkFileListener
    Public networkDir As String = ""

    Private Sub SetListener()

        Dim watcher As FileSystemWatcher = New FileSystemWatcher(networkDir, "*.*")
        AddHandler watcher.Created, AddressOf OnCreated
        watcher.IncludeSubdirectories = True
        watcher.InternalBufferSize = 25 * 4096
        watcher.NotifyFilter = NotifyFilters.FileName
        watcher.EnableRaisingEvents = True

        MessageBox.Show("Close to End Listener")

        'While Console.ReadLine() <> "x"
        'End While

        watcher.Dispose()
    End Sub

    Private Shared Sub OnCreated(ByVal source As Object, ByVal e As FileSystemEventArgs)
        Console.WriteLine("File: " & e.FullPath & " " & e.ChangeType)
    End Sub

End Class
