Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

Partial Public Class gv_Directory
    <Key>
    <Column(Order:=0)>
    <StringLength(50)>
    Public Property UserID As String

    <StringLength(1)>
    Public Property IncludeSubDirs As String

    <Key>
    <Column(Order:=1)>
    <StringLength(254)>
    Public Property FQN As String

    <Key>
    <Column(Order:=2)>
    <StringLength(50)>
    Public Property DB_ID As String

    <StringLength(1)>
    Public Property VersionFiles As String

    <StringLength(1)>
    Public Property ckMetaData As String

    <StringLength(1)>
    Public Property ckPublic As String

    <StringLength(1)>
    Public Property ckDisableDir As String

    <StringLength(10)>
    Public Property QuickRefEntry As String

    Public Property isSysDefault As Boolean?

    <StringLength(1)>
    Public Property OcrDirectory As String

    <StringLength(50)>
    Public Property RetentionCode As String

    Public Property isServerDirectory As Boolean?

    Public Property isMappedDrive As Boolean?

    Public Property isNetworkDrive As Boolean?

    Public Property RequiresAuthentication As Boolean?

    Public Property AdminDisabled As Boolean?

    Public Property ArchiveSkipBit As Boolean?

    Public Property ListenForChanges As Boolean?

    Public Property ListenDirectory As Boolean?

    Public Property ListenSubDirectory As Boolean?

    Public Property DirGuid As Guid?

    <StringLength(50)>
    Public Property HiveConnectionName As String

    Public Property HiveActive As Boolean?

    <StringLength(254)>
    Public Property RepoSvrName As String

    Public Property RowCreationDate As Date?

    Public Property RowLastModDate As Date?

    <StringLength(1)>
    Public Property OcrPdf As String

    <StringLength(50)>
    Public Property RepoName As String

    Public Property RowGuid As Guid?

    <StringLength(1)>
    Public Property DeleteOnArchive As String
End Class
