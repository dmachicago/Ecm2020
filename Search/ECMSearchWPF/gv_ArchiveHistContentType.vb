Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

Partial Public Class gv_ArchiveHistContentType
    <Key>
    <Column(Order:=0)>
    <StringLength(50)>
    Public Property ArchiveID As String

    <Key>
    <Column(Order:=1)>
    <StringLength(254)>
    Public Property Directory As String

    <Key>
    <Column(Order:=2)>
    <StringLength(50)>
    Public Property FileType As String

    Public Property NbrFilesArchived As Integer?

    <StringLength(50)>
    Public Property HiveConnectionName As String

    Public Property HiveActive As Boolean?

    <StringLength(254)>
    Public Property RepoSvrName As String

    Public Property RowCreationDate As Date?

    Public Property RowLastModDate As Date?

    <StringLength(50)>
    Public Property RepoName As String

    Public Property RowGuid As Guid?
End Class
