Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

Partial Public Class gv_DataSourceCheckOut
    <Key>
    <Column(Order:=0)>
    <StringLength(50)>
    Public Property SourceGuid As String

    <Key>
    <Column(Order:=1)>
    <StringLength(50)>
    Public Property DataSourceOwnerUserID As String

    <Key>
    <Column(Order:=2)>
    <StringLength(50)>
    Public Property CheckedOutByUserID As String

    Public Property isReadOnly As Boolean?

    Public Property isForUpdate As Boolean?

    Public Property checkOutDate As Date?

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
