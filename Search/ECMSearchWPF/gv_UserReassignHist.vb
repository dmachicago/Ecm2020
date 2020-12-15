' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="gv_UserReassignHist.vb" company="D. Miller and Associates, Limited">
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
''' Class gv_UserReassignHist.
''' </summary>
Partial Public Class gv_UserReassignHist
    ''' <summary>
    ''' Gets or sets the previous user identifier.
    ''' </summary>
    ''' <value>The previous user identifier.</value>
    <Key>
    <Column(Order:=0)>
    <StringLength(50)>
    Public Property PrevUserID As String

    ''' <summary>
    ''' Gets or sets the name of the previous user.
    ''' </summary>
    ''' <value>The name of the previous user.</value>
    <StringLength(50)>
    Public Property PrevUserName As String

    ''' <summary>
    ''' Gets or sets the previous email address.
    ''' </summary>
    ''' <value>The previous email address.</value>
    <StringLength(254)>
    Public Property PrevEmailAddress As String

    ''' <summary>
    ''' Gets or sets the previous user password.
    ''' </summary>
    ''' <value>The previous user password.</value>
    <StringLength(254)>
    Public Property PrevUserPassword As String

    ''' <summary>
    ''' Gets or sets the previous admin.
    ''' </summary>
    ''' <value>The previous admin.</value>
    <StringLength(1)>
    Public Property PrevAdmin As String

    ''' <summary>
    ''' Gets or sets the previs active.
    ''' </summary>
    ''' <value>The previs active.</value>
    <StringLength(1)>
    Public Property PrevisActive As String

    ''' <summary>
    ''' Gets or sets the previous user login identifier.
    ''' </summary>
    ''' <value>The previous user login identifier.</value>
    <Key>
    <Column(Order:=1)>
    <StringLength(50)>
    Public Property PrevUserLoginID As String

    ''' <summary>
    ''' Gets or sets the reassigned user identifier.
    ''' </summary>
    ''' <value>The reassigned user identifier.</value>
    <StringLength(50)>
    Public Property ReassignedUserID As String

    ''' <summary>
    ''' Gets or sets the name of the reassigned user.
    ''' </summary>
    ''' <value>The name of the reassigned user.</value>
    <Key>
    <Column(Order:=2)>
    <StringLength(50)>
    Public Property ReassignedUserName As String

    ''' <summary>
    ''' Gets or sets the reassigned email address.
    ''' </summary>
    ''' <value>The reassigned email address.</value>
    <StringLength(254)>
    Public Property ReassignedEmailAddress As String

    ''' <summary>
    ''' Gets or sets the reassigned user password.
    ''' </summary>
    ''' <value>The reassigned user password.</value>
    <StringLength(254)>
    Public Property ReassignedUserPassword As String

    ''' <summary>
    ''' Gets or sets the reassigned admin.
    ''' </summary>
    ''' <value>The reassigned admin.</value>
    <StringLength(1)>
    Public Property ReassignedAdmin As String

    ''' <summary>
    ''' Gets or sets the reassignedis active.
    ''' </summary>
    ''' <value>The reassignedis active.</value>
    <StringLength(1)>
    Public Property ReassignedisActive As String

    ''' <summary>
    ''' Gets or sets the reassigned user login identifier.
    ''' </summary>
    ''' <value>The reassigned user login identifier.</value>
    <StringLength(50)>
    Public Property ReassignedUserLoginID As String

    ''' <summary>
    ''' Gets or sets the reassignment date.
    ''' </summary>
    ''' <value>The reassignment date.</value>
    <Key>
    <Column(Order:=3)>
    Public Property ReassignmentDate As Date

    ''' <summary>
    ''' Gets or sets the row identifier.
    ''' </summary>
    ''' <value>The row identifier.</value>
    Public Property RowID As Guid?

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
