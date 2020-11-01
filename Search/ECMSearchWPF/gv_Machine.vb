Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

Partial Public Class gv_Machine
    <Key>
    <StringLength(80)>
    Public Property MachineName As String

    <StringLength(254)>
    Public Property FQN As String

    <StringLength(50)>
    Public Property ContentType As String

    Public Property CreateDate As Date?

    Public Property LastUpdate As Date?

    <StringLength(50)>
    Public Property SourceGuid As String

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
