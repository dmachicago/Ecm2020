Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

Partial Public Class gv_RuntimeErrors
    Public Property ErrorMsg As String

    Public Property StackTrace As String

    Public Property EntryDate As Date?

    <StringLength(50)>
    Public Property IdNbr As String

    <Key>
    Public Property EntrySeq As Integer

    <StringLength(50)>
    Public Property ConnectiveGuid As String

    <StringLength(50)>
    Public Property UserID As String

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
