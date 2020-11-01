Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

Partial Public Class gv_Retention
    <Key>
    <Column(Order:=0)>
    <StringLength(50)>
    Public Property RetentionCode As String

    Public Property RetentionDesc As String

    <Key>
    <Column(Order:=1)>
    <DatabaseGenerated(DatabaseGeneratedOption.None)>
    Public Property RetentionUnits As Integer

    <Key>
    <Column(Order:=2)>
    <StringLength(50)>
    Public Property RetentionAction As String

    <StringLength(50)>
    Public Property ManagerID As String

    <StringLength(200)>
    Public Property ManagerName As String

    Public Property DaysWarning As Integer?

    <StringLength(1)>
    Public Property ResponseRequired As String

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

    <StringLength(10)>
    Public Property RetentionPeriod As String
End Class
