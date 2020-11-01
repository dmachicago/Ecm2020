Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

Partial Public Class gv_LibraryUsers
    <Column("ReadOnly")>
    Public Property _ReadOnly As Boolean?

    Public Property CreateAccess As Boolean?

    Public Property UpdateAccess As Boolean?

    Public Property DeleteAccess As Boolean?

    <Key>
    <Column(Order:=0)>
    <StringLength(50)>
    Public Property UserID As String

    <Key>
    <Column(Order:=1)>
    <StringLength(50)>
    Public Property LibraryOwnerUserID As String

    <Key>
    <Column(Order:=2)>
    <StringLength(80)>
    Public Property LibraryName As String

    Public Property NotAddedAsGroupMember As Boolean?

    <StringLength(50)>
    Public Property HiveConnectionName As String

    Public Property HiveActive As Boolean?

    <StringLength(254)>
    Public Property RepoSvrName As String

    Public Property RowCreationDate As Date?

    Public Property RowLastModDate As Date?

    Public Property SingleUser As Boolean?

    Public Property GroupUser As Boolean?

    Public Property GroupCnt As Integer?

    <StringLength(50)>
    Public Property RepoName As String

    Public Property RowGuid As Guid?
End Class
