' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="gv_EmailArchParms.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************
Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

''' <summary>
''' Class gv_EmailArchParms.
''' </summary>
Partial Public Class gv_EmailArchParms
    ''' <summary>
    ''' Gets or sets the user identifier.
    ''' </summary>
    ''' <value>The user identifier.</value>
    <Key>
    <Column(Order:=0)>
    <StringLength(50)>
    Public Property UserID As String

    ''' <summary>
    ''' Gets or sets the archive emails.
    ''' </summary>
    ''' <value>The archive emails.</value>
    <StringLength(1)>
    Public Property ArchiveEmails As String

    ''' <summary>
    ''' Gets or sets the remove after archive.
    ''' </summary>
    ''' <value>The remove after archive.</value>
    <StringLength(1)>
    Public Property RemoveAfterArchive As String

    ''' <summary>
    ''' Gets or sets the set as default folder.
    ''' </summary>
    ''' <value>The set as default folder.</value>
    <StringLength(1)>
    Public Property SetAsDefaultFolder As String

    ''' <summary>
    ''' Gets or sets the archive after x days.
    ''' </summary>
    ''' <value>The archive after x days.</value>
    <StringLength(1)>
    Public Property ArchiveAfterXDays As String

    ''' <summary>
    ''' Gets or sets the remove after x days.
    ''' </summary>
    ''' <value>The remove after x days.</value>
    <StringLength(1)>
    Public Property RemoveAfterXDays As String

    ''' <summary>
    ''' Gets or sets the remove x days.
    ''' </summary>
    ''' <value>The remove x days.</value>
    Public Property RemoveXDays As Integer?

    ''' <summary>
    ''' Gets or sets the archive x days.
    ''' </summary>
    ''' <value>The archive x days.</value>
    Public Property ArchiveXDays As Integer?

    ''' <summary>
    ''' Gets or sets the name of the folder.
    ''' </summary>
    ''' <value>The name of the folder.</value>
    <Key>
    <Column(Order:=1)>
    <StringLength(254)>
    Public Property FolderName As String

    ''' <summary>
    ''' Gets or sets the database identifier.
    ''' </summary>
    ''' <value>The database identifier.</value>
    <Key>
    <Column(Order:=2)>
    <StringLength(50)>
    Public Property DB_ID As String

    ''' <summary>
    ''' Gets or sets the archive only if read.
    ''' </summary>
    ''' <value>The archive only if read.</value>
    <StringLength(1)>
    Public Property ArchiveOnlyIfRead As String

    ''' <summary>
    ''' Gets or sets a value indicating whether this instance is system default.
    ''' </summary>
    ''' <value><c>null</c> if [is system default] contains no value, <c>true</c> if [is system default]; otherwise, <c>false</c>.</value>
    Public Property isSysDefault As Boolean?

    ''' <summary>
    ''' Gets or sets the name of the container.
    ''' </summary>
    ''' <value>The name of the container.</value>
    <StringLength(80)>
    Public Property ContainerName As String

    ''' <summary>
    ''' Gets or sets the name of the machine.
    ''' </summary>
    ''' <value>The name of the machine.</value>
    <StringLength(80)>
    Public Property MachineName As String

    ''' <summary>
    ''' Gets or sets the name of the hive connection.
    ''' </summary>
    ''' <value>The name of the hive connection.</value>
    <StringLength(50)>
    Public Property HiveConnectionName As String

    ''' <summary>
    ''' Gets or sets a value indicating whether [hive active].
    ''' </summary>
    ''' <value><c>null</c> if [hive active] contains no value, <c>true</c> if [hive active]; otherwise, <c>false</c>.</value>
    Public Property HiveActive As Boolean?

    ''' <summary>
    ''' Gets or sets the name of the repo SVR.
    ''' </summary>
    ''' <value>The name of the repo SVR.</value>
    <StringLength(254)>
    Public Property RepoSvrName As String

    ''' <summary>
    ''' Gets or sets the row creation date.
    ''' </summary>
    ''' <value>The row creation date.</value>
    Public Property RowCreationDate As Date?

    ''' <summary>
    ''' Gets or sets the row last mod date.
    ''' </summary>
    ''' <value>The row last mod date.</value>
    Public Property RowLastModDate As Date?

    ''' <summary>
    ''' Gets or sets the n row identifier.
    ''' </summary>
    ''' <value>The n row identifier.</value>
    <Key>
    <Column(Order:=3)>
    Public Property nRowID As Integer

    ''' <summary>
    ''' Gets or sets the name of the repo.
    ''' </summary>
    ''' <value>The name of the repo.</value>
    <StringLength(50)>
    Public Property RepoName As String

    ''' <summary>
    ''' Gets or sets the row unique identifier.
    ''' </summary>
    ''' <value>The row unique identifier.</value>
    Public Property RowGuid As Guid?
End Class
