Imports System.IO
Imports System.Linq

Public Class clsFilesToProcess

    Public Function getFilesAfterDate(DirName As String) As List(Of String)

        Dim DB As New clsDatabaseARCH
        Dim lastArchiveDate As Date = DB.getDirLastArchiveDate(DirName)
        DB = Nothing

        Dim LOFiles As New List(Of String)
        Dim info As DirectoryInfo = New DirectoryInfo(DirName)
        Dim files As FileInfo() = info.GetFiles().OrderBy(Function(p) p.CreationTime).ToArray()

        For Each file As FileInfo In files
            If file.LastWriteTime > lastArchiveDate Then
                LOFiles.Add(file.FullName)
            End If
        Next
        Dim LOG As New clsLogging
        LOG.WriteToArchiveLog("INFO: #Files to process in directory '" + DirName + "' : " + LOFiles.ToString)
        LOG = Nothing
        Return LOFiles

    End Function

    Public Function getDirLastArchiveDate(DirName As String) As DateTime

        Dim DB As New clsDatabaseARCH
        Dim lastArchiveDate As Date = DB.getDirLastArchiveDate(DirName)
        DB = Nothing

        Dim LOFiles As New List(Of String)
        Dim info As DirectoryInfo = New DirectoryInfo(DirName)
        Dim files As FileInfo() = info.GetFiles().OrderBy(Function(p) p.CreationTime).ToArray()

        For Each file As FileInfo In files
            If file.LastWriteTime > lastArchiveDate Then
                LOFiles.Add(file.FullName)
            End If
        Next

        Return lastArchiveDate

    End Function

End Class
