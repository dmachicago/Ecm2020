Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

Partial Public Class gv_GlobalSeachResults
    <StringLength(254)>
    Public Property ContentTitle As String

    <StringLength(254)>
    Public Property ContentAuthor As String

    <StringLength(50)>
    Public Property ContentType As String

    <StringLength(50)>
    Public Property CreateDate As String

    <StringLength(50)>
    Public Property ContentExt As String

    <Key>
    <Column(Order:=0)>
    <StringLength(50)>
    Public Property ContentGuid As String

    <Key>
    <Column(Order:=1)>
    <StringLength(50)>
    Public Property UserID As String

    <StringLength(254)>
    Public Property FileName As String

    Public Property FileSize As Integer?

    Public Property NbrOfAttachments As Integer?

    <StringLength(254)>
    Public Property FromEmailAddress As String

    Public Property AllRecipiants As String

    Public Property Weight As Integer?

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
