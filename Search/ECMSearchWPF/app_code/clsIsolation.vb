'Imports System.Windows.Browser.HtmlPage
Imports System
Imports System.IO
Imports System.IO.IsolatedStorage
Imports System.IO.IsolatedStorage.IsolatedStorageFile
Imports System.IO.IsolatedStorage.IsolatedStorageFileStream

Public Class clsIsolation

    Private Root As IsolatedStorageFile, rName As String

    Public Sub New(ByVal RootName As String)
        rName = RootName
        Root = IsolatedStorageFile.GetMachineStoreForAssembly
        If Not System.IO.Directory.Exists(RootName) Then
            Root.CreateDirectory(RootName)
        End If

    End Sub

    Public Function GetFiles(ByVal sPattern As String) As String()
        GetFiles = Root.GetFileNames(sPattern)
    End Function

    Public Function GetDirectories(ByVal sPattern As String) As String()
        GetDirectories = Root.GetDirectoryNames(sPattern)
    End Function

    Public Sub CreateDirectories(ByVal dPath As String)
        Root.CreateDirectory(dPath)
    End Sub

    Public Sub DeleteFile(ByVal fPath As String)
        Root.DeleteFile(fPath)
    End Sub

    Public Sub DeleteDirectory(ByVal dPath As String)
        Root.DeleteDirectory(dPath)
    End Sub

    Public Function CreateFile(ByVal FileName As String, Optional ByVal data As Byte() = Nothing) As IsolatedStorageFileStream
        CreateFile = New IsolatedStorageFileStream(FileName, IO.FileMode.Create, IO.FileAccess.ReadWrite, Root)
        If (data IsNot Nothing) Then
            CreateFile.Write(data, 0, data.Length)
            CreateFile.Seek(0, IO.SeekOrigin.Begin)
        End If
        CreateFile.Close()
        Return CreateFile
    End Function

    Public Function ReadFile(ByVal fPath As String) As Byte()
        If Not File.Exists(fPath) Then
            Return Nothing
        End If
        Dim p = New IsolatedStorageFileStream(fPath, IO.FileMode.Open, IO.FileAccess.Read, Root)
        ReadFile = New Byte(1023) {}
        p.Read(ReadFile, 0, ReadFile.Length)
        p.Close()
        Return ReadFile
    End Function

    Public Function WriteToFile(ByVal fPath As String, ByVal data As Byte()) As IsolatedStorageFileStream
        WriteToFile = New IsolatedStorageFileStream(fPath, IO.FileMode.Open, IO.FileAccess.Write, Root)
        WriteToFile.Write(data, 0, data.Length)
        WriteToFile.Seek(0, IO.SeekOrigin.Begin)
        WriteToFile.Close()
        Return WriteToFile
    End Function

End Class
