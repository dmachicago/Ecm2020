' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="gv_ZippedFiles.vb" company="D. Miller and Associates, Limited">
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
''' Class gv_ZippedFiles.
''' </summary>
Partial Public Class gv_ZippedFiles
    ''' <summary>
    ''' Gets or sets the content unique identifier.
    ''' </summary>
    ''' <value>The content unique identifier.</value>
    <Key>
    <Column(Order:=0)>
    <StringLength(50)>
    Public Property ContentGUID As String

    ''' <summary>
    ''' Gets or sets the source type code.
    ''' </summary>
    ''' <value>The source type code.</value>
    <StringLength(50)>
    Public Property SourceTypeCode As String

    ''' <summary>
    ''' Gets or sets the source image.
    ''' </summary>
    ''' <value>The source image.</value>
    <Column(TypeName:="image")>
    Public Property SourceImage As Byte()

    ''' <summary>
    ''' Gets or sets the source unique identifier.
    ''' </summary>
    ''' <value>The source unique identifier.</value>
    <Key>
    <Column(Order:=1)>
    <StringLength(50)>
    Public Property SourceGuid As String

    ''' <summary>
    ''' Gets or sets the data source owner user identifier.
    ''' </summary>
    ''' <value>The data source owner user identifier.</value>
    <Key>
    <Column(Order:=2)>
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
