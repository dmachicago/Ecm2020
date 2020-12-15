' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="gv_DataSourceRestoreHistory.vb" company="D. Miller and Associates, Limited">
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
''' Class gv_DataSourceRestoreHistory.
''' </summary>
Partial Public Class gv_DataSourceRestoreHistory
    ''' <summary>
    ''' Gets or sets the source unique identifier.
    ''' </summary>
    ''' <value>The source unique identifier.</value>
    <Key>
    <Column(Order:=0)>
    <StringLength(50)>
    Public Property SourceGuid As String

    ''' <summary>
    ''' Gets or sets the restored to machine.
    ''' </summary>
    ''' <value>The restored to machine.</value>
    <StringLength(50)>
    Public Property RestoredToMachine As String

    ''' <summary>
    ''' Gets or sets the name of the restore user.
    ''' </summary>
    ''' <value>The name of the restore user.</value>
    <StringLength(50)>
    Public Property RestoreUserName As String

    ''' <summary>
    ''' Gets or sets the restore user identifier.
    ''' </summary>
    ''' <value>The restore user identifier.</value>
    <StringLength(50)>
    Public Property RestoreUserID As String

    ''' <summary>
    ''' Gets or sets the restore user domain.
    ''' </summary>
    ''' <value>The restore user domain.</value>
    <StringLength(254)>
    Public Property RestoreUserDomain As String

    ''' <summary>
    ''' Gets or sets the restore date.
    ''' </summary>
    ''' <value>The restore date.</value>
    Public Property RestoreDate As Date?

    ''' <summary>
    ''' Gets or sets the data source owner user identifier.
    ''' </summary>
    ''' <value>The data source owner user identifier.</value>
    <Key>
    <Column(Order:=1)>
    <StringLength(50)>
    Public Property DataSourceOwnerUserID As String

    ''' <summary>
    ''' Gets or sets the seq no.
    ''' </summary>
    ''' <value>The seq no.</value>
    <Key>
    <Column(Order:=2)>
    Public Property SeqNo As Integer

    ''' <summary>
    ''' Gets or sets the type content code.
    ''' </summary>
    ''' <value>The type content code.</value>
    <StringLength(50)>
    Public Property TypeContentCode As String

    ''' <summary>
    ''' Gets or sets the create date.
    ''' </summary>
    ''' <value>The create date.</value>
    Public Property CreateDate As Date?

    ''' <summary>
    ''' Gets or sets the name of the document.
    ''' </summary>
    ''' <value>The name of the document.</value>
    <StringLength(254)>
    Public Property DocumentName As String

    ''' <summary>
    ''' Gets or sets the FQN.
    ''' </summary>
    ''' <value>The FQN.</value>
    <StringLength(500)>
    Public Property FQN As String

    ''' <summary>
    ''' Gets or sets the verified data.
    ''' </summary>
    ''' <value>The verified data.</value>
    <StringLength(1)>
    Public Property VerifiedData As String

    ''' <summary>
    ''' Gets or sets the original CRC.
    ''' </summary>
    ''' <value>The original CRC.</value>
    <StringLength(50)>
    Public Property OrigCrc As String

    ''' <summary>
    ''' Gets or sets the restore CRC.
    ''' </summary>
    ''' <value>The restore CRC.</value>
    <StringLength(50)>
    Public Property RestoreCrc As String

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
