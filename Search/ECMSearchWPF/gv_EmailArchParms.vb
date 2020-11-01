Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

Partial Public Class gv_EmailArchParms
    <Key>
    <Column(Order:=0)>
    <StringLength(50)>
    Public Property UserID As String

    <StringLength(1)>
    Public Property ArchiveEmails As String

    <StringLength(1)>
    Public Property RemoveAfterArchive As String

    <StringLength(1)>
    Public Property SetAsDefaultFolder As String

    <StringLength(1)>
    Public Property ArchiveAfterXDays As String

    <StringLength(1)>
    Public Property RemoveAfterXDays As String

    Public Property RemoveXDays As Integer?

    Public Property ArchiveXDays As Integer?

    <Key>
    <Column(Order:=1)>
    <StringLength(254)>
    Public Property FolderName As String

    <Key>
    <Column(Order:=2)>
    <StringLength(50)>
    Public Property DB_ID As String

    <StringLength(1)>
    Public Property ArchiveOnlyIfRead As String

    Public Property isSysDefault As Boolean?

    <StringLength(80)>
    Public Property ContainerName As String

    <StringLength(80)>
    Public Property MachineName As String

    <StringLength(50)>
    Public Property HiveConnectionName As String

    Public Property HiveActive As Boolean?

    <StringLength(254)>
    Public Property RepoSvrName As String

    Public Property RowCreationDate As Date?

    Public Property RowLastModDate As Date?

    <Key>
    <Column(Order:=3)>
    Public Property nRowID As Integer

    <StringLength(50)>
    Public Property RepoName As String

    Public Property RowGuid As Guid?
End Class
