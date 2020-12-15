' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="gv_FunctionProdJargon.vb" company="D. Miller and Associates, Limited">
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
''' Class gv_FunctionProdJargon.
''' </summary>
Partial Public Class gv_FunctionProdJargon
    ''' <summary>
    ''' Gets or sets the key flag.
    ''' </summary>
    ''' <value>The key flag.</value>
    <MaxLength(50)>
    Public Property KeyFlag As Byte()

    ''' <summary>
    ''' Gets or sets the repeat data code.
    ''' </summary>
    ''' <value>The repeat data code.</value>
    <Key>
    <Column(Order:=0)>
    <StringLength(50)>
    Public Property RepeatDataCode As String

    ''' <summary>
    ''' Gets or sets the name of the corp function.
    ''' </summary>
    ''' <value>The name of the corp function.</value>
    <Key>
    <Column(Order:=1)>
    <StringLength(80)>
    Public Property CorpFuncName As String

    ''' <summary>
    ''' Gets or sets the jargon code.
    ''' </summary>
    ''' <value>The jargon code.</value>
    <Key>
    <Column(Order:=2)>
    <StringLength(50)>
    Public Property JargonCode As String

    ''' <summary>
    ''' Gets or sets the name of the corp.
    ''' </summary>
    ''' <value>The name of the corp.</value>
    <Key>
    <Column(Order:=3)>
    <StringLength(50)>
    Public Property CorpName As String

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
