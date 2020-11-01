Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

Partial Public Class gv_EcmUser
    <Key>
    <StringLength(50)>
    Public Property EMail As String

    <StringLength(20)>
    Public Property PhoneNumber As String

    <StringLength(100)>
    Public Property YourName As String

    <StringLength(50)>
    Public Property YourCompany As String

    <StringLength(50)>
    Public Property PassWord As String

    <StringLength(1)>
    Public Property Authority As String

    Public Property CreateDate As Date?

    <StringLength(50)>
    Public Property CompanyID As String

    Public Property LastUpdate As Date?

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
