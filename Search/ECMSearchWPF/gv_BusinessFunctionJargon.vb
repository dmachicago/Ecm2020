Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

Partial Public Class gv_BusinessFunctionJargon
    <Key>
    <Column(Order:=0)>
    <StringLength(80)>
    Public Property CorpFuncName As String

    <Key>
    <Column(Order:=1)>
    Public Property WordID As Integer

    <Key>
    <Column(Order:=2)>
    <StringLength(50)>
    Public Property JargonWords_tgtWord As String

    <Key>
    <Column(Order:=3)>
    <StringLength(50)>
    Public Property JargonCode As String

    <Key>
    <Column(Order:=4)>
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
