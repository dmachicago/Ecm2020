' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="gv_RuntimeErrors.vb" company="D. Miller and Associates, Limited">
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
''' Class gv_RuntimeErrors.
''' </summary>
Partial Public Class gv_RuntimeErrors
    ''' <summary>
    ''' Gets or sets the error MSG.
    ''' </summary>
    ''' <value>The error MSG.</value>
    Public Property ErrorMsg As String

    ''' <summary>
    ''' Gets or sets the stack trace.
    ''' </summary>
    ''' <value>The stack trace.</value>
    Public Property StackTrace As String

    ''' <summary>
    ''' Gets or sets the entry date.
    ''' </summary>
    ''' <value>The entry date.</value>
    Public Property EntryDate As Date?

    ''' <summary>
    ''' Gets or sets the identifier NBR.
    ''' </summary>
    ''' <value>The identifier NBR.</value>
    <StringLength(50)>
    Public Property IdNbr As String

    ''' <summary>
    ''' Gets or sets the entry seq.
    ''' </summary>
    ''' <value>The entry seq.</value>
    <Key>
    Public Property EntrySeq As Integer

    ''' <summary>
    ''' Gets or sets the connective unique identifier.
    ''' </summary>
    ''' <value>The connective unique identifier.</value>
    <StringLength(50)>
    Public Property ConnectiveGuid As String

    ''' <summary>
    ''' Gets or sets the user identifier.
    ''' </summary>
    ''' <value>The user identifier.</value>
    <StringLength(50)>
    Public Property UserID As String

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
