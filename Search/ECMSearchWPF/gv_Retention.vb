' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="gv_Retention.vb" company="D. Miller and Associates, Limited">
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
''' Class gv_Retention.
''' </summary>
Partial Public Class gv_Retention
    ''' <summary>
    ''' Gets or sets the retention code.
    ''' </summary>
    ''' <value>The retention code.</value>
    <Key>
    <Column(Order:=0)>
    <StringLength(50)>
    Public Property RetentionCode As String

    ''' <summary>
    ''' Gets or sets the retention desc.
    ''' </summary>
    ''' <value>The retention desc.</value>
    Public Property RetentionDesc As String

    ''' <summary>
    ''' Gets or sets the retention units.
    ''' </summary>
    ''' <value>The retention units.</value>
    <Key>
    <Column(Order:=1)>
    <DatabaseGenerated(DatabaseGeneratedOption.None)>
    Public Property RetentionUnits As Integer

    ''' <summary>
    ''' Gets or sets the retention action.
    ''' </summary>
    ''' <value>The retention action.</value>
    <Key>
    <Column(Order:=2)>
    <StringLength(50)>
    Public Property RetentionAction As String

    ''' <summary>
    ''' Gets or sets the manager identifier.
    ''' </summary>
    ''' <value>The manager identifier.</value>
    <StringLength(50)>
    Public Property ManagerID As String

    ''' <summary>
    ''' Gets or sets the name of the manager.
    ''' </summary>
    ''' <value>The name of the manager.</value>
    <StringLength(200)>
    Public Property ManagerName As String

    ''' <summary>
    ''' Gets or sets the days warning.
    ''' </summary>
    ''' <value>The days warning.</value>
    Public Property DaysWarning As Integer?

    ''' <summary>
    ''' Gets or sets the response required.
    ''' </summary>
    ''' <value>The response required.</value>
    <StringLength(1)>
    Public Property ResponseRequired As String

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
    ''' Gets or sets the retention period.
    ''' </summary>
    ''' <value>The retention period.</value>
    <StringLength(10)>
    Public Property RetentionPeriod As String
End Class
