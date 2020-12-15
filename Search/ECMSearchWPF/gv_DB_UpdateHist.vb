' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="gv_DB_UpdateHist.vb" company="D. Miller and Associates, Limited">
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
''' Class gv_DB_UpdateHist.
''' </summary>
Partial Public Class gv_DB_UpdateHist
    ''' <summary>
    ''' Gets or sets the create date.
    ''' </summary>
    ''' <value>The create date.</value>
    <Key>
    <Column(Order:=0)>
    Public Property CreateDate As Date

    ''' <summary>
    ''' Gets or sets the fix identifier.
    ''' </summary>
    ''' <value>The fix identifier.</value>
    <Key>
    <Column(Order:=1)>
    <DatabaseGenerated(DatabaseGeneratedOption.None)>
    Public Property FixID As Integer

    ''' <summary>
    ''' Gets or sets the name of the database.
    ''' </summary>
    ''' <value>The name of the database.</value>
    <StringLength(50)>
    Public Property DBName As String

    ''' <summary>
    ''' Gets or sets the company identifier.
    ''' </summary>
    ''' <value>The company identifier.</value>
    <StringLength(50)>
    Public Property CompanyID As String

    ''' <summary>
    ''' Gets or sets the name of the machine.
    ''' </summary>
    ''' <value>The name of the machine.</value>
    <StringLength(50)>
    Public Property MachineName As String

    ''' <summary>
    ''' Gets or sets the status.
    ''' </summary>
    ''' <value>The status.</value>
    <StringLength(50)>
    Public Property Status As String

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
