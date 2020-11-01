Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

Partial Public Class gv_SearchHistory
    Public Property SearchSql As String

    Public Property SearchDate As Date?

    <StringLength(50)>
    Public Property UserID As String

    <Key>
    Public Property RowID As Integer

    Public Property ReturnedRows As Integer?

    Public Property StartTime As Date?

    Public Property EndTime As Date?

    <StringLength(50)>
    Public Property CalledFrom As String

    <StringLength(50)>
    Public Property TypeSearch As String

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

    Public Property SearchParms As String
End Class
