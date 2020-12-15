' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="gv_Users.vb" company="D. Miller and Associates, Limited">
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
''' Class gv_Users.
''' </summary>
Partial Public Class gv_Users
    ''' <summary>
    ''' Gets or sets the user identifier.
    ''' </summary>
    ''' <value>The user identifier.</value>
    <Key>
    <Column(Order:=0)>
    <StringLength(50)>
    Public Property UserID As String

    ''' <summary>
    ''' Gets or sets the name of the user.
    ''' </summary>
    ''' <value>The name of the user.</value>
    <Key>
    <Column(Order:=1)>
    <StringLength(50)>
    Public Property UserName As String

    ''' <summary>
    ''' Gets or sets the email address.
    ''' </summary>
    ''' <value>The email address.</value>
    <StringLength(254)>
    Public Property EmailAddress As String

    ''' <summary>
    ''' Gets or sets the user password.
    ''' </summary>
    ''' <value>The user password.</value>
    <StringLength(254)>
    Public Property UserPassword As String

    ''' <summary>
    ''' Gets or sets the admin.
    ''' </summary>
    ''' <value>The admin.</value>
    <StringLength(1)>
    Public Property Admin As String

    ''' <summary>
    ''' Gets or sets the is active.
    ''' </summary>
    ''' <value>The is active.</value>
    <StringLength(1)>
    Public Property isActive As String

    ''' <summary>
    ''' Gets or sets the user login identifier.
    ''' </summary>
    ''' <value>The user login identifier.</value>
    <StringLength(50)>
    Public Property UserLoginID As String

    ''' <summary>
    ''' Gets or sets a value indicating whether [client only].
    ''' </summary>
    ''' <value><c>null</c> if [client only] contains no value, <c>true</c> if [client only]; otherwise, <c>false</c>.</value>
    Public Property ClientOnly As Boolean?

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
    ''' Gets or sets the active unique identifier.
    ''' </summary>
    ''' <value>The active unique identifier.</value>
    <Key>
    <Column(Order:=2)>
    Public Property ActiveGuid As Guid

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
