Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

<Table("vUserGrid")>
Partial Public Class vUserGrid
    <Key>
    <Column(Order:=0)>
    <StringLength(50)>
    Public Property UserID As String

    <Key>
    <Column(Order:=1)>
    <StringLength(50)>
    Public Property UserName As String

    <StringLength(254)>
    Public Property EmailAddress As String

    <StringLength(1)>
    Public Property Admin As String

    <StringLength(1)>
    Public Property isActive As String

    <StringLength(50)>
    Public Property UserLoginID As String

    Public Property ClientOnly As Boolean?

    <StringLength(50)>
    Public Property HiveConnectionName As String

    Public Property HiveActive As Boolean?

    <StringLength(254)>
    Public Property RepoSvrName As String

    Public Property RowCreationDate As Date?

    Public Property RowLastModDate As Date?
End Class
