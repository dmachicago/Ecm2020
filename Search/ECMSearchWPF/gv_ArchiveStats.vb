' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="gv_ArchiveStats.vb" company="D. Miller and Associates, Limited">
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
''' Class gv_ArchiveStats.
''' </summary>
Partial Public Class gv_ArchiveStats
    ''' <summary>
    ''' Gets or sets the archive start date.
    ''' </summary>
    ''' <value>The archive start date.</value>
    Public Property ArchiveStartDate As Date?

    ''' <summary>
    ''' Gets or sets the status.
    ''' </summary>
    ''' <value>The status.</value>
    <Key>
    <Column(Order:=0)>
    <StringLength(50)>
    Public Property Status As String

    ''' <summary>
    ''' Gets or sets the successful.
    ''' </summary>
    ''' <value>The successful.</value>
    <StringLength(1)>
    Public Property Successful As String

    ''' <summary>
    ''' Gets or sets the type of the archive.
    ''' </summary>
    ''' <value>The type of the archive.</value>
    <Key>
    <Column(Order:=1)>
    <StringLength(50)>
    Public Property ArchiveType As String

    ''' <summary>
    ''' Gets or sets the total emails in repository.
    ''' </summary>
    ''' <value>The total emails in repository.</value>
    Public Property TotalEmailsInRepository As Integer?

    ''' <summary>
    ''' Gets or sets the total content in repository.
    ''' </summary>
    ''' <value>The total content in repository.</value>
    Public Property TotalContentInRepository As Integer?

    ''' <summary>
    ''' Gets or sets the user identifier.
    ''' </summary>
    ''' <value>The user identifier.</value>
    <Key>
    <Column(Order:=2)>
    <StringLength(50)>
    Public Property UserID As String

    ''' <summary>
    ''' Gets or sets the archive end date.
    ''' </summary>
    ''' <value>The archive end date.</value>
    Public Property ArchiveEndDate As Date?

    ''' <summary>
    ''' Gets or sets the stat unique identifier.
    ''' </summary>
    ''' <value>The stat unique identifier.</value>
    <Key>
    <Column(Order:=3)>
    <StringLength(50)>
    Public Property StatGuid As String

    ''' <summary>
    ''' Gets or sets the entry seq.
    ''' </summary>
    ''' <value>The entry seq.</value>
    <Key>
    <Column(Order:=4)>
    Public Property EntrySeq As Integer

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
