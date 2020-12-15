' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 07-16-2020
'
' Last Modified By : wdale
' Last Modified On : 07-16-2020
' ***********************************************************************
' <copyright file="clsIsolation.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************ge
Imports System
Imports System.IO
Imports System.IO.IsolatedStorage
Imports System.IO.IsolatedStorage.IsolatedStorageFile
Imports System.IO.IsolatedStorage.IsolatedStorageFileStream

''' <summary>
''' Class clsIsolation.
''' </summary>
Public Class clsIsolation

    Private Root As IsolatedStorageFile, rName As String

    ''' <summary>
    ''' Initializes a new instance of the <see cref="clsIsolation"/> class.
    ''' </summary>
    ''' <param name="RootName">Name of the root.</param>
    Public Sub New(ByVal RootName As String)
        rName = RootName
        Root = IsolatedStorageFile.GetMachineStoreForAssembly
        If Not System.IO.Directory.Exists(RootName) Then
            Root.CreateDirectory(RootName)
        End If

    End Sub

    ''' <summary>
    ''' Gets the files.
    ''' </summary>
    ''' <param name="sPattern">The s pattern.</param>
    ''' <returns>System.String().</returns>
    Public Function GetFiles(ByVal sPattern As String) As String()
        GetFiles = Root.GetFileNames(sPattern)
    End Function

    ''' <summary>
    ''' Gets the directories.
    ''' </summary>
    ''' <param name="sPattern">The s pattern.</param>
    ''' <returns>System.String().</returns>
    Public Function GetDirectories(ByVal sPattern As String) As String()
        GetDirectories = Root.GetDirectoryNames(sPattern)
    End Function

    ''' <summary>
    ''' Creates the directories.
    ''' </summary>
    ''' <param name="dPath">The d path.</param>
    Public Sub CreateDirectories(ByVal dPath As String)
        Root.CreateDirectory(dPath)
    End Sub

    ''' <summary>
    ''' Deletes the file.
    ''' </summary>
    ''' <param name="fPath">The f path.</param>
    Public Sub DeleteFile(ByVal fPath As String)
        Root.DeleteFile(fPath)
    End Sub

    ''' <summary>
    ''' Deletes the directory.
    ''' </summary>
    ''' <param name="dPath">The d path.</param>
    Public Sub DeleteDirectory(ByVal dPath As String)
        Root.DeleteDirectory(dPath)
    End Sub

    ''' <summary>
    ''' Creates the file.
    ''' </summary>
    ''' <param name="FileName">Name of the file.</param>
    ''' <param name="data">The data.</param>
    ''' <returns>IsolatedStorageFileStream.</returns>
    Public Function CreateFile(ByVal FileName As String, Optional ByVal data As Byte() = Nothing) As IsolatedStorageFileStream
        CreateFile = New IsolatedStorageFileStream(FileName, IO.FileMode.Create, IO.FileAccess.ReadWrite, Root)
        If (data IsNot Nothing) Then
            CreateFile.Write(data, 0, data.Length)
            CreateFile.Seek(0, IO.SeekOrigin.Begin)
        End If
        CreateFile.Close()
        Return CreateFile
    End Function

    ''' <summary>
    ''' Reads the file.
    ''' </summary>
    ''' <param name="fPath">The f path.</param>
    ''' <returns>System.Byte().</returns>
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

    ''' <summary>
    ''' Writes to file.
    ''' </summary>
    ''' <param name="fPath">The f path.</param>
    ''' <param name="data">The data.</param>
    ''' <returns>IsolatedStorageFileStream.</returns>
    Public Function WriteToFile(ByVal fPath As String, ByVal data As Byte()) As IsolatedStorageFileStream
        WriteToFile = New IsolatedStorageFileStream(fPath, IO.FileMode.Open, IO.FileAccess.Write, Root)
        WriteToFile.Write(data, 0, data.Length)
        WriteToFile.Seek(0, IO.SeekOrigin.Begin)
        WriteToFile.Close()
        Return WriteToFile
    End Function

End Class
