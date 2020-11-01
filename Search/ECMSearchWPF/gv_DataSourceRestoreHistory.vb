Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

Partial Public Class gv_DataSourceRestoreHistory
    <Key>
    <Column(Order:=0)>
    <StringLength(50)>
    Public Property SourceGuid As String

    <StringLength(50)>
    Public Property RestoredToMachine As String

    <StringLength(50)>
    Public Property RestoreUserName As String

    <StringLength(50)>
    Public Property RestoreUserID As String

    <StringLength(254)>
    Public Property RestoreUserDomain As String

    Public Property RestoreDate As Date?

    <Key>
    <Column(Order:=1)>
    <StringLength(50)>
    Public Property DataSourceOwnerUserID As String

    <Key>
    <Column(Order:=2)>
    Public Property SeqNo As Integer

    <StringLength(50)>
    Public Property TypeContentCode As String

    Public Property CreateDate As Date?

    <StringLength(254)>
    Public Property DocumentName As String

    <StringLength(500)>
    Public Property FQN As String

    <StringLength(1)>
    Public Property VerifiedData As String

    <StringLength(50)>
    Public Property OrigCrc As String

    <StringLength(50)>
    Public Property RestoreCrc As String

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
