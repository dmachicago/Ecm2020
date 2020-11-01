Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

Partial Public Class gv_WebSource
    <Key>
    <Column(Order:=0)>
    <StringLength(50)>
    Public Property SourceGuid As String

    Public Property CreateDate As Date?

    <StringLength(254)>
    Public Property SourceName As String

    <Column(TypeName:="image")>
    Public Property SourceImage As Byte()

    <Key>
    <Column(Order:=1)>
    <StringLength(50)>
    Public Property SourceTypeCode As String

    Public Property FileLength As Integer?

    Public Property LastWriteTime As Date?

    Public Property RetentionExpirationDate As Date?

    Public Property Description As String

    <StringLength(2000)>
    Public Property KeyWords As String

    <StringLength(2000)>
    Public Property Notes As String

    Public Property CreationDate As Date?

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
