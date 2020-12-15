' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="gv_HelpTextUser.vb" company="D. Miller and Associates, Limited">
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
''' Class gv_HelpTextUser.
''' </summary>
Partial Public Class gv_HelpTextUser
    ''' <summary>
    ''' Gets or sets the user identifier.
    ''' </summary>
    ''' <value>The user identifier.</value>
    <Key>
    <Column(Order:=0)>
    <StringLength(50)>
    Public Property UserID As String

    ''' <summary>
    ''' Gets or sets the name of the screen.
    ''' </summary>
    ''' <value>The name of the screen.</value>
    <Key>
    <Column(Order:=1)>
    <StringLength(100)>
    Public Property ScreenName As String

    ''' <summary>
    ''' Gets or sets the help text.
    ''' </summary>
    ''' <value>The help text.</value>
    Public Property HelpText As String

    ''' <summary>
    ''' Gets or sets the name of the widget.
    ''' </summary>
    ''' <value>The name of the widget.</value>
    <Key>
    <Column(Order:=2)>
    <StringLength(100)>
    Public Property WidgetName As String

    ''' <summary>
    ''' Gets or sets the widget text.
    ''' </summary>
    ''' <value>The widget text.</value>
    <StringLength(254)>
    Public Property WidgetText As String

    ''' <summary>
    ''' Gets or sets a value indicating whether [display help text].
    ''' </summary>
    ''' <value><c>null</c> if [display help text] contains no value, <c>true</c> if [display help text]; otherwise, <c>false</c>.</value>
    Public Property DisplayHelpText As Boolean?

    ''' <summary>
    ''' Gets or sets the company identifier.
    ''' </summary>
    ''' <value>The company identifier.</value>
    <StringLength(50)>
    Public Property CompanyID As String

    ''' <summary>
    ''' Gets or sets the last update.
    ''' </summary>
    ''' <value>The last update.</value>
    Public Property LastUpdate As Date?

    ''' <summary>
    ''' Gets or sets the create date.
    ''' </summary>
    ''' <value>The create date.</value>
    Public Property CreateDate As Date?

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
