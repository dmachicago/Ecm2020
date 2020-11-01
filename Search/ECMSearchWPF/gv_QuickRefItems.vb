Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

Partial Public Class gv_QuickRefItems
    Public Property QuickRefIdNbr As Integer?

    <StringLength(300)>
    Public Property FQN As String

    <Key>
    <StringLength(50)>
    Public Property QuickRefItemGuid As String

    <StringLength(50)>
    Public Property SourceGuid As String

    <StringLength(50)>
    Public Property DataSourceOwnerUserID As String

    <StringLength(300)>
    Public Property Author As String

    Public Property Description As String

    <StringLength(2000)>
    Public Property Keywords As String

    <StringLength(80)>
    Public Property FileName As String

    <StringLength(254)>
    Public Property DirName As String

    Public Property MarkedForDeletion As Boolean?

    <StringLength(50)>
    Public Property RetentionCode As String

    <StringLength(50)>
    Public Property MetadataTag As String

    <StringLength(50)>
    Public Property MetadataValue As String

    <StringLength(50)>
    Public Property Library As String

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
