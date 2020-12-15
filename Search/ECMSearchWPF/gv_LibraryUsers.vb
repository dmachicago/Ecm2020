' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="gv_LibraryUsers.vb" company="D. Miller and Associates, Limited">
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
''' Class gv_LibraryUsers.
''' </summary>
Partial Public Class gv_LibraryUsers
    ''' <summary>
    ''' Gets or sets a value indicating whether [read only].
    ''' </summary>
    ''' <value><c>null</c> if [read only] contains no value, <c>true</c> if [read only]; otherwise, <c>false</c>.</value>
    <Column("ReadOnly")>
    Public Property _ReadOnly As Boolean?

    ''' <summary>
    ''' Gets or sets a value indicating whether [create access].
    ''' </summary>
    ''' <value><c>null</c> if [create access] contains no value, <c>true</c> if [create access]; otherwise, <c>false</c>.</value>
    Public Property CreateAccess As Boolean?

    ''' <summary>
    ''' Gets or sets a value indicating whether [update access].
    ''' </summary>
    ''' <value><c>null</c> if [update access] contains no value, <c>true</c> if [update access]; otherwise, <c>false</c>.</value>
    Public Property UpdateAccess As Boolean?

    ''' <summary>
    ''' Gets or sets a value indicating whether [delete access].
    ''' </summary>
    ''' <value><c>null</c> if [delete access] contains no value, <c>true</c> if [delete access]; otherwise, <c>false</c>.</value>
    Public Property DeleteAccess As Boolean?

    ''' <summary>
    ''' Gets or sets the user identifier.
    ''' </summary>
    ''' <value>The user identifier.</value>
    <Key>
    <Column(Order:=0)>
    <StringLength(50)>
    Public Property UserID As String

    ''' <summary>
    ''' Gets or sets the library owner user identifier.
    ''' </summary>
    ''' <value>The library owner user identifier.</value>
    <Key>
    <Column(Order:=1)>
    <StringLength(50)>
    Public Property LibraryOwnerUserID As String

    ''' <summary>
    ''' Gets or sets the name of the library.
    ''' </summary>
    ''' <value>The name of the library.</value>
    <Key>
    <Column(Order:=2)>
    <StringLength(80)>
    Public Property LibraryName As String

    ''' <summary>
    ''' Gets or sets a value indicating whether [not added as group member].
    ''' </summary>
    ''' <value><c>null</c> if [not added as group member] contains no value, <c>true</c> if [not added as group member]; otherwise, <c>false</c>.</value>
    Public Property NotAddedAsGroupMember As Boolean?

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
    ''' Gets or sets a value indicating whether [single user].
    ''' </summary>
    ''' <value><c>null</c> if [single user] contains no value, <c>true</c> if [single user]; otherwise, <c>false</c>.</value>
    Public Property SingleUser As Boolean?

    ''' <summary>
    ''' Gets or sets a value indicating whether [group user].
    ''' </summary>
    ''' <value><c>null</c> if [group user] contains no value, <c>true</c> if [group user]; otherwise, <c>false</c>.</value>
    Public Property GroupUser As Boolean?

    ''' <summary>
    ''' Gets or sets the group count.
    ''' </summary>
    ''' <value>The group count.</value>
    Public Property GroupCnt As Integer?

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
