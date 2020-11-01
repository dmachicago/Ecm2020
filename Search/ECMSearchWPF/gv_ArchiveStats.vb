Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

Partial Public Class gv_ArchiveStats
    Public Property ArchiveStartDate As Date?

    <Key>
    <Column(Order:=0)>
    <StringLength(50)>
    Public Property Status As String

    <StringLength(1)>
    Public Property Successful As String

    <Key>
    <Column(Order:=1)>
    <StringLength(50)>
    Public Property ArchiveType As String

    Public Property TotalEmailsInRepository As Integer?

    Public Property TotalContentInRepository As Integer?

    <Key>
    <Column(Order:=2)>
    <StringLength(50)>
    Public Property UserID As String

    Public Property ArchiveEndDate As Date?

    <Key>
    <Column(Order:=3)>
    <StringLength(50)>
    Public Property StatGuid As String

    <Key>
    <Column(Order:=4)>
    Public Property EntrySeq As Integer

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
