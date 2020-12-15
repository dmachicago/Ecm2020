' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="gv_QuickDirectory.vb" company="D. Miller and Associates, Limited">
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
''' Class gv_QuickDirectory.
''' </summary>
Partial Public Class gv_QuickDirectory
    ''' <summary>
    ''' Gets or sets the user identifier.
    ''' </summary>
    ''' <value>The user identifier.</value>
    <Key>
    <Column(Order:=0)>
    <StringLength(50)>
    Public Property UserID As String

    ''' <summary>
    ''' Gets or sets the include sub dirs.
    ''' </summary>
    ''' <value>The include sub dirs.</value>
    <StringLength(1)>
    Public Property IncludeSubDirs As String

    ''' <summary>
    ''' Gets or sets the FQN.
    ''' </summary>
    ''' <value>The FQN.</value>
    <Key>
    <Column(Order:=1)>
    <StringLength(254)>
    Public Property FQN As String

    ''' <summary>
    ''' Gets or sets the database identifier.
    ''' </summary>
    ''' <value>The database identifier.</value>
    <Key>
    <Column(Order:=2)>
    <StringLength(50)>
    Public Property DB_ID As String

    ''' <summary>
    ''' Gets or sets the version files.
    ''' </summary>
    ''' <value>The version files.</value>
    <StringLength(1)>
    Public Property VersionFiles As String

    ''' <summary>
    ''' Gets or sets the ck meta data.
    ''' </summary>
    ''' <value>The ck meta data.</value>
    <StringLength(1)>
    Public Property ckMetaData As String

    ''' <summary>
    ''' Gets or sets the ck public.
    ''' </summary>
    ''' <value>The ck public.</value>
    <StringLength(1)>
    Public Property ckPublic As String

    ''' <summary>
    ''' Gets or sets the ck disable dir.
    ''' </summary>
    ''' <value>The ck disable dir.</value>
    <StringLength(1)>
    Public Property ckDisableDir As String

    ''' <summary>
    ''' Gets or sets a value indicating whether [quick reference entry].
    ''' </summary>
    ''' <value><c>null</c> if [quick reference entry] contains no value, <c>true</c> if [quick reference entry]; otherwise, <c>false</c>.</value>
    Public Property QuickRefEntry As Boolean?

    ''' <summary>
    ''' Gets or sets the retention code.
    ''' </summary>
    ''' <value>The retention code.</value>
    <StringLength(50)>
    Public Property RetentionCode As String

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
