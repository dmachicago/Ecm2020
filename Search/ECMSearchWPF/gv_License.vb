Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

Partial Public Class gv_License
    <Key>
    <Column(Order:=0)>
    <StringLength(2000)>
    Public Property Agreement As String

    <Key>
    <Column(Order:=1)>
    <DatabaseGenerated(DatabaseGeneratedOption.None)>
    Public Property VersionNbr As Integer

    <Key>
    <Column(Order:=2)>
    Public Property ActivationDate As Date

    <Key>
    <Column(Order:=3)>
    Public Property InstallDate As Date

    <Key>
    <Column(Order:=4)>
    <StringLength(50)>
    Public Property CustomerID As String

    <Key>
    <Column(Order:=5)>
    <StringLength(254)>
    Public Property CustomerName As String

    <Key>
    <Column(Order:=6)>
    Public Property LicenseID As Integer

    <StringLength(50)>
    Public Property XrtNxr1 As String

    <StringLength(100)>
    Public Property ServerIdentifier As String

    <StringLength(100)>
    Public Property SqlInstanceIdentifier As String

    <StringLength(80)>
    Public Property MachineID As String

    <StringLength(50)>
    Public Property HiveConnectionName As String

    Public Property HiveActive As Boolean?

    <StringLength(254)>
    Public Property RepoSvrName As String

    Public Property RowCreationDate As Date?

    Public Property RowLastModDate As Date?

    <StringLength(254)>
    Public Property ServerName As String

    <StringLength(254)>
    Public Property SqlInstanceName As String

    <StringLength(254)>
    Public Property SqlServerInstanceName As String

    <StringLength(254)>
    Public Property SqlServerMachineName As String

    <StringLength(50)>
    Public Property RepoName As String

    Public Property RowGuid As Guid?
End Class
