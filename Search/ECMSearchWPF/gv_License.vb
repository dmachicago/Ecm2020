' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="gv_License.vb" company="D. Miller and Associates, Limited">
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
''' Class gv_License.
''' </summary>
Partial Public Class gv_License
    ''' <summary>
    ''' Gets or sets the agreement.
    ''' </summary>
    ''' <value>The agreement.</value>
    <Key>
    <Column(Order:=0)>
    <StringLength(2000)>
    Public Property Agreement As String

    ''' <summary>
    ''' Gets or sets the version NBR.
    ''' </summary>
    ''' <value>The version NBR.</value>
    <Key>
    <Column(Order:=1)>
    <DatabaseGenerated(DatabaseGeneratedOption.None)>
    Public Property VersionNbr As Integer

    ''' <summary>
    ''' Gets or sets the activation date.
    ''' </summary>
    ''' <value>The activation date.</value>
    <Key>
    <Column(Order:=2)>
    Public Property ActivationDate As Date

    ''' <summary>
    ''' Gets or sets the install date.
    ''' </summary>
    ''' <value>The install date.</value>
    <Key>
    <Column(Order:=3)>
    Public Property InstallDate As Date

    ''' <summary>
    ''' Gets or sets the customer identifier.
    ''' </summary>
    ''' <value>The customer identifier.</value>
    <Key>
    <Column(Order:=4)>
    <StringLength(50)>
    Public Property CustomerID As String

    ''' <summary>
    ''' Gets or sets the name of the customer.
    ''' </summary>
    ''' <value>The name of the customer.</value>
    <Key>
    <Column(Order:=5)>
    <StringLength(254)>
    Public Property CustomerName As String

    ''' <summary>
    ''' Gets or sets the license identifier.
    ''' </summary>
    ''' <value>The license identifier.</value>
    <Key>
    <Column(Order:=6)>
    Public Property LicenseID As Integer

    ''' <summary>
    ''' Gets or sets the XRT NXR1.
    ''' </summary>
    ''' <value>The XRT NXR1.</value>
    <StringLength(50)>
    Public Property XrtNxr1 As String

    ''' <summary>
    ''' Gets or sets the server identifier.
    ''' </summary>
    ''' <value>The server identifier.</value>
    <StringLength(100)>
    Public Property ServerIdentifier As String

    ''' <summary>
    ''' Gets or sets the SQL instance identifier.
    ''' </summary>
    ''' <value>The SQL instance identifier.</value>
    <StringLength(100)>
    Public Property SqlInstanceIdentifier As String

    ''' <summary>
    ''' Gets or sets the machine identifier.
    ''' </summary>
    ''' <value>The machine identifier.</value>
    <StringLength(80)>
    Public Property MachineID As String

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
    ''' Gets or sets the name of the server.
    ''' </summary>
    ''' <value>The name of the server.</value>
    <StringLength(254)>
    Public Property ServerName As String

    ''' <summary>
    ''' Gets or sets the name of the SQL instance.
    ''' </summary>
    ''' <value>The name of the SQL instance.</value>
    <StringLength(254)>
    Public Property SqlInstanceName As String

    ''' <summary>
    ''' Gets or sets the name of the SQL server instance.
    ''' </summary>
    ''' <value>The name of the SQL server instance.</value>
    <StringLength(254)>
    Public Property SqlServerInstanceName As String

    ''' <summary>
    ''' Gets or sets the name of the SQL server machine.
    ''' </summary>
    ''' <value>The name of the SQL server machine.</value>
    <StringLength(254)>
    Public Property SqlServerMachineName As String

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
