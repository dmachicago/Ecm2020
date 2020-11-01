Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

Partial Public Class gv_EmailToDelete
    <Key>
    <Column(Order:=0)>
    <StringLength(50)>
    Public Property EmailGuid As String

    <Key>
    <Column(Order:=1)>
    <StringLength(500)>
    Public Property StoreID As String

    <StringLength(50)>
    Public Property UserID As String

    <StringLength(100)>
    Public Property MessageID As String

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
