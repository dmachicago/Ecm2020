' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="gv_DataOwners.vb" company="D. Miller and Associates, Limited">
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
''' Class gv_DataOwners.
''' </summary>
Partial Public Class gv_DataOwners
    ''' <summary>
    ''' Gets or sets a value indicating whether [primary owner].
    ''' </summary>
    ''' <value><c>null</c> if [primary owner] contains no value, <c>true</c> if [primary owner]; otherwise, <c>false</c>.</value>
    Public Property PrimaryOwner As Boolean?

    ''' <summary>
    ''' Gets or sets the owner type code.
    ''' </summary>
    ''' <value>The owner type code.</value>
    <StringLength(50)>
    Public Property OwnerTypeCode As String

    ''' <summary>
    ''' Gets or sets a value indicating whether [full access].
    ''' </summary>
    ''' <value><c>null</c> if [full access] contains no value, <c>true</c> if [full access]; otherwise, <c>false</c>.</value>
    Public Property FullAccess As Boolean?

    ''' <summary>
    ''' Gets or sets a value indicating whether [read only].
    ''' </summary>
    ''' <value><c>null</c> if [read only] contains no value, <c>true</c> if [read only]; otherwise, <c>false</c>.</value>
    <Column("ReadOnly")>
    Public Property _ReadOnly As Boolean?

    ''' <summary>
    ''' Gets or sets a value indicating whether [delete access].
    ''' </summary>
    ''' <value><c>null</c> if [delete access] contains no value, <c>true</c> if [delete access]; otherwise, <c>false</c>.</value>
    Public Property DeleteAccess As Boolean?

    ''' <summary>
    ''' Gets or sets a value indicating whether this <see cref="gv_DataOwners"/> is searchable.
    ''' </summary>
    ''' <value><c>null</c> if [searchable] contains no value, <c>true</c> if [searchable]; otherwise, <c>false</c>.</value>
    Public Property Searchable As Boolean?

    ''' <summary>
    ''' Gets or sets the source unique identifier.
    ''' </summary>
    ''' <value>The source unique identifier.</value>
    <Key>
    <Column(Order:=0)>
    <StringLength(50)>
    Public Property SourceGuid As String

    ''' <summary>
    ''' Gets or sets the user identifier.
    ''' </summary>
    ''' <value>The user identifier.</value>
    <Key>
    <Column(Order:=1)>
    <StringLength(50)>
    Public Property UserID As String

    ''' <summary>
    ''' Gets or sets the group owner user identifier.
    ''' </summary>
    ''' <value>The group owner user identifier.</value>
    <Key>
    <Column(Order:=2)>
    <StringLength(50)>
    Public Property GroupOwnerUserID As String

    ''' <summary>
    ''' Gets or sets the name of the group.
    ''' </summary>
    ''' <value>The name of the group.</value>
    <Key>
    <Column(Order:=3)>
    <StringLength(80)>
    Public Property GroupName As String

    ''' <summary>
    ''' Gets or sets the data source owner user identifier.
    ''' </summary>
    ''' <value>The data source owner user identifier.</value>
    <Key>
    <Column(Order:=4)>
    <StringLength(50)>
    Public Property DataSourceOwnerUserID As String

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
