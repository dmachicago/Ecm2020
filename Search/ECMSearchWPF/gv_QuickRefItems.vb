' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="gv_QuickRefItems.vb" company="D. Miller and Associates, Limited">
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
''' Class gv_QuickRefItems.
''' </summary>
Partial Public Class gv_QuickRefItems
    ''' <summary>
    ''' Gets or sets the quick reference identifier NBR.
    ''' </summary>
    ''' <value>The quick reference identifier NBR.</value>
    Public Property QuickRefIdNbr As Integer?

    ''' <summary>
    ''' Gets or sets the FQN.
    ''' </summary>
    ''' <value>The FQN.</value>
    <StringLength(300)>
    Public Property FQN As String

    ''' <summary>
    ''' Gets or sets the quick reference item unique identifier.
    ''' </summary>
    ''' <value>The quick reference item unique identifier.</value>
    <Key>
    <StringLength(50)>
    Public Property QuickRefItemGuid As String

    ''' <summary>
    ''' Gets or sets the source unique identifier.
    ''' </summary>
    ''' <value>The source unique identifier.</value>
    <StringLength(50)>
    Public Property SourceGuid As String

    ''' <summary>
    ''' Gets or sets the data source owner user identifier.
    ''' </summary>
    ''' <value>The data source owner user identifier.</value>
    <StringLength(50)>
    Public Property DataSourceOwnerUserID As String

    ''' <summary>
    ''' Gets or sets the author.
    ''' </summary>
    ''' <value>The author.</value>
    <StringLength(300)>
    Public Property Author As String

    ''' <summary>
    ''' Gets or sets the description.
    ''' </summary>
    ''' <value>The description.</value>
    Public Property Description As String

    ''' <summary>
    ''' Gets or sets the keywords.
    ''' </summary>
    ''' <value>The keywords.</value>
    <StringLength(2000)>
    Public Property Keywords As String

    ''' <summary>
    ''' Gets or sets the name of the file.
    ''' </summary>
    ''' <value>The name of the file.</value>
    <StringLength(80)>
    Public Property FileName As String

    ''' <summary>
    ''' Gets or sets the name of the dir.
    ''' </summary>
    ''' <value>The name of the dir.</value>
    <StringLength(254)>
    Public Property DirName As String

    ''' <summary>
    ''' Gets or sets a value indicating whether [marked for deletion].
    ''' </summary>
    ''' <value><c>null</c> if [marked for deletion] contains no value, <c>true</c> if [marked for deletion]; otherwise, <c>false</c>.</value>
    Public Property MarkedForDeletion As Boolean?

    ''' <summary>
    ''' Gets or sets the retention code.
    ''' </summary>
    ''' <value>The retention code.</value>
    <StringLength(50)>
    Public Property RetentionCode As String

    ''' <summary>
    ''' Gets or sets the metadata tag.
    ''' </summary>
    ''' <value>The metadata tag.</value>
    <StringLength(50)>
    Public Property MetadataTag As String

    ''' <summary>
    ''' Gets or sets the metadata value.
    ''' </summary>
    ''' <value>The metadata value.</value>
    <StringLength(50)>
    Public Property MetadataValue As String

    ''' <summary>
    ''' Gets or sets the library.
    ''' </summary>
    ''' <value>The library.</value>
    <StringLength(50)>
    Public Property Library As String

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
