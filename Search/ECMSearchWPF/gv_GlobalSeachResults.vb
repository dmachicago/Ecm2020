' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="gv_GlobalSeachResults.vb" company="D. Miller and Associates, Limited">
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
''' Class gv_GlobalSeachResults.
''' </summary>
Partial Public Class gv_GlobalSeachResults
    ''' <summary>
    ''' Gets or sets the content title.
    ''' </summary>
    ''' <value>The content title.</value>
    <StringLength(254)>
    Public Property ContentTitle As String

    ''' <summary>
    ''' Gets or sets the content author.
    ''' </summary>
    ''' <value>The content author.</value>
    <StringLength(254)>
    Public Property ContentAuthor As String

    ''' <summary>
    ''' Gets or sets the type of the content.
    ''' </summary>
    ''' <value>The type of the content.</value>
    <StringLength(50)>
    Public Property ContentType As String

    ''' <summary>
    ''' Gets or sets the create date.
    ''' </summary>
    ''' <value>The create date.</value>
    <StringLength(50)>
    Public Property CreateDate As String

    ''' <summary>
    ''' Gets or sets the content ext.
    ''' </summary>
    ''' <value>The content ext.</value>
    <StringLength(50)>
    Public Property ContentExt As String

    ''' <summary>
    ''' Gets or sets the content unique identifier.
    ''' </summary>
    ''' <value>The content unique identifier.</value>
    <Key>
    <Column(Order:=0)>
    <StringLength(50)>
    Public Property ContentGuid As String

    ''' <summary>
    ''' Gets or sets the user identifier.
    ''' </summary>
    ''' <value>The user identifier.</value>
    <Key>
    <Column(Order:=1)>
    <StringLength(50)>
    Public Property UserID As String

    ''' <summary>
    ''' Gets or sets the name of the file.
    ''' </summary>
    ''' <value>The name of the file.</value>
    <StringLength(254)>
    Public Property FileName As String

    ''' <summary>
    ''' Gets or sets the size of the file.
    ''' </summary>
    ''' <value>The size of the file.</value>
    Public Property FileSize As Integer?

    ''' <summary>
    ''' Gets or sets the NBR of attachments.
    ''' </summary>
    ''' <value>The NBR of attachments.</value>
    Public Property NbrOfAttachments As Integer?

    ''' <summary>
    ''' Gets or sets from email address.
    ''' </summary>
    ''' <value>From email address.</value>
    <StringLength(254)>
    Public Property FromEmailAddress As String

    ''' <summary>
    ''' Gets or sets all recipiants.
    ''' </summary>
    ''' <value>All recipiants.</value>
    Public Property AllRecipiants As String

    ''' <summary>
    ''' Gets or sets the weight.
    ''' </summary>
    ''' <value>The weight.</value>
    Public Property Weight As Integer?

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
