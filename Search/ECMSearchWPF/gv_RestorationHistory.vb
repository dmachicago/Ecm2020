Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

Partial Public Class gv_RestorationHistory
    <Key>
    <Column(Order:=0)>
    <StringLength(50)>
    Public Property SourceType As String

    <Key>
    <Column(Order:=1)>
    <StringLength(50)>
    Public Property SourceGuid As String

    <Key>
    <Column(Order:=2)>
    <StringLength(50)>
    Public Property OriginalCrc As String

    <Key>
    <Column(Order:=3)>
    <StringLength(50)>
    Public Property RestoredCrc As String

    <Key>
    <Column(Order:=4)>
    <StringLength(10)>
    Public Property RestorationDate As String

    <Key>
    <Column(Order:=5)>
    Public Property RestorationID As Integer

    <Key>
    <Column(Order:=6)>
    <StringLength(50)>
    Public Property RestoredBy As String

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
