Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

Partial Public Class gv_ConvertedDocs
    <Key>
    <Column(Order:=0)>
    <StringLength(254)>
    Public Property FQN As String

    <StringLength(254)>
    Public Property FileName As String

    <StringLength(254)>
    Public Property XMLName As String

    <StringLength(254)>
    Public Property XMLDIr As String

    <StringLength(254)>
    Public Property FileDir As String

    <Key>
    <Column(Order:=1)>
    <StringLength(50)>
    Public Property CorpName As String

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
