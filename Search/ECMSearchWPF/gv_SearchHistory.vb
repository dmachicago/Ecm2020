' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="gv_SearchHistory.vb" company="D. Miller and Associates, Limited">
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
''' Class gv_SearchHistory.
''' </summary>
Partial Public Class gv_SearchHistory
    ''' <summary>
    ''' Gets or sets the search SQL.
    ''' </summary>
    ''' <value>The search SQL.</value>
    Public Property SearchSql As String

    ''' <summary>
    ''' Gets or sets the search date.
    ''' </summary>
    ''' <value>The search date.</value>
    Public Property SearchDate As Date?

    ''' <summary>
    ''' Gets or sets the user identifier.
    ''' </summary>
    ''' <value>The user identifier.</value>
    <StringLength(50)>
    Public Property UserID As String

    ''' <summary>
    ''' Gets or sets the row identifier.
    ''' </summary>
    ''' <value>The row identifier.</value>
    <Key>
    Public Property RowID As Integer

    ''' <summary>
    ''' Gets or sets the returned rows.
    ''' </summary>
    ''' <value>The returned rows.</value>
    Public Property ReturnedRows As Integer?

    ''' <summary>
    ''' Gets or sets the start time.
    ''' </summary>
    ''' <value>The start time.</value>
    Public Property StartTime As Date?

    ''' <summary>
    ''' Gets or sets the end time.
    ''' </summary>
    ''' <value>The end time.</value>
    Public Property EndTime As Date?

    ''' <summary>
    ''' Gets or sets the called from.
    ''' </summary>
    ''' <value>The called from.</value>
    <StringLength(50)>
    Public Property CalledFrom As String

    ''' <summary>
    ''' Gets or sets the type search.
    ''' </summary>
    ''' <value>The type search.</value>
    <StringLength(50)>
    Public Property TypeSearch As String

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

    ''' <summary>
    ''' Gets or sets the search parms.
    ''' </summary>
    ''' <value>The search parms.</value>
    Public Property SearchParms As String
End Class
