' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="gv_Directory.vb" company="D. Miller and Associates, Limited">
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
''' Class gv_Directory.
''' </summary>
Partial Public Class gv_Directory
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
    ''' Gets or sets the quick reference entry.
    ''' </summary>
    ''' <value>The quick reference entry.</value>
    <StringLength(10)>
    Public Property QuickRefEntry As String

    ''' <summary>
    ''' Gets or sets a value indicating whether this instance is system default.
    ''' </summary>
    ''' <value><c>null</c> if [is system default] contains no value, <c>true</c> if [is system default]; otherwise, <c>false</c>.</value>
    Public Property isSysDefault As Boolean?

    ''' <summary>
    ''' Gets or sets the ocr directory.
    ''' </summary>
    ''' <value>The ocr directory.</value>
    <StringLength(1)>
    Public Property OcrDirectory As String

    ''' <summary>
    ''' Gets or sets the retention code.
    ''' </summary>
    ''' <value>The retention code.</value>
    <StringLength(50)>
    Public Property RetentionCode As String

    ''' <summary>
    ''' Gets or sets a value indicating whether this instance is server directory.
    ''' </summary>
    ''' <value><c>null</c> if [is server directory] contains no value, <c>true</c> if [is server directory]; otherwise, <c>false</c>.</value>
    Public Property isServerDirectory As Boolean?

    ''' <summary>
    ''' Gets or sets a value indicating whether this instance is mapped drive.
    ''' </summary>
    ''' <value><c>null</c> if [is mapped drive] contains no value, <c>true</c> if [is mapped drive]; otherwise, <c>false</c>.</value>
    Public Property isMappedDrive As Boolean?

    ''' <summary>
    ''' Gets or sets a value indicating whether this instance is network drive.
    ''' </summary>
    ''' <value><c>null</c> if [is network drive] contains no value, <c>true</c> if [is network drive]; otherwise, <c>false</c>.</value>
    Public Property isNetworkDrive As Boolean?

    ''' <summary>
    ''' Gets or sets a value indicating whether [requires authentication].
    ''' </summary>
    ''' <value><c>null</c> if [requires authentication] contains no value, <c>true</c> if [requires authentication]; otherwise, <c>false</c>.</value>
    Public Property RequiresAuthentication As Boolean?

    ''' <summary>
    ''' Gets or sets a value indicating whether [admin disabled].
    ''' </summary>
    ''' <value><c>null</c> if [admin disabled] contains no value, <c>true</c> if [admin disabled]; otherwise, <c>false</c>.</value>
    Public Property AdminDisabled As Boolean?

    ''' <summary>
    ''' Gets or sets a value indicating whether [archive skip bit].
    ''' </summary>
    ''' <value><c>null</c> if [archive skip bit] contains no value, <c>true</c> if [archive skip bit]; otherwise, <c>false</c>.</value>
    Public Property ArchiveSkipBit As Boolean?

    ''' <summary>
    ''' Gets or sets a value indicating whether [listen for changes].
    ''' </summary>
    ''' <value><c>null</c> if [listen for changes] contains no value, <c>true</c> if [listen for changes]; otherwise, <c>false</c>.</value>
    Public Property ListenForChanges As Boolean?

    ''' <summary>
    ''' Gets or sets a value indicating whether [listen directory].
    ''' </summary>
    ''' <value><c>null</c> if [listen directory] contains no value, <c>true</c> if [listen directory]; otherwise, <c>false</c>.</value>
    Public Property ListenDirectory As Boolean?

    ''' <summary>
    ''' Gets or sets a value indicating whether [listen sub directory].
    ''' </summary>
    ''' <value><c>null</c> if [listen sub directory] contains no value, <c>true</c> if [listen sub directory]; otherwise, <c>false</c>.</value>
    Public Property ListenSubDirectory As Boolean?

    ''' <summary>
    ''' Gets or sets the dir unique identifier.
    ''' </summary>
    ''' <value>The dir unique identifier.</value>
    Public Property DirGuid As Guid?

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
    ''' Gets or sets the ocr PDF.
    ''' </summary>
    ''' <value>The ocr PDF.</value>
    <StringLength(1)>
    Public Property OcrPdf As String

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
    ''' Gets or sets the delete on archive.
    ''' </summary>
    ''' <value>The delete on archive.</value>
    <StringLength(1)>
    Public Property DeleteOnArchive As String
End Class
